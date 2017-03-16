<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查询会员 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">
<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">查询会员</h3>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <label for="js-code-input" class="normal-input-label">请输入会员卡号</label>
                <input type="text" class="normal-input" id="js-code-input" style="width: 250px;"/>
                <button class="button btn-submit" onclick="loadCustomer()">确定</button>
            </div>
            <div id="result-container">

            </div>
        </div>
    </div>
    <%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    .sub-title {
        font-size: 17px;

    }
</style>
<script>
    $(document).ready(function() {

    });
    function loadCustomer() {
        $.ajax({
            type: "POST",
            url: "/admin/customer",
            data: {
                code: $("#js-code-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    $("#result-container").empty();
                    loadData(data);
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }
    function loadData(data) {

        var customer = data.customer;
        var consumption = data.consumptionList;
        var payment = data.paymentList;
        var html = '<h3 class="sub-title">会员信息</h3>';
        var gender = customer.customerInfo.gender == 1?"男":"女";
        html += '<div class="normal-div">会员卡号： ' + customer.code + '</div>' +
                '<div class="normal-div">手机号： ' + customer.phone + '</div>' +
                '<div class="normal-div">会员状态： ' + getCustomerStatus(customer.status) + '</div>' +
                '<div class="normal-div">会员姓名： ' + customer.customerInfo.name + '</div>' +
                '<div class="normal-div">会员性别： ' + gender + '</div>' +
                '<div class="normal-div">会员所在省份： ' + customer.customerInfo.province + '</div>' +
                '<div class="normal-div">会员所在城市： ' + customer.customerInfo.city + '</div>' +
                '<div class="normal-div">会员生日： ' + customer.customerInfo.birthday + '</div>';

        html += '<h3 class="sub-title">消费记录</h3>' +
                '<div class="table-container">' +
                '<table class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>'+
                '<th width="40%">消费时间</th>' +
                '<th width="20%">支付方式</th>' +
                '<th width="20%">消费金额</th>' +
                '<th width="20%">赠送积分</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';

        for (var i = 0; i < consumption.length; i++) {
            var c = consumption[i];
            var payType = (c.payType == 1)?'卡余额':'现金';
            var time = new Date(c.time).Format("yyyy-MM-dd hh:mm:ss");
            html += '<tr>' +
                    '<td>' + time + '</td>' +
                    '<td>' + payType + '</td>' +
                    '<td>' + c.money.toFixed(2) + '</td>' +
                    '<td>' + c.point + '</td>' +
                    '</tr>';
        }

        html += '</tbody>' +
                '</table>' +
                '</div>';

        html += '<h3 class="sub-title">缴费记录</h3>' +
                '<div class="table-container">' +
                '<table class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>'+
                '<th width="50%">缴费时间</th>' +
                '<th width="50%">缴费金额</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';

        for (var i = 0; i < payment.length; i++) {
            var p = payment[i];
            var time = new Date(p.time).Format("yyyy-MM-dd hh:mm:ss");
            html += '<tr>' +
                    '<td>' + time + '</td>' +
                    '<td>' + p.money + '</td>' +
                    '</tr>';
        }

        html += '</tbody>' +
                '</table>' +
                '</div>';

        $("#result-container").append(html);
    }
</script>
</html>

