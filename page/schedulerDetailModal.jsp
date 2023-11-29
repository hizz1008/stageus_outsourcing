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
          <select class="selectStartHour" name="startHour"></select>
          <select class="selectStartMin" name="startMin"></select>
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
    console.log(userPlan)



    function createSetTime() {
      var hour = 24;
      var min = 60;
      var selectStartHour = document.querySelector(".selectStartHour")
      var selectEndHour = document.querySelector(".selectEndHour")

      var selectStartMin = document.querySelector(".selectStartMin")
      var selectEndMin = document.querySelector(".selectEndMin")

      for (var i = 0; i < hour; i++) {
        var optionStartHour = document.createElement("option")
        var optionEndHour = document.createElement("option")
        optionStartHour.textContent = i
        optionEndHour.textContent = i
        optionStartHour.value = i
        optionEndHour.value = i
        selectStartHour.appendChild(optionStartHour)
        selectEndHour.appendChild(optionEndHour)
      }

      for (var j = 0; j < min; j++) {
        var optionStartMin = document.createElement("option")
        var optionEndMin = document.createElement("option")
        optionStartMin.textContent = j
        optionEndMin.textContent = j
        optionStartMin.value = j
        optionEndMin.value = j
        selectStartMin.appendChild(optionStartMin)
        selectEndMin.appendChild(optionEndMin)
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
        var deleteBtn = document.createElement("input")
        var deleteInput = document.createElement("input")

        deleteInput.type = "hidden"
        deleteInput.value = userPlan.idx[i]
        deleteInput.name = "deleteIdx"

        planTable.className = "planTable"
        planTr.className = "planTr"

        editBtn.value = "수정"
        editBtn.type = "submit"
        editBtn.className = "btnStyle"
        deleteBtn.value = "삭제"
        deleteBtn.type = "submit"
        deleteBtn.onclick = deleteBtnEvent
        deleteBtn.className = "btnStyle"

        planTitle.textContent = userPlan.content[i]
        planTitle.className = "planTitle"
        
        var startHour = userPlan.startHour[i].toString().padStart(2, "0")
        var startMin = userPlan.startMin[i].toString().padStart(2, "0")
        var endHour = userPlan.endHour[i].toString().padStart(2, "0")
        var endMin = userPlan.endMin[i].toString().padStart(2, "0")
        
        startTime.textContent = startHour + ":" + startMin
        startTime.className = "startTime";
        endTime.textContent = endHour + ":" + endMin
        endTime.className = "endTime";

        planTable.appendChild(planTr)

        planTr.appendChild(planTitle)
        planTr.appendChild(startTime)
        planTr.appendChild(endTime)

        planTable.appendChild(editBtn)
        planTable.appendChild(deleteBtn)
        planTable.appendChild(deleteInput)

        planSection.appendChild(planTable)
      }
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
    window.onload = function(){
      createSetTime();
      receiveUserPlan(userPlan)
    }

    function deleteBtnEvent(e){
      var planForm = document.querySelector("#planForm")
      e.preventDefault()
      planForm.action = "../action/deletePlanAction.jsp"
      planForm.submit()
    }
  </script>
  <script src="../javascript/validation.js"></script>
</body>
