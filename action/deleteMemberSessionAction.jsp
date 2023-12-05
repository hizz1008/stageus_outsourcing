<%@ page import="javax.servlet.http.HttpSession" %>
<!-- 세션을 가져오는 라이브러리 -->
<%
  // 현재 세션 가져오기
  session = request.getSession();
  session.removeAttribute("memberIdx");
  session.removeAttribute("memberName");

  response.sendRedirect("../page/schedulerPage.jsp");
%>