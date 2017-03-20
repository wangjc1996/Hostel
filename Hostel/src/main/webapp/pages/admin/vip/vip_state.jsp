<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员状态 - HOSTEL</title>
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
            <h3 class="title">会员状态</h3>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <label for="js-code-input" class="normal-input-label">请输入会员手机号</label>
                <input type="text" class="normal-input" id="js-code-input" style="width: 250px;"/>
                <button class="button btn-submit" onclick="loadVip()">确定</button>
                <button class="button btn-submit" onclick="loadAll()">所有会员</button>
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

    function loadVip() {
        $.ajax({
            type: "POST",
            url: "/admin/manager/getVip",
            data: {
                phone: $("#js-code-input").val()
            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    $("#result-container").empty();
                    var vipList = data.list;
                    loadData(vipList);
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    function loadAll() {
        $.ajax({
            type: "POST",
            url: "/admin/manager/getAllVip",
            data: {

            },
            success: function(data) {
                if (data["success"] == false) {
                    toaster(data["error"], "error");
                } else {
                    $("#js-code-input").empty();
                    $("#result-container").empty();
                    var vipList = data.list;
                    loadData(vipList);
                }
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    function loadData(list) {

        var html = "";
        html += '<div class="table-container">' +
                '<table id="js-table" class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>' +
                '<th width="11%">会员号</th>' +
                '<th width="8%">姓名</th>' +
                '<th width="14%">手机</th>' +
                '<th width="8%">状态</th>' +
                '<th width="13%">银行卡</th>' +
                '<th width="6%">等级</th>' +
                '<th width="6%">折扣</th>' +
                '<th width="8%">余额</th>' +
                '<th width="8%">消费</th>' +
                '<th width="14%">到期</th>' +
                '<th width="6%">积分</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';
        for (var i = 0; i < list.length; i++) {
            var vip = list[i];

            var state = "";
            switch (vip.state){
                case "invalid":state="未激活";break;
                case "valid":state="有效";break;
                case "pause":state="已暂停";break;
                case "stop":state="已停止";break;
                default :
                        state = "数据错误";
            }
            html += '<tr>' +
                    '<td>' + vip.vid + '</td>' +
                    '<td>' + vip.name + '</td>' +
                    '<td>' + vip.phone + '</td>' +
                    '<td>' + state + '</td>' +
                    '<td>' + vip.bankid + '</td>' +
                    '<td>' + vip.level.level.substring(0, 2) + '</td>' +
                    '<td>' + vip.level.discount + '</td>' +
                    '<td>' + vip.level.balance + '</td>' +
                    '<td>' + vip.level.integration + '</td>' +
                    '<td>' + vip.level.time + '</td>' +
                    '<td>' + vip.level.point + '</td>' +
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

