$(function() {
    // 获取地址栏参数
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    var lock = GetQueryString("lock");
    if (lock) {
        $("input").attr("disabled", "disabled");
        $("input").attr("background", "#FFF");
        $("input").css("border", "none");
        $("select").attr("disabled", "disabled");
    }


})