<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="js/jquery-1.12.4.js"></script>
</head>
<body>
<script>
    $(function () {
        var url = '${filepath}';
        window.open("pdfjs/web/viewer.html?file=" + url);
    })
</script>
</body>
</html>
