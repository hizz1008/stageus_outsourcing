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
  <link rel="stylesheet" href="../css/userProfilePage.css" type="text/css">
  <title>User Profile Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">개인정보</h1>
      <section class="userProfile">
        <p class="userProfileInfo">이름 : <span class="name"></span></p>
        <p class="userProfileInfo">전화번호 : <span class="tel"></span></p>
        <p class="userProfileInfo">부서 : <span class="department"></span></p>
        <p class="userProfileInfo">직책 : <span class="position"></span></p>
      </section>
      <section class="userProfileBtns">
        <input class="userProfileBtnStyle editBtn" type="button" value="수정" onclick="editPageEvent()">
        <input class="userProfileBtnStyle deleteBtn" type="button" value="탈퇴"
        onclick="confirmationAlert()">
      </section>
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
      document.querySelector(".name").textContent = userProfile.name
      document.querySelector(".tel").textContent = userProfile.tel
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
      document.querySelector(".department").textContent = userProfile.department
      
      document.querySelector(".position").textContent = userProfile.position
    }
    
    //
    function confirmationAlert(){
      var confirmAlert = confirm("정말로 탈퇴하시겠습니까?")
      if(confirmAlert){
        return alert("탈퇴되었습니다")
      }
      else{
        return
      }
    }
    //
    function editPageEvent(){
      window.location.href = "./editUserProfilePage.jsp"
    }
    window.onload = function(){
      updateUserProfile()
    }
  </script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>