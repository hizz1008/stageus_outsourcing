<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%

  String id = request.getParameter("id");
  String tel = request.getParameter("tel");
  String resultText = "";
  String account_password = "";

  String numEnglishRegex = "^[a-zA-Z0-9]{1,20}$";
  String telRegex = "^\\d{11}$";

  if(!id.matches(numEnglishRegex) || !tel.matches(telRegex)){
    response.sendRedirect("../page/findPasswordPage.jsp");
  }else{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
  
    String sql = "SELECT password FROM account WHERE id= ? AND tel = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id);
    query.setString(2, tel);
    ResultSet result = query.executeQuery();
    if (result.next()) {
      account_password = result.getString("password"); 
      resultText = "비밀번호는 "+ account_password + " 입니다";
    }else{
      resultText = "정보가 존재하지 않습니다";
    }
  }
%>
<script>
  var resultText = "<%=resultText%>"
  alert(resultText)
  window.location = "../page/findPasswordPage.jsp"
</script>