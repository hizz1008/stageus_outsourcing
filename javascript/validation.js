function numEnglishValidationEvent(input){
  var regex = /^[a-zA-Z0-9]+$/;
  if(!regex.test(input.value) ){
    return false
  }else{
    return true
  }
}
// 이벤트 지우기
// 길이체크 추가
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

function contentValidationEvent(input){
  var regex = /^[0-9a-zA-Z\uAC00-\uD7A3^\s]+$/;
  if(!regex.test(input)){
    alert("올바른 형식의 내용을 입력해주세요")
    return false
  }else{
    return true
  }
}
function timeValidationEvent(startHour,endHour,startMin,endMin){
  if(startHour > endHour || startHour == endHour && startMin >=endMin){
    alert("올바른 시간을 입력해주세요")
    return false
  }else{
    return true
  }
}
function idAlert(){
  alert("올바른 형식의 아이디를 입력해주세요")
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