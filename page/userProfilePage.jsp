<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/reset.css" type="text/css">
  <link rel="stylesheet" href="../css/common.css" type="text/css">
  <link rel="stylesheet" href="../css/loginBeforeHeader.css" type="text/css">
  <link rel="stylesheet" href="../css/userProfilePage.css" type="text/css">
  <title>User Profile Page</title>
</head>
<body>
  <header id="header" class="headerStyle"></header>
  <main class="mainStyle">
    <section class="sectionStyle">
      <h1 class="titleStyle">개인정보</h1>
      <section class="userProfiles">
        <p class="userProfileInfo">이름 : <span class="name"></span></p>
        <p class="userProfileInfo">전화번호 : <span class="tel"></span></p>
        <p class="userProfileInfo">부서 : <span class="department"></span></p>
        <p class="userProfileInfo">직책 : <span class="position"></span></p>
      </section>
      <section class="userProfileBtns">
        <input class="userProfileBtnStyle editBtn" type="button" value="수정" onclick="editPageEvent()">
        <input class="userProfileBtnStyle deleteBtn" type="button" value="탈퇴"
        onclick="confirmationAlert()">
      </section>
    </section>
  </main>
  <script>
    var userProfiles = {
      name: "방준연",
      tel: "01001000100",
      department: "개발팀",
      position: "팀원",
    }
    function updateUserProfile(){
      document.querySelector(".name").textContent = userProfiles.name
      document.querySelector(".tel").textContent = userProfiles.tel
      document.querySelector(".department").textContent = userProfiles.department
      document.querySelector(".position").textContent = userProfiles.position
    }
    updateUserProfile()
    //
    function confirmationAlert(){
      var confirmAlert = confirm("정말로 탈퇴하시겠습니까?")
      if(confirmAlert){
        return alert("탈퇴되었습니다")
      }
      else{
        return
      }
    }
    //
    function editPageEvent(){
      window.location.href = "./editUserProfilePage.jsp"
    }
  </script>
  <script src="../javascript/createHeader1.js"></script>
</body>