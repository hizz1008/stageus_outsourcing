<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/schedulerPage.css" type="text/css">
  <title>Schedule Page</title>
</head>
<body>
  <header class="header">
  </header>
  <div class="blackBackground"></div>
  <nav class="nav">
    <div class="navHeader">
      <p class="navUserInfo"></p>
      <a href="./page/userProfilePage.jsp" class="navUserName"></a>
      <input class="closeNavBtn" type="button" value="X" onclick="closeNavEvent()">
    </div>

    <div class="otherUserProfiles">
      <p class="otherUserDepartment"></p>
      <div class="otherUserNames"></div>
    </div>
  </nav>
  <main class="main">
  </main>
  <script>
    var userProfiles = {
      name: "방준연",
      tel: "01001000100",
      department: "개발팀",
      position: "팀장",
    }
    var otherUserProfiles = {
      name: ["사용자1","사용자2","사용자3"],
      department: ["개발팀","개발팀","디자인팀"],
      position: ["팀원","팀원","팀원"]
    }
    var user = {
      yearNum : 2023,
      monthNum : 11,
      dayNum : [1,2,3,4,5,6,7],
      planNum : [9,8,7,6,5,4,3]
    }
    var userPlan = {
      title : ["밥 먹기", "빨래하기"],
      startTime : ["11:00", "13:00"],
      endTime : ["12:00", "14:00"],
      dayNum : 3
    }
    var user1 = {
      yearNum : 2023,
      monthNum : 11,
      dayNum : [3,5,12,15],
      planNum : [2,10,32,100]
    }
    var user2 = {
      yearNum : 2023,
      monthNum : 11,
      dayNum : [1,2,3,4],
      planNum : [1,2,20,100]
    }
    var user3 = {
      yearNum : 2023,
      monthNum : 11,
      dayNum : [5,6,7,8],
      planNum : [2,10,32,100]
    }
    function createUserProfiles(){
      var navUserInfo = document.querySelector(".navUserInfo")
      var navUserName = document.querySelector(".navUserName")
      navUserInfo.textContent = userProfiles.department + " " + userProfiles.position
      navUserName.textContent = userProfiles.name
    }
    createUserProfiles()
    function createOtherUserProfiles(){
      var navOtherUserProfiles = document.querySelector(".navotherUserProfiles")
      var otherUserDepartment = document.querySelector(".otherUserDepartment")
      var otherUserNames = document.querySelector(".otherUserNames")

      for(var i = 0; i < otherUserProfiles.name.length; i++){
        if(otherUserProfiles.department[i] === userProfiles.department){
          otherUserDepartment.textContent = otherUserProfiles.department[i]
          var otherUserName = document.createElement("p")
          otherUserName.textContent = otherUserProfiles.name[i]
          otherUserNames.appendChild(otherUserName)
        }
      }
    }
    createOtherUserProfiles();


    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1;
    function createHeader(){
      var header = document.querySelector(".header")

      var left = document.createElement("div")
      left.className = "left"
        var headerbars = document.createElement("i")
        headerbars.id = "headerbars"
        headerbars.className = "fa-solid fa-bars headerbars"
        headerbars.onclick = headerbarsEvent

        var headerLogo = document.createElement("a")
        headerLogo.className = "headerLogo"
        headerLogo.textContent = "Stageus"
        headerLogo.href = "./index.jsp"

      left.appendChild(headerbars)
      left.appendChild(headerLogo)
      var center = document.createElement("div")
      center.className = "center"
        var leftBtn = document.createElement("i")
        leftBtn.id = "leftBtn"
        leftBtn.className = "fa-solid fa-caret-left leftBtn"
        leftBtn.onclick = leftBtnEvent;

        var yearText = document.createElement("p")
        yearText.className = "yearText"
        yearText.textContent = currentYear

        var rightBtn = document.createElement("i")
        rightBtn.id = "rightBtn"
        rightBtn.className = "fa-solid fa-caret-right rightBtn"
        rightBtn.onclick = rightBtnEvent;

        var monthList = document.createElement("ol")
        monthList.className = "monthList"
          for(var i = 1; i <= 12; i++){
            var month = document.createElement("li")
            month.className = "month"
            month.textContent = i
            month.value = i
            month.onclick = monthEvent
            if(i === currentMonth){
              month.classList.add("selectedMonth")
            }
            monthList.appendChild(month)
          }
      center.appendChild(leftBtn)
      center.appendChild(yearText)
      center.appendChild(rightBtn)
      center.appendChild(monthList)

      var right = document.createElement("div")
        right.className = "right"
        var userName = document.createElement("a")
        userName.className = "userName"
        userName.textContent = userProfiles.name
        userName.href = "./page/userProfilePage.jsp"
        
        var form = document.createElement("form")
        var logoutBtn = document.createElement("input")
        logoutBtn.className = "logoutBtn"
        logoutBtn.type = "submit"
        logoutBtn.value = "로그아웃"
        form.appendChild(logoutBtn)

      right.appendChild(userName)
      right.appendChild(form)

      header.appendChild(left)
      header.appendChild(center)
      header.appendChild(right)
    }
    createHeader()

    function leftBtnEvent(){
      currentYear--
      var yearText = document.querySelector(".yearText")
      yearText.textContent = currentYear
      calendar()
    }

    function rightBtnEvent(){
      currentYear++
      var yearText = document.querySelector(".yearText")
      yearText.textContent = currentYear
      calendar()

    }

    function monthEvent(e){
      var monthCells = document.querySelectorAll(".month")
      monthCells.forEach(cell=>{
        cell.classList.remove("selectedMonth")
      })
      var monthCell = e.target
      monthCell.classList.add("selectedMonth")
      currentMonth = monthCell.value

      calendar()
      //세션으로 사용
    }
    function calendar(){
      var main = document.querySelector(".main")
      main.innerHTML = ""
      var amountBox = 35;

      var main = document.querySelector(".main")
      var totalDaysInMonth = new Date(currentYear, currentMonth, 0).getDate();
      
      for(var i = 1; i <= amountBox; i++){
        var calendarCell = document.createElement("div")
        var calendarCellText = document.createElement("p")
        var cellNum = document.createElement("p")
        var planTitle = document.createElement("p")
        cellNum.className = "cellTitle"
        planTitle.className = "planTitle"
        planTitle.onclick = scheduleOpenEvent

        if(currentYear === user.yearNum && currentMonth === user.monthNum){
          if(user.dayNum.includes(i)){
            var index = user.dayNum.indexOf(i)
            var planNumber = user.planNum[index]
            if(planNumber >= 100){
              planTitle.textContent = "99+";
              calendarCell.appendChild(planTitle);
            }else{
              planTitle.textContent = planNumber;
              calendarCell.appendChild(planTitle);
            }
            cellNum.textContent = i
          }
          else if(i <= totalDaysInMonth){
            cellNum.textContent = i;
          }else{
            cellNum.textContent = ""
          }
        }
        else if(i <= totalDaysInMonth){
          cellNum.textContent = i;
        }else{
          cellNum.textContent = ""
        }
        calendarCell.className = "cell"
        calendarCell.appendChild(cellNum);
        main.appendChild(calendarCell);
      }
    }
  calendar()
  
  function scheduleOpenEvent(){
    var childWindow = window.open("./page/scheduleDetailsPage.jsp", "_blank", "width=600,height=400");
    childWindow.onload = ()=>{
      childWindow.receiveUserPlan(userPlan);
    }
  }


  function closeNavEvent(){
    var nav = document.querySelector(".nav")
    var blackBackground = document.querySelector(".blackBackground")
    nav.style.left = "-100%"
    blackBackground.style.display = "none"
  }
  //함수 이름 통일성 필요

  function headerbarsEvent(){
    var nav = document.querySelector(".nav")
    var blackBackground = document.querySelector(".blackBackground")
    nav.style.left = "0%"
    blackBackground.style.display = "block"
  }
  
  </script>
  <script src="https://kit.fontawesome.com/e8e74eadbe.js" crossorigin="anonymous"></script>
</body>