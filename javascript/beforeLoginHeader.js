function createHeader(){
  var header = document.querySelector("#header")
  var headerLogo = document.createElement("a");
  var baseUrl1 = "http://15.164.221.192:8080/stageus_outsourcing/index.jsp"
  var baseUrl2 = "http://15.164.221.192:8080/stageus_outsourcing/"
  headerLogo.textContent = "Stageus"

  if(window.location.href == baseUrl1 || window.location.href == baseUrl2){
    headerLogo.href = "./index.jsp"
  }else{
    headerLogo.href = "../index.jsp"
  }
  headerLogo.className = "headerLogo"
  header.appendChild(headerLogo)
}
createHeader()