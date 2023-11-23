<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/loginPage.css" type="text/css">
  <link rel="stylesheet" href="../css/editUserProfilePage.css" type="text/css">
  <title>Edit User Profile Page</title>
</head>
<body>
  <header class="header"></header>
  <main class="main">
    <section class="section">
      <h1 class="title">개인정보 수정</h1>
      <form class="form editUserProfiles">
        <p class="infoStyle">이름</p>
        <input class="inputStyle nameInput" type="text">
        <p class="infoStyle">전화번호</p>
        <input class="inputStyle telInput" type="tel">

        <p class="infoStyle">부서</p>
        <select class="departmentSelect">
          <option value="개발팀">개발팀</option>
          <option value="디자인팀">디자인팀</option>
        </select>
  
        <p class="infoStyle">직책</p>
        <select class="positionSelect">
          <option value="팀장">팀장</option>
          <option value="팀원">팀원</option>
        </select>
      </form>

        <input class="btnStyle loginBtn" type="button" value="수정" onclick="findIdFormValidationEvent(event)">

    </section>
  </main>
  <script>
    var userProfiles = {
      name: "방준연",
      tel: "01001000100",
      department: "개발부",
      position: "팀원",
    }
    function updateUserProfile(){
      document.querySelector(".nameInput").value = userProfiles.name
      document.querySelector(".telInput").value = userProfiles.tel
    }
    updateUserProfile()

    var departmentSelect = document.querySelector(".departmentSelect");
    var positionSelect = document.querySelector(".positionSelect")
    
    var departmentValue = userProfiles.department;
    var positionValue = userProfiles.position;

    for(var i = 0; i < departmentSelect.options.length; i++){
      if(departmentSelect.options[i].value === departmentValue){
        departmentSelect.selectedIndex = i
        break;
      }
    }

    for(var j = 0; j < positionSelect.options.length; j++){
      if(positionSelect.options[j].value === positionValue){
        positionSelect.selectedIndex = j
        break;
      }
    }
    //
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/createHeader1.js"></script>
</body>