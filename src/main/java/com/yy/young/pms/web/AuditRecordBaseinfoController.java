package com.yy.young.pms.web;

import com.yy.young.cms.service.ICmsDBService;
import com.yy.young.common.core.excel.ExcelExport;
import com.yy.young.common.core.excel.ExcelImport;
import com.yy.young.common.core.excel.IExcelExport;
import com.yy.young.common.core.excel.IExcelImport;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.util.Page;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.interfaces.model.User;
import com.yy.young.pms.model.*;
import com.yy.young.pms.service.*;
import com.yy.young.ums.service.IUmsUserService;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.ls.LSInput;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
* xxx服务
* Created by rookie on 2018-04-03.
*/
@Controller
@RequestMapping("/pms/auditRecordBaseinfo")
public class AuditRecordBaseinfoController {

    @Resource(name="auditRecordBaseinfoService")
    IAuditRecordBaseinfoService service;

    @Resource(name="auditFieldBaseService")
    IAuditFieldBaseService auditFieldBaseService;

    @Resource(name = "pmsUserService")
    IPmsUserExtService pmsUserService;

    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService2;

    @Resource(name="auditPmsCommunicationService")
    IAuditPmsCommunicationService auditPmsCommunicationService;

    @Resource(name="auditPmsDeptService")
    IAuditPmsDeptService auditPmsDeptService;

    @Resource(name="auditPmsEducationService")
    IAuditPmsEducationService auditPmsEducationService;

    @Resource(name="auditPmsHonorTitleService")
    IAuditPmsHonorTitleService auditPmsHonorTitleService;

    @Resource(name="auditPmsJoinProjectService")
    IAuditPmsJoinProjectService auditPmsJoinProjectService;

    @Resource(name="auditPmsLeaderEvaluationService")
    IAuditPmsLeaderEvaluationService auditPmsLeaderEvaluationService;

    @Resource(name="auditPmsMainTechGroupService")
    IAuditPmsMainTechGroupService auditPmsMainTechGroupService;

    @Resource(name="auditPmsPaperService")
    IAuditPmsPaperService auditPmsPaperService;

    @Resource(name="auditPmsPatentService")
    IAuditPmsPatentService auditPmsPatentService;

    @Resource(name="auditPmsPublishService")
    IAuditPmsPublishService auditPmsPublishService;

    @Resource(name="auditPmsRelationsService")
    IAuditPmsRelationsService auditPmsRelationsService;

    @Resource(name="auditPmsSelfEvaluationService")
    IAuditPmsSelfEvaluationService auditPmsSelfEvaluationService;

    @Resource(name="auditPmsSupportProjectService")
    IAuditPmsSupportProjectService auditPmsSupportProjectService;

    @Resource(name="auditPmsTechAwardsService")
    IAuditPmsTechAwardsService auditPmsTechAwardsService;

    @Resource(name="auditPmsTechnologyBraceService")
    IAuditPmsTechnologyBraceService auditPmsTechnologyBraceService;

    @Resource(name="auditPmsWorkService")
    IAuditPmsWorkService auditPmsWorkService;

    @Resource(name="auditPmsYearCheckService")
    IAuditPmsYearCheckService auditPmsYearCheckService;

    @Resource(name = "cmsDBService")
    ICmsDBService cmsDBService;

    @Resource(name="auditFieldService")
    IAuditFieldService auditFieldService;

    @Resource(name="auditShowUserService")
    IAuditShowUserService auditShowUserService;

    @Resource(name="auditFieldCommuService")
    IAuditFieldCommuService auditFieldCommuService;

    @Resource(name="auditRecordCommunicationService")
    IAuditRecordCommunicationService auditRecordCommunicationService;

    @Resource(
            name = "umsUserService"
    )
    IUmsUserService userService;
    /**
    * 获取数据列表
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("查询xxx列表")
    @RequestMapping("/getList")
    @ResponseBody
    public Object getList(AuditRecordBaseinfo obj, HttpServletRequest request) throws Exception{
        List<AuditRecordBaseinfo> list = service.getList(obj);
        return new Result(list);
    }

    /**
    * 获取分页数据
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("分页查询xxx列表")
    @RequestMapping("/getPage")
    @ResponseBody
    public Object getPage(AuditRecordBaseinfo obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditRecordBaseinfo> list = service.getPage(obj, page);
        page.setData(list);
        return page;
    }

    /**
    * 获取单条数据
    * @param id
    * @param request
    * @return
    * @throws Exception
    */
    @Log("查询xxx")
    @RequestMapping("/get")
    @ResponseBody
    public Object get(String id, HttpServletRequest request) throws Exception{
        AuditRecordBaseinfo obj = service.get(id);
        return new Result(obj);
    }

    /**
    * 统计数量
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("统计xxx数量")
    @RequestMapping("/count")
    @ResponseBody
    public Object count(AuditRecordBaseinfo obj, HttpServletRequest request) throws Exception{
        return new Result(service.count(obj));
    }

    /**
    * 新增
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("新增xxx")
    @RequestMapping("/insert")
    @ResponseBody
    public Object insert(AuditRecordBaseinfo obj, HttpServletRequest request) throws Exception{
        service.insert(obj);
        return new Result();
    }

    /**
    * 修改
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("修改xxx")
    @RequestMapping("/update")
    @ResponseBody
    public Object update(AuditRecordBaseinfo obj, HttpServletRequest request) throws Exception{
        service.update(obj);
        return new Result();
    }


    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditRecordBaseinfo obj, HttpServletRequest request) throws Exception{
        List<PmsUser> educationList = pmsUserService2.getList(new PmsUser());
        for (PmsUser item : educationList) {
            JSONObject jsonObject = JSONObject.fromObject(item);
            Iterator keys = jsonObject.keys();
            String userId = jsonObject.getString("id");
            while(keys.hasNext()) {
                String key = keys.next().toString();
                String val = jsonObject.getString(key);
                AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
                AuditRecordBaseinfo.setFieldKey(key);
                AuditRecordBaseinfo.setUserId(userId);
                int size = service.getList(AuditRecordBaseinfo).size();
                AuditRecordBaseinfo.setFieldVal(val);
                if (("id").equals(key) || ("userId").equals(key) || ("num").equals(key) || ("photoAddress").equals(key) || ("trashFlag").equals(key) ) {
                    AuditRecordBaseinfo.setAuditStatus(1);
                }else {
                    AuditRecordBaseinfo.setAuditStatus(5);
                }
                AuditRecordBaseinfo.setLockStatus(2);
                AuditRecordBaseinfo.setItemId(1);//临时处理，库里一定没有数据
                if (size > 0) {
                    service.update(AuditRecordBaseinfo);
                }else {
                    service.insert(AuditRecordBaseinfo);
                }
            }
        }

        return new Result();
    }


    /**
     * @param
     * @param request
     * @return
     * @throws Exception
     */
    @Log("管理员审核")
    @RequestMapping("/changeStatus")
    @ResponseBody
    public Object changeStatus(String ids,Integer auditStatus,Integer lockStatus,String userId,String vStr,String vName, HttpServletRequest request) throws Exception{
        Result result = new Result();

        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            String[] vStrArr = vStr.split(",",-1);
            String[] vNameArr = vName.split(",");
            for (int i=0;i<idArr.length;i++) {
                AuditRecordBaseinfo obj = new AuditRecordBaseinfo();
                if (!("on").equals(idArr[i])) {
                    obj.setId(idArr[i]);
                }else {
                    obj.setId(CommonUtil.getUUID());
                }
                obj.setAuditStatus(auditStatus);

                if (auditStatus != null && 2 == auditStatus) {
                    lockStatus = 2;//审核不通过，自动解锁条目，让用户可以修改
                }

                obj.setLockStatus(lockStatus);
                obj.setFieldVal(vStrArr[i]);//新增

                if (("on").equals(idArr[i])) {
                    //设置item_id start以上次为基准，如果上次为0，则这次为1；
                    int itemId;
                    AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
                    temp.setUserId(userId);
                    List<AuditRecordBaseinfo> tempList =  service.getList(temp);//降序
                    if (tempList.size() > 0) {
                        itemId = tempList.get(0).getItemId();
                    }else {
                        itemId = 1;
                    }
                    obj.setFieldKey(vNameArr[i]);
                    obj.setItemId(itemId);
                    obj.setUserId(userId);
                    //设置item_id end
                    service.insert(obj);
                }
                else {
                    service.update(obj);
                }
                idArr[i] = obj.getId();

                if (auditStatus != null) {
                    if (1 == auditStatus) {
                        PmsUser pmsUser = service.get(idArr[i]).toAnother();
                        pmsUser.setId(userId);
                        pmsUserService2.update(pmsUser);
                        //new start 同步admin 用户管理那里的信息
                        //同步，姓名，账号，生日，性别
                        User user = new User();
                        user.setId(userId);
                        if (("userName").equals(vNameArr[i])) {
                            user.setName(vStrArr[i]);
                            userService.updateUser(user);
                        }

                        if (("birth").equals(vNameArr[i])) {
                            user.setBirthday(vStrArr[i]);
                            userService.updateUser(user);
                        }
                        if (("sex").equals(vNameArr[i])) {
                            if ("男".equals(vStrArr[i])){
                                user.setSex("1");
                                userService.updateUser(user);
                            }else if ("女".equals(vStrArr[i])){
                                user.setSex("0");
                                userService.updateUser(user);
                            }
                        }
                        //new end
                    }
                    if (2 == auditStatus) {
                        AuditRecordBaseinfo toShow = new AuditRecordBaseinfo();
                        toShow.setUserId(userId);
                        toShow.setAuditStatus(1);
                        toShow.setFieldKey(service.get(idArr[i]).getFieldKey());
                        List<AuditRecordBaseinfo> toShows = service.getList(toShow);
                        PmsUser pmsUser;
                        if (toShows.size() > 0) {
                            pmsUser = toShows.get(0).toAnother();
                        }else{
                            //没有审核通过的记录，把信息置为空
                            pmsUser = service.get(idArr[i]).noOkItem();
                        }
                        pmsUser.setId(userId);
                        pmsUserService2.update(pmsUser);
                    }
                }
            }
        }else{
            result.setCode(-1);
            result.setInfo("操作失败：编号无效!");
        }

        //对人员审核判断
        AuditShowUser AuditShowUser = new AuditShowUser();
        AuditShowUser.setUserId(userId);
        if (auditShowUserService.getList(AuditShowUser).size() > 0) {

        }else {
            auditShowUserService.insert(AuditShowUser);
        }
        AuditShowUser.setPersonalShow(0);
        //start
        AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
        AuditRecordBaseinfo.setUserId(userId);
        //TODO 用户修改和审核不一样，使用库中最新的item_id 判断是否需要显示用户
        List<AuditRecordBaseinfo> tempList =  service.getList(AuditRecordBaseinfo);//降序
        if (tempList.size() > 0) {
            AuditRecordBaseinfo.setItemId(tempList.get(0).getItemId());
            AuditRecordBaseinfo.setAuditStatus(5);
            if (service.getList(AuditRecordBaseinfo).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
        }

        AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
        AuditRecordCommunication.setUserId(userId);
        //TODO 用户修改和审核不一样，使用库中最新的item_id 判断是否需要显示用户
        List<AuditRecordCommunication> tempList1 =  auditRecordCommunicationService.getList(AuditRecordCommunication);//降序
        if (tempList1.size() > 0) {
            AuditRecordCommunication.setItemId(tempList1.get(0).getItemId());
            AuditRecordCommunication.setAuditStatus(5);
            if (auditRecordCommunicationService.getList(AuditRecordCommunication).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
        }


        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        if (auditPmsRelationsService.getList(AuditPmsRelations).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsEducation AuditPmsEducation = new AuditPmsEducation();
        AuditPmsEducation.setUserId(userId);
        AuditPmsEducation.setStatus(5);
        if (auditPmsEducationService.getList(AuditPmsEducation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsWork AuditPmsWork = new AuditPmsWork();
        AuditPmsWork.setUserId(userId);
        AuditPmsWork.setStatus(5);
        if (auditPmsWorkService.getList(AuditPmsWork).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsMainTechGroup AuditPmsMainTechGroup = new AuditPmsMainTechGroup();
        AuditPmsMainTechGroup.setUserId(userId);
        AuditPmsMainTechGroup.setStatus(5);
        if (auditPmsMainTechGroupService.getList(AuditPmsMainTechGroup).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsHonorTitle AuditPmsHonorTitle = new AuditPmsHonorTitle();
        AuditPmsHonorTitle.setUserId(userId);
        AuditPmsHonorTitle.setStatus(5);
        if (auditPmsHonorTitleService.getList(AuditPmsHonorTitle).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechAwards AuditPmsTechAwards = new AuditPmsTechAwards();
        AuditPmsTechAwards.setUserId(userId);
        AuditPmsTechAwards.setStatus(5);
        if (auditPmsTechAwardsService.getList(AuditPmsTechAwards).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPaper AuditPmsPaper = new AuditPmsPaper();
        AuditPmsPaper.setUserId(userId);
        AuditPmsPaper.setStatus(5);
        if (auditPmsPaperService.getList(AuditPmsPaper).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPublish AuditPmsPublish = new AuditPmsPublish();
        AuditPmsPublish.setUserId(userId);
        AuditPmsPublish.setStatus(5);
        if (auditPmsPublishService.getList(AuditPmsPublish).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPatent AuditPmsPatent = new AuditPmsPatent();
        AuditPmsPatent.setUserId(userId);
        AuditPmsPatent.setStatus(5);
        if (auditPmsPatentService.getList(AuditPmsPatent).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsJoinProject AuditPmsJoinProject = new AuditPmsJoinProject();
        AuditPmsJoinProject.setUserId(userId);
        AuditPmsJoinProject.setStatus(5);
        if (auditPmsJoinProjectService.getList(AuditPmsJoinProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechnologyBrace AuditPmsTechnologyBrace = new AuditPmsTechnologyBrace();
        AuditPmsTechnologyBrace.setUserId(userId);
        AuditPmsTechnologyBrace.setStatus(5);
        if (auditPmsTechnologyBraceService.getList(AuditPmsTechnologyBrace).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsSupportProject AuditPmsSupportProject = new AuditPmsSupportProject();
        AuditPmsSupportProject.setUserId(userId);
        AuditPmsSupportProject.setStatus(5);
        if (auditPmsSupportProjectService.getList(AuditPmsSupportProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsYearCheck AuditPmsYearCheck = new AuditPmsYearCheck();
        AuditPmsYearCheck.setUserId(userId);
        AuditPmsYearCheck.setStatus(5);
        if (auditPmsYearCheckService.getList(AuditPmsYearCheck).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("最后为：" + AuditShowUser.getPersonalShow());
        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }


    /**
     * 获取用户审核信息，用于用户查看时信息对比请求USERID，返回信息不相同改变状态而且判断一下状态。
     */
    @Log("获取用户审核信息")
    @RequestMapping("/getUserAuditInfo")
    @ResponseBody
    public Object getUserAuditInfo (AuditRecordBaseinfo obj,HttpServletRequest request) throws Exception {

        //筛选最后一次start
        AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
        AuditRecordBaseinfo.setUserId(obj.getUserId());
        List<AuditRecordBaseinfo> tempList = service.getList(AuditRecordBaseinfo);
        if (tempList.size() > 0) {
            obj.setItemId(tempList.get(0).getItemId());
        }
        //筛选最后一次 end
        List<AuditRecordBaseinfo> auditList = service.getList(obj);

        List<Object> list = new ArrayList<Object>();
        list.add(auditList);
        return new Result(list);
    }

    /**
     * 用户修改提交审核
     * @param pData
     * @param request
     * @return
     * @throws Exception
     */
    @Log("用户修改信息提交审核")
    @RequestMapping("/userUpdate")
    @ResponseBody
//    {"id":"1","oldName":"李晓峰1","placeOfOrigin":"河北1","workStartTime":"2018-07-26"}提交所有数据
    public Object userUpdate(String pData, HttpServletRequest request) throws Exception{
        //nowdate
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nowStr = formatter.format(date);
        String rTime = "";

        String rs = request.getParameter("sf");
        Result result = new Result();
        JSONObject obj = JSONObject.fromObject(pData);

        Iterator iterator = obj.keys();
        String userId = obj.get("id").toString();

        //设置item_id start以上次为基准，如果上次为0，则这次为1；
        int itemId;
        AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
        temp.setUserId(userId);
        List<AuditRecordBaseinfo> tempList =  service.getList(temp);//降序
        if (tempList.size() > 0) {
            itemId = tempList.get(0).getItemId() + 1;
        }else {
            itemId = 1;
        }
        //设置item_id end
        while (iterator.hasNext()) {
            String key = iterator.next().toString();
            String val = obj.getString(key);
            //用户修改直接插入，字段和上次一样则用上次的状态，
            //获取上次记录start
            AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
            AuditRecordBaseinfo.setUserId(userId);
            AuditRecordBaseinfo.setFieldKey(key);
            List<AuditRecordBaseinfo> list =  service.getList(AuditRecordBaseinfo);//降序
            //获取上次记录 end
            int counts = list.size();
            int status;
            int lockStatus;

            if (counts > 0) {
                AuditRecordBaseinfo recordBaseinfo = list.get(0);

                lockStatus = recordBaseinfo.getLockStatus();
                if (val.equals(recordBaseinfo.getFieldVal())) {
                    status = recordBaseinfo.getAuditStatus();
                    //新增：如果数值一样，用户还是提交，库中字段为审核不通过2，则将状态置为待审核5
                    if (status == 2) {
                        status = 5;
                    }

                }else {
                    status = 5;
                }
                //new time start
                if ("remark".equals(key)) {
                    if (val.equals(recordBaseinfo.getFieldVal())) {
                        AuditRecordBaseinfo AuditRecordBaseinfo2 = new AuditRecordBaseinfo();
                        AuditRecordBaseinfo2.setUserId(userId);
                        AuditRecordBaseinfo2.setFieldKey("remarkModifyTime");
                        List<AuditRecordBaseinfo> list2 =  service.getList(AuditRecordBaseinfo2);//降序
                        int tempCount = list2.size();
                        if (tempCount > 0) {
                            AuditRecordBaseinfo rs_modify_bo = list2.get(0);
                            rTime = rs_modify_bo.getFieldVal();
                        }else {
                            rTime = nowStr;
                        }
                    }else {
                        rTime = nowStr;
                    }
                }
                //new time end
            }else {
                status = 5;
                lockStatus = 2;
            }


/*            if (("rs").equals(rs)) {
                lockStatus = 1;
            }*/
            AuditRecordBaseinfo.setLockStatus(lockStatus);
            AuditRecordBaseinfo.setItemId(itemId);
            if (!key.equals("deptList")) {
                AuditRecordBaseinfo.setFieldVal(val);//设置字段值，先不判断部门信息

            }

            //判断是否需要审核，不需要审核就更改正式库信息，正式库信息只用于对外显示。
            AuditField AuditField = new AuditField();//判断是否需要审核
            AuditField.setTableName("pms_user");//判断是否需要审核
            AuditField.setTableField(key);

            if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1 || ("rs").equals(rs)) {
                PmsUser pmsUser = AuditRecordBaseinfo.toAnother();
                pmsUser.setId(userId);
                pmsUserService2.update(pmsUser);
                status = 1;
                //new start 同步admin 用户管理那里的信息
                //同步，姓名，账号，生日，性别
                User user = new User();
                user.setId(userId);
                if (("userName").equals(key)) {
                    user.setName(val);
                    userService.updateUser(user);
                }
/*                if (("userId").equals(key)) {//用户不可更改账号
                    user.setAccount(val);
                }*/
                if (("birth").equals(key)) {
                    user.setBirthday(val);
                    userService.updateUser(user);
                }
                if (("sex").equals(key)) {
                    if ("男".equals(val)){
                        user.setSex("1");
                        userService.updateUser(user);
                    }else if ("女".equals(val)){
                        user.setSex("0");
                        userService.updateUser(user);
                    }
                }
                //new end
            }
            //每次修改插入记录库
/*            if (("rs").equals(rs)) {
                status = 1;
            }*/
            AuditRecordBaseinfo.setAuditStatus(status);//TODO 最后设置
            if ("remarkModifyTime".equals(key)) {

            }
            service.insert(AuditRecordBaseinfo);//TODO 最后插
        }
        //另
        AuditRecordBaseinfo AuditRecordBaseinfo3 = new AuditRecordBaseinfo();
        AuditRecordBaseinfo3.setUserId(userId);
        AuditRecordBaseinfo3.setFieldKey("remarkModifyTime");
        List<AuditRecordBaseinfo> list3 =  service.getList(AuditRecordBaseinfo3);//降序
        int tempCount = list3.size();
        if (tempCount > 0) {
            AuditRecordBaseinfo3.setId(list3.get(0).getId());
            AuditRecordBaseinfo3.setFieldVal(rTime);
            service.update(AuditRecordBaseinfo3);
        }

        //另end

        //对人员审核判断
        AuditShowUser AuditShowUser = new AuditShowUser();
        AuditShowUser.setUserId(userId);
        if (auditShowUserService.getList(AuditShowUser).size() > 0) {
            System.out.println("有show");
        }else {
            System.out.println("有show无");
            auditShowUserService.insert(AuditShowUser);
        }
        AuditShowUser.setPersonalShow(0);
        //start
        AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
        AuditRecordBaseinfo.setAuditStatus(5);
        AuditRecordBaseinfo.setItemId(itemId);
        AuditRecordBaseinfo.setUserId(userId);
        System.out.println("用户"+userId+"基本信息最后审核条目ID" + itemId);
        if (service.getList(AuditRecordBaseinfo).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
        AuditRecordCommunication.setUserId(userId);
        List<AuditRecordCommunication> listComRec = auditRecordCommunicationService.getList(AuditRecordCommunication);
        if (listComRec.size() > 0) {
            int comItemId = listComRec.get(0).getItemId();
            AuditRecordCommunication.setItemId(comItemId);
            AuditRecordCommunication.setAuditStatus(5);
            if (auditRecordCommunicationService.getList(AuditRecordCommunication).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
            System.out.println("用户"+userId+"有通讯审核记录最后一次为" + comItemId);
        }else {
            System.out.println("用户没有通讯审核记录" + userId);
        }

        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        if (auditPmsRelationsService.getList(AuditPmsRelations).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsEducation AuditPmsEducation = new AuditPmsEducation();
        AuditPmsEducation.setUserId(userId);
        AuditPmsEducation.setStatus(5);
        if (auditPmsEducationService.getList(AuditPmsEducation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsWork AuditPmsWork = new AuditPmsWork();
        AuditPmsWork.setUserId(userId);
        AuditPmsWork.setStatus(5);
        if (auditPmsWorkService.getList(AuditPmsWork).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsMainTechGroup AuditPmsMainTechGroup = new AuditPmsMainTechGroup();
        AuditPmsMainTechGroup.setUserId(userId);
        AuditPmsMainTechGroup.setStatus(5);
        if (auditPmsMainTechGroupService.getList(AuditPmsMainTechGroup).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsHonorTitle AuditPmsHonorTitle = new AuditPmsHonorTitle();
        AuditPmsHonorTitle.setUserId(userId);
        AuditPmsHonorTitle.setStatus(5);
        if (auditPmsHonorTitleService.getList(AuditPmsHonorTitle).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechAwards AuditPmsTechAwards = new AuditPmsTechAwards();
        AuditPmsTechAwards.setUserId(userId);
        AuditPmsTechAwards.setStatus(5);
        if (auditPmsTechAwardsService.getList(AuditPmsTechAwards).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPaper AuditPmsPaper = new AuditPmsPaper();
        AuditPmsPaper.setUserId(userId);
        AuditPmsPaper.setStatus(5);
        if (auditPmsPaperService.getList(AuditPmsPaper).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPublish AuditPmsPublish = new AuditPmsPublish();
        AuditPmsPublish.setUserId(userId);
        AuditPmsPublish.setStatus(5);
        if (auditPmsPublishService.getList(AuditPmsPublish).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPatent AuditPmsPatent = new AuditPmsPatent();
        AuditPmsPatent.setUserId(userId);
        AuditPmsPatent.setStatus(5);
        if (auditPmsPatentService.getList(AuditPmsPatent).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsJoinProject AuditPmsJoinProject = new AuditPmsJoinProject();
        AuditPmsJoinProject.setUserId(userId);
        AuditPmsJoinProject.setStatus(5);
        if (auditPmsJoinProjectService.getList(AuditPmsJoinProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechnologyBrace AuditPmsTechnologyBrace = new AuditPmsTechnologyBrace();
        AuditPmsTechnologyBrace.setUserId(userId);
        AuditPmsTechnologyBrace.setStatus(5);
        if (auditPmsTechnologyBraceService.getList(AuditPmsTechnologyBrace).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsSupportProject AuditPmsSupportProject = new AuditPmsSupportProject();
        AuditPmsSupportProject.setUserId(userId);
        AuditPmsSupportProject.setStatus(5);
        if (auditPmsSupportProjectService.getList(AuditPmsSupportProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsYearCheck AuditPmsYearCheck = new AuditPmsYearCheck();
        AuditPmsYearCheck.setUserId(userId);
        AuditPmsYearCheck.setStatus(5);
        if (auditPmsYearCheckService.getList(AuditPmsYearCheck).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("最后为：" + AuditShowUser.getPersonalShow());
        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }


    /**
    * 删除
    * @param ids
    * @param id
    * @param request
    * @return
    * @throws Exception
    */
    @Log("删除xxx")
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(String ids, String id, HttpServletRequest request) throws Exception{
        Result result = new Result();
        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            service.delete(idArr);
        }else if(StringUtils.isNotBlank(id)){
            service.delete(id);
        }else{
            result.setCode(-1);
            result.setInfo("删除失败:待删除编号无效!");
        }
        return result;
    }

    /**
    * 导入
    * @param file
    * @param request
    * @return
    * @throws Exception
    */
    @Log("导入xxx")
    @RequestMapping("/import")
    @ResponseBody
    public Object importExcel(MultipartFile file, HttpServletRequest request) throws Exception{
        Result result = new Result();
        try {
            if (file != null && !file.isEmpty()) {
                //excel导入处理,返回excel中的数据集合
                IExcelImport ei = new ExcelImport(file);//将文件转为ExcelImport对象
                //从excel读取数据
                List<AuditRecordBaseinfo> list = ei.getImportDataAsBean(AuditRecordBaseinfo.class);
                if (list != null && list.size() > 0){
                    int num = service.batchInsert(list);//批量插入
                    result.setInfo("成功导入数据" + num + "条!");
                }else {
                    result.setCode(-1);
                    result.setInfo("导入失败:excel解析后结果为空!");
                }
            } else {
                result.setCode(-1);
                result.setInfo("导入失败:文件为空!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            result.setCode(-1);
            result.setInfo("导入失败!");
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            result.setCode(-1);
            result.setInfo("导入失败!");
        } catch (Exception e) {
            e.printStackTrace();
            result.setCode(-1);
            result.setInfo("导入失败!");
        }
        return result;
    }

    /**
    * 导出
    * @param obj 查询的参数
    * @param request
    * @param response
    * @throws Exception
    */
    @Log("导出xxx")
    @RequestMapping("/export")
    public void exportExcel(AuditRecordBaseinfo obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditRecordBaseinfo> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditRecordBaseinfo.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}