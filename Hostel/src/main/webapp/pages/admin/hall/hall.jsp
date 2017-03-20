<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登记入住 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">登记入住</h3>
            <div class="normal-div"></div>
            <div style="margin: 20px 0 15px 0;">
                <label for="js-code-input" class="normal-input-label">未预订入住</label>
                <button class="button btn-submit" onclick="noBook()">刷新</button>
                <div id="avail-container"></div>
            </div>
            <div style="margin-bottom: 20px;">
                <label for="js-code-input" class="normal-input-label">请输入会员手机号</label>
                <input type="text" class="normal-input" id="js-code-input" style="width: 250px;"/>
                <button class="button btn-submit" onclick="getBook()">确定</button>
                <button class="button btn-submit" onclick="getAllBook()">当日全部</button>
            </div>

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
        noBook();
        getAllBook();
    });

    //查找空余房间
    function noBook() {
        $.ajax({
            type: "POST",
            url: "/admin/hall/getAvail",
            success: function (data) {
                var availList = data.list;
                if (availList.length == 0) {
                    toaster("本店今日无房源！", "error");
                } else {
                    loadAvail(availList);
                }
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

    }

    //模糊查找订单
    function getBook() {
        $.ajax({
            type: "POST",
            url: "/admin/hall/getBooks",
            data: {
                phone: $("#js-code-input").val(),
            },
            success: function (data) {
                var bookList = data.list;
                if (bookList.length == 0) {
                    toaster("没有找到今天的订单！", "error");
                } else {
                    loadData(bookList);
                }
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    //今日所有订单
    function getAllBook() {
        $.ajax({
            type: "POST",
            url: "/admin/hall/getAllBooks",
            success: function (data) {
                var bookList = data.list;
                if (bookList.length == 0) {
                    toaster("本店今日无预定！", "error");
                } else {
                    loadData(bookList);
                }
            },
            error: function () {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

    //订单数据
    function loadData(bookList) {
        $("#item-container").empty();
        var html = "";
        html += '<div class="table-container">' +
                '<table id="js-table" class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>' +
                '<th width="15%">订单编号</th>' +
                '<th width="15%">入住日期</th>' +
                '<th width="15%">人员</th>' +
                '<th width="10%">房间</th>' +
                '<th width="12%">金额</th>' +
                '<th width="10%">入住</th>' +
                '<th width="10%">支付</th>' +
                '<th width="13%">操作</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';
        for (var i = 0; i < bookList.length; i++) {
            var book = bookList[i];
            var price = book.price;
            var isPaid = "未支付";
            var checkin = "未入住";
            var button = '<button class="button btn-edit" onclick="vipCashCheckin(' + book.bookid + ')">现金入住</button>';
            if (price < 0) {
                price = -price;
            } else {
                isPaid = "已支付";
                button = '<button class="button btn-edit" onclick="vipCheckin(' + book.bookid + ')">办理入住</button>';
            }
            if (book.checkin > 0) {
                checkin = "已入住";
                button = '';
            }

            html += '<tr>' +
                    '<td>' + book.bookid + '</td>' +
                    '<td>' + book.date + '</td>' +
                    '<td>' + book.names + '</td>' +
                    '<td>' + book.type + '</td>' +
                    '<td>' + price + '</td>' +
                    '<td>' + checkin + '</td>' +
                    '<td>' + isPaid + '</td>' +
                    '<td>' + button + '</td>' +
                    '</tr>';
        }
        html += '</tbody>' +
                '</table>' +
                '</div>' +
                '<div class="clear-fix"></div>';
        $("#item-container").append(html);
    }

    //空余房间数据
    function loadAvail(availList) {
        $("#avail-container").empty();
        var html = "";
        html += '<div class="table-container">' +
                '<table id="js-table" class="table table-striped table-bordered">' +
                '<thead>' +
                '<tr>' +
                '<th width="21%">日期</th>' +
                '<th width="17%">房型</th>' +
                '<th width="17%">单价</th>' +
                '<th width="17%">剩余数量</th>' +
                '<th width="13%">操作</th>' +
                '</tr>' +
                '</thead>' +
                '<tbody>';
        for (var i = 0; i < availList.length; i++) {
            var plan = availList[i];
            var button = '';
            if (plan.available > 0) {
                button = '<button class="button btn-edit" onclick="nonVipPage(' + plan.planid + ')">立即入住</button>';
            }

            html += '<tr>' +
                    '<td hidden>' + plan.planid + '</td>' +
                    '<td>' + plan.date + '</td>' +
                    '<td>' + plan.type + '</td>' +
                    '<td>' + plan.price + '</td>' +
                    '<td>' + plan.available + '</td>' +
                    '<td>' + button + '</td>' +
                    '</tr>';
        }
        html += '</tbody>' +
                '</table>' +
                '</div>' +
                '<div class="clear-fix"></div>';
        $("#avail-container").append(html);
    }

    //已预定，现金支付
    function vipCashCheckin(bookid) {
        var flag = confirm("确认已支付现金并入住？");
        if (flag == true) {
            $.ajax({
                type: "POST",
                url: "/admin/hall/vipCashCheckin",
                data: {
                    bookid: bookid,
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("入住成功~", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/hall";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });
        }
    }

    //已预定并支付，直接入住
    function vipCheckin(bookid) {
        var flag = confirm("确认入住？");
        if (flag == true) {
            $.ajax({
                type: "POST",
                url: "/admin/hall/vipCheckin",
                data: {
                    bookid: bookid,
                },
                success: function (data) {
                    if (data["success"] == false) {
                        toaster(data["error"], "error");
                    } else {
                        toaster("入住成功~", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/hall";
                        }, 1000);
                    }
                },
                error: function () {
                    toaster("服务器出现问题，请稍微再试！", "error");
                }
            });
        }
    }

    function nonVipPage(planid) {
        window.location.href = "/admin/hall/nonVipCheckin?planid=" + planid;
    }

</script>
</html>
