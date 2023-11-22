function inputFocus(e){
  e.currentTarget.value = "";
}
function inputBulr(e){
  if(e.currentTarget.value === ""){
    e.currentTarget.value = e.currentTarget.defaultValue;
    e.target.type = "text"
  }
}