/**
 * Created by Administrator on 2017/6/10.
 */
var URL_MENU = "{URL_PORTAL}portal/getMenu.action";//菜单地址
$(function () {
    /*顶部工具栏提示信息*/
    $("[data-toggle='popover']").popover();

    //获取菜单
    jo.postAjax(URL_MENU,{},function(json){
        if(json && json.code == 0){
            var menus = json.data;
            if(menus && menus.length > 0){
                var _html = '';
                for(var i=0;i<menus.length;i++){
                    var menu = menus[i];
                    _html += getNavUnitHtml(menu);
                }
                $(".young-nav-container").html(_html);//插入菜单
                //当有且只有1个根节点时,自动展开
                if(menus.length == 1){
                    var one = $(".young-nav-container>.young-nav-unit")[0];
                    var child = $(one).find(">.young-nav-child");
                    //$(one).find(">.young-nav-tit").click();
                    childNavOpen(child);//展开节点
                }
            }
        }else{
            alert(jo.getDefVal(json.info, "获取菜单异常!"));
        }
    });

    /*菜单点击事件*/
    $(".young-nav-tit").on("click",function(event){
        //子节点
        var child = $(this).next(".young-nav-child");
        if(child && child.hasClass("child-open")){//包含child-open,则收缩
            childNavClose(child);//关闭节点
            //关闭不对兄弟节点进行处理
        }else if(child && child.hasClass("child-close")){//包含child-close,则展开
            //同级已展开菜单
            var brother =  child.parent().parent().find(">.young-nav-unit");
            //收缩同级子节点
            brother.each(function(idx, ele){
                var c = $(ele).find(">.young-nav-child");
                if(c && c.length > 0 && c.hasClass("child-open")){//只对已展开的菜单做处理
                    childNavClose(c);//关闭
                }
            });

            //展开
            childNavOpen(child);//展开
        }
    });
});
//生成菜单单元的html
function getNavUnitHtml(menu){
    var _html = '';
    if(jo.isValid(menu)){
        _html += '<div class="young-nav-unit">';
        //生成菜单标题
        _html += '<div class="young-nav-tit" onclick="' + menu.href + ''+(jo.isValid(menu.href) ? ';refreshCrumbs(\''+menu.name+'\')' : '')+'">'
            + '<div class="young-nav-icon"><i class="fa ' + menu.icon + '" aria-hidden="true"></i></div>'
            + '<div class="young-nav-name">' + menu.name + '</div>'
            + '<div class="young-nav-handle">'
            + (jo.isValid(menu.children) ? '<i class="fa fa-angle-right" aria-hidden="true"></i>' : '')
            + '</div>'
            + '</div>';
        //生成子菜单
        if(menu.children && menu.children.length > 0){
            _html += '<div class="young-nav-child child-close">';
            for(var i=0;i<menu.children.length;i++){
                _html += getNavUnitHtml(menu.children[i]);//递归生成子节点
            }
            _html += '</div>';
        }
        _html += '</div>';
    }
    return _html;
}
//注销登录
function logout(){
    jo.confirm("您确定要注销登录吗?", {title:"退出"}, function(){
        window.location.href = URL_UMS + "logout.action";
    });
}
//子节点展开
function childNavOpen(child){
    child.slideDown('fast');
    child.removeClass("child-close");
    child.addClass("child-open");
    child.parent().find(">.young-nav-tit>.young-nav-handle").html('<i class="fa fa-angle-down" aria-hidden="true"></i>');
}
//子节点关闭
function childNavClose(child){
    child.slideUp('fast');
    child.removeClass("child-open");
    child.addClass("child-close");
    child.parent().find(">.young-nav-tit>.young-nav-handle").html('<i class="fa fa-angle-right" aria-hidden="true"></i>');
}
function resizeLeftBar(){
    //重新计算左侧菜单栏高度,使菜单栏在超出长度时出现滚动条
    $(".body-left-bar").css("height","0px");
    $(".body-left-bar").css("height",$("body").outerHeight()-$(".layout-table-td-head").outerHeight()+"px");
}