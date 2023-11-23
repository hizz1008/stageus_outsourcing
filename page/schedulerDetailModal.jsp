<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/schedulerDetailModal.css" type="text/css">
  <title>Schedule Details Page</title>
</head>
<body>
  <header id="header" class="headerStyle">
    <h1 class="dayNum"></h1>
  </header>
  <main class="mainStyle">
    <section class="planSection">
    </section>



    <form class="inputSection">
      <section class="setTimeSection">
        <div class="setStartTime">
          <p class="setStartTimeText">시작</p>
          <select class="selectStartHour"></select>
          <select class="selectStartMin"></select>
        </div>
        <div class="setEndTime">
          <p class="setEndTimeText">종료</p>
          <select class="selectEndHour"></select>
          <select class="selectEndMin"></select>
        </div>
      </section>
      <section class="addPlanSection">
        <input class="addPlanInput" type="text">
        <input class="addPlanBtn btnStyle" type="submit" value="등록" onclick="addPlanValidationEvent(event)">
      </section>
    </form>
  </main>
  <script>
    function createSetTime() {
      var hour = 24;
      var min = 60;
      var selectStartHour = document.querySelector(".selectStartHour");
      var selectEndHour = document.querySelector(".selectEndHour");

      var selectStartMin = document.querySelector(".selectStartMin");
      var selectEndMin = document.querySelector(".selectEndMin");

      for (var i = 0; i < hour; i++) {
        var optionStartHour = document.createElement("option");
        var optionEndHour = document.createElement("option");
        optionStartHour.textContent = i;
        optionEndHour.textContent = i;
        optionStartHour.value = i;
        optionEndHour.value = i;
        selectStartHour.appendChild(optionStartHour);
        selectEndHour.appendChild(optionEndHour);  
      }

      for (var j = 0; j < min; j++) {
        var optionStartMin = document.createElement("option");
        var optionEndMin = document.createElement("option");
        optionStartMin.textContent = j;
        optionEndMin.textContent = j;
        optionStartMin.value = j;
        optionEndMin.value = j;
        selectStartMin.appendChild(optionStartMin);
        selectEndMin.appendChild(optionEndMin);  
      }
    }
    var userPlan;

    createSetTime();
    function receiveUserPlan(data) {
      var dayNum = document.querySelector(".dayNum")
      var planSection = document.querySelector(".planSection")
 
      dayNum.textContent = data.dayNum;
      for(var i = 0; i < data.title.length; i++){
        var planTable = document.createElement("table")
        var planTr = document.createElement("tr")
        var planTitle = document.createElement("td")
        var startTime = document.createElement("td")
        var endTime = document.createElement("td")
        var editBtn = document.createElement("input")
        var deleteBtn = document.createElement("input")

        planTable.className = "planTable"
        planTr.className = "planTr"

        editBtn.value = "수정"
        editBtn.type = "submit"
        editBtn.className = "btnStyle"
        deleteBtn.value = "삭제"
        deleteBtn.type = "submit"
        deleteBtn.className = "btnStyle"

        planTitle.textContent = data.title[i]
        planTitle.className = "planTitle"
        startTime.textContent = data.startTime[i] + "-"
        startTime.className = "startTime"
        endTime.textContent = data.endTime[i]
        endTime.className = "endTime"

        

        planTable.appendChild(planTr)
        
        planTr.appendChild(planTitle)
        planTr.appendChild(startTime)
        planTr.appendChild(endTime)
        
        planTable.appendChild(editBtn)
        planTable.appendChild(deleteBtn)

        planSection.appendChild(planTable)
      }
    }
  </script>
  <script src="../javascript/validation.js"></script>
</body>