$(document).ready(function () {
    adminLightItem();
    datePicker();
    navbarLeftItems();
});


function toaster(message, type) {
    var toaster = $("#toaster");
    toaster.append('<div class="toast-item"><div class="message">' + message + '</div>' +
        '<i class="close fa fa-close"></i></div>');
    var thisItem = toaster.children().last();
    $(thisItem.children(".close").eq(0)).bind("click", function () {
        thisItem.slideUp(function() {
            thisItem.remove();
        });
    });
    if (type == "success") thisItem.addClass("success");
    else if (type == "error") thisItem.addClass("error");
    thisItem.fadeIn();
    setTimeout(function() {
        thisItem.slideUp(function() {
            thisItem.remove();
        });
    }, 3000);
}

function adminLightItem() {
    if ($("#admin-nav-items")) {
        var items = $("#admin-nav-items").children();
        for(var i = 0; i < items.length; i++) {
            var item = $(items[i]);
            var url = window.location.href;
            console.log(item.attr("url"));
            if (url.indexOf(item.attr("url")) != -1) {
                item.addClass("active");
                break;
            }
        }

    }
}

function datePicker() {
    try {
        $('.date-picker').each(function () {
            $(this).datetimepicker({
                lang:'ch',
                timepicker:false,
                format:'Y-m-d',
                formatDate:'Y/m/d',
                minDate: '1916/01/01',
                maxDate:'+1970/03/01',
                yearStart: 1916,
                yearEnd: 2016,
                scrollInput: false
            })
        });
    } catch (e) {
        console.log(e);
    }
}

function getWeek(day) {
    switch (day) {
        case 0: return '日';
        case 1: return '一';
        case 2: return '二';
        case 3: return '三';
        case 4: return '四';
        case 5: return '五';
        case 6: return '六';
    }
}

// Date 格式化
Date.prototype.Format = function(fmt) {
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
};

function planStatusTranslate(num) {
    switch (num) {
        case 0: return '未审批';
        case 1: return '已批准';
        case 2: return '不批准';
    }
}

function navbarLeftItems() {

    var shopList;

    $("#js-navbar-shop-select").text("选择门店： " + window.localStorage.getItem("shopName"));

    $.ajax({
        type: "POST",
        url: "/getShops",
        async: false,
        success: function(data) {
            shopList = data.shopList;
            for (var i = 0; i < shopList.length; i++) {
                $("#js-shop-panel > ul").append('<li shopId="' + shopList[i].id + '">' + shopList[i].name + '</li>');
            }
        },
        error: function() {
            toaster("服务器出现问题，请稍微再试！", "error");
        }
    });

    var open = false;
    $("#js-navbar-shop-select").click(function() {
        if (open == false) {
            open = true;
            $("#js-shop-panel").show();
        } else {
            open = false;
            $("#js-shop-panel").hide();
        }
    });
    $("#js-shop-panel").find("li").each(function() {
        $(this).click(function() {
            open = false;
            $("#js-shop-panel").hide();
            $("#js-navbar-shop-select").text("选择门店： " + $(this).text());
            window.localStorage.setItem("shopId",  $(this).attr("shopId"));
            window.localStorage.setItem("shopName", $(this).text());

            try {
                loadProducts();
            } catch (e) {

            }

        });
    });
}

function getCustomerStatus(status) {
    switch (status) {
        case 0: return '未激活';
        case 1: return '有效';
        case 2: return '已暂停';
        case 3: return '已停止';
    }
}