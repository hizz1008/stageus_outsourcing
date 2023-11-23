<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <input id="idInput" class="idInputStyle" type="text" placeholder="아이디" onchange="idOnchangeEvent(event)">

        <input class="idValidationBtn" type="button" value="중복확인" onclick="IdDuplicateCheckEvent(event)">
      </div>

      <input id="passwordInput" class="inputStyle" type="password" placeholder="비밀번호">

      <input id="passwordConfirmInput" class="inputStyle" type="password" placeholder="비밀번호 재입력"
      oninput="passwordValidationEvent(event)">

      <p id="passwordValidationText" class="passwordValidationTextStyle"></p>

      <input id="nameInput" class="inputStyle" type="text" placeholder="이름">

      <input id="telInput" class="inputStyle" type="tel" placeholder="전화번호">

      <p class="telValidationTextStyle">- 없이 기입해주세요</p>

      <select id="departmentSelect" class="selectStyle">
        <option selected disabled>부서</option>
        <option value="개발팀">개발팀</option>
        <option value="디자인팀">디자인팀</option>
      </select>

      <select id="positionSelect" class="selectStyle">
        <option selected disabled>직책</option>
        <option value="팀장">팀장</option>
        <option value="팀원">팀원</option>
      </select>
      
      <input class="btnStyle BGcolorgreen" type="submit" value="회원가입" onclick="signUpValidationEvent(event)"></input>
      
    </form>
   </section>
  </main>
  <script>

    function idOnchangeEvent(e){
      var idInput = e.target.value
      if(idInput === e.target.value){
        
      }
    }

    function IdDuplicateCheckEvent(){
      var idInput = document.querySelector("#idInput")
      if(!numEnglishValidationEvent(idInput)){
        idInput.disabled = false;
        return idAlert()
      }else{
        return idInput.disabled = true;
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

  function signUpValidationEvent(e){
    e.preventDefault()
    var signUpForm = document.querySelector("#form")
    var idInput = document.querySelector("#idInput")
    var passwordInput = document.querySelector("#passwordInput")
    var passwordConfirmInput = document.querySelector("#passwordConfirmInput")
    var nameInput = document.querySelector("#nameInput")
    var telInput = document.querySelector("#telInput")
    var departmentSelect = document.querySelector("#departmentSelect")
    var positionSelect = document.querySelector("#positionSelect")


    if (!idInput.disabled){
      return alert("아이디 중복을 확인해주세요");
    } else if(!numEnglishValidationEvent(passwordInput)){
      return passwordAlert()
    } else if(passwordInput.value !== passwordConfirmInput.value){
      return alert("비밀번호가 일치하지 않습니다")
    } else if (!koreanValidationEvent(nameInput)){
      return nameAlert()
    } else if (!numValidationEvent(telInput) || telInput.value.length !== 11){
      return telAlert()
    } else if(departmentSelect.value === "부서"){
      return alert("부서를 선택해주세요");
    } else if(positionSelect.value === "직책"){
      return alert("직책을 선택해주세요");
    }else{
      signUpForm.submit();
    }
  }


  
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>