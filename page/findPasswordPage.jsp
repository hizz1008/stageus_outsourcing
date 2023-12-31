<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <title>Find Password Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">비밀번호 찾기</h1>
      <form id="form" class="formstyle">
        <input id="idInput" class="inputStyle" type="text" placeholder="아이디" name="id">
        <input id="telInput" class="inputStyle " type="tel" placeholder="전화번호" name="tel">
        <p class="telValidationTextStyle">- 없이 기입해주세요</p>
        <input id="loginBtn" class="btnStyle BGcolorBlue" type="button" value="확인" onclick="findPasswordFormValidationEvent(event)">
      </form>
    </section>
  </main>
  <script>
    function findPasswordFormValidationEvent(){
      var form = document.querySelector("#form")
      var id = document.querySelector("#idInput")
      var tel = document.querySelector("#telInput")
      if(!numEnglishValidation(id)){
        return idAlert()
      }else if(!numValidation(tel) || tel.value.length !== 11){
        return telAlert()
      }else{
        form.action = "../action/findPasswordAction.jsp"
        form.submit()
      }
    }
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>