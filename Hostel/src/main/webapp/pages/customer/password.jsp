<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
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
            <h3 class="title">修改密码</h3>

            <div style="width: 300px">

                <label for="js-old-input" class="normal-input-label">原密码</label>
                <input type="password" id="js-old-input" class="normal-input">
                <label for="js-new-input" class="normal-input-label">新密码</label>
                <input type="password" id="js-new-input" class="normal-input">
                <label for="js-again-input" class="normal-input-label">再次输入新密码</label>
                <input type="password" id="js-again-input" class="normal-input">
            </div>
            <button class="button btn-normal right-floated" onclick="submit()">修改</button>
            <div class="clear-fix"></div>
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
    function submit() {
        $.ajax({
            type: "POST",
            url: "/user/password",
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

