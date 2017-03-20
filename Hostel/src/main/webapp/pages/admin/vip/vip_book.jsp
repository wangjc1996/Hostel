<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员订单 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">
<%@include file="../../common/manager_navbar.jsp"%>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">会员订单</h3>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <label for="js-code-input" class="normal-input-label">请输入会员手机号</label>
                <input type="text" class="normal-input" id="js-code-input" style="width: 250px;"/>
                <button class="button btn-submit" onclick="loadBook()">确定</button>
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

    function loadBook() {
        $.ajax({
            type: "POST",
            url: "/admin/manager/book",
            data: {
                phone: $("#js-code-input").val()
            },
            success: function(data) {
                var list = data.list;
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else if (list.length == 0) {
                    toaster("无订单信息！", "error");
                } else {
                    loadData(list);
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    function loadData(list) {
        $("#result-container").empty();

        var html = "";
        html += '<div class="table-container">' +
                '<table id="js-table" class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>' +
                '<th width="15%">订单编号</th>' +
                '<th width="15%">酒店名称</th>' +
                '<th width="15%">入住日期</th>' +
                '<th width="15%">人员</th>' +
                '<th width="10%">房间</th>' +
                '<th width="13%">金额</th>' +
                '<th width="10%">入住</th>' +
                '<th width="10%">支付</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';
        for (var i = 0; i < list.length; i++) {
            var book = list[i];

            var price = book.price;
            var isPaid = "未支付";
            var checkin = "未入住";
            if (price < 0) {
                price = -price;
            } else {
                isPaid = "已支付";
            }
            if (book.checkin > 0) {
                checkin = "已入住";
            }

            html += '<tr>' +
                    '<td>' + book.bookid + '</td>' +
                    '<td>' + book.hname + '</td>' +
                    '<td>' + book.date + '</td>' +
                    '<td>' + book.names + '</td>' +
                    '<td>' + book.type + '</td>' +
                    '<td>' + price + '</td>' +
                    '<td>' + checkin + '</td>' +
                    '<td>' + isPaid + '</td>' +
                    '</tr>';
        }
        html += '</tbody>' +
                '</table>' +
                '</div>' +
                '<div class="clear-fix"></div>';

        $("#result-container").append(html);
    }

</script>
</html>

