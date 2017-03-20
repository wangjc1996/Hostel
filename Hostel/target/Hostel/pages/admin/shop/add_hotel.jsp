<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请开店 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">申请开店</h3>
            <label for="js-name-input" class="normal-input-label">酒店名称</label>
            <input type="text" class="normal-input" id="js-name-input"/>
            <label for="js-addr-input" class="normal-input-label">店面地址</label>
            <input type="text" class="normal-input" id="js-addr-input"/>
            <label for="js-phone-input" class="normal-input-label">联系电话</label>
            <input type="text" class="normal-input" id="js-phone-input"/>
            <label for="js-bankid-input" class="normal-input-label">银行账户（提交不可改）</label>
            <input type="text" class="normal-input" id="js-bankid-input"/>
            <label for="js-bankpsd-input" class="normal-input-label">银行密码</label>
            <input type="password" class="normal-input" id="js-bankpsd-input"/>
            <div class="button-group right-floated">
                <button class="button btn-submit" onclick="submit()">提交</button>
            </div>
            <div class="clear-fix"></div>
        </div>
    </div>
</div>
<%@include file="/pages/common/toaster.jsp" %>
</body>

<style>
    .admin-panel {
        width: 500px;
    }
</style>
<script>
    $(document).ready(function () {

    });
    function submit() {
        $.ajax({
            type: "POST",
            url: "/admin/hotel/add",
            data: {
                name: $("#js-name-input").val(),
                location: $("#js-addr-input").val(),
                phone: $("#js-phone-input").val(),
                bankid: $("#js-bankid-input").val(),
                bankpsd: $("#js-bankpsd-input").val()
            },
            success: function (data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("申请成功，待管理员审核", "success");
                    setTimeout(function () {
                        window.location.href = "/admin/plan";
                    }, 1000);
                }
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

</script>
</html>
