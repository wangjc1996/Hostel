<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="admin-navbar">
    <div class="content">
        <span class="navbar-title">HOSTEL经理后台</span>
        <ul id="admin-nav-items" class="nav-items">
            <li class="nav-item" onclick="window.location.href='/admin/manager/vip'">会员状态</li>
            <li class="nav-item" onclick="window.location.href='/admin/manager/book'">会员订单</li>
            <li class="nav-item" onclick="window.location.href='/admin/manager/statistics'">各店入住</li>
            <li class="nav-item" onclick="window.location.href='/admin/manager/fiance'">财务统计</li>
            <li class="nav-item" onclick="window.location.href='/admin/manager/approval'">开店审批</li>
            <li class="nav-item" onclick="window.location.href='/admin/manager/settlement'">线上结算</li>
        </ul>
        <span class="right-items">
            <i class="right-item fa fa-sign-out" title="登出" onclick="window.location.href='/logout'"></i>
        </span>
    </div>
</div>