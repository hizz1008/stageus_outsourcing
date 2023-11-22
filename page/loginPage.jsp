<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/loginPage.css" type="text/css">
  <title>Login Page</title>
</head>
<body>
  <header class="header"></header>
  <main class="main">
    <section class="section">
      <h1 class="title">스케줄러 로그인</h1>
      <form class="form">
        <input class="inputStyle" type="text" value="아이디" onfocus="inputFocus(event)" onblur="inputBulr(event)">
        <input class="inputStyle" type="text" value="비밀번호" onfocus="inputFocus(event)" onblur="inputBulr(event)" onclick="typePasswordEvent(event)">
        <input class="btnStyle loginBtn" type="submit" value="로그인">
        <a class="btnStyle signUpBtn" href="./signUpPage.jsp">회원가입</a>
  
        <a class="aLink" href="./findIdPage.jsp">아이디 찾기</a>
        <a class="aLink" href="./findPasswordPage.jsp">비밀번호 찾기</a>
      </form>
    </section>
  </main>
  <script>
    function typePasswordEvent(e){
      e.target.type = "password"
    }
  </script>
  <script src="../javascript/inputFocusBulr.js"></script>
  <script src="../javascript/createHeader1.js"></script>
</body>