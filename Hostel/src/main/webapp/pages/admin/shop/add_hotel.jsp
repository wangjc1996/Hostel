<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增店面 - 店面管理 - 管理后台 - 哆哆甜品屋</title>
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
            <h3 class="title">新增店面</h3>
            <label for="js-name-input" class="normal-input-label">店面名称</label>
            <input type="text" class="normal-input" id="js-name-input" />
            <label for="js-desc-textarea" class="normal-input-label">店面描述</label>
            <textarea class="normal-textarea" id="js-desc-textarea" rows=5></textarea>
            <label for="js-addr-input" class="normal-input-label">店面地址</label>
            <input type="text" class="normal-input" id="js-addr-input" />
            <div class="button-group right-floated">
                <button class="button btn-cancel" onclick="window.location.href='/admin/shop'">返回</button>
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
        width: 500px;
    }
</style>
<script>
    $(document).ready(function() {

    });
    function submit() {
        $.ajax({
            type: "POST",
            url: "/admin/shop/add",
            data: {
                name: $("#js-name-input").val(),
                description: $("#js-desc-textarea").val(),
                address: $("#js-addr-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("新增成功~", "success");
                    setTimeout(function () {
                        window.location.href = "/admin/shop";
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
