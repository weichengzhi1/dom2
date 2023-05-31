<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>佳能医院登录系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

         .container {
            max-width: 400px;
            margin: 0 auto;
            margin-right: 200px;
            margin-top :250px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f5f5f5;
        }

        h2 {
            text-align: center;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .form-group button {
            width: 100%;
            padding: 8px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            margin-top: 5px;
        }
        .background-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("3.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            z-index: -1;
        }
    </style>
</head>
<body>
    <div class="background-image"></div>
    <div class="container">
        <h2>佳能医院登录系统</h2>
        <form method="post">
            <div class="form-group">
                <label for="idNumber">身份证号：</label>
                <input type="text" id="idNumber" name="idNumber" required>
            </div>
            <div class="form-group">
                <label for="password">密码：</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <button type="submit">登录</button>
            </div>
            <div class="form-group">
                <span class="error-message">
                    <%-- 显示登录错误信息 --%>
                    <% 
                        if (request.getMethod().equalsIgnoreCase("POST")) {
                            String idNumber = request.getParameter("idNumber");
                            String password = request.getParameter("password");

                            // 数据库连接参数
                            String dbUrl = "jdbc:mysql://localhost:3306/Patient_information";
                            String dbUsername = "root";
                            String dbPassword = "root";

                            // 数据库连接
                            Connection conn = null;
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                                // 查询数据库中的用户信息
                                String sql = "SELECT * FROM patient_tb WHERE id_number = ?";
                                PreparedStatement statement = conn.prepareStatement(sql);
                                statement.setString(1, idNumber);
                                ResultSet resultSet = statement.executeQuery();

                                if (resultSet.next()) {
                                    String storedPassword = resultSet.getString("password");

                                    if (password.equals(storedPassword)) {
                                        // 登录成功，进行相应的操作
                                        response.sendRedirect("welcome.jsp"); // 重定向到欢迎页面
                                    } else {
                                        out.print("密码错误");
                                    }
                                } else {
                                    out.print("用户不存在，请先注册");
                                }

                                resultSet.close();
                                statement.close();
                                conn.close();
                            } catch (ClassNotFoundException | SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </span>
            </div>
            <div class="form-group">
                <p>没有注册？<a href="register.jsp">点击注册</a></p>
            </div>
        </form>
    </div>
</body>
</html>
