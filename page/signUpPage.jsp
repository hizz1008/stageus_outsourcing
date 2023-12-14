<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <link rel="stylesheet" href="../css/signUpPage.css" type="text/css">
  <title>SignUp Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
   <section class="sectionStyle">
    <h1 class="titleStyle">스케줄러 로그인</h1>
    <form id="form" class="formstyle">
    <div class="idInputDiv">
        <input id="idInput" class="idInputStyle" type="text" placeholder="아이디" name="id" onchange="idOnchangeEvent()">
        <input id="idDuplicationInput" type="hidden" name="idDuplication" value="false">

        <input class="idValidationBtn" type="button" value="중복확인" onclick="IdDuplicateCheckEvent()">
      </div>

      <input id="passwordInput" class="inputStyle" type="password" placeholder="비밀번호" name="password">

      <input id="passwordConfirmInput" class="inputStyle" type="password" placeholder="비밀번호 재입력"
      oninput="passwordValidationEvent(event)">

      <p id="passwordValidationText" class="passwordValidationTextStyle"></p>

      <input id="nameInput" class="inputStyle" type="text" placeholder="이름" name="name">

      <input id="telInput" class="inputStyle" type="tel" placeholder="전화번호" name="tel">

      <p class="telValidationTextStyle">- 없이 기입해주세요</p>

      <select id="departmentSelect" class="selectStyle" name="department">
        <option selected disabled>부서</option>
        <option value="1">개발팀</option>
        <option value="2">디자인팀</option>
      </select>

      <select id="positionSelect" class="selectStyle" name="position">
        <option selected disabled>직책</option>
        <option value="1">팀장</option>
        <option value="2">팀원</option>
      </select>
      
      <input class="btnStyle BGcolorgreen" type="button" value="회원가입" onclick="signUpValidationEvent(event)"></input>
      <!-- Sumit의 정의에 대해 찾아보기-->


    </form>
   </section>
  </main>
  <script>
    document.addEventListener("keydown", function(event){
      if(event.key === "Enter"){
        signUpValidationEvent()
      }
    });
    function idOnchangeEvent(){
      idDuplicationInput.value = "false"
    }

    function receiveDataFromChild(data){
      console.log(data)
    }

    function IdDuplicateCheckEvent(){
      var form = document.querySelector("#form")
      var idInput = document.querySelector("#idInput")
      var idDuplicationInput = document.querySelector("#idDuplicationInput")
      if(!numEnglishValidation(idInput)){
        idInput.disabled = false;
        idDuplicationInput.value = "false"
        return idAlert()
      }else{
      var childWindow = window.open("../action/checkDPIdAction.jsp?id="+idInput.value,"","width=500,height=300")
      }
    }

    function passwordValidationEvent(e){
    var passwordInput = document.querySelector("#passwordInput");
    var passwordValidationText = document.querySelector("#passwordValidationText");

    if(e.currentTarget.value === passwordInput.value){
      passwordValidationText.textContent = "비밀번호가 일치합니다";
      passwordValidationText.style.color = "#4285F4";
    } else {
      passwordValidationText.textContent = "비밀번호가 일치하지 않습니다";
      passwordValidationText.style.color = "#FF0101";
    }
  }

  function signUpValidationEvent(){
    // e.preventDefault()
    var signUpForm = document.querySelector("#form")
    var idInput = document.querySelector("#idInput")
    var idDuplicationInput = document.querySelector("#idDuplicationInput")
    var passwordInput = document.querySelector("#passwordInput")
    var passwordConfirmInput = document.querySelector("#passwordConfirmInput")
    var nameInput = document.querySelector("#nameInput")
    var telInput = document.querySelector("#telInput")
    var departmentSelect = document.querySelector("#departmentSelect")
    var positionSelect = document.querySelector("#positionSelect")


    if (idDuplicationInput.value === "false"){
      return alert("아이디 중복을 확인해주세요");
    } else if(!numEnglishValidation(passwordInput)){
      return passwordAlert()
    } else if(passwordInput.value !== passwordConfirmInput.value){
      return alert("비밀번호가 일치하지 않습니다")
    } else if (!koreanValidation(nameInput)){
      return nameAlert()
    } else if (!numValidation(telInput) || telInput.value.length !== 11){
      return telAlert()
    } else if(departmentSelect.value === "부서"){
      return alert("부서를 선택해주세요");
    } else if(positionSelect.value === "직책"){
      return alert("직책을 선택해주세요");
    }else{
      idInput.disabled = false
      signUpForm.action = "../action/signUpAction.jsp"
      signUpForm.submit();
    }
  }


  
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>