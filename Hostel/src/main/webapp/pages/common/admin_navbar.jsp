<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="admin-navbar">
    <div class="content">
        <span class="navbar-title">HOSTEL商家</span>
        <ul id="admin-nav-items" class="nav-items">
            <li class="nav-item" onclick="window.location.href='/admin/info'">店面信息</li>
            <li class="nav-item" onclick="window.location.href='/admin/hall'">入住登记</li>
            <li class="nav-item" onclick="window.location.href='/admin/plan'">计划管理</li>
            <li class="nav-item" onclick="window.location.href='/admin/statistics'">入住统计</li>
            <li class="nav-item" onclick="window.location.href='/admin/fiance'">财务统计</li>
            <li class="nav-item" onclick="window.location.href='/admin/password'">修改密码</li>
            <li class="nav-item" onclick="window.location.href='/admin/hotel/add'">申请开店</li>
        </ul>
        <span class="right-items">
            <i class="right-item fa fa-sign-out" title="登出" onclick="window.location.href='/logout'"></i>
        </span>
    </div>
</div>