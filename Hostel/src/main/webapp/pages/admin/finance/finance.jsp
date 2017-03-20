<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>财务分析 - HOSTEL</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/normalize.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/plugins/datatables/datatables.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/jquery-2.1.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/echarts.min.js"></script>
</head>
<body class="admin-body">

<%@include file="../../common/admin_navbar.jsp" %>
<div class="wrapper">
    <div class="content">
        <div class="admin-panel">
            <h3 class="title">财务分析</h3>
            <div class="normal-div"></div>
            <div style="margin-bottom: 20px; margin-top: 20px;">
                <div id="chart-area" style="width: 600px;height:400px;"></div>
                <script type="text/javascript">
                    var myChart = echarts.init(document.getElementById('chart-area'));
                    var d = new Date();
                    var month = d.getMonth() + 1;
                    option = {
                        title: {
                            text: month+'月销售额分析（单位：RMB）',
                            left: 'center',
                            top: 25,
                            textStyle: {
                                color: '#111'
                            }
                        },

                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b}: {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            x: 'left',
                            data:['会员账户','会员现金','非会员现金']
                        },
                        series: [
                            {
                                name:'销售额',
                                type:'pie',
                                selectedMode: 'single',
                                radius: [0, '30%'],

                                label: {
                                    normal: {
                                        position: 'inner'
                                    }
                                },
                                labelLine: {
                                    normal: {
                                        show: false
                                    }
                                },
                                data:[
                                    {value:${vo.vipAccount+vo.vipCash}, name:'会员', selected:true},
                                    {value:${vo.nonVipCash}, name:'非会员'}
                                ]
                            },
                            {
                                name:'支付渠道',
                                type:'pie',
                                radius: ['40%', '55%'],

                                data:[
                                    {value:${vo.vipAccount}, name:'会员账户'},
                                    {value:${vo.vipCash}, name:'会员现金'},
                                    {value:${vo.nonVipCash}, name:'非会员现金'}
                                ]
                            }
                        ]
                    };
                    myChart.setOption(option);
                </script>
            </div>

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
    });

</script>
</html>
