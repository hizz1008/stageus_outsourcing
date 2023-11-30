<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.ArrayList"%>
<%
  Integer idx = (Integer)session.getAttribute("loggedInSession");
  Integer currentYear = (Integer)session.getAttribute("currentYear");
  Integer currentMonth = (Integer)session.getAttribute("currentMonth");

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");


%>
<p><%=memberIdx%></p>