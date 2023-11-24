<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
  request.setCharacterEncoding("utf-8");
  String id = request.getParameter("id");

  Class.forName("com.mysql.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");

  String result;
  int idDPResult;

  String duplicateCheck = "SELECT id FROM account WHERE id = ?";
  PreparedStatement queryDuplicate = connect.prepareStatement(duplicateCheck);
  queryDuplicate.setString(1, id);
  ResultSet resultSet = queryDuplicate.executeQuery();
  if(resultSet.next()){
    result = "중복된 아이디입니다";
    idDPResult = 0;
  } else {
    result = "사용 가능한 아이디입니다";
    idDPResult = 1;
  }
%>
<html>
<head>
    <title>아이디 중복 확인 결과</title>
    <script>
      function displayResult() {
          var resultText = document.querySelector("#resultText")
          var result = "<%=result%>";
          var idDPResult  = "<%=idDPResult%>";
          var idDuplicationInput = opener.document.querySelector("#idDuplicationInput")
          var idInput = opener.document.querySelector("#idInput")
          if(idDPResult == 1){
            idDuplicationInput.value = "true"
            idInput.disabled = true
            alert(result)
            window.close()
          }else{
            idDuplicationInput.value = "false"
            idInput.disabled = false
            alert(result)
            window.close()
          }
      }
      window.onload = displayResult;
  </script>
</head>
<body>
</body>
</html>
