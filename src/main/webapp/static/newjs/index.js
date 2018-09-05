/**
 * Created by Administrator on 2017/6/10.
 */
var URL_MENU = "portal/getMenu.action";//菜单地址
$(function () {

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
                _html += '<span class="layui-nav-bar" style="top: 214px; height: 0px; opacity: 0;"></span>';
                $("#LAY-system-side-menu").html(_html);//插入菜单
            }
        }else{
            alert(jo.getDefVal(json.info, "获取菜单异常!"));
        }
    });

    //测试
    var pData = {};
    pData["id"] = "${loginUser.id }";
    jo.postAjax("pms/pmsUser/get.action",pData,function (json) {
        if (json.code == 0 && json.data[0].photoAddress != null) {
            $("#headerPic").attr("src","fs/file/image.action?id=" + json.data[0].photoAddress);
        }else {
            $("#headerPic").attr("src","static/images/def_head.jpg");
        }
    });
    //测试



});
//生成菜单单元的html
function getNavUnitHtml(menu){
    var _html = '';
    if(jo.isValid(menu)){
        _html += '<li data-name="component" class="layui-nav-item" onclick="' + menu.href + ''+(jo.isValid(menu.href) ? ';refreshCrumbs(\''+menu.name+'\')' : '')+'">';

        // _html += '<li data-name="component" class="layui-nav-item">';
        //生成菜单标题
        _html += '<a class="mainAct" lay-href="javascript:;" lay-tips="人事管理" lay-direction="2">'
            + '<i class="iconfont icon-renshiguanli firstIcon"></i><cite>' + menu.name + '</cite>'
            + (jo.isValid(menu.children) ? '<i class="layui-icon layui-icon-down"></i>' : '') + '</a>';
        _html += '<dl class="layui-nav-child">';
        //生成子菜单
        if(menu.children && menu.children.length > 0){

            for(var i=0;i<menu.children.length;i++){
                _html += getChid(menu.children[i]);//递归生成子节点
            }

        }
        _html += '</dl>';
        _html +=  '</li>'
    }
    return _html;
}

function getChid(menu) {
    var _html = '';
    if(jo.isValid(menu)){

        _html += '<dd data-name="grid">';
        //生成菜单标题
        // _html += '<a class="two-level" lay-href="javascript:;">'

        _html += '<a class="two-level" href="javascript:;" onclick="' + menu.href + ''+(jo.isValid(menu.href) ? ';refreshCrumbs(\''+menu.name+'\')' : '')+'">'
            + '<i class="iconfont icon-quan"></i>'
            // + (jo.isValid(menu.children) ? '<i class="iconfont icon-quan"></i>' : '')
            + '' + menu.name + ''+ '</a>'
            + '';

        //生成子菜单
        if(menu.children && menu.children.length > 0){
            _html += '<div class="nav-child-list"><i class="bdnuarrow"></i><div class="nav-child-list-wrap"><div>';

            for(var i=0;i<menu.children.length;i++){
                _html += getThree(menu.children[i]);//递归生成子节点
            }
            _html += '</div></div></div>';

        }

        _html += '</dd>';

    }
    return _html;
}
function getThree(menu) {
    var _html = '';
    if(jo.isValid(menu)){
        //生成菜单标题
        // _html += '<a lay-href="javascript:;">'

        _html += '<a  onclick="' + menu.href + ''+(jo.isValid(menu.href) ? ';refreshCrumbs(\''+menu.name+'\')' : '')+'">'
            + '' + menu.name + ''
            + (jo.isValid(menu.children) ? '' : '')
            + '</a>';
        //生成子菜单
        if(menu.children && menu.children.length > 0){
            for(var i=0;i<menu.children.length;i++){
                _html += getThree(menu.children[i]);//递归生成子节点
            }
        }

    }
    return _html;
}
//注销登录
function logout(){
    jo.confirm("您确定要注销登录吗?", {title:"退出"}, function(){
        window.location.href = URL_UMS + "logout.action";
    });
}

