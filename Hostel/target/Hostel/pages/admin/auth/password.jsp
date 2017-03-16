<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码 - 管理后台 - 哆哆甜品屋</title>
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
            <h3 class="title">修改密码</h3>
            <label for="js-old-input" class="normal-input-label">旧密码</label>
            <input type="password" class="normal-input" id="js-old-input" />
            <label for="js-new-input" class="normal-input-label">新密码</label>
            <input type="password" class="normal-input" id="js-new-input" />
            <label for="js-again-input" class="normal-input-label">再次输入密码</label>
            <input type="password" class="normal-input" id="js-again-input" />
            <div class="button-group right-floated">
                <button class="button table-btn btn-submit" onclick="submit()">提交</button>
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

    });
    function submit() {
        $.ajax({
            type: "POST",
            url: "/admin/password",
            data: {
                old: $("#js-old-input").val(),
                password: $("#js-new-input").val(),
                passwordAgain: $("#js-again-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("修改密码成功~", "success");
                }
                $("#js-old-input").val("");
                $("#js-new-input").val("");
                $("#js-again-input").val("");
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

</script>
</html>

