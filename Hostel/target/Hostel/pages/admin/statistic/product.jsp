<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>热卖产品统计 - 管理后台 - 哆哆甜品屋</title>
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
            <h3 class="title">热卖产品统计</h3>

            <select id="month-select" onchange="loadProduct()" style="margin-top: 20px;">
                <option>2016-03</option>
                <option>2016-02</option>
            </select>
            <div id="product-container"></div>

        </div>
    </div>
    <%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    #product-container {
        width: 600px;
        height: 350px;
        margin: 20px auto 0 auto;
    }
</style>

<script>
    $(document).ready(function () {
        loadProduct();
    });
    function loadProduct() {
        $.ajax({
            type: "GET",
            url: "/admin/statistics/product/getProducts",
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
            var myChart = echarts.init(document.getElementById('product-container'));
            var option = {
                title: {
                    text: '该月热卖产品',
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                xAxis: {
                    type: 'value',
                    boundaryGap: [0, 0.01]
                },
                yAxis: {
                    type: 'category',
                    data: data.names.reverse()
                },
                series: [
                    {
                        name: '该月销售数量',
                        type: 'bar',
                        data: data.nums.reverse()
                    },
                ]
            };
            myChart.setOption(option);
        }
    }
</script>

</html>