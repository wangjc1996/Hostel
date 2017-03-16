<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>房源计划 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">
<%@include file="../../common/admin_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">房源计划管理
                <button class="button btn-submit right-floated"
                        onclick="window.location.href='/admin/plan/add'">制定计划
                </button>
            </h3>

            <div class="normal-div">店面：${product.name}</div>

            <div class="table-container">
                <table id="js-table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th width="20%">日期</th>
                        <th width="15%">房型</th>
                        <th width="15%">单价</th>
                        <th width="15%">剩余数量</th>
                        <th width="20%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${planItems}" var="item">
                        <tr>
                            <td hidden>${item.planid}</td>
                            <td>${item.date}</td>
                            <td>${item.type}</td>
                            <td>￥ ${item.price}</td>
                            <td>${item.available}</td>
                            <td>
                                <button class="button button-edit"
                                        onclick="window.location.href='/admin/plan/edit?planid=${item.planid}'">修改
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>


        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp" %>
</body>

<style>
    table .button {
        margin-right: 5px;
    }
</style>
<script>
    $(document).ready(function () {

    });
</script>
</html>
