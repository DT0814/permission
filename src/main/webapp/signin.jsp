<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<html lang="zh-CN">
<%
    String ret = request.getParameter("ret");
    if (StringUtils.isNotBlank(ret)) {
        ret = URLEncoder.encode(ret);
    } else {
        ret = "";
    }
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/favicon.ico">
    <title>大盛川建筑工程项目管理有限公司信息管理系统 </title>
    <link href="bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/signin.css" rel="stylesheet">
    <script src="js/ie8-responsive-file-warning.js"></script>
    <script src="js/ie-emulation-modes-warning.js"></script>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
</head>

<body>

<div class="container">
    <form class="form-signin" action="/login.page?ret=<%=ret%>" method="post">
        <div style="text-align: center;margin: 20px">
            <img src="/img/logo.png"
                 style="width: 43px;height: 41px;float: left"/>
            <h2 class="form-signin-heading">信息管理系统</h2>
        </div>
        <label for="inputEmail" class="sr-only">邮箱/电话</label>
        <input type="text" id="inputEmail" class="form-control" placeholder="Email/Telephone" name="username" required
               autofocus value="${username}">
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password" required>
        <div class="checkbox" style="color: red;">${error}</div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登 陆</button>
    </form>
</div>
<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
