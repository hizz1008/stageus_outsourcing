var currentDate = new Date();
var currentYear = currentDate.getFullYear();
var currentMonth;
function createHeader(){
  var header = document.querySelector(".header")

  var left = document.createElement("div")
  left.className = "left"
    var headerbars = document.createElement("i")
    headerbars.id = "headerbars"
    headerbars.className = "fa-solid fa-bars headerbars"

    var headerLogo = document.createElement("a")
    headerLogo.className = "headerLogo"
    headerLogo.textContent = "Stageus"
    headerLogo.href = "./index.jsp"

  left.appendChild(headerbars)
  left.appendChild(headerLogo)
  var center = document.createElement("div")
  center.className = "center"
    var leftBtn = document.createElement("i")
    leftBtn.id = "leftBtn"
    leftBtn.className = "fa-solid fa-caret-left leftBtn"
    leftBtn.onclick = leftBtnEvent;

    var yearText = document.createElement("p")
    yearText.className = "yearText"
    yearText.textContent = currentYear

    var rightBtn = document.createElement("i")
    rightBtn.id = "rightBtn"
    rightBtn.className = "fa-solid fa-caret-right rightBtn"
    rightBtn.onclick = rightBtnEvent;

    var monthList = document.createElement("ol")
    monthList.className = "monthList"
      for(var i = 0; i < 12; i++){
        var month = document.createElement("li")
        month.className = "month"
        month.textContent = i+1
        month.value = i+1
        month.onclick = monthEvent
        monthList.appendChild(month)
      }
  center.appendChild(leftBtn)
  center.appendChild(yearText)
  center.appendChild(rightBtn)
  center.appendChild(monthList)

  var right = document.createElement("div")
  right.className = "right"
    var userName = document.createElement("p")
    userName.className = "userName"
    userName.textContent = userProfiles.name

    var form = document.createElement("form")
    var logoutBtn = document.createElement("input")
    logoutBtn.className = "logoutBtn"
    logoutBtn.type = "submit"
    logoutBtn.value = "로그아웃"
    form.appendChild(logoutBtn)

  right.appendChild(userName)
  right.appendChild(form)

  header.appendChild(left)
  header.appendChild(center)
  header.appendChild(right)
}
createHeader()

function leftBtnEvent(){
  currentYear--
  var yearText = document.querySelector(".yearText")
  yearText.textContent = currentYear
}

function rightBtnEvent(){
  currentYear++
  var yearText = document.querySelector(".yearText")
  yearText.textContent = currentYear
}

function monthEvent(e){
  var monthCells = document.querySelectorAll(".month")
  monthCells.forEach(cell=>{
    cell.classList.remove("selectedMonth")
  })

  var monthCell = e.target
  monthCell.classList.add("selectedMonth")
  currentMonth = monthCell.value
}

// 헤더1은 로그인 되기 전 헤더2는 로그인 된 헤더로 이름을 짓는 것이 좋음