function idValidationEvent(idInput){
  var regex = /^[a-zA-Z0-9]+$/;

  if(idInput.value === "아이디" || !regex.test(idInput.value) ){
    alert("올바른 형식의 아이디를 입력해주세요")
    return false
  }else{
    return true
  }
}
function passwordValidationEvent(passwordInput){
  var regex = /^[a-zA-Z0-9]+$/;

  if(passwordInput.value === "비밀번호" || !regex.test(passwordInput.value) ){
    alert("올바른 형식의 비밀번호를 입력해주세요")
    return false
  }else{
    return true
  }
}

function telValidationEvent(telInput){
  var regex = /^\d+$/;

  if(!regex.test(telInput.value) || telInput.value.length !== 11){
    alert("올바른 형식의 전화번호를 입력해주세요")
    return false
  }else{
    return true
  }
}

function nameValidationEvent(nameInput){
  var regex = /^[ㄱ-ㅎㅏ-ㅣ]+$/;
  if(!regex.test(nameInput.value) || nameInput.value === "이름"){
    alert("올바른 형식의 이름을 입력해주세요")
    return false
  } else{
    return true
  }
}

function idValidationEvent(idInput){
  var regex = /^[a-zA-Z0-9]+$/;

  if(idInput.value === "아이디" || !regex.test(idInput.value) ){
    alert("올바른 형식의 아이디를 입력해주세요")
    return false
  }else{
    return true
  }
}

//문자, 숫자 가능 유효성 검사 이벤트로 이름 수정
function ValidationEvent(input){
  var regex = /^[0-9a-zA-Z\uAC00-\uD7A3]+$/;

  if(!regex.test(input)){
    alert("올바른 형식의 내용을 입력해주세요")
    return false
  }else{
    return true
  }
}

function loginFormValidationEvent(e){
  e.preventDefault()
  var id = document.querySelector(".idInput")
  var password = document.querySelector(".passwordInput")
  var form = document.querySelector(".form")
  if(idValidationEvent(id)&& passwordValidationEvent(password)){
    form.submit()
  }
}

function findIdFormValidationEvent(e){
  e.preventDefault()
  var form = document.querySelector(".form")
  var name = document.querySelector(".nameInput")
  var tel = document.querySelector(".telInput")
  if(nameValidationEvent(name) && telValidationEvent(tel)){
    form.submit()
  }
}

function findPasswordFormValidationEvent(e){
  e.preventDefault()
  var form = document.querySelector(".form")
  var id = document.querySelector(".idInput")
  var tel = document.querySelector(".telInput")
  if(idValidationEvent(id) && telValidationEvent(tel)){
    form.submit()
  }
}
function addPlanValidationEvent(e){
  e.preventDefault()
  var addPlanInput = document.querySelector(".addPlanInput")
  var inputSection = document.querySelector(".inputSection")
  if(ValidationEvent(addPlanInput)){
    inputSection.submit()
  }

}