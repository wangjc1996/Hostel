<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>开店审批 - HOSTEL</title>
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
            <h3 class="title">开店审批</h3>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <c:choose>
                    <c:when test="${list.size() == 0}">
                        <h1>无开店申请</h1>
                    </c:when>
                    <c:when test="${list.size() > 0}">
                        <div class="table-container">
                            <table id="js-table" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th width="15%">审批单号</th>
                                    <th width="15%">酒店名称</th>
                                    <th width="15%">位置</th>
                                    <th width="15%">电话</th>
                                    <th width="15%">银行卡</th>
                                    <th width="10%">通过</th>
                                    <th width="10%">回绝</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="item">
                                    <tr>
                                        <td>${item.applyid}</td>
                                        <td>${item.name}</td>
                                        <td>${item.location}</td>
                                        <td>${item.phone}</td>
                                        <td>${item.bankid}</td>
                                        <td>
                                            <button class="button button-pass">通过</button>
                                        </td>
                                        <td>
                                            <button class="button button-reject">回绝</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                </c:choose>
            </div>
            <div class="clear-fix"></div>
            <h3 class="title">店面信息修改审批</h3>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <c:choose>
                    <c:when test="${modify.size() == 0}">
                        <h1>无修改申请</h1>
                    </c:when>
                    <c:when test="${modify.size() > 0}">
                        <div class="table-container">
                            <table id="modify-table" class="table table-striped table-bordered">
                                <thead>
                                <tr>
                                    <th width="13%">审批单号</th>
                                    <th width="15%">酒店名称</th>
                                    <th width="13%">酒店编号</th>
                                    <th width="20%">位置</th>
                                    <th width="15%">电话</th>
                                    <th width="10%">通过</th>
                                    <th width="10%">回绝</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${modify}" var="item">
                                    <tr>
                                        <td>${item.applyid}</td>
                                        <td>${item.name}</td>
                                        <td>${item.hid}</td>
                                        <td>${item.location}</td>
                                        <td>${item.phone}</td>
                                        <td>
                                            <button class="button button-modify-pass">通过</button>
                                        </td>
                                        <td>
                                            <button class="button button-modify-reject">回绝</button>
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
    <%@include file="/pages/common/toaster.jsp" %>
</body>

<style>
    .sub-title {
        font-size: 17px;

    }
</style>
<script>
    $(document).ready(function () {
        initItem();
    });

    function initItem() {
        $(".button-pass").click(function () {
            var tds = $(this).parents("tr").children();
            var applyid = tds.eq(0).text();

            $.ajax({
                type: "POST",
                url: "/admin/manager/new/pass",
                data: {
                    applyid: applyid
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("审批上传中", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/manager/approval";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });

        });

        $(".button-reject").click(function () {
            var tds = $(this).parents("tr").children();
            var applyid = tds.eq(0).text();

            $.ajax({
                type: "POST",
                url: "/admin/manager/reject",
                data: {
                    applyid: applyid
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("审批上传中", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/manager/approval";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });

        });

        $(".button-modify-pass").click(function () {
            var tds = $(this).parents("tr").children();
            var applyid = tds.eq(0).text();

            $.ajax({
                type: "POST",
                url: "/admin/manager/modify/pass",
                data: {
                    applyid: applyid
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("审批上传中", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/manager/approval";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });

        });

        $(".button-modify-reject").click(function () {
            var tds = $(this).parents("tr").children();
            var applyid = tds.eq(0).text();

            $.ajax({
                type: "POST",
                url: "/admin/manager/reject",
                data: {
                    applyid: applyid
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("审批上传中", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/manager/approval";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });

        });

    }

</script>
</html>

