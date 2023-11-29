<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  // POST로 전달된 데이터 읽기
  String content = request.getParameter("planEditInput");
  String startHour = request.getParameter("planEditStartHour");
  String startMin = request.getParameter("planEditStartMin");
  String endHour = request.getParameter("planEditEndHour");
  String endMin = request.getParameter("planEditEndMin");
  String idx = request.getParameter("deleteIdx");

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");

  String sql = "UPDATE plan SET content = ?, start_hour = ?, start_min = ?, end_hour = ?, end_min = ? WHERE idx = ?";

  PreparedStatement query = connect.prepareStatement(sql);

  query.setString(1, content);
  query.setInt(2, Integer.parseInt(startHour));
  query.setInt(3, Integer.parseInt(startMin));
  query.setInt(4, Integer.parseInt(endHour));
  query.setInt(5, Integer.parseInt(endMin));
  query.setInt(6, Integer.parseInt(idx));

  query.executeUpdate();
%>
<script>
    window.close();
</script>