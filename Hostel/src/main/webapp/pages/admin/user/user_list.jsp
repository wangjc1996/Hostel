<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>店员管理 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">
<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">店员管理
                <button class="button btn-submit right-floated"
                        onclick="window.location.href='/admin/user/add'">新增店员</button>
            </h3>

            <div class="table-container">
                <table id="js-user-table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th width="10%">编号</th>
                        <th width="15%">用户名</th>
                        <th width="15%">姓名</th>
                        <th width="15%">角色</th>
                        <th width="30%">所属店面</th>
                        <th width="15%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${userList}" var="item">
                        <tr class="user-item" userId="${item.id}">
                            <td>${item.id}</td>
                            <td>${item.username}</td>
                            <td>${item.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.role == 2}">分店服务员</c:when>
                                    <c:when test="${item.role == 3}">总店服务员</c:when>
                                    <c:when test="${item.role == 4}">总经理</c:when>
                                </c:choose>
                            </td>
                            <td class="table-shop">
                                <span onclick="window.location.href='/admin/shop/detail?id=${item.shop.id}'">
                                ${item.shop.name}</span></td>
                            <td>
                                <button class="button btn-submit" onclick="edit(this)">编辑</button>
                                <button class="button btn-cancel" onclick="deleteUser(this)">删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    .table-shop > span {
        cursor: pointer;
    }
    .table-shop:hover {
        text-decoration: underline;
    }
</style>
<script>
    $(document).ready(function() {
        loadTable();
    });
    function loadTable() {
        $("#js-user-table").dataTable({
            "language": {
                url: '${pageContext.request.contextPath}/assets/plugins/datatables/Chinese.json'
            }
        });
    }
    function edit(obj) {
        var id = $(obj).parents(".user-item").attr("userId");
        window.location.href = "/admin/user/edit?id=" + id;
    }
    function deleteUser(obj) {

        var result = confirm("您是否真的要删除该用户？");

        if (result == 1) {
            ajaxDelete();
        }

        function ajaxDelete() {
            $.ajax({
                type: "POST",
                url: "/admin/user/delete",
                data: {
                    id: $(obj).parents(".user-item").attr("userId")
                },
                success: function(data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        $(obj).parents(".user-item").remove();
                        toaster("删除成功~", "success");
                    }
                },
                error: function() {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });
        }
    }
</script>
</html>
