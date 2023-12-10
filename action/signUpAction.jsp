<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- JSP 라이브러리 임포트하는 방법 -->
<!-- 데이터베이스 탐색 라이브러리 -->
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
  String id = request.getParameter("id");
  String password = request.getParameter("password");
  String name = request.getParameter("name");
  String tel = request.getParameter("tel");
  String department = request.getParameter("department");
  String position = request.getParameter("position");
  int errorResult = -1;

  String numEnglishRegex = "^[a-zA-Z0-9]{1,20}$";
  String koreanRegex = "^[가-힣]{1,20}$";
  String telRegex = "^\\d{11}$";
  //각각 따로 만들어서 사용

  if(!id.matches(numEnglishRegex) || !password.matches(numEnglishRegex) || !name.matches(koreanRegex) || !tel.matches(telRegex)){
    //직책과 부서도 예외처리 해야함
    response.sendRedirect("../page/signUpPage.jsp");
  }else{
    Class.forName("com.mysql.jdbc.Driver");
  
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/schedule", "stageus", "1234");
  
    // 중복 아이디 확인을 위한 구문
    String duplicateCheck = "SELECT id FROM account WHERE id = ?";
    PreparedStatement queryDuplicate = connect.prepareStatement(duplicateCheck);
    queryDuplicate.setString(1, id);
    ResultSet resultSet = queryDuplicate.executeQuery();
    if(!resultSet.next()){
      if(tel.length() == 11){
        //이차 검증은 공식에서 어긋남
        String sql = "INSERT INTO account (id, password, name, tel, department, position) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, id);
        query.setString(2, password);
        query.setString(3, name);
        query.setString(4, tel);
        query.setString(5, department);
        query.setString(6, position);
        // 쿼리 실행
        query.executeUpdate();
  
        session.setAttribute("loggedInId", id);
        response.sendRedirect("../index.jsp");
      }else{
        errorResult = 2;
      }
    }else{
      errorResult = 1;
    }
  }
%>
<script>
  var errorResult = "<%=errorResult%>"
  if(errorResult === 1){
    alert("중복된 아이디입니다")
  }else if(errorResult === 2){
    alert("올바른 형식의 전화번호를 입력해주세요")
  }
  
</script>
