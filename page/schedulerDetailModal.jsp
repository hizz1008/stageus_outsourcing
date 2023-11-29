<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList"%>
<%
    Integer idx = (Integer)session.getAttribute("loggedInSession");
    Integer currentYear = (Integer)session.getAttribute("currentYear");
    Integer currentMonth = (Integer)session.getAttribute("currentMonth");
    int year = Integer.parseInt(request.getParameter("year"));
    int month = Integer.parseInt(request.getParameter("month"));
    int day = Integer.parseInt(request.getParameter("day"));
    session.setAttribute("currentYear", year);
    session.setAttribute("currentMonth", month);
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
<body>
  <header id="header" class="headerStyle">
    <h1 class="dayNum"></h1>
  </header>
  <main class="mainStyle">
    
    <form class="planSection" id="planForm"></form>

    <form class="inputSection" id="form">
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

    function createTable(planTr, planTitle, startTime, endTime, userPlan, i) {
      var startHour = userPlan.startHour[i].toString().padStart(2, "0");
      var startMin = userPlan.startMin[i].toString().padStart(2, "0");
      var endHour = userPlan.endHour[i].toString().padStart(2, "0");
      var endMin = userPlan.endMin[i].toString().padStart(2, "0");

      planTitle.textContent = userPlan.content[i];
      startTime.textContent = startHour + ":" + startMin;
      endTime.textContent = endHour + ":" + endMin;

      planTr.appendChild(planTitle);
      planTr.appendChild(startTime);
      planTr.appendChild(endTime);
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




   
    function receiveUserPlan(userPlan) {
      var dayNum = document.querySelector(".dayNum")
      var planSection = document.querySelector(".planSection")
      dayNum.textContent = userPlan.day

      for (var i = 0; i < userPlan.idx.length; i++) {
        var planTable = document.createElement("table")
        var planTr = document.createElement("tr")
        
        var planTitle = document.createElement("td")
        var startTime = document.createElement("td")
        var endTime = document.createElement("td")
        var editBtn = document.createElement("input")
        var editSaveBtn = document.createElement("input")
        var deleteBtn = document.createElement("input")
        var deleteInput = document.createElement("input")


        var editInput = document.createElement("input")
        var editStartHour = document.createElement("select")
        var editStartMin = document.createElement("select")
        var editEndHour = document.createElement("select")
        var editEndMin = document.createElement("select")

        var planEditSection = document.createElement("div")
        var planEditInput = document.createElement("input")

        var planEditStartHour = document.createElement("select")
        var planEditStartMin = document.createElement("select")
        var planEditEndHour = document.createElement("select")
        var planEditEndMin = document.createElement("select")



        createTable(planTr,planTitle,startTime,endTime,userPlan,i)
        planTable.appendChild(planTr)



        planEditSection.id = "planEditSection"
        planEditSection.className = "planEditSection"

        planEditStartHour.id = "planEditStartHour"
        planEditStartHour.name = "planEditStartHour"

        planEditStartMin.id = "planEditStartMin"
        planEditStartMin.name = "planEditStartMin"

        planEditEndHour.id = "planEditEndHour"
        planEditEndHour.name = "planEditEndHour"

        planEditEndMin.id = "planEditEndMin"
        planEditEndMin.name = "planEditEndMin"

        planEditInput.type = "text"
        planEditInput.name = "planEditInput"
        planEditInput.className = "planEditInput"
        planEditInput.id = "planEditInput"
        planEditInput.value = userPlan.content[i]


        
        editInput.type = "text"
        editInput.id = "editInput"
        editInput.value = userPlan.content[i]
 

        deleteInput.type = "hidden"
        deleteInput.value = userPlan.idx[i]
        deleteInput.name = "deleteIdx"

        planTable.className = "planTable"
        planTr.className = "planTr"

        editBtn.value = "수정"
        editBtn.type = "button"
        editBtn.className = "btnStyle"
        editBtn.id = "editBtn"
        editBtn.onclick = editBtnEvent

        editSaveBtn.value = "저장"
        editSaveBtn.type = "hidden"
        editSaveBtn.className = "btnStyle"
        editSaveBtn.id = "editSaveBtn"

        deleteBtn.value = "삭제"
        deleteBtn.type = "submit"
        deleteBtn.onclick = deleteBtnEvent
        deleteBtn.className = "btnStyle"

        planTitle.textContent = userPlan.content[i]
        planTitle.className = "planTitle"
        
        createHourTime(planEditStartHour,planEditEndHour)
        planEditStartHour.value = userPlan.startHour[i]
        planEditEndHour.value = userPlan.endHour[i]
        createMinTime(planEditStartMin,planEditEndMin)
        planEditStartMin.value = userPlan.startMin[i]
        planEditEndMin.value = userPlan.endMin[i]

        planEditSection.appendChild(planEditInput)
        planEditSection.appendChild(planEditStartHour)
        planEditSection.appendChild(planEditStartMin)
        planEditSection.appendChild(planEditEndHour)
        planEditSection.appendChild(planEditEndMin)

        planTable.appendChild(planEditSection)

        planTable.appendChild(editBtn)
        planTable.appendChild(editSaveBtn)

        planTable.appendChild(deleteBtn)
        planTable.appendChild(deleteInput)

        planSection.appendChild(planTable)
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
      if (contentValidationEvent(addPlanInput)) {
        form.action = "../action/createPlanAction.jsp?";
        form.submit();
      }
    }

    function deleteBtnEvent(e){
      var planForm = document.querySelector("#planForm")
      e.preventDefault()
      planForm.action = "../action/deletePlanAction.jsp"
      planForm.submit()
    }

    function editBtnEvent(e){
      var planTable = e.target.parentElement
      var planTr = planTable.querySelector(".planTr")
      var planEditSection = planTable.querySelector("#planEditSection")
      var editBtn = planTable.querySelector("#editBtn")
      var editSaveBtn = planTable.querySelector("#editSaveBtn")

      planTr.style.display = "none"
      planEditSection.style.display = "flex"
      editBtn.type = "hidden"
      editSaveBtn.type = "submit"

      editSaveBtn.onclick = editSaveBtnEvent
    }
    function editSaveBtnEvent(e){
      e.preventDefault()
      var planTable = e.target.parentElement
      var editInput = planTable.querySelector("#planEditInput").value
      if(contentValidationEvent(editInput)){
        var planForm = document.querySelector("#planForm")
      planForm.action = "../action/editPlanAction.jsp"
      planForm.submit()
      }
    }

    window.onload = function(){
      createInputSetTime()
      receiveUserPlan(userPlan)
    }
  </script>
  <script src="../javascript/validation.js"></script>
</body>
