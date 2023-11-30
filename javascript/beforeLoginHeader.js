function createHeader(){
  var header = document.querySelector("#header")
  var headerLogo = document.createElement("a");
  var baseUrl = "http://15.164.221.192:8080/stageus_outsourcing/index.jsp"
  headerLogo.textContent = "Stageus"

  headerLogo.href = "../index.jsp"
  headerLogo.className = "headerLogo"
  header.appendChild(headerLogo)
}
createHeader()