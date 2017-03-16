<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的信息 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/plugins/datetimepicker/css/jquery.datetimepicker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/plugins/datetimepicker/js/jquery.datetimepicker.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body>
<%@include file="../common/navbar.jsp" %>
<%@include file="../common/dashboard_header.jsp" %>
<div class="wrapper">
    <div class="content">
        <%@include file="../common/dashboard_left.jsp" %>
        <div class="right-content">
            <h3 class="title">我的信息</h3>

            <div style="width: 300px">
                <div class="normal-div">我的会员卡号： <span class="number">${info.vid}</span></div>
                <div class="normal-div">我的手机号： <span class="number">${info.phone}</span></div>

                <label for="js-name-input" class="normal-input-label">姓名</label>
                <input type="text" id="js-name-input" class="normal-input" value="${info.name}">
                <label for="js-bank-input" class="normal-input-label">银行卡号</label>
                <input type="text" id="js-bank-input" class="normal-input" value="${bank.bankid}">
                <label for="js-bank-input" class="normal-input-label">银行卡密码</label>
                <input type="password" id="js-password-input" class="normal-input"  value="">
            </div>
            <button class="button btn-normal right-floated" onclick="submit()">修改</button>
            <div class="clear-fix"></div>
        </div>
    </div>
</div>

<%@include file="/pages/common/toaster.jsp" %>

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
    $(document).ready(function () {

    });
    function submit() {
        $.ajax({
            type: "POST",
            url: "/user/modifyInfo",
            data: {
                name: $("#js-name-input").val(),
                bankid: $("#js-bank-input").val(),
                password: $("#js-password-input").val(),
            },
            success: function (data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    toaster("修改成功~", "success");
                    setTimeout(function () {
                        window.location.href = "/dashboard";
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

