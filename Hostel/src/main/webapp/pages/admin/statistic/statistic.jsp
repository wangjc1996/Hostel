<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>入住统计 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">入住统计</h3>
            <div class="normal-div"></div>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <label class="normal-input-label">本日房源</label>
                <c:choose>
                    <c:when test="${list.size() == 0}">
                        <h1>今日无房源</h1>
                    </c:when>
                    <c:when test="${list.size() > 0}">
                        <div class="table-container">
                            <table id="js-table" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th width="19%">日期</th>
                                    <th width="19%">房型</th>
                                    <th width="19%">单价</th>
                                    <th width="10%">剩余数量</th>
                                    <th width="10%">预定人数</th>
                                    <th width="10%">预定入住</th>
                                    <th width="13%">非预定入住</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="item">
                                    <tr>
                                        <td>${item.date}</td>
                                        <td>${item.type}</td>
                                        <td>${item.price}</td>
                                        <td>${item.available}</td>
                                        <td>${item.bookTotal}</td>
                                        <td>${item.bookCheckin}</td>
                                        <td>${item.nonBookCheckin}</td>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                </c:choose>
            </div>

        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp" %>
</body>

<style>
    .book-item {
        margin-bottom: 20px;
        border-bottom: 1px solid #b6b6b6;
        padding-bottom: 10px;
    }
</style>
<script>
    $(document).ready(function () {
    });

</script>
</html>
