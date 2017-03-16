<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员统计 - 管理后台 - 哆哆甜品屋</title>
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
            <h3 class="title">会员统计</h3>
            <div id="age-container"></div>
            <div id="gender-container"></div>
            <div id="city-container"></div>
            <div id="status-container"></div>

            <select id="month-select" onchange="reloadConsume()">
                <option>2016-03</option>
                <option>2016-02</option>
            </select>
            <div id="consume-container"></div>
        </div>
    </div>
    <%@include file="/pages/common/toaster.jsp"%>
</body>

<style>
    #age-container,
    #gender-container,
    #city-container,
    #status-container,
    #consume-container {
        width: 600px;
        height: 350px;
        margin: 20px auto 0 auto;
    }
</style>
<script>
    $(document).ready(function() {

        $.ajax({
            type: "GET",
            url: "/admin/statistics/customer/age",
            success: function(data) {
                loadAge(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

        $.ajax({
            type: "GET",
            url: "/admin/statistics/customer/gender",
            success: function(data) {
                loadGender(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

        $.ajax({
            type: "GET",
            url: "/admin/statistics/customer/city",
            success: function(data) {
                loadCity(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

        $.ajax({
            type: "GET",
            url: "/admin/statistics/customer/status",
            success: function(data) {
                loadStatus(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

        $.ajax({
            type: "GET",
            url: "/admin/statistics/customer/consume",
            data: {
                month: $("#month-select").val(),
            },
            success: function(data) {
                loadConsume(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });

    });

    function loadAge(data) {

        var newData = [];
        for (var d in data) {
            var o = {};
            o.value = data[d];
            o.name = d;
            newData.push(o);
        }

        var myChart = echarts.init(document.getElementById('age-container'));
        var option = {
            title : {
                text: '会员年龄段统计',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series : [
                {
                    name: '年龄段人数',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '45%'],
                    data: newData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart.setOption(option);
    }

    function loadGender(data) {

        var newData = [];
        for (var d in data) {
            var o = {};
            o.value = data[d];
            o.name = d;
            newData.push(o);
        }

        var myChart = echarts.init(document.getElementById('gender-container'));
        var option = {
            title : {
                text: '会员性别统计',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series : [
                {
                    name: '男女人数',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '45%'],
                    data: newData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart.setOption(option);
    }

    function loadCity(data) {

        var newData = [];
        for (var d in data) {
            var o = {};
            o.value = data[d];
            o.name = d;
            newData.push(o);
        }

        var myChart = echarts.init(document.getElementById('city-container'));
        var option = {
            title : {
                text: '会员居住地统计',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series : [
                {
                    name: '会员居住地',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '45%'],
                    data: newData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart.setOption(option);
    }

    function loadStatus(data) {

        var newData = [];
        for (var d in data) {
            var o = {};
            o.value = data[d];
            o.name = d;
            newData.push(o);
        }

        var myChart = echarts.init(document.getElementById('status-container'));
        var option = {
            title : {
                text: '会员卡状态统计',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series : [
                {
                    name: '会员卡状态',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '45%'],
                    data: newData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart.setOption(option);
    }

    function loadConsume(data) {

        var newData = [];
        for (var d in data) {
            var o = {};
            o.value = data[d];
            o.name = d;
            newData.push(o);
        }

        var myChart = echarts.init(document.getElementById('consume-container'));
        var option = {
            title : {
                text: '会员消费统计',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series : [
                {
                    name: '会员消费情况',
                    type: 'pie',
                    radius : '55%',
                    center: ['50%', '45%'],
                    data: newData,
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        myChart.setOption(option);
    }

    function reloadConsume() {
        $.ajax({
            type: "GET",
            url: "/admin/statistics/customer/consume",
            data: {
                month: $("#month-select").val(),
            },
            success: function(data) {
                loadConsume(data);
            },
            error: function() {
                toaster("服务器出现问题，请稍微再试！", "error");
            }
        });
    }

</script>
</html>
