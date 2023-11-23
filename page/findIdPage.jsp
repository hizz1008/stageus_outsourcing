<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <link rel="stylesheet" href="../css/findIdPage.css" type="text/css">
  <title>Find Id Page</title>
</head>
<body>
  <header class="header"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">아이디 찾기</h1>
      <form class="form formstyle">
        <input class="inputStyle nameInput" type="text" placeholder="이름">
        <input class="inputStyle telInput" type="tel" placeholder="전화번호">
        <p class="telValidationText">- 없이 기입해주세요</p>
        <input class="btnStyle BGcolorBlue loginBtn" type="submit" value="확인" onclick="findIdFormValidationEvent(event)">
  
        <a class="aLink" href="./findPasswordPage.jsp">비밀번호 찾기</a>
      </form>
    </section>
  </main>
  <script>
    function findIdFormValidationEvent(e){
      e.preventDefault()
      var form = document.querySelector(".form")
      var name = document.querySelector(".nameInput")
      var tel = document.querySelector(".telInput")
      if(nameValidationEvent(name) && telValidationEvent(tel)){
        form.submit()
      }
    }
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/createHeader1.js"></script>
</body>