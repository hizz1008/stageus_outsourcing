<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/scheduleDetailsPage.css" type="text/css">
  <title>Schedule Details Page</title>
</head>
<body>
  <header class="header">
    <h1 class="dayNum"></h1>
  </header>
  <main class="main">
    <section class="planSection">
    </section>

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

    <form class="inputSection">
      <input class="addPlanInput" type="text">
      <input class="addPlanBtn btnStyle" type="submit" value="등록" onclick="addPlanValidationEvent(event)">
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
        var planContent = document.createElement("div")
        var planTitle = document.createElement("p")
        var startTime = document.createElement("p")
        var endTime = document.createElement("p")
        var editBtn = document.createElement("input")
        var deleteBtn = document.createElement("input")

        planContent.className = "planContent"

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

        

        planContent.appendChild(planTitle)
        planContent.appendChild(startTime)
        planContent.appendChild(endTime)
        planContent.appendChild(editBtn)
        planContent.appendChild(deleteBtn)

        planSection.appendChild(planContent)
      }
    }
  </script>
  <script src="../javascript/validation.js"></script>
</body>