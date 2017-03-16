<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预订销售统计 - 管理后台 - 哆哆甜品屋</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/echarts.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</head>
<body class="admin-body">
<%@include file="../../common/admin_navbar.jsp"%>
<div class="wrapper">

    <div class="content">
        <div class="admin-panel">
            <a href="/admin/statistics/customer">会员统计</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="/admin/statistics/sale">预订售出统计</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="/admin/statistics/product">热卖产品统计</a>
        </div>
        <div class="admin-panel">
            <h3 class="title">预订销售统计</h3>

            <select id="month-select" onchange="loadSale()" style="margin-top: 20px;">
                <option>2016-03</option>
                <option>2016-02</option>
            </select>
            <div id="sale-container"></div>

        </div>
    </div>
    <%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    #sale-container {
        width: 850px;
        height: 600px;
        margin: 20px auto 0 auto;
    }
</style>

<script>
    $(document).ready(function () {
        loadSale();
    });
    function loadSale() {
        $.ajax({
            type: "GET",
            url: "/admin/statistics/sale/getSales",
            data: {
                month: $("#month-select").val()
            },
            success: function(data) {
                load(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

        function load(data) {
            var myChart = echarts.init(document.getElementById('sale-container'));
            var option = {
                title : {
                    text: '该月各门店预订/销售情况统计',
                },
                tooltip : {
                    trigger: 'axis'
                },
                legend: {
                    data:['预订数量','销售数量']
                },
                toolbox: {
                    show : true,
                    feature : {
                        dataView : {show: true, readOnly: false},
                        magicType : {show: true, type: ['line', 'bar']},
                        restore : {show: true},
                        saveAsImage : {show: true}
                    }
                },
                calculable : true,
                xAxis : [
                    {
                        type : 'category',
                        data : data.names
                    }
                ],
                yAxis : [
                    {
                        type : 'value'
                    }
                ],
                series : [
                    {
                        name:'预订数量',
                        type:'bar',
                        data:data.bookNums,
                    },
                    {
                        name:'销售数量',
                        type:'bar',
                        data:data.saleNums,
                    }
                ]
            };

            myChart.setOption(option);
        }
    }
</script>

</html>