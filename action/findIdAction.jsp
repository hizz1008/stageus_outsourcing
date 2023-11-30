<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%

  String name = request.getParameter("name");
  String tel = request.getParameter("tel");
  String resultText = "";
  String account_id = "";

  String koreanRegex = "^[가-힣]{1,20}$";
  String telRegex = "^\\d{11}$";
  
  if(!name.matches(koreanRegex) || !tel.matches(telRegex)){
    response.sendRedirect("../page/findIdPage.jsp");
  }else{
    // 드라이브 연결
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
  
    // 현재 로그인된 유저 idx 검사
  
  
    String sql = "SELECT id FROM account WHERE name = ? AND tel = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, name);
    query.setString(2, tel);
    ResultSet result = query.executeQuery();
    if (result.next()) {
      account_id = result.getString("id"); 
      resultText = "아이디는 "+ account_id + " 입니다";
    }else{
      resultText = "정보가 존재하지 않습니다";
    }
  }
%>
<script>
  var resultText = "<%=resultText%>"
  alert(resultText)
  window.location = "../page/findIdPage.jsp"
</script>