<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <input id="idInput" class="inputStyle" type="text" placeholder="아이디">
        <input id="telInput" class="inputStyle " type="tel" placeholder="전화번호">
        <p class="telValidationTextStyle">- 없이 기입해주세요</p>
        <input id="loginBtn" class="btnStyle BGcolorBlue" type="submit" value="확인" onclick="findPasswordFormValidationEvent(event)">
      </form>
    </section>
  </main>
  <script>
    function findPasswordFormValidationEvent(e){
      e.preventDefault()
      var form = document.querySelector("#form")
      var id = document.querySelector("#idInput")
      var tel = document.querySelector("#telInput")
      if(!numEnglishValidationEvent(id)){
        return idAlert()
      }else if(!numValidationEvent(tel) || tel.value.length !== 11){
        return telAlert()
      }else{
        form.submit()
      }
    }
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/createHeader1.js"></script>
</body>