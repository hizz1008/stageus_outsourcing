<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList"%>
<%


  Integer idx = (Integer)session.getAttribute("loggedInSession");
  String name = (String) session.getAttribute("userName");
  String tel = (String) session.getAttribute("userTel");
  Integer department = (Integer)session.getAttribute("userDepartment");
  Integer position = (Integer)session.getAttribute("userPosition");

  String memberName = (String)session.getAttribute("memberName");
  Integer memberIdx = (Integer)session.getAttribute("memberIdx");
  if(memberName == null && memberIdx == null){
    memberName = "null";
    memberIdx = -1;
  }

  Integer currentYear = (Integer)session.getAttribute("currentYear");
  Integer currentMonth = (Integer)session.getAttribute("currentMonth");

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");

  ArrayList<Integer> planDayList = new ArrayList<Integer>();

  ArrayList<Integer> teamMemberIdxList = new ArrayList<Integer>();
  ArrayList<String> nameList = new ArrayList<String>();
  ArrayList<Integer> departmentList = new ArrayList<Integer>();
  ArrayList<Integer> positionList = new ArrayList<Integer>();

  ArrayList<Integer> memberPlanDayList = new ArrayList<Integer>();

  if(idx == null){
    response.sendRedirect("../index.jsp");
  }else{
    //자신 일정 개수 가져오기
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
    //자신 일정 개수 가져오기

    //포지션이 팀장일 때 팀원 가져오기
    if(position == 1){
      String teamMemberSql = "SELECT idx, name, department, position FROM account WHERE department = ? AND position = 2";
      PreparedStatement teamMemberQuery = connect.prepareStatement(teamMemberSql);
      teamMemberQuery.setInt(1,department);
      // 데이터 테이블로 사용
      ResultSet teamMemberResult = teamMemberQuery.executeQuery();

      while (teamMemberResult.next()) {
        int teamMemberIdx = teamMemberResult.getInt("idx");
        String teamMemberName = teamMemberResult.getString("name");
        int teamMemberDepartment = teamMemberResult.getInt("department");
        int teamMemberPosition = teamMemberResult.getInt("position");

        teamMemberIdxList.add(teamMemberIdx);
        nameList.add("\""+teamMemberName+"\"");
        departmentList.add(teamMemberDepartment);
        positionList.add(teamMemberPosition);
      }    
    }
    //포지션이 팀장일 때 팀원 가져오기

    if(memberName != null && memberIdx != -1){
      //세션을 사용하고 있기에 그것으로 예외처리 사용
      //if문 순서 다시 설정

      String getMemberPlanNumSql = "SELECT day_column FROM plan WHERE account_idx = ? AND year_column = ? AND month_column = ?";
      PreparedStatement getMemberPlanNumQuery = connect.prepareStatement(getMemberPlanNumSql);
      getMemberPlanNumQuery.setInt(1,memberIdx);
      getMemberPlanNumQuery.setInt(2,currentYear);
      getMemberPlanNumQuery.setInt(3,currentMonth);


      ResultSet getMemberPlanNumResult = getMemberPlanNumQuery.executeQuery();
      
      while(getMemberPlanNumResult.next()){
        int memberPlanDay = Integer.parseInt(getMemberPlanNumResult.getString("day_column"));
        memberPlanDayList.add(memberPlanDay);
      }
    }    
  }
%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginAfterHeader.css">
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
      <p class="teamMemberDepartment"></p>
      <div class="teamMemberNames"></div>
    </div>
  </nav>
  <main class="main">
  </main>
  <script>
    var idx = <%=idx%>
    var currentYear = <%=currentYear%>
    var currentMonth = <%=currentMonth%>

    var userProfile = {
        idx : <%=idx%>,
        name : "<%=name%>",
        tel : "<%=tel%>",
        department : <%=department%>,
        position : <%=position%>,
        planDayList : <%=planDayList%>
    };

    var teamMemberList = {
      idx:<%=teamMemberIdxList%>,
      name: <%=nameList%>,
      department: <%=departmentList%>,
      position: <%=positionList%>
    }

    var memberProfile = {
      idx : <%=memberIdx%>,
      name : "<%=memberName%>",
      planDayList : <%=memberPlanDayList%>
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
    
    function createTeamMemberProfile(){
      var teamMemberSection = document.querySelector(".navotherUserProfile")
      var teamMemberDepartment = document.querySelector(".teamMemberDepartment")
      var teamMemberNames = document.querySelector(".teamMemberNames")

      for(var i = 0; i < teamMemberList.name.length; i++){
        if(teamMemberList.department[i] == 1){
          teamMemberDepartment.textContent = "개발팀"
        }else{
          teamMemberDepartment.textContent = "디자인팀"
        }
          var teamMemberForm = document.createElement("form")
          var teamMemberNameBtn = document.createElement("input")
          var teamMemberIdx = document.createElement("input")
          var teamMemberName = document.createElement("input")
          teamMemberForm.id = "teamMemberForm"

          teamMemberIdx.type = "hidden"
          teamMemberIdx.name = "teamMemberIdx"
          teamMemberIdx.value = teamMemberList.idx[i]

          teamMemberName.type = "hidden"
          teamMemberName.name = "teamMemberName"
          teamMemberName.value = teamMemberList.name[i]
          
          teamMemberNameBtn.type = "button"
          teamMemberNameBtn.className = "teamMemberNameBtn"
          teamMemberNameBtn.name = "teamMemberNameBtn"
          teamMemberNameBtn.value = teamMemberList.name[i]
          teamMemberNameBtn.onclick = teamMemberScheduleEvent

          teamMemberForm.appendChild(teamMemberIdx)
          teamMemberForm.appendChild(teamMemberName)
          teamMemberForm.appendChild(teamMemberNameBtn)
          teamMemberNames.appendChild(teamMemberForm)
      }
    }
    

    //target과 cureentTarget차의


    var currentDate = new Date();

    function createHeader(){
      var header = document.querySelector(".header")

      //left
      var left = document.createElement("div")
      left.className = "left"
        if(userProfile.position === "팀장"){
          var headerbars = document.createElement("i")
          headerbars.id = "headerbars"
          headerbars.className = "fa-solid fa-bars headerbars"
          headerbars.onclick = openNavEvent
          left.appendChild(headerbars)
        }
        var headerLogo = document.createElement("a")
        headerLogo.className = "headerLogo"
        headerLogo.textContent = "Stageus"
        headerLogo.href = "./index.jsp"


      left.appendChild(headerLogo)
      //left
      //center
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
      //center
      //rigth
      var right = document.createElement("div")
        right.className = "right"
        var userName = document.createElement("a")
        userName.className = "userName"
        userName.textContent = userProfile.name
        userName.onclick = refreshEvent
    
        var logoutBtn = document.createElement("a")
        logoutBtn.className = "logoutBtn"
        logoutBtn.href = "../action/logOutAction.jsp"
        logoutBtn.textContent = "로그아웃"

        if(memberProfile.name != "null"){
          var memberName = document.createElement("p")
          memberName.textContent = memberProfile.name
          memberName.className = "memberName"
          userName.textContent = "내 일정"
          userName.onclick = refreshEvent
          right.appendChild(userName)
          right.appendChild(memberName)
        }else{
          right.appendChild(userName)
          right.appendChild(logoutBtn)
        }



      header.appendChild(left)
      header.appendChild(center)
      header.appendChild(right)
      //rigth
    }

    //create header
    
  function calendar(profile) {
    var main = document.querySelector(".main");
    var amountBox = 35;

    var totalDaysInMonth = new Date(currentYear, currentMonth, 0).getDate();

    for (var i = 1; i <= amountBox; i++) {
      var calendarCell = document.createElement("div");
      var calendarCellText = document.createElement("p");
      var cellNum = document.createElement("p");
      var planTitle = document.createElement("p");
      cellNum.className = "cellTitle"
      cellNum.id = "cellNum"
      planTitle.className = "planTitle"
      calendarCell.onclick = schedulerDetailOpenEvent

      if (profile.planDayList) {
        if (profile.planDayList.includes(i)) {
          var index = profile.planDayList.indexOf(i)
          var planNumber = profile.planDayList[index]
          var planCount = profile.planDayList.filter(num => num === i).length
          if (planNumber >= 100) {
            planTitle.textContent = "99+"
          } else {
            planTitle.textContent = planCount
          }
          cellNum.textContent = i
        } else if (i <= totalDaysInMonth) {
          cellNum.textContent = i
        } else {
          cellNum.textContent = ""
        }
      } else {
        if (i <= totalDaysInMonth) {
          cellNum.textContent = i
        } else {
          cellNum.textContent = ""
        }
      }

      calendarCell.appendChild(cellNum);
      calendarCell.className = "cell";
      calendarCell.appendChild(planTitle);
      main.appendChild(calendarCell);
    }
  }


  function refreshEvent(){
    memberProfile.name = "null"
    memberProfile.planDayList = []

    window.location.href = "../action/deleteMemberSessionAction.jsp"
  }

  function teamMemberScheduleEvent(e){
    e.preventDefault()
    var teamMemberForm = e.currentTarget.parentElement
    teamMemberForm.action = "../action/saveMemberSessionAction.jsp"
    teamMemberForm.submit()
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
    window.location.href = "../action/updateCurrentMonthAction.jsp?currentMonth=" + monthValue;
  }
  
  
  function schedulerDetailOpenEvent(e){
    var childWindow
    if(!e.currentTarget.textContent){
      return
    }
    else if(memberProfile.name != "null"){
      var cellNum = e.currentTarget.querySelector("#cellNum").textContent
      childWindow = window.open("./schedulerDetailModal.jsp?day=" + cellNum, "_blank", "width=700,height=800");
    }
    else{
      var cellNum = e.currentTarget.querySelector("#cellNum").textContent
      childWindow = window.open("./schedulerDetailModal.jsp?day=" + cellNum, "_blank", "width=700,height=800");
    }
  }



  function closeNavEvent(){
    var nav = document.querySelector(".nav")
    var blackBackground = document.querySelector(".blackBackground")
    nav.style.left = "-100%"
    blackBackground.style.display = "none"
  }

  function openNavEvent(){
    var nav = document.querySelector(".nav")
    var blackBackground = document.querySelector(".blackBackground")
    nav.style.left = "0%"
    blackBackground.style.display = "block"
  }

  window.onload = function(){
    createUserProfile()
    createTeamMemberProfile();
    createHeader()
    if(memberProfile.name == "null"){
      calendar(userProfile)
    } else {
      calendar(memberProfile)
    }
  }

  
  </script>
  <script src="https://kit.fontawesome.com/e8e74eadbe.js" crossorigin="anonymous"></script>
</body>