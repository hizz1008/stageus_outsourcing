<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList"%>
<%
    Integer idx = (Integer)session.getAttribute("loggedInSession");
    Integer year = (Integer)session.getAttribute("currentYear");
    Integer month = (Integer)session.getAttribute("currentMonth");
    
    //int year = Integer.parseInt(request.getParameter("year"));
    //int month = Integer.parseInt(request.getParameter("month"));
    int day = Integer.parseInt(request.getParameter("day"));

    //session.setAttribute("currentYear", year);
    //session.setAttribute("currentMonth", month);
    session.setAttribute("currentDay", day);

    ArrayList<Integer> planIdxList = new ArrayList<Integer>();
    ArrayList<Integer> startHourList = new ArrayList<Integer>();
    ArrayList<Integer> startMinList = new ArrayList<Integer>();
    ArrayList<Integer> endHourList = new ArrayList<Integer>();
    ArrayList<Integer> endMinList = new ArrayList<Integer>();
    ArrayList<String> contentList = new ArrayList<String>();

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
    String sql = "SELECT idx, start_hour, start_min, end_hour, end_min, content FROM plan WHERE account_idx = ? AND year_column = ? AND month_column = ? AND day_column = ?";
    PreparedStatement query = connect.prepareStatement(sql);

    query.setInt(1, idx);
    query.setInt(2, year);
    query.setInt(3, month);
    query.setInt(4, day);
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
        <input class="addPlanInput" type="text" name="content" />
        <input
          class="addPlanBtn btnStyle"
          type="submit"
          value="등록"
          onclick="addPlanValidationEvent(event)"
        />
      </section>
    </form>
  </main>
  <script>
    var planIdxList = <%=planIdxList%>
    var startHourList = <%=startHourList%>
    var startMinList = <%=startMinList%>
    var endHourList = <%=endHourList%>
    var endMinList = <%=endMinList%>
    var contentList = <%=contentList%>
    var day = <%=day%>

    var userPlan = {
      day:day,
      idx:planIdxList,
      startHour:startHourList,
      startMin:startMinList,
      endHour:endHourList,
      endMin:endMinList,
      content:contentList
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




   
    function getPlan(userPlan) {
      var dayNum = document.querySelector(".dayNum")
      var planSection = document.querySelector(".planSection")
      dayNum.textContent = userPlan.day

      for (var i = 0; i < userPlan.idx.length; i++) {
        var planArticle = document.createElement("article")

        var planDiv = document.createElement("div")
        planArticle.className = "planArticle"
        planDiv.className = "planDiv"
        planDiv.id = "planDiv"
        
        var planTitle = document.createElement("p")
        planTitle.textContent = userPlan.content[i]
        planTitle.className = "planTitle"

        var startTime = document.createElement("p")
        startTime.className = "startTime"

        var endTime = document.createElement("p")
        endTime.className = "endTime"
        
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

        var planEditSection = document.createElement("div")
        planEditSection.id = "planEditSection"
        planEditSection.className = "planEditSection"

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




        createPlan(planDiv,planTitle,startTime,endTime,userPlan,i)

        createHourTime(planEditStartHour,planEditEndHour)
        planEditStartHour.value = userPlan.startHour[i]
        planEditEndHour.value = userPlan.endHour[i]
        createMinTime(planEditStartMin,planEditEndMin)
        planEditStartMin.value = userPlan.startMin[i]
        planEditEndMin.value = userPlan.endMin[i]

        planArticle.appendChild(planDiv)

        planEditSection.appendChild(planEditInput)
        planEditSection.appendChild(planEditStartHour)
        planEditSection.appendChild(planEditStartMin)
        planEditSection.appendChild(planEditEndHour)
        planEditSection.appendChild(planEditEndMin)

        planArticle.appendChild(planEditSection)
        planArticle.appendChild(planEditBtnDiv)

        planEditBtnDiv.appendChild(editBtn)
        planEditBtnDiv.appendChild(editSaveBtn)

        planEditBtnDiv.appendChild(deleteBtn)
        planEditBtnDiv.appendChild(deleteInput)
        
        planSection.appendChild(planArticle)
      }
    }



    function createInputSetTime() {
      var selectStartHour = document.querySelector(".selectStartHour")
      var selectEndHour = document.querySelector(".selectEndHour")
      createHourTime(selectStartHour,selectEndHour)

      var selectStartMin = document.querySelector(".selectStartMin")
      var selectEndMin = document.querySelector(".selectEndMin")
      createMinTime(selectStartMin,selectEndMin)
    }

    function addPlanValidationEvent(e) {
      e.preventDefault();
      var addPlanInput = document.querySelector(".addPlanInput").value;

      var form = document.querySelector("#form");

      var startHourValue = parseInt(document.querySelector(".selectStartHour").value);
      var selectEndHour = parseInt(document.querySelector(".selectEndHour").value);
      var startMinValue = parseInt(document.querySelector(".selectStartMin").value);
      var selectEndMin = parseInt(document.querySelector(".selectEndMin").value);

      if(timeValidationEvent(startHourValue,selectEndHour,startMinValue,selectEndMin)){
        if (contentValidationEvent(addPlanInput)) {
          form.action = "../action/createPlanAction.jsp?";
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
      var planArticle = e.target.parentElement
      var planDiv = planArticle.querySelector("#planDiv")
      var planEditSection = planArticle.querySelector("#planEditSection")
      var editBtn = planArticle.querySelector("#editBtn")
      var editSaveBtn = planArticle.querySelector("#editSaveBtn")

      planDiv.style.display = "none"
      planEditSection.style.display = "flex"
      editBtn.type = "hidden"
      editSaveBtn.type = "submit"

      editSaveBtn.onclick = editSaveBtnEvent
    }

    function editSaveBtnEvent(e){
      e.preventDefault()
      var planArticle = e.target.parentElement
      var editInput = planArticle.querySelector("#planEditInput").value
      var planEditStartHour = parseInt(document.querySelector("#planEditStartHour").value);
      var planEditStartMin = parseInt(document.querySelector("#planEditStartMin").value);
      var planEditEndHour = parseInt(document.querySelector("#planEditEndHour").value);
      var planEditEndMin = parseInt(document.querySelector("#planEditEndMin").value);
  
      if(timeValidationEvent(planEditStartHour,planEditEndHour,planEditStartMin,planEditEndMin)){
        if(contentValidationEvent(editInput)){
        var planForm = document.querySelector("#planForm")
        planForm.action = "../action/editPlanAction.jsp"
        planForm.submit()
        }
      }
    }

    window.onload = function(){
      createInputSetTime()
      getPlan(userPlan)
    }

    //  이벤트함수와 생성함수 분리
  </script>
  <script src="../javascript/validation.js"></script>
</body>
