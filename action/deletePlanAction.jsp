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

  int deleteIdx = Integer.parseInt(request.getParameter("deleteIdx"));
  Integer currentYear = (Integer)session.getAttribute("currentYear");
  Integer currentMonth = (Integer)session.getAttribute("currentMonth");
  Integer currentDay = (Integer)session.getAttribute("currentDay");


  String sql = "DELETE FROM plan WHERE idx = ? AND day_column = ?";
  PreparedStatement query = connect.prepareStatement(sql);
  query.setInt(1, deleteIdx);
  query.setInt(2, currentDay);
  int result = query.executeUpdate();

  if (result > 0) {
    response.sendRedirect("../page/schedulerDetailModal.jsp?year="+currentYear+"&month="+currentMonth+"&day="+currentDay);
  }
%>
<script>
  window.close();
  window.opener.location.reload();
</script>