<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增店员 - 店员管理 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">新增店员</h3>
            <label for="js-username-input" class="normal-input-label">用户名</label>
            <input type="text" class="normal-input" id="js-username-input" />
            <label for="js-name-input" class="normal-input-label">姓名</label>
            <input type="text" class="normal-input" id="js-name-input" />
            <label for="js-password-input" class="normal-input-label">密码</label>
            <input type="password" class="normal-input" id="js-password-input" />
            <label for="js-role-select" class="normal-input-label">角色</label>
            <select id="js-role-select" class="normal-input">
                <option value="2">分店服务员</option>
                <option value="3">总店服务员</option>
                <option value="4">总经理</option>
            </select>
            <label for="js-shop-select" class="normal-input-label">所属店面</label>
            <select id="js-shop-select" class="normal-input">
                <c:forEach items="${shopList}" var="item">
                    <option value="${item.id}">${item.name}</option>
                </c:forEach>
            </select>
            <div class="button-group right-floated">
                <button class="button btn-cancel" onclick="window.location.href='/admin/user'">返回</button>
                <button class="button btn-submit" onclick="submit()">提交</button>
            </div>
            <div class="clear-fix"></div>
        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    .admin-panel {
        width: 400px;
    }
</style>
<script>
    $(document).ready(function() {
        selectListener();
    });
    function selectListener() {
        $("#js-role-select").change(function () {
           if ($("#js-role-select").val() == 4) {
               $("#js-shop-select").prop("disabled", true);
           } else {
               $("#js-shop-select").prop("disabled", false);
           }
        });
    }
    function submit() {
        $.ajax({
            type: "POST",
            url: "/admin/user/add",
            data: {
                username: $("#js-username-input").val(),
                name: $("#js-name-input").val(),
                password: $("#js-password-input").val(),
                role: $("#js-role-select").val(),
                shop: $("#js-shop-select").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("新增成功~", "success");
                    setTimeout(function () {
                        window.location.href = "/admin/user";
                    }, 1000);
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

</script>
</html>
