<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 400px;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        input[type="submit"] {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .login-link {
            display: inline-block;
            margin-top: 5px;
            margin-left: 50px;
            text-decoration: none;
            color: #4CAF50;
        }

        .background-image {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("1.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            z-index: -1;
        }

        .page-title {
            font-size: 48px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            writing-mode: vertical-lr;
            transform: rotate(0deg);
        }

        .success-message {
            color: #4CAF50;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .center-button {
            display: flex;
            justify-content: center;
        }
    </style>

</head>
<body>
    <div class="background-image"></div>
    
    <h2 class="page-title">佳能医院就诊系统</h2>
    <div class="container">
        <%        
            // 数据库连接参数
            String dbUrl = "jdbc:mysql://localhost:3306/Patient_information?useSSL=false&characterEncoding=utf8";
            String dbUsername = "root";
            String dbPassword = "root";

            // 数据库连接
            Connection conn = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                conn.prepareStatement("SET NAMES 'utf8'").executeUpdate(); // 设置数据库编码为UTF-8
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // 处理用户注册逻辑
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String name = request.getParameter("name");
                String sex = request.getParameter("sex");
                String birthdate = request.getParameter("birthdate");
                String idNumber = request.getParameter("id_number");
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                String emergencyContact = request.getParameter("emergency_contact");
                String password = request.getParameter("password");

                // 在数据库中插入新用户
                String sql = "INSERT INTO patient_tb (name, sex, birthdate, id_number, address, phone, emergency_contact, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try {
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, name);
                    statement.setString(2, sex);
                    statement.setString(3, birthdate);
                    statement.setString(4, idNumber);
                    statement.setString(5, address);
                    statement.setString(6, phone);
                    statement.setString(7, emergencyContact);
                    statement.setString(8, password);
                    statement.executeUpdate();

                    // 注册成功后，显示成功消息
                    out.println("<p class='success-message'>注册成功！</p>");

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <form action="" method="post">
            <table>
                <tr>
                    <th><label for="name">姓名：</label></th>
                    <td><input type="text" id="name" name="name" required></td>
                </tr>
                <tr>
                    <th><label for="sex">性别：</label></th>
                    <td>
                        <input type="radio" name="sex" value="男" required>男
                        <input type="radio" name="sex" value="女" required>女
                    </td>
                </tr>
                <tr>
                    <th><label for="birthdate">出生日期：</label></th>
                    <td><input type="date" id="birthdate" name="birthdate" required></td>
                </tr>
                <tr>
                    <th><label for="id_number">身份证号：</label></th>
                    <td><input type="text" id="id_number" name="id_number" required></td>
                </tr>
                <tr>
                    <th><label for="address">居住地：</label></th>
                    <td><input type="text" id="address" name="address" required></td>
                </tr>
                <tr>
                    <th><label for="phone">电话号码：</label></th>
                    <td><input type="text" id="phone" name="phone" required></td>
                </tr>
                <tr>
                    <th><label for="emergency_contact">紧急联系人：</label></th>
                    <td><input type="text" id="emergency_contact" name="emergency_contact" required></td>
                </tr>
                <tr>
                    <th><label for="password">登录密码：</label></th>
                    <td><input type="password" id="password" name="password" required></td>
                </tr>
                <tr>
                    <td colsspan="2" class="center-button">
                        <input type="submit" value="注册">
                     <td>   
                        <a href="login.jsp" class="login-link">点击登录</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
