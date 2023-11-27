<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <title>Find Id Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">아이디 찾기</h1>
      <form id="form" class="formstyle">
        <input id="nameInput" class="inputStyle" type="text" placeholder="이름" name="name">
        <input id="telInput" class="inputStyle" type="tel" placeholder="전화번호" name="tel">
        <p class="telValidationTextStyle">- 없이 기입해주세요</p>
        <input class="btnStyle BGcolorBlue loginBtn" type="submit" value="확인" onclick="findIdFormValidationEvent(event)">
  
        <a class="aLinkStyle" href="./findPasswordPage.jsp">비밀번호 찾기</a>
      </form>
    </section>
  </main>
  <script>
    function findIdFormValidationEvent(e){
      e.preventDefault()
      var form = document.querySelector("#form")
      var name = document.querySelector("#nameInput")
      var tel = document.querySelector("#telInput")
      if(!koreanValidationEvent(name)){
        return alert("올바른 이름을 입력해주세요")
      }else if(!numValidationEvent(tel) || tel.value.length !== 11){
        return alert("올바른 전화번호를 입력해주세요")
      }else{
        form.action = "../action/findIdAction.jsp"
        form.submit()
      }
    }
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>