/**
 * Created by Administrator on 2018/3/21.
 */
/**
 * 省市县联动--省份选择
 */
function choiceProvince() {
    var pro = $("#provinceCode").val();
    $("#cityCode").html("<option value=''></option>");
    $("#cityCode").val("");
    if (pro) {
        jo.postAjax("common/administrative/getCityListByProvinceCode.action", {"provinceCode": pro}, function (json) {
            if (json && json.code == "0") {
                var s = new JoSelect(document.getElementById("cityCode"));
                if (jo.isValid(s.element.getAttribute("firstItem"))) {
                    s.firstItem = JSON.parse(s.element.getAttribute("firstItem"));
                }
                s.load(json.data);
                choiceCity();//调用市选择
                if (typeof (choiceProvinceCall) == "function") {
                    choiceProvinceCall(pro);
                }
            }
        }, true);
    } else {
        //如果省份啥也没选,同时将县也清空
        $("#countyCode").html("<option value=''></option>");
        $("#countyCode").val("");
    }
}

/**
 * 省市县联动--市选择
 */
function choiceCity() {
    var pro = $("#cityCode").val();
    $("#countyCode").html("<option value=''></option>");
    $("#countyCode").val("");
    if (pro) {
        jo.postAjax("common/administrative/getCountyListByCityCode.action", {"cityCode": pro}, function (json) {
            if (json && json.code == "0") {
                var s = new JoSelect(document.getElementById("countyCode"));
                if (jo.isValid(s.element.getAttribute("firstItem"))) {
                    s.firstItem = JSON.parse(s.element.getAttribute("firstItem"));
                }
                s.load(json.data);
                if (typeof (choiceCityCall) == "function") {
                    choiceCityCall(pro);
                }
            }
        }, true);
    }
}

/**
 * 随着滚动条自动悬浮按钮栏
 */
function autoFloatButtonBar() {
    var top = $(".button-bar").offset().top;//距离顶部距离
    var floated = false;//当前悬浮状态,避免不必要的属性设置
    //下面这2行是为了显示更平滑,存在bug,已废弃,通过按钮条备份节点来优化显示
    /*var pHei = $(".button-bar").parent().outerHeight();//父元素高度
     $(".button-bar").parent().css("height",pHei+"px");*/
    $(document).scroll(function (e) {
        if (!floated && $(document).scrollTop() >= top) {
            floated = true;
            $(".button-bar").after('<div class="button_bar_copy" style="height:' + $(".button-bar").outerHeight() + "px" + ';width:1px;margin:0px;padding:0px;"></div>');
            $(".button-bar").addClass("button-float");
        } else if (floated && $(document).scrollTop() <= top) {
            floated = false;
            $(".button-bar").next(".button_bar_copy").remove();
            $(".button-bar").removeClass("button-float");
        } else {
            //console.info("不需要变"+"---此时="+$(".button-bar").offset().top +"=="+top)
        }
    });
}
/**
 * jiForm表单修改状态转新增状态
 * @param autoId 是否自动填充id值
 */
function joFormUpdateToAdd(autoId){
    joForm.isAdd = true;//标记表单为新增
    //新增表单初始化操作托管函数
    if(typeof(joForm.initFormPageOfAdd) == "function"){joForm.initFormPageOfAdd();}
    joForm.initFormPageBtn();//初始化表单按钮
    //joForm.handleReadOnly();//只读处理
    //设置主键值
    if(autoId){
        if(document.getElementsByName("id")[0]){
            document.getElementsByName("id")[0].value = joForm.params.PKValue;//设置主键值
            $(document.getElementsByName("id")[0]).attr("readonly",true);
        }
    }
}
/**
 * 人事档案详情对userId绑定的joView初始化操作
 */
function joViewInitAboutDoc(formHeight){
    var userId = jo.getUrlParam("userId");
    var condition = "";
    if(userId){
        condition = "userId=" + userId;
        joView.setTransferParam(condition);//将用户id传到新增页用来新增
    }
    joView.init({grid:$("#mainList"),PKName:"id","condition":condition,"formHeight":jo.getDefVal(formHeight, '390px')});//初始化页面
}
/**
 * 新增表单中对userId的处理,用在joForm.initFormPageOfAdd回调中
 */
function userIdHandleInAddForm(){
    if(jo.getUrlParam("userId") && document.getElementsByName("userId")[0]){
        document.getElementsByName("userId")[0].value = jo.getUrlParam("userId");//设置主键值
        $(document.getElementsByName("userId")[0]).attr("readonly",true);
    }
}
/**
 * 查看用户简历
 * @param uid
 */
function lookUserDoc(uid){
    if(uid){
        top.jo.showWin("page/personal/old_myDoc.jsp?id="+(uid), "80%", "85%", "用户简历", "WIN_USER_DOC");
    }
}
/**
 * 下载简历
 * @param userId 用户编号
 */
function downloadResume(userId){
    if(userId){
        jo.newWindow("pms/pmsUser/exportWord/"+(userId));
    }
}