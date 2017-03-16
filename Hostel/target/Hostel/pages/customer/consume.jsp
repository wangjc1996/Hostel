<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>我的消费 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<%@include file="../common/navbar.jsp"%>
<%@include file="../common/dashboard_header.jsp"%>
<div class="wrapper">
    <div class="content">
        <%@include file="../common/dashboard_left.jsp"%>
        <div class="right-content">
            <h3 class="title">我的消费</h3>

            <div class="normal-div">
                累积消费金额： <span class="number">${msg.msg}</span>
            </div>

        </div>
    </div>
</div>

<%@include file="/pages/common/toaster.jsp"%>

</body>
<style>
    body {
        background-color: #f5f5f5;
    }
    .normal-div > .number {
        color: #d76863;
    }
</style>
<script>
    $(document).ready(function() {

    });
</script>
</html>

