<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./css/common.css" type="text/css">
  <link rel="stylesheet" href="./css/loginBeforeHeader.css" type="text/css">
  <link rel="stylesheet" href="./css/index.css" type="text/css">
  <title>Login Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="main">
    <section class="section">
      <h1 class="title">스케줄러 로그인</h1>
      <form id="form" class="formstyle">
        <input id="idInput" class="inputStyle" type="text" placeholder="아이디">
        <input id="passwordInput" class="inputStyle " type="password" placeholder="비밀번호">
        <input class="btnStyle loginBtn" type="submit" value="로그인" onclick="loginFormValidationEvent(event)">
        <a class="btnStyle signUpBtn" href="./signUpPage.jsp">회원가입</a>
  
        <a class="aLink" href="./page/findIdPage.jsp">아이디 찾기</a>
        <a class="aLink" href="./page/findPasswordPage.jsp">비밀번호 찾기</a>
      </form>
    </section>
  </main>
  <script>
    function loginFormValidationEvent(e){
      e.preventDefault()
      var id = document.querySelector("#idInput")
      var password = document.querySelector("#passwordInput")
      var form = document.querySelector("#form")
      if(!numEnglishValidationEvent(id)){
        return alert("올바른 아이디를 입력해주세요")
      }else if(!numEnglishValidationEvent(password)){
        return alert("올바른 비밀번호를 입력해주세요")
      }
      form.submit()
    }
  </script>
  <script src="./javascript/validation.js"></script>
  <script src="./javascript/beforeLoginHeader.js"></script>
</body>