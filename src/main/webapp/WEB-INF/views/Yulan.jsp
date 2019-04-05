<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<input type="button" onclick="openPDF()" value="预览"/>
<script>
    function openPDF(){
        var url='${filepath}';
        window.open("pdfjs/web/viewer.html?file="+url);
    }
</script>
</body>
</html>
