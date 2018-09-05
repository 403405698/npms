/**
 * 常量相关的属性或者方法放在前面,方便修改
 * Created by Administrator on 2017/6/10.
 */

/**
 * 替换url常量
 * @param sUrl
 */
function replaceUrlConstants(sUrl){
    if(!sUrl){return '';}
    sUrl = sUrl.replace("{URL_UMS}", URL_UMS);//替换ums域名常量
    sUrl = sUrl.replace("{URL_PORTAL}", URL_PORTAL);//替换门户域名常量
    sUrl = sUrl.replace("{URL_STATIC}", URL_STATIC);//替换静态域名
    sUrl = sUrl.replace("{URL_FS}", URL_FS);//文件系统域名
    sUrl = sUrl.replace("{URL_CMS}", URL_CMS);//内容管理系统域名

    //在Url后追加时间戳,防止浏览器缓存
    sUrl = sUrl + jo.getLinkSign(sUrl) + "_t=" + new Date().getTime();
    return sUrl;
}
/**
 * 打开页面,在首页的main窗口
 * @param sUrl 页面url
 */
function openPageOnMain(sUrl){
    sUrl = replaceUrlConstants(sUrl);
    console.log("openPageOnMain" + sUrl);
    $("iframe[name='main']").attr("src", sUrl);
}
/*if(window != window.parent){
    progressStart();
}
$(function(){
    progressOver();
});*/
/**
 * 进度条展示
 */
function progressStart(){
    document.write('<div id="progress_core" style="width:10px;height:4px;position: fixed;top:0px;left:0px;border-radius: 2px;background-color: #242F35;border-right: #FC5743 solid 1px;"></div>');
    $("#progress_core").show();
    $("#progress_core").animate({width:'90%'});
}
/**
 * 进度条关闭
 */
function progressOver(){
    $("#progress_core").animate({width:'100%'}, "fast", function(){
        $("#progress_core").css("width", "0px");
        $("#progress_core").hide();
    });
}
/**
 * 在新窗口打开
 * @param sUrl 页面url
 */
function newWindow(sUrl){
    jo.newWindow(sUrl);
}
/**
 * 刷新面包屑
 * @param sInfo 面包屑内容
 */
function refreshCrumbs(sInfo){
    $("#crumbs").html(sInfo);
}
/**
 * 打开页面并且刷新面包屑
 * @param sUrl
 * @param sInfo
 */
function openPage(sUrl, sInfo){
    openPageOnMain(sUrl);
    refreshCrumbs(sInfo);
}
/**
 * 创建资源菜单树
 * @param eleId 树存放的容器id,默认为navigateTree
 * @param clickFunc 树节点点击事件,参数为event,treeId,treeNode
 */
function createNavigateTree(eleId,clickFunc){
    eleId = jo.getDefVal(eleId, "navigateTree");
    jo.postAjax("{URL_UMS}ums/navigate/getNavigateList.action", {}, function(json){
        if(json && json.code == 0){
            var root = {//加了children后子节点中的父子关系乱掉了,之前是可以用的,有待考虑
                ID:"ROOT"
                ,NAME:"资源导航池"
                //,children:json.data
                ,open:"true"
            };
            json.data.push(root);
            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "ID"
                ,item_pid : "PARENT_ID"
                ,item_show : "NAME"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建资源树失败!");
        }
    });
}
/**
 * 创建部门树
 * @param eleId 树存放的容器id,默认为navigateTree
 * @param clickFunc 树节点点击事件,参数为event,treeId,treeNode
 */
function createDeptTree(eleId,clickFunc){
    eleId = jo.getDefVal(eleId, "deptTree");
    jo.postAjax("{URL_UMS}ums/tree/getDeptTree.action", {}, function(json){
        if(json && json.code == 0){
           /* if(json && json.data && json.data[0] && json.data[0].ID == "ROOT"){
                json.data[0].open = true;
            }*/
            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "ID"
                ,item_pid : "PARENT_ID"
                ,item_show : "NAME"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建部门树失败!");
        }
    });
}
/**
 * 创建单位树
 * @param eleId
 * @param clickFunc
 */
function createCompanyTree(eleId,clickFunc){
    eleId = jo.getDefVal(eleId, "companyTree");
    jo.postAjax("{URL_UMS}ums/tree/getCompanyTree.action", {}, function(json){
        if(json && json.code == 0){
            if(json && json.data && json.data[0] && json.data[0].ID == "ROOT"){
                json.data[0].open = true;
            }
            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "ID"
                ,item_pid : "PARENT_ID"
                ,item_show : "NAME"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建单位树失败!");
        }
    });
}
/**
 * 创建组织树
 * @param eleId
 * @param clickFunc
 */
function createOrgTree(eleId,clickFunc){
    eleId = jo.getDefVal(eleId, "orgTree");
    jo.postAjax("{URL_UMS}ums/tree/getOrgTree.action", {}, function(json){
        if(json && json.code == 0){
            if(json && json.data && json.data[0] && json.data[0].ID == "ROOT"){
                json.data[0].open = true;
            }
            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "ID"
                ,item_pid : "PARENT_ID"
                ,item_show : "NAME"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建组织树失败!");
        }
    });
}
/**
 * 创建角色树(单位-角色形式展示)
 * @param eleId
 * @param clickFunc
 * @param bChecked 是否有选择框,默认false
 */
function createRoleTree(eleId, clickFunc, bChecked){
    eleId = jo.getDefVal(eleId, "roleTree");
    jo.postAjax("{URL_UMS}ums/tree/getRoleTree.action", {}, function(json){
        if(json && json.code == 0){
            if(json && json.data && json.data[0] && json.data[0].ID == "ROOT"){
                json.data[0].open = true;
            }

            for(var i=0;i<json.data.length;i++){
                var n = json.data[i];
                if(n.nodeType == "COMPANY"){

                }else{
                    n.NAME = "[角色] " + n.NAME;
                }
                if(jo.isValid(n.children) && n.children.length > 0){
                    for(var j=0;j<n.children.length;j++){
                        var n2 = n.children[j];
                        if(n2.nodeType == "COMPANY"){

                        }else{
                            n2.NAME = "[角色] " + n2.NAME;
                        }
                    }
                }
            }

            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "ID"
                ,item_pid : "PARENT_ID"
                ,item_show : "NAME"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            if(bChecked){
                param.check = {//需引入cxcheck扩展包
                    enable: true,    //勾选框开关
                    chkStyle: "checkbox",    //默认checkbox(与chkboxType属性关联),也可以写radio(与radioType属性关联)
                    chkboxType: {"Y":"ps","N":"s"},    //Y和N固定不变,Y表示勾选,N表示取消勾选;Y和N的值为p或s或ps,p表示会影响父节点,s表示会影响子节点
                    radioType: "all"    //取值为"all"和"level",all表示在所有节点中单选,level表示在同一层级内单选
                };
            }
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建角色树失败!");
        }
    });
}
/**
 * 创建文件夹树
 * @param eleId
 * @param clickFunc
 */
function createFolderTree(eleId,clickFunc){
    eleId = jo.getDefVal(eleId, "folderTree");
    jo.postAjax("{URL_FS}fs/fileInfo/getFolderTree.action", {}, function(json){
        if(json && json.code == 0){
            if(json && json.data && json.data[0] && json.data[0].id == "ROOT"){
                json.data[0].open = true;
            }
            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "id"
                ,item_pid : "folderId"
                ,item_show : "name"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建文件夹树失败!");
        }
    });
}
/**
 * 创建可编辑的文件夹树
 * @param eleId
 * @param clickFunc
 */
function createEditableFolderTree(eleId,clickFunc){
    eleId = jo.getDefVal(eleId, "folderTree");
    jo.postAjax("{URL_FS}fs/fileInfo/getFolderTree.action", {}, function(json){
        if(json && json.code == 0){
            if(json && json.data && json.data[0] && json.data[0].id == "ROOT"){
                json.data[0].open = true;
            }
            var param = {
                treeId : eleId
                ,zNodes : json.data
                ,item_id : "id"
                ,item_pid : "folderId"
                ,item_show : "name"
            };
            if(typeof (clickFunc) == "function"){
                param.onClickFunc = clickFunc;//树节点点击回调
            }
            param.edit = {
                enable : true,
                removeTitle : "删除",
                renameTitle : "编辑",
                showRemoveBtn : true,
                showRenameBtn : false
            };
            //初始化树的前置处理
            param.initZTreeBefore = function(sTreeId, setting, nodes){
                //删除节点前的回调
                setting.callback.beforeRemove = function(treeId, treeNode){
                    var res = false;
                    if(treeNode.id){
                        if(treeNode.id == "ROOT"){
                            jo.alert("不允许删除根目录!");
                            return false;
                        }
                        if(window.confirm("您确定要删除此文件夹及此文件夹下所有文件?")){
                            jo.postAjax("{URL_FS}fs/file/dropFolder.action", {folderId:treeNode.id}, function(json){
                                if(json && json.code == "0"){
                                    res = true;
                                    jo.showMsg("文件夹删除成功!");
                                }
                            });
                        }
                    }
                    return res;
                };
                //添加新增按钮
                setting.view.addHoverDom = function(treeId, treeNode){
                    var sObj = $("#" + treeNode.tId + "_span"); //获取节点信息
                    if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;

                    var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='新建子文件夹' onfocus='this.blur();'></span>"; //定义添加按钮
                    sObj.after(addStr); //加载添加按钮
                    var btn = $("#addBtn_"+treeNode.tId);

                    //绑定添加事件，并定义添加操作
                    if (btn) btn.bind("click", function(){
                        var zTree = $.fn.zTree.getZTreeObj("folderTree");
                        //将新节点添加到数据库中
                        jo.prompt({maxlength:10,title:"新建文件夹名称"}, function(value, index, elem){
                            var name = value;
                            jo.postAjax("{URL_FS}fs/file/createFolder.action", {"name":name, "folderId":treeNode.id}, function(json){
                                if(json && json.code == "0"){
                                    var newNode = json.data[0]; //获取新添加的节点Id
                                    zTree.addNodes(treeNode, {"id":newNode.id, "folderId":treeNode.id, "name":name}); //页面上添加节点
                                    var node = zTree.getNodeByParam("id", newNode.id, null); //根据新的id找到新添加的节点
                                    zTree.selectNode(node); //让新添加的节点处于选中状态
                                    jo.close(index);
                                    if(joView.inited){
                                        joView.reloadCurrentPage();//刷新当前页信息展示
                                    }
                                }
                            });
                        });
                    });
                };
                setting.view.removeHoverDom = function(treeId, treeNode){
                    $("#addBtn_"+treeNode.tId).unbind().remove();
                };
            };
            jo.drawZTree(param);
        }else{
            jo.showMsg("创建文件夹树失败!");
        }
    });
}

/**
 * 选择资源菜单
 * 用于表单中的资源输入
 * @param idInp 回填id的输入框id
 * @param nameInp 回填name的输入框id
 * @param bMore 是否允许多选,默认单选
 */
function choiceNavigate(idInp, nameInp, bMore){
    jo.selectTree('{URL_UMS}ums/navigate/getNavigateList.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore, null, null, null, function(zNodes){
        zNodes.push({
            ID:"ROOT"
            ,NAME:"ROOT"
            ,open:"true"
        });
    });
}
/**
 * 选择部门,仅部门
 * @param idInp 回填id的输入框id
 * @param nameInp 回填name的输入框id
 * @param bMore 是否允许多选,默认单选
 */
function choiceDept(idInp, nameInp, bMore){
    jo.selectTree('{URL_UMS}ums/tree/getDeptTree.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore);
}
/**
 * 选择单位
 * @param idInp 回填id的输入框id
 * @param nameInp 回填name的输入框id
 * @param bMore 是否允许多选,默认单选
 */
function choiceCompany(idInp, nameInp, bMore){
    jo.selectTree('{URL_UMS}ums/tree/getCompanyTree.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore);
}
/**
 * 选择组织,不区分单位和部门
 * @param idInp 回填id的输入框id
 * @param nameInp 回填name的输入框id
 * @param bMore 是否允许多选,默认单选
 */
function choiceOrg(idInp, nameInp, bMore){
    jo.selectTree('{URL_UMS}ums/tree/getOrgTree.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore);
}
/**
 * 选择图标
 * @param inpId 回显图标class的输入框id
 */
function choiceIcon(inpId){
    jo.selectIcon(jo.getDefVal(inpId, "ICON"));
}
/**
 * 下载文件
 * @param fileId 文件编号
 */
function downloadFile(fileId){
    if(jo.isValid(fileId)){
        jo.confirm("您确定要下载该文件吗?", {title:"下载确认"}, function(idx){
            jo.post("{URL_FS}fs/file/download.action", {"fileId" : fileId});
            jo.close(idx);
        });
    }else{
        console.error("文件编号无效,无法下载!");
    }
}
/**
 * 删除文件
 * @param fileId 文件编号
 */
function dropFile(fileId){
    if(jo.isValid(fileId)){
        jo.confirm("您确定要删除该文件吗?", {title:"删除确认"}, function(){
            jo.postAjax("{URL_FS}fs/file/dropFile.action", {"fileId" : fileId}, function(json){
                if(json && json.code == "0"){
                    jo.showMsg("成功删除文件!");
                    if(joView.inited){
                        joView.reloadCurrentPage();
                    }
                }if(json && json.code == "-1"){
                    jo.showMsg(json.info);
                }
            });
        });
    }else{
        console.error("文件编号无效,无法删除!");
    }
}


