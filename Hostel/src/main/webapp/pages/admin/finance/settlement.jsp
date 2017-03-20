<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分店结算 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/manager_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">分店结算</h3>
            <div class="normal-div"></div>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <label class="normal-input-label">本月结算</label>
                <div class="table-container">
                    <table id="js-table" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th width="20%">月份</th>
                            <th width="20%">酒店编号</th>
                            <th width="20%">名称</th>
                            <th width="20%">线上支付笔数</th>
                            <th width="20%">总金额</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list}" var="item">
                            <tr>
                                <td>${item.month}</td>
                                <td>${item.hid}</td>
                                <td>${item.hname}</td>
                                <td>${item.number}</td>
                                <td>${item.amount}</td>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${hasSettle == false}">
                    <button class="button btn-submit" onclick="settle()">全部结算</button>
                </c:if>
                <c:if test="${hasSettle == true}">
                    <label class="normal-input-label">本月结算已完成</label>
                </c:if>
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

    function settle() {
        var d = new Date();
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        var flag = confirm("确认结算？");
        if (flag == true) {
            $.ajax({
                type: "POST",
                url: "/admin/manager/settlement",
                data: {
                    year:year,
                    month: month
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("结算成功！", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/manager/settlement";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });
        }

    }

</script>
</html>
