<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/loginPage.css" type="text/css">
  <title>Find Password Page</title>
</head>
<body>
  <header class="header"></header>
  <main class="main">
    <section class="section">
      <h1 class="Title">비밀번호 찾기</h1>
      <form class="Form">
        <input class="inputStyle" type="text" value="아이디" onfocus="inputFocus(event)" onblur="inputBulr(event)">
        <input class="inputStyle" type="tel" value="전화번호" onfocus="inputFocus(event)" onblur="inputBulr(event)">
        <p class="telValidationText">- 없이 기입해주세요</p>
        <input class="btnStyle loginBtn" type="submit" value="확인">
      </form>
    </section>
  </main>
  <script src="../javascript/inputFocusBulr.js"></script>
  <script src="../javascript/createHeader1.js"></script>
</body>