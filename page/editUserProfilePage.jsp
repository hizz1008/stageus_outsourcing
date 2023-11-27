<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  Integer idx = (Integer)session.getAttribute("loggedInSession");

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");

  String name = "";
  String tel = "";
  int department = -1;
  int position = -1;

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
    response.sendRedirect("../index.jsp");
  }
%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <link rel="stylesheet" href="../css/editUserProfilePage.css" type="text/css">
  <title>Edit User Profile Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">개인정보 수정</h1>
      <form id="form" class="editUserProfile">
        <p class="infoStyle">이름</p>
        <input id="nameInput" class="inputStyle" type="text" name="name">
        <p class="infoStyle">전화번호</p>
        <input id="telInput" class="inputStyle" type="tel" name="tel">

        <p class="infoStyle">부서</p>
        <select id="departmentSelect" class="selectStyle" name="department">
          <option value=1>개발팀</option>
          <option value=2>디자인팀</option>
        </select>
  
        <p class="infoStyle">직책</p>
        <select id="positionSelect" class="selectStyle" name="position">
          <option value=1>팀장</option>
          <option value=2>팀원</option>
        </select>
        <input class="btnStyle BGcolorBlue" type="button" value="수정" onclick="editUserInputValidationEvent(event)">
      </form>

    </section>
  </main>
  <script>
    var idx = <%=idx%>;

    var userProfile = {
        name : "<%=name%>",
        tel : "<%=tel%>",
        department : <%=department%>,
        position : <%=position%>
    };
    function updateUserProfile(){
      document.querySelector("#nameInput").value = userProfile.name
      document.querySelector("#telInput").value = userProfile.tel
    }
    function editUserInputValidationEvent(e){
      e.preventDefault()
      var nameInput = document.querySelector("#nameInput")
      var telInput = document.querySelector("#telInput")
      var form = document.querySelector("#form")

      if(!koreanValidationEvent(nameInput)){
        return nameAlert()
      }else if(!numValidationEvent(telInput) || telInput.value.length !== 11){
        return telAlert()
      }else{
        form.action = "../action/updateUserProfileAction.jsp"
        form.submit()
      }
    }

  

 
    window.onload = function() {
      var departmentSelect = document.querySelector("#departmentSelect");
      var positionSelect = document.querySelector("#positionSelect")
      
      var departmentValue = userProfile.department;
      var positionValue = userProfile.position;
      for(var i = 0; i < departmentSelect.options.length; i++){
        if(departmentSelect.options[i].value == departmentValue){
          departmentSelect.selectedIndex = i
          break;
        }
      }

      for(var j = 0; j < positionSelect.options.length; j++){
        if(positionSelect.options[j].value == positionValue){
          positionSelect.selectedIndex = j
          break;
        }
      }
      updateUserProfile()
    }
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>