<%@ page import="javax.servlet.http.HttpSession" %>
<!-- 세션을 가져오는 라이브러리 -->
<%
  // 현재 세션 가져오기
  Integer currentMonth = (Integer)session.getAttribute("currentMonth");

  String monthValue = request.getParameter("currentMonth");
  int newMonthValue = Integer.parseInt(monthValue);

  session.setAttribute("currentMonth", newMonthValue);
  response.sendRedirect("../page/schedulerPage.jsp");
%>