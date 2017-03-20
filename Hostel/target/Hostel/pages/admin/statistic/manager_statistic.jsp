<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>入住统计 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/manager_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">入住统计</h3>
            <div class="normal-div"></div>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <label for="js-hid-input" class="normal-input-label">请输入酒店编号</label>
                <input type="text" class="normal-input" id="js-hid-input" style="width: 250px;"/>
                <br/>
                <label for="js-date-input" class="normal-input-label">请输入指定日期</label>
                <input type="text" class="normal-input" id="js-date-input" style="width: 250px;"/>
                <br/>
                <button class="button btn-submit" onclick="getStatistic()">查询</button>

                <div id="item-container"></div>


            </div>
        </div>
    </div>
    <%@include file="/pages/common/toaster.jsp" %>
</body>

<style>
    .book-item {
        margin-bottom: 20px;
        border-bottom: 1px solid #b6b6b6;
        padding-bottom: 10px;
    }
</style>
<script>
    $(document).ready(function () {
        var d = new Date();
        var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
        $("#js-date-input").val(str);
    });

    function getStatistic() {
        $.ajax({
            type: "POST",
            url: "/admin/manager/statistics",
            data: {
                hid: $("#js-hid-input").val(),
                date: $("#js-date-input").val()
            },
            success: function (data) {
                var list = data.list;
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else if (list.length == 0) {
                    toaster("该店无房源信息！", "error");
                } else {
                    loadData(list);
                }
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    function loadData(list) {
        $("#item-container").empty();
        var html = "";
        html += '<div class="table-container">' +
                '<table id="js-table" class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>' +
                '<th width="19%">日期</th>' +
                '<th width="19%">房型</th>' +
                '<th width="19%">单价</th>' +
                '<th width="10%">剩余数量</th>' +
                '<th width="10%">预定人数</th>' +
                '<th width="10%">预定入住</th>' +
                '<th width="13%">非预定入住</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';
        for (var i = 0; i < list.length; i++) {
            var item = list[i];

            html += '<tr>' +
                    '<td>' + item.date + '</td>' +
                    '<td>' + item.type + '</td>' +
                    '<td>' + item.price + '</td>' +
                    '<td>' + item.available + '</td>' +
                    '<td>' + item.bookTotal + '</td>' +
                    '<td>' + item.bookCheckin + '</td>' +
                    '<td>' + item.nonBookCheckin + '</td>' +
                    '</tr>';
        }
        html += '</tbody>' +
                '</table>' +
                '</div>' +
                '<div class="clear-fix"></div>';
        $("#item-container").append(html);
    }

</script>
</html>
