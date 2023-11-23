<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/loginPage.css" type="text/css">
  <title>SignUp Page</title>
</head>
<body>
  <header class="header"></header>
  <main class="main">
   <section class="section">
    <h1 class="title">스케줄러 로그인</h1>
    <form class="form formstyle">
    <div class="idInputDiv">
        <input class="idInputStyle idInput" type="text" value="아이디" onfocus="inputFocus(event)" onblur="inputBulr(event)">

        <input class="idValidationBtn" type="button" value="중복확인" onclick="IdduplicateCheckEvent()">
      </div>

      <input class="inputStyle passwordInput" type="text" value="비밀번호" onfocus="inputFocus(event)" onblur="inputBulr(event)" onclick="typePasswordEvent(event)">

      <input class="inputStyle passwordConfirmInput" type="text" value="비밀번호 재입력" onfocus="inputFocus(event)" onblur="inputBulr(event)" onclick="typePasswordEvent(event)"
      oninput="passwordValidationEvent(event)">

      <p class="passwordValidationText"></p>

      <input class="inputStyle nameInput" type="text" value="이름" onfocus="inputFocus(event)" onblur="inputBulr(event)">

      <input class="inputStyle telInput" type="tel" value="전화번호" onfocus="inputFocus(event)" onblur="inputBulr(event)">

      <p class="telValidationText">- 없이 기입해주세요</p>

      <select class="departmentSelect">
        <option selected disabled>부서</option>
        <option value="개발팀">개발팀</option>
        <option value="디자인팀">디자인팀</option>
      </select>

      <select class="positionSelect">
        <option selected disabled>직책</option>
        <option value="팀장">팀장</option>
        <option value="팀원">팀원</option>
      </select>
      
      <input class="btnStyle signUpBtn" type="submit" value="회원가입" onclick="signUpValidation(event)" ></input>
      
    </form>
   </section>
  </main>
  <script>

    function typePasswordEvent(e){
      e.target.type = "password"
    }

    function IdduplicateCheckEvent(){
      var idInput = document.querySelector(".idInput")
      var regex = /^[a-zA-Z0-9]+$/;

      if(idInput.value === "아이디" || !regex.test(idInput.value) ){
        idInput.disabled = false;
        return alert("올바른 형식의 아이디를 입력해주세요")
      }else{
        return idInput.disabled = true;
      }
    }

    function passwordValidationEvent(e){
    var passwordInput = document.querySelector(".passwordInput");
    var passwordValidationText = document.querySelector(".passwordValidationText");

    if(e.currentTarget.value === passwordInput.value){
      passwordValidationText.textContent = "비밀번호가 일치합니다";
      passwordValidationText.style.color = "#4285F4";
    } else {
      passwordValidationText.textContent = "비밀번호가 일치하지 않습니다";
      passwordValidationText.style.color = "#FF0101";
    }
  }

  function signUpValidation(e){
    e.preventDefault()
    var signUpForm = document.querySelector(".form")
    var idInput = document.querySelector(".idInput")
    var passwordInputValue = document.querySelector(".passwordInput").value
    var passwordConfirmInputValue = document.querySelector(".passwordConfirmInput").value
    var nameInputValue = document.querySelector(".nameInput").value
    var telInputValue = document.querySelector(".telInput").value
    var departmentSelect = document.querySelector(".departmentSelect")
    var positionSelect = document.querySelector(".positionSelect")
    var passwordRegex = /^[a-zA-Z0-9]+$/;
    var nameRegex = /^[ㄱ-ㅎㅏ-ㅣ]+$/;
    var telRegex = /^\d+$/;


    if (!idInput.disabled){
      return alert("아이디 중복을 확인해주세요");
    } else if(!passwordRegex.test(passwordInputValue)){
      return alert("올바른 형식의 비밀번호를 입력해주세요");
    } else if(passwordInputValue !== passwordConfirmInputValue){
      return alert("비밀번호가 일치하지 않습니다");
    } else if (!nameRegex.test(nameInputValue) || nameInputValue == "이름"){
      return alert("올바른 이름을 입력해주세요");
    } else if (!telRegex.test(telInputValue) || telInputValue.length !== 11){
      return alert("올바른 전화번호를 기입해주세요");
    } else if(departmentSelect.value === "부서"){
      return alert("부서를 선택해주세요");
    } else if(positionSelect.value === "직책"){
      return alert("직책을 선택해주세요");
    }
    signUpForm.submit();
  }


  
  </script>
  <script src="../javascript/inputFocusBulr.js"></script>
  <script src="../javascript/createHeader1.js"></script>
</body>