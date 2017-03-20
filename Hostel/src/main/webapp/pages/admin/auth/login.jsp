<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商家登陆 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
    <div class="wrapper">
        <div class="content admin-login-panel">
            <div class="panel-content">
                <h3 class="title">商家后台系统</h3>
                <form class="login-form">
                    <input class="input-username" type="text" name="username" placeholder="酒店编号" />
                    <input class="input-password" type="password" name="password" placeholder="密码" />
                    <input type="checkbox" id="js-checkbox-remember"/> 记住我
                    <button type="button" class="button btn-login right-floated" onclick="login()">登录</button>
                    <div class="clear-fix"></div>
                </form>
            </div>
        </div>
    </div>
    <%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    body {
        overflow-y: hidden;
        background-color: #f1f1f1;
    }
</style>
<script>
    $(document).ready(function() {
        fillForm();
    });

    function fillForm() {
        if (window.localStorage.getItem("admin_remember") == 1) {
            $("#js-checkbox-remember").prop("checked", true);
            $(".input-username").val(window.localStorage.getItem("admin_login"));
            $(".input-password").val(window.localStorage.getItem("admin_password"));
        }
    }

    function login() {
        if ($("#js-checkbox-remember").prop("checked") == true) {
            window.localStorage.setItem("admin_remember", 1);
            window.localStorage.setItem("admin_login", $(".input-username").val());
            window.localStorage.setItem("admin_password", $(".input-password").val());
        } else {
            window.localStorage.setItem("admin_remember", 0);
            window.localStorage.setItem("admin_login", "");
            window.localStorage.setItem("admin_password", "");
        }

        $.ajax({
            type: "POST",
            url: "/admin/login",
            data: $('.login-form').serialize(),
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                    $(".input-password").val("");
                } else {
                    toaster("登录成功！马上自动跳转...", "success");
                    setTimeout(function () {
                        if (data["hid"] == null)
                            window.location.href = "/admin/manager/vip";
                        else
                            window.location.href = "/admin/plan";
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
