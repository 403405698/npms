/**
 * 内容管理系统js
 * 依赖于平台基础库(jo,layer,zTree等插件)
 */

window.cms = {};
(function(){
    /**
     * 创建模块树
     * @param eleId 树容器id
     * @param clickFunc 点击事件
     */
    cms.createModuleTree = function(eleId,clickFunc){
        eleId = jo.getDefVal(eleId, "moduleTree");
        jo.postAjax("{URL_CMS}cms/module/getModuleList.action", {}, function(json){
            if(json && json.code == 0){
                var nodes = {"id":"", "name":"模块列表", "open":true, "children":json.data};
                var param = {
                    treeId : eleId
                    ,zNodes : nodes
                    ,item_id : "id"
                   // ,item_pid : "PARENT_ID"
                    ,item_show : "name"
                };
                if(typeof (clickFunc) == "function"){
                    param.onClickFunc = clickFunc;//树节点点击回调
                }
                jo.drawZTree(param);
            }else{
                jo.showMsg("创建组织树失败!");
            }
        });
    };
    /**
     * 创建模块树--按钮管理页面专属
     * @param eleId
     * @param clickFunc
     */
    cms.createModuleTreeOfButton = function(eleId,clickFunc){
        eleId = jo.getDefVal(eleId, "moduleTree");
        jo.postAjax("{URL_CMS}cms/module/getModuleList.action", {}, function(json){
            if(json && json.code == 0){

                json.data.push({"id":"COMMON", "name":"公共按钮"});
                var nodes = {"id":"", "name":"模块列表", "open":true, "children":json.data};
                var param = {
                    treeId : eleId
                    ,zNodes : nodes
                    ,item_id : "id"
                    // ,item_pid : "PARENT_ID"
                    ,item_show : "name"
                };
                if(typeof (clickFunc) == "function"){
                    param.onClickFunc = clickFunc;//树节点点击回调
                }
                jo.drawZTree(param);
            }else{
                jo.showMsg("创建组织树失败!");
            }
        });
    };
    /**
     * 选择业务字段
     * @param tableId 表
     */
    cms.choiceColsByTable = function(tableId, fieldInp, remarkInp){
        if(jo.isValid(tableId)){
            var sUrl = "{URL_CMS}cms/tableCol/getColByTable.action?tableId=" + tableId;
            jo.selectTree(sUrl, jo.getDefVal(fieldInp, 'cols'), jo.getDefVal(remarkInp, 'remarks'), 'field', 'showText', 'tableId', true, '', '', '', function(oList){
                for(var i=0;i<oList.length;i++){
                    var item = oList[i];
                    item.showText = item.field + (item.remark ? "（"+item.remark+"）" : "");
                }
            });
        }
    };
})();