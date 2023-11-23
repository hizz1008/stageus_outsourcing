<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <link rel="stylesheet" href="../css/editUserProfilePage.css" type="text/css">
  <title>Edit User Profile Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">개인정보 수정</h1>
      <form id="form" class="formStyle editUserProfiles">
        <p class="infoStyle">이름</p>
        <input id="nameInput" class="inputStyle" type="text">
        <p class="infoStyle">전화번호</p>
        <input id="telInput" class="inputStyle" type="tel">

        <p class="infoStyle">부서</p>
        <select id="departmentSelect" class="selectStyle">
          <option value="개발팀">개발팀</option>
          <option value="디자인팀">디자인팀</option>
        </select>
  
        <p class="infoStyle">직책</p>
        <select id="positionSelect" class="selectStyle">
          <option value="팀장">팀장</option>
          <option value="팀원">팀원</option>
        </select>
        <input class="btnStyle BGcolorBlue" type="button" value="수정" onclick="editUserInputValidationEvent(event)">
      </form>

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
      document.querySelector("#nameInput").value = userProfiles.name
      document.querySelector("#telInput").value = userProfiles.tel
    }
    function editUserInputValidationEvent(e){
      e.preventDefault()
      var nameInput = document.querySelector("#nameInput")
      var telInput = document.querySelector("#telInput")
      var form = document.querySelector("#form")

      if(!koreanValidationEvent(nameInput)){
        return nameAlert()
      }else if(!numValidationEvent(telInput) || telInput.value.length !== 11){
        return telAlert()
      }else{
        form.submit()
      }
    }

  

 
    window.onload = function() {
      var departmentSelect = document.querySelector("#departmentSelect");
      var positionSelect = document.querySelector("#positionSelect")
      
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
      updateUserProfile()
    }
  </script>
  <script src="../javascript/validation.js"></script>
  <script src="../javascript/beforeLoginHeader.js"></script>
</body>