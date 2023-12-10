<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList"%>
<%
    Integer year = (Integer)session.getAttribute("currentYear");
    Integer month = (Integer)session.getAttribute("currentMonth");
    Integer currentDay = (Integer)session.getAttribute("currentDay");
    
    Integer userIdx = (Integer)session.getAttribute("loggedInSession");
    Integer memberIdx = (Integer)session.getAttribute("memberIdx");
    //세션에 있음 폼태그로 사용하지 않아도 됨
    int day = -1;

    //플랜 등록을 엔터로 입력했을 때  파라미터 null 제어
    if(request.getParameter("day") != null){
      day = Integer.parseInt(request.getParameter("day"));
      session.setAttribute("currentDay", day);
    }

    

    ArrayList<Integer> planIdxList = new ArrayList<Integer>();
    ArrayList<Integer> startHourList = new ArrayList<Integer>();
    ArrayList<Integer> startMinList = new ArrayList<Integer>();
    ArrayList<Integer> endHourList = new ArrayList<Integer>();
    ArrayList<Integer> endMinList = new ArrayList<Integer>();
    ArrayList<String> contentList = new ArrayList<String>();

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
    String sql = "SELECT idx, start_hour, start_min, end_hour, end_min, content FROM plan WHERE account_idx = ? AND year_column = ? AND month_column = ? AND day_column = ? ORDER BY start_hour ASC, start_min ASC, end_hour ASC,  end_min ASC";
    PreparedStatement query = connect.prepareStatement(sql);

    if(memberIdx == null){
      query.setInt(1, userIdx);
    }else{
      query.setInt(1, memberIdx);
    }
    query.setInt(2, year);
    query.setInt(3, month);
    query.setInt(4, currentDay);
    ResultSet result = query.executeQuery();
    
    while (result.next()) {
      int planIdx = Integer.parseInt(result.getString("idx"));
      int startHour = Integer.parseInt(result.getString("start_hour"));
      int startMin = Integer.parseInt(result.getString("start_min"));
      int endHour = Integer.parseInt(result.getString("end_hour"));
      int endMin = Integer.parseInt(result.getString("end_min"));
      String content = result.getString("content");
  
      planIdxList.add(planIdx);
      startHourList.add(startHour);
      startMinList.add(startMin);
      endHourList.add(endHour);
      endMinList.add(endMin);
      contentList.add("\"" + content + "\"");
    }
%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/reset.css" type="text/css" />
  <link
    rel="stylesheet"
    href="../css/schedulerDetailModal.css"
    type="text/css"
  />
  <title>Schedule Details Page</title>
</head>
<article></article>
<body>
  <header id="header" class="headerStyle">
    <h1 class="dayNum"></h1>
  </header>
  <main class="mainStyle">
    
    <section class="planSection" id="planForm"></section>

    <form class="addPlanForm" id="form">
      <section class="setTimeSection">
        <div class="setStartTime">
          <p class="setStartTimeText">시작</p>
          <select id="selectStartHour" class="selectStartHour" name="startHour"></select>
          <select id="selectStartMin" class="selectStartMin" name="startMin"></select>
        </div>
        <div class="setEndTime">
          <p class="setEndTimeText">종료</p>
          <select class="selectEndHour" name="endHour"></select>
          <select class="selectEndMin" name="endMin"></select>
        </div>
      </section>
      <section class="addPlanSection">
        <input class="addPlanInput" type="text" name="content">
        <input class="addPlanBtn btnStyle" type="button" value="등록" onclick="addPlanValidationEvent(event)">
    </form>
  </main>
  <script>
    var userIdx = <%=userIdx%>
    var memberIdx = <%=memberIdx%>
    console.log(<%=currentDay%>)

    var userPlan = {
      day:<%=currentDay%>,
      idx:<%=planIdxList%>,
      startHour:<%=startHourList%>,
      startMin:<%=startMinList%>,
      endHour:<%=endHourList%>,
      endMin:<%=endMinList%>,
      content:<%=contentList%>
    }

    function createPlan(planDiv, planTitle, startTime, endTime, userPlan, i) {
      var startHour = userPlan.startHour[i].toString().padStart(2, "0");
      var startMin = userPlan.startMin[i].toString().padStart(2, "0");
      var endHour = userPlan.endHour[i].toString().padStart(2, "0");
      var endMin = userPlan.endMin[i].toString().padStart(2, "0");

      planTitle.textContent = userPlan.content[i];
      startTime.textContent = startHour + ":" + startMin;
      endTime.textContent = endHour + ":" + endMin;

      planDiv.appendChild(planTitle);
      planDiv.appendChild(startTime);
      planDiv.appendChild(endTime);
    }

    function createHourTime(startHour,endHour){
      var hour = 24;
      for(var i = 0; i < hour; i++){
        var optionStartHour = document.createElement("option")
        var optionEndHour = document.createElement("option")
        optionStartHour.textContent = i
        optionEndHour.textContent = i
        optionStartHour.value = i
        optionEndHour.value = i
        startHour.appendChild(optionStartHour)
        endHour.appendChild(optionEndHour)
      }
    }

    function createMinTime(startMin,endMin){
      var min = 60;
      for(var i = 0; i < min; i++){
        var optionStartMin = document.createElement("option")
        var optionEndMin = document.createElement("option")
        optionStartMin.textContent = i
        optionEndMin.textContent = i
        optionStartMin.value = i
        optionEndMin.value = i
        startMin.appendChild(optionStartMin)
        endMin.appendChild(optionEndMin)
      }
    }




   
    function getPlan(userPlan,memberIdx) {
      var dayNum = document.querySelector(".dayNum")
      var planSection = document.querySelector(".planSection")
      var addPlanSection = document.querySelector(".addPlanSection")
      dayNum.textContent = userPlan.day

      for (var i = 0; i < userPlan.idx.length; i++) {
        var planArticle = document.createElement("article")

        var planDiv = document.createElement("div")
        planDiv.className = "planDiv"
        planDiv.id = "planDiv"
        
        var planTitle = document.createElement("p")
        planTitle.textContent = userPlan.content[i]
        planTitle.className = "planTitle"

        var startTime = document.createElement("p")
        startTime.className = "startTime"

        var endTime = document.createElement("p")
        endTime.className = "endTime"

        createPlan(planDiv,planTitle,startTime,endTime,userPlan,i)

        planArticle.appendChild(planDiv)
        planSection.appendChild(planArticle)

        if(memberIdx == null){
          planArticle.className = "planArticle"
          var planEditBtnDiv = document.createElement("div")
          planEditBtnDiv.className = "planEditBtnDiv"


          var editBtn = document.createElement("input")
          editBtn.value = "수정"
          editBtn.type = "button"
          editBtn.className = "btnStyle"
          editBtn.id = "editBtn"
          editBtn.onclick = editBtnEvent


          var editSaveBtn = document.createElement("input")
          editSaveBtn.value = "저장"
          editSaveBtn.type = "hidden"
          editSaveBtn.className = "btnStyle"
          editSaveBtn.id = "editSaveBtn"

          var deleteBtn = document.createElement("input")
          deleteBtn.value = "삭제"
          deleteBtn.type = "submit"
          deleteBtn.onclick = deleteBtnEvent
          deleteBtn.className = "btnStyle"

          var deleteInput = document.createElement("input")
          deleteInput.type = "hidden"
          deleteInput.value = userPlan.idx[i]
          deleteInput.name = "deleteIdx"


          var editInput = document.createElement("input")
          editInput.type = "text"
          editInput.id = "editInput"
          editInput.value = userPlan.content[i]

          var editStartHour = document.createElement("select")
          var editStartMin = document.createElement("select")
          var editEndHour = document.createElement("select")
          var editEndMin = document.createElement("select")

          var planEditForm = document.createElement("form")
          planEditForm.id = "planEditForm"
          planEditForm.className = "planEditForm"

          var planEditIdx = document.createElement("input")
          planEditIdx.type = "hidden"
          planEditIdx.name = "planEditIdx"
          planEditIdx.value = userPlan.idx[i]
          
          var planEditInput = document.createElement("input")
          planEditInput.type = "text"
          planEditInput.name = "planEditInput"
          planEditInput.className = "planEditInput"
          planEditInput.id = "planEditInput"
          planEditInput.value = userPlan.content[i]

          var planEditStartHour = document.createElement("select")
          planEditStartHour.id = "planEditStartHour"
          planEditStartHour.name = "planEditStartHour"

          var planEditStartMin = document.createElement("select")
          planEditStartMin.id = "planEditStartMin"
          planEditStartMin.name = "planEditStartMin"

          var planEditEndHour = document.createElement("select")
          planEditEndHour.id = "planEditEndHour"
          planEditEndHour.name = "planEditEndHour"

          var planEditEndMin = document.createElement("select")
          planEditEndMin.id = "planEditEndMin"
          planEditEndMin.name = "planEditEndMin"

          createHourTime(planEditStartHour,planEditEndHour)
          planEditStartHour.value = userPlan.startHour[i]
          planEditEndHour.value = userPlan.endHour[i]
          createMinTime(planEditStartMin,planEditEndMin)
          planEditStartMin.value = userPlan.startMin[i]
          planEditEndMin.value = userPlan.endMin[i]

          planEditForm.appendChild(planEditIdx)
          planEditForm.appendChild(planEditInput)
          planEditForm.appendChild(planEditStartHour)
          planEditForm.appendChild(planEditStartMin)
          planEditForm.appendChild(planEditEndHour)
          planEditForm.appendChild(planEditEndMin)

          planEditBtnDiv.appendChild(editBtn)
          planEditBtnDiv.appendChild(editSaveBtn)

          planEditBtnDiv.appendChild(deleteBtn)
          planEditBtnDiv.appendChild(deleteInput)

          planArticle.appendChild(planEditForm)
          planArticle.appendChild(planEditBtnDiv)
        }else{
          planArticle.className = "memberPlanArticle"
        }
      }
    }

    function createInputSetTime(memberIdx) {
      if(memberIdx == null){
        var selectStartHour = document.querySelector(".selectStartHour")
        var selectEndHour = document.querySelector(".selectEndHour")
        createHourTime(selectStartHour,selectEndHour)

        var selectStartMin = document.querySelector(".selectStartMin")
        var selectEndMin = document.querySelector(".selectEndMin")
        createMinTime(selectStartMin,selectEndMin)
      }else{
        return
      }
    }

    //엔터가 눌렸을 때 동작 제어
    document.addEventListener("keydown", function(event){
      if(event.key === "Enter"){
        event.preventDefault()
        addPlanValidationEvent()
      }
    });


    function addPlanValidationEvent() {
      var addPlanInput = document.querySelector(".addPlanInput").value;
      var form = document.querySelector("#form");

      var startHourValue = parseInt(document.querySelector(".selectStartHour").value);
      var selectEndHour = parseInt(document.querySelector(".selectEndHour").value);
      var startMinValue = parseInt(document.querySelector(".selectStartMin").value);
      var selectEndMin = parseInt(document.querySelector(".selectEndMin").value);

      if(timeValidation(startHourValue,selectEndHour,startMinValue,selectEndMin)){
        if (contentValidation(addPlanInput)) {
          form.action = "../action/createPlanAction.jsp"
          form.submit();
        }
      }
    }

    function deleteBtnEvent(e){
      var planForm = document.querySelector("#planForm")
      e.preventDefault()
      planForm.action = "../action/deletePlanAction.jsp"
      planForm.submit()
    }

    function editBtnEvent(e){
      var planArticle = e.target.closest(".planArticle")
      var planDiv = planArticle.querySelector("#planDiv")
      var planEditForm = planArticle.querySelector("#planEditForm")
      var editBtn = planArticle.querySelector("#editBtn")
      var editSaveBtn = planArticle.querySelector("#editSaveBtn")

      planDiv.style.display = "none"
      planEditForm.style.display = "flex"
      editBtn.type = "hidden"
      editSaveBtn.type = "button"

      editSaveBtn.onclick = editSaveBtnEvent
    }

    function editSaveBtnEvent(e){
      var planArticle = e.target.closest(".planArticle")
      var editInput = planArticle.querySelector("#planEditInput").value
      var planEditStartHour = parseInt(document.querySelector("#planEditStartHour").value);
      var planEditStartMin = parseInt(document.querySelector("#planEditStartMin").value);
      var planEditEndHour = parseInt(document.querySelector("#planEditEndHour").value);
      var planEditEndMin = parseInt(document.querySelector("#planEditEndMin").value);
  
      if(timeValidation(planEditStartHour,planEditEndHour,planEditStartMin,planEditEndMin)){
        if(contentValidation(editInput)){
        var planEditForm = planArticle.querySelector(".planEditForm")
        planEditForm.action = "../action/editPlanAction.jsp?"
        planEditForm.submit()
        }
      }
    }

    window.onload = function(){
      var addPlanForm = document.querySelector(".addPlanForm")
      createInputSetTime(memberIdx)
      getPlan(userPlan,memberIdx)
      if(memberIdx == null){
        addPlanForm.style.display = "flex"
      }else{
        addPlanForm.style.display = "none"
      }
    }

    //  이벤트함수와 생성함수 분리
  </script>
  <script src="../javascript/validation.js"></script>
</body>
