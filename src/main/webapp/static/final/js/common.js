$(function() {
    var txt = $(".select .left").html();
    var opt = document.getElementsByClassName("opt");
    var selectContent = document.getElementById("selectContent");
    if (selectContent) {
        var oLi = selectContent.getElementsByTagName("li");
    }
    for (var i = 0; i < opt.length; i++) {
        if (opt[i].innerHTML == txt) {
            oLi[i].style.display = "none";
        }
    }
    var baifen = document.getElementsByClassName("baifen");
    for (var i = 0; i < baifen.length; i++) {
        var num = baifen[i].innerHTML.split("%")[0];
        if (num >= 60) {
            baifen[i].style.color = "#3fc75e";
        }
        if (baifen[i].innerHTML == "已审核") {
            baifen[i].style.color = "#1AAD19";
        }
        $(".select .baifen").css("color", "#ede038");
    }


    $(".select").click(function(event) {
        event.stopPropagation();
        if ($(this).hasClass("active")) {
            $(this).removeClass("active");
            $(".select-content").slideUp();
        } else {
            $(".select-content").slideDown();
            $(this).addClass("active");
        }
    })
    $(document.body).click(function() {
        $(".select-content").slideUp();
        $(".select").removeClass("active");
    })
    $(".select-content li").click(function() {
        $(".select").removeClass("active");
        $(".select-content li").show();
        $(".select .left").html($(this).children("a").children(".left").html());
        $(".select .baifen").html($(this).children("a").children(".baifen").html());
        $(".select-content").slideUp();
        $(this).hide();
        var href = $(this).children("a").attr("lay-href");
        if (href) {
            window.location.href = href;
        }
    })
    var edit1 = GetQueryString("edit");
    // 初始化展示页面不显示输入框样式
    if (!edit1) {
        $(".layui-input").addClass("readonly");
        $(".layui-input").attr("readonly", "readonly");
        $(".layui-textarea").addClass("readonly");
        $(".layui-textarea").attr("readonly", "readonly");
        $(".search-input").removeAttr("readonly");
        $(".list-input").removeAttr("readonly");
        $(".list-input").removeClass("readonly");
    } else {
        $("button.save").show();
        $("button.edit").hide();
        $(".col-item.save").hide();
        $(".col-item.edit").show();
    }


    // 展示页面上面点击编辑按钮
    $(".button-group button.edit").click(function() {
        $(this).hide();
        $("button.save").show();
        $(".layui-input").removeAttr("readonly");
        $(".layui-input").removeClass("readonly");
        $(".col-item.save").hide();
        $(".col-item.edit").show();
        $(".paixu").show();
        $("#remarkModifyTime").attr("readonly","readonly");
    })

    //上面点击保存编辑
    $(".button-group button.save").click(function() {
        //TODO new此处判断
        if (jo.checkForm($("#pageForm"))) {//TODO new
            $(this).hide();
            $("button.edit").show();
            $(".layui-input").attr("readonly", "readonly");
            $(".search-input").removeAttr("readonly");
            $(".layui-input").addClass("readonly");
            $(".layui-input.list-input").removeClass("readonly");//new
            $(".layui-input.list-input").removeAttr("readonly");//new
            $(".col-item.save").show();
            $(".col-item.edit").hide();
            $(".paixu").hide();
            $("#remarkModifyTime").attr("readonly","readonly");
        }

    });

    // 展示页面下面面点击编辑按钮
    $(".changItem button.edit").click(function() {
        $(this).hide();
        $(this).next("button.save").show();
        $(this).parents(".row-two").find($(".layui-input")).removeAttr("readonly");
        $(this).parents(".row-two").find($(".layui-input")).removeClass("readonly");
        $(this).parents(".row-two").find($(".col-item.save")).hide();
        $(this).parents(".row-two").find($(".col-item.edit")).show();
    })

    //下面点击保存编辑
    $(".changItem button.save").click(function() {
        $(this).hide();
        $(this).prev("button.edit").show();
        $(".search-input").removeAttr("readonly");
        $(this).parents(".row-two").find($(".layui-input")).attr("readonly", "readonly");
        $(this).parents(".row-two").find($(".layui-input")).addClass("readonly");
        $(this).parents(".row-two").find($(".col-item.save")).show();
        $(this).parents(".row-two").find($(".col-item.edit")).hide();
    })


    // 信息预览
    $(".preview").click(function() {
            layer.open({ /*弹出框*/
                type: 2,
                title: '信息预览',
                // maxmin: true,//大小窗口切换
                shadeClose: true, //点击遮罩关闭层
                area: ['100%', '100%'],
                content: 'information-preview.html'
            });
        })
        // 获取地址栏参数
    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]);
        return null;
    }

    // 锁定状态下操作无反应
    if ($(".changItem").children(".icon-suoding.big")) {
        $(".not-allowed").attr("disabled", "disabled");
    }




});