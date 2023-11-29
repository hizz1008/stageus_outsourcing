<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
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

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");

  String name = "";
  String tel = "";
  int department = -1;
  int position = -1;

  ArrayList<Integer> planDayList = new ArrayList<Integer>();

  if(idx == null){
    response.sendRedirect("../index.jsp");
  }
  else{
    String sql = "SELECT name, tel, department, position FROM account WHERE idx = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, idx);
  
    ResultSet result = query.executeQuery();
    if (result.next()) {
      name = result.getString("name");
      tel = result.getString("tel");
      department = result.getInt("department");
      position = result.getInt("position");
    }else{
      response.sendRedirect("../.jsp");
    }

    String getPlanNumSql = "SELECT day_column FROM plan WHERE account_idx = ? AND year_column = ? AND month_column = ?";
    PreparedStatement getPlanNumQuery = connect.prepareStatement(getPlanNumSql);
    getPlanNumQuery.setInt(1,idx);
    getPlanNumQuery.setInt(2,currentYear);
    getPlanNumQuery.setInt(3,currentMonth);
    
    ResultSet getPlanNumResult = getPlanNumQuery.executeQuery();
    while (getPlanNumResult.next()){
      int planDay = Integer.parseInt(getPlanNumResult.getString("day_column"));

      planDayList.add(planDay);
    }
  }
%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
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
      <a href="./userProfilePage.jsp" class="navUserName"></a>
      <input class="closeNavBtn" type="button" value="X" onclick="closeNavEvent()">
    </div>

    <div class="otherUserProfile">
      <p class="otherUserDepartment"></p>
      <div class="otherUserNames"></div>
    </div>
  </nav>
  <main class="main">
  </main>
  <script>
    var idx = <%=idx%>;
    var currentYear = <%=currentYear%>;
    var currentMonth = <%=currentMonth%>;

    var userProfile = {
        name : "<%=name%>",
        tel : "<%=tel%>",
        department : <%=department%>,
        position : <%=position%>,
        planDayList : <%=planDayList%>
    };
    console.log(userProfile.planDayList)

    var otherUserProfile = {
      name: ["사용자1","사용자2","사용자3"],
      department: ["개발팀","개발팀","디자인팀"],
      position: ["팀원","팀원","팀원"]
    }
    function createUserProfile(){
      var navUserInfo = document.querySelector(".navUserInfo")
      var navUserName = document.querySelector(".navUserName")
      if(userProfile.department === 1){
        userProfile.department = "개발팀"
      }else{
        userProfile.department = "디자인팀"
      }
      if(userProfile.position === 1){
        userProfile.position = "팀장"
      }else{
        userProfile.position = "팀원"
      }
      navUserInfo.textContent = userProfile.department + " " + userProfile.position
      navUserName.textContent = userProfile.name
    }
    
    function createOtherUserProfile(){
      var navOtherUserProfile = document.querySelector(".navotherUserProfile")
      var otherUserDepartment = document.querySelector(".otherUserDepartment")
      var otherUserNames = document.querySelector(".otherUserNames")

      for(var i = 0; i < otherUserProfile.name.length; i++){
        if(otherUserProfile.department[i] === userProfile.department){
          otherUserDepartment.textContent = otherUserProfile.department[i]
          var otherUserName = document.createElement("p")
          otherUserName.textContent = otherUserProfile.name[i]
          otherUserNames.appendChild(otherUserName)
        }
      }
    }
    


    var currentDate = new Date();
    function createHeader(){
      var header = document.querySelector(".header")

      var left = document.createElement("div")
      left.className = "left"
        var headerbars = document.createElement("i")
        headerbars.id = "headerbars"
        headerbars.className = "fa-solid fa-bars headerbars"
        headerbars.onclick = openNavEvent

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
        userName.textContent = userProfile.name
        userName.href = "./userProfilePage.jsp"
    
        var logoutBtn = document.createElement("a")
        logoutBtn.className = "logoutBtn"
        logoutBtn.href = "../action/logOutAction.jsp"
        logoutBtn.textContent = "로그아웃"

      right.appendChild(userName)
      right.appendChild(logoutBtn)

      header.appendChild(left)
      header.appendChild(center)
      header.appendChild(right)
    }
    

    function leftBtnEvent(){
      var yearText = document.querySelector(".yearText")
      window.location.href = "../action/minusCurrentYearAction.jsp";
    }

    function rightBtnEvent(){
      var yearText = document.querySelector(".yearText")
      window.location.href = "../action/plusCurrentYearAction.jsp";
    }

    function monthEvent(e){
      var monthCells = document.querySelectorAll(".month")
      monthCells.forEach(cell=>{
        cell.classList.remove("selectedMonth")
      })
      var monthCell = e.target
      var monthValue = monthCell.value
      window.location.href = "../action/currentMonthUpdateAction.jsp?currentMonth=" + monthValue;
    }
    function calendar() {
        var main = document.querySelector(".main")
        var amountBox = 35;

        var totalDaysInMonth = new Date(currentYear, currentMonth, 0).getDate();

        for (var i = 1; i <= amountBox; i++) {
            var calendarCell = document.createElement("div")
            var calendarCellText = document.createElement("p")
            var cellNum = document.createElement("p")
            var planTitle = document.createElement("p")
            cellNum.className = "cellTitle"
            cellNum.id = "cellNum"
            planTitle.className = "planTitle"
            calendarCell.onclick = schedulerDetailOpenEvent

            if (userProfile.planDayList.includes(i)) {
            var index = userProfile.planDayList.indexOf(i)
            var planNumber = userProfile.planDayList[index]
            var planCount = userProfile.planDayList.filter(num => num === i).length;

            if (planNumber >= 100) {
                planTitle.textContent = "99+"
            } else {
                planTitle.textContent = planCount;
            }
            cellNum.textContent = i
            } else if (i <= totalDaysInMonth) {
            cellNum.textContent = i
            } else {
            cellNum.textContent = ""
            }

            calendarCell.appendChild(cellNum)
            calendarCell.className = "cell"
            calendarCell.appendChild(planTitle)
            main.appendChild(calendarCell)
        }
    }

  
  function schedulerDetailOpenEvent(e){
    var cellNum = e.currentTarget.querySelector("#cellNum").textContent

    var childWindow = window.open("./schedulerDetailModal.jsp?year=" + currentYear + "&month=" + currentMonth + "&day=" + cellNum, "_blank", "width=700,height=800");

    // childWindow.onload = ()=>{
    //   childWindow.receiveUserPlan(userPlan);
    // }
  }


  function closeNavEvent(){
    var nav = document.querySelector(".nav")
    var blackBackground = document.querySelector(".blackBackground")
    nav.style.left = "-100%"
    blackBackground.style.display = "none"
  }
  //함수 이름 통일성 필요

  function openNavEvent(){
    var nav = document.querySelector(".nav")
    var blackBackground = document.querySelector(".blackBackground")
    nav.style.left = "0%"
    blackBackground.style.display = "block"
  }

  window.onload = function(){
    createUserProfile()
    createOtherUserProfile();
    createHeader()
    calendar()
  }

  
  </script>
  <script src="https://kit.fontawesome.com/e8e74eadbe.js" crossorigin="anonymous"></script>
</body>