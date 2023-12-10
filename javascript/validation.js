function numEnglishValidation(input){
  var regex = /^[a-zA-Z0-9]{1,20}$/;
  if(!regex.test(input.value) ){
    return false
  }else{
    return true
  }
}
function numValidation(input){
  var regex = /^\d{11}$/;
  if(!regex.test(input.value)){
    return false
  }else{
    return true
  }
}

function koreanValidation(input){
  var regex = /^[가-힣]{1,20}$/;
  if(!regex.test(input.value)){
    return false
  } else{
    return true
  }
}

function contentValidation(input){
  var regex = /^(?!(\s|\S*\s{50,})).{1,50}$/
  if(!regex.test(input)){
    alert("올바른 형식의 내용을 입력해주세요")
    return false
  }else{
    return true
  }
}
function timeValidation(startHour,endHour,startMin,endMin){
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