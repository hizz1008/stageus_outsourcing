function createHeader(){
  var header = document.querySelector("header")
  var headerLogo = document.createElement("a");
  headerLogo.textContent = "Stageus"
  headerLogo.href = "../index.jsp"
  headerLogo.className = "headerLogo"
  header.appendChild(headerLogo)
}
createHeader()