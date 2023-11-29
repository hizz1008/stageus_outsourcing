function numEnglishValidationEvent(input){
  var regex = /^[a-zA-Z0-9]+$/;
  if(!regex.test(input.value) ){
    return false
  }else{
    return true
  }
}

function numValidationEvent(input){
  var regex = /^\d+$/;
  if(!regex.test(input.value)){
    return false
  }else{
    return true
  }
}

function koreanValidationEvent(input){
  var regex = /^[가-힣]+$/;
  if(!regex.test(input.value)){
    return false
  } else{
    return true
  }
}

//문자, 숫자 가능 유효성 검사 이벤트로 이름 수정
function contentValidationEvent(input){
  var regex = /^[0-9a-zA-Z\uAC00-\uD7A3^\s]+$/;
  if(!regex.test(input)){
    alert("올바른 형식의 내용을 입력해주세요")
    return false
  }else{
    return true
  }
}
function idAlert(){
  alert("올바른 형식의 아이디를 입력해주세요")
  return
}
function telAlert(){
  alert("올바른 형식의 전화번호를 입력해주세요")
}
function passwordAlert(){
  alert("올바른 비밀번호를 입력해주세요")
}
function nameAlert(){
  alert("올바른 이름을 입력해주세요")
}