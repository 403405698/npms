/**
 * Created by JaneYork on 2018/8/15.
 */
var URL_MENU = "portal/getMenu.action";//菜单地址
$(function () {

    //获取菜单
    jo.postAjax(URL_MENU,{},function(json){
        if(json && json.code == 0){
            var menus = json.data;
/*            var test = "openPageOnMain('page/pms/auditPersonnel.jsp')";
            console.log("test" + test.substring(16,test.length-2));*/
            if(menus && menus.length > 0){
                var _html = '';
                var all3 = '';
                for(var i=0;i<menus.length;i++){
                    var menu = menus[i];
                    _html += getNavUnitHtml(menu);//1.2
                    //3start
                    if(menu.children && menu.children.length > 0){
                        for (var j=0;j<menu.children.length;j++) {
                            var m2 = menu.children[j];
                            if (m2.children && m2.children.length > 0) {
                                var c = "";
                                if (m2.name == "信息审核") {
                                    c = "nav-child-list1";
                                }
                                if (m2.name == "员工花名册") {
                                    c = "nav-child-list2";
                                }
                                if (m2.name  == "人事统计") {
                                    c = "nav-child-list3";
                                }
                                if (m2.name  == "角色权限") {
                                    c = "nav-child-list4";
                                }
                                if (m2.name  == "单点登录服务") {
                                    c = "nav-child-list5";
                                }
                                var th_html = '';
                                th_html += '         <div class="'+c+' nav-child-list" style="position: fixed;z-index: 999999;left: 220px;">\n' +
                                    '            <i class="bdnuarrow"></i>\n' +
                                    '            <div class="nav-child-list-wrap">\n' +
                                    '                <div>';

                                for (var k=0;k<m2.children.length;k++) {
                                    var m3 = m2.children[k];
/*                                    var jspStr = m3.href.substring(16,m3.href.length-2);
                                    console.log("打印3级：" + m3.name + m3.href);
                                    console.log("打印3级：" + m3.href.substring(16,m3.href.length-2));
                                    th_html += '<a lay-href="'+jspStr+'">'+m3.name+'</a>';*/
                                    th_html += '<a lay-href="javascript:;" onclick="'+m3.href+'">'+m3.name+'</a>';
                                }
                                th_html += '                </div>\n' +
                                    '            </div>\n' +
                                    '        </div>';
                                all3 += th_html;
                            }
                        }
                    }
                    //3end
                }
                _html += '<span class="layui-nav-bar" style="top: 214px; height: 0px; opacity: 0;"></span>';
                $("#LAY-system-side-menu").html(_html);//插入菜单
                $("#outer3ji").html(all3);

            }

        }else{
            alert(jo.getDefVal(json.info, "获取菜单异常!"));
        }
    });

    //新增判断，去除admin显示
    if (loginUser.roleId == "1") {
        $("#r_baseshow").hide();
    }
    //去除admin end
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

//2ji
function getChid(menu) {
    var _html = '';
    if(jo.isValid(menu)){

        //生成2级a特殊类
        var a_class = "";
        if (menu.name == "信息审核") {
            a_class = "reviewe";
        }
        if (menu.name == "员工花名册") {
            a_class = "flower";
        }
        if (menu.name  == "人事统计") {
            a_class = "tongji";
        }
        if (menu.name  == "角色权限") {
            a_class = "rolePermission";
        }
        if (menu.name  == "单点登录服务") {
            a_class = "sso";
        }
        //a 特殊end

        _html += '<dd data-name="grid">';
        //生成菜单标题
        _html += '<a class="two-level '+a_class+'" href="javascript:;" onclick="' + menu.href + ''+(jo.isValid(menu.href) ? ';refreshCrumbs(\''+menu.name+'\')' : '')+'">'
            + '<i class="iconfont icon-quan"></i>'
            + '' + menu.name + ''+ '</a>'
            + '';
        //生成子菜单
/*        if(menu.children && menu.children.length > 0){

            for(var i=0;i<menu.children.length;i++){
                getThree(menu.children[i]);//递归生成子节点
            }
            _html += '</div></div></div>';

        }*/

        _html += '</dd>';

    }
    return _html;
}
function getThree(menu) {
    var _html = '';
    if(jo.isValid(menu)){
        //生成菜单标题
        var c = "";
        if (menu.parentName == "信息审核") {
            c = "nav-child-list1";
        }
        if (menu.parentName == "员工花名册") {
            c = "nav-child-list2";
        }
        if (menu.parentName == "人事统计") {
            c = "nav-child-list3";
        }
        _html += '        <div class="'+c+' nav-child-list" style="position: fixed;z-index: 999999;left: 220px;">\n' +
            '            <i class="bdnuarrow"></i>\n' +
            '            <div class="nav-child-list-wrap">\n' +
            '                <div>';

        _html += '<a  onclick="' + menu.href + ''+(jo.isValid(menu.href) ? ';refreshCrumbs(\''+menu.name+'\')' : '')+'">'
            + '' + menu.name + ''
            + (jo.isValid(menu.children) ? '' : '')
            + '</a>';

        _html += '                </div>\n' +
            '            </div>\n' +
            '        </div>';
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

