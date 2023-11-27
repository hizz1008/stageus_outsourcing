<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  // 드라이브 연결
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
  
  Integer idx = (Integer)session.getAttribute("loggedInSession");
  String name = request.getParameter("name");
  String tel = request.getParameter("tel");
  String department = request.getParameter("department");
  String position = request.getParameter("position");

  String sql = "UPDATE account SET name = ?, tel = ?, department = ?, position = ? WHERE idx = ?";
  
  PreparedStatement query = connect.prepareStatement(sql);

  query.setString(1, name);
  query.setString(2, tel);
  query.setInt(3, Integer.parseInt(department));
  query.setInt(4, Integer.parseInt(position));
  query.setInt(5, idx);

  int result = query.executeUpdate(); 

  if (result > 0) {
    response.sendRedirect("../page/userProfilePage.jsp");
  } else {
    response.sendRedirect("../index.jsp");
  }
%>