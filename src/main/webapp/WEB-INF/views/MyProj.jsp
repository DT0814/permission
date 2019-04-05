<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="fly,layui,前端社区">
    <meta name="description" content="Fly社区是模块化前端UI框架Layui的官网社区，致力于为web开发提供强劲动力">
    <link rel="stylesheet" href="/assets/fly-3.0/res/layui/css/layui.css">
    <link rel="stylesheet" href="/assets/fly-3.0/res/css/global.css">
</head>
<body>

<h1 style="position: absolute; width:100%; text-align: center; top: 20px; left: 0; font-size: 20px; color: #333;">
    我的项目
</h1>

<div class="layui-container">
    <table class="layui-table layui-text">
        <colgroup>
            <col width="700">
            <col>
        </colgroup>
        <thead>
        <tr>
            <th>项目名称</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach begin="0" step="1" items="${ProList}" var="list" varStatus="ProList">

        <tr>
            <td>${list.name}</td>
            <td>
                <a href="/toProj?id=${list.id}" class="layui-btn">查看与修改</a>
                <a href="/delectProj.action?id=${list.id}" class="layui-btn">删除</a>

            </td>
        </tr>

        </c:forEach>

        </tbody>
    </table>
</div>


<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_30088308'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "w.cnzz.com/c.php%3Fid%3D30088308' type='text/javascript'%3E%3C/script%3E"));</script>
</body>
</html>