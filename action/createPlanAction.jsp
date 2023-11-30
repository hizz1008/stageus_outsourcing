<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  Integer account_idx = (Integer)session.getAttribute("loggedInSession");
  Integer currentYear = (Integer)session.getAttribute("currentYear");
  Integer currentMonth = (Integer)session.getAttribute("currentMonth");
  Integer currentDay = (Integer)session.getAttribute("currentDay");
  String content = request.getParameter("content");

  String redirectURL = "../page/schedulerDetailModal.jsp?year=" + currentYear + "&month=" + currentMonth + "&day=" + currentDay;

  String regex = "^[0-9a-zA-Z\\uAC00-\\uD7A3^\\s]+$";
  if(!content.matches(regex)){
    response.sendRedirect(redirectURL);
  }else{
    String start_hour = request.getParameter("startHour");
    String start_min = request.getParameter("startMin");
    String end_hour = request.getParameter("endHour");
    String end_min = request.getParameter("endMin");
  
  
    // 데이터베이스 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
  
    String sql = "INSERT INTO plan (account_idx, year_column, month_column, day_column, start_hour, start_min, end_hour, end_min, content) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, account_idx);
    query.setInt(2, currentYear);
    query.setInt(3, currentMonth);
    query.setInt(4, currentDay);
    query.setString(5, start_hour);
    query.setString(6, start_min);
    query.setString(7, end_hour);
    query.setString(8, end_min);
    query.setString(9, content);
  
    query.executeUpdate();
    response.sendRedirect(redirectURL);
  }
%>
