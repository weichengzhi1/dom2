<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Action</title>
</head>
<body>
    <%
        String idNumber = request.getParameter("idNumber");
        String password = request.getParameter("password");

        // 数据库连接信息
        String url = "jdbc:mysql://localhost:3306/Patient_information";
        String username = "root";
        String passwordDb = "root";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, passwordDb);
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM patient_tb WHERE id_number = '" + idNumber + "' AND password = '" + password + "'";
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                // 登录成功，跳转到欢迎页面
                response.sendRedirect("welcome.jsp");
            } else {
                // 登录失败，提示用户注册
                out.println("Invalid credentials. Please <a href=\"register.jsp\">register</a>.");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("An error occurred: " + e.getMessage());
        }
    %>
</body>
</html>
