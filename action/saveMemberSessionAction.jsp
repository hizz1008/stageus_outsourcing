<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  //팀원 이름, idx 파라미터로 가져오기
  String memberName = request.getParameter("teamMemberName");
  int memberIdx = Integer.parseInt(request.getParameter("teamMemberIdx"));

  //해당 정보 세션에 저장
  session.setAttribute("memberName", memberName);
  session.setAttribute("memberIdx", memberIdx);

  response.sendRedirect("../page/schedulerPage.jsp");
%>
