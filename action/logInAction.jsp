<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<!-- 클래스를 현재jsp페이지로 가져오는 라이브러리 -->
<%@ page import="java.sql.Connection" %>
<!-- 클래스를 데이터베이스에 연결하는 라이브러리 -->
<%@ page import="java.sql.PreparedStatement" %>
<!-- 데이터베이스 명령문을 연결해주는 라이브러리 -->
<%@ page import="java.sql.ResultSet"%>
<!-- 리드할 때 임포트 하는 라이브러리 -->
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.time.LocalDate" %>
<!-- 세션을 가져오는 라이브러리 -->

<%
  request.setCharacterEncoding("utf-8");
  // 해당 데이터를 어떻게 가져올 것인지에 대한 인코딩 설정
  String id = request.getParameter("id");
  String password = request.getParameter("password");

  String regex = "^[a-zA-Z0-9]{1,20}$";
  
  if(!id.matches(regex) || !password.matches(regex)){
    response.sendRedirect("../index.jsp");
  }else{
    // connector 파일 불러오기
    Class.forName("com.mysql.jdbc.Driver");
      // 데이터베이스 연결
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
    String sql = "SELECT * FROM account WHERE id = ? AND password = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id);
    query.setString(2, password);
    //result로 실행
    ResultSet result = query.executeQuery();
    //ResultSet에 대한 값을 저장해 다음 레코드로 이동
    //해당 값이 있다면 true를 반환 없다면 false를 반환
    if (result.next()) {
      // 로그인 성공
      int currentYear = LocalDate.now().getYear();
      int currentMonth = LocalDate.now().getMonthValue();
      int userIdx = result.getInt("idx");
      session.setAttribute("loggedInSession", userIdx);
      session.setAttribute("currentYear", currentYear);
      session.setAttribute("currentMonth", currentMonth);
      response.sendRedirect("../page/schedulerPage.jsp");
    }
  }
%>
<script>
  alert("존재하지 않는 ID,PW입니다")
  window.location.href = "../index.jsp";
</script>
