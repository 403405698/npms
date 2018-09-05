package com.yy.young.pms.web;

import com.yy.young.base.exception.YoungBaseException;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.*;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.fs.model.FileInfo;
import com.yy.young.fs.service.IFileInfoService;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.interfaces.model.User;
import com.yy.young.interfaces.ums.service.IUmsOutService;
import com.yy.young.pms.model.*;
import com.yy.young.common.web.AbstractCommonController;
import com.yy.young.pms.service.*;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.ums.service.IUmsRoleService;
import com.yy.young.ums.service.IUmsUserService;
import freemarker.template.Configuration;
import freemarker.template.Template;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户基础信息服务
 * Created by rookie on 2018-03-27.
 */
@Controller
@RequestMapping("/pms/pmsUser")
public class PmsUserController extends AbstractCommonController<PmsUser> {

    @Resource(name = "userDeptService")
    IUserDeptService userDeptService;

    @Resource(name = "pmsUserService")
    IPmsUserExtService pmsUserService;

    //新增
    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService2;

    @Resource(name="auditRecordBaseinfoService")
    IAuditRecordBaseinfoService auditRecordBaseinfoService;
    //新增end

    @Resource(name = "fsFileInfoService")
    IFileInfoService fileInfoService;

    @Resource(name = "communicationService")
    ICommonService<Communication> communicationService;//通讯信息

    @Resource(name = "pmsSelfEvaluationService")
    ICommonService<PmsSelfEvaluation> selfEvaluationService;//自我评价

    @Resource(name = "educationService")
    ICommonService<Education> educationService;//教育经历

    @Resource(name = "workService")
    ICommonService<Work> workService;//工作经历

    @Resource(name = "pmsMainTechGroupService")
    ICommonService<PmsMainTechGroup> pmsMainTechGroupService;//社团兼职

    @Resource(name = "pmsHonorTitleService")
    ICommonService<PmsHonorTitle> pmsHonorTitleService;//荣誉称号

    @Resource(name = "pmsTechAwardsService")
    ICommonService<PmsTechAwards> pmsTechAwardsService;//获奖情况

    @Resource(name = "paperService")
    ICommonService<Paper> paperService;//论文情况

    @Resource(name = "publishService")
    ICommonService<Publish> publishService;//出版著作

    @Resource(name = "patentService")
    ICommonService<Patent> patentService;//专利

    @Resource(name = "joinProjectService")
    ICommonService<JoinProject> joinProjectService;//项目经历

    @Resource(name = "technologyBraceService")
    ICommonService<TechnologyBrace> technologyBraceService;//技术支撑

    @Resource(name = "pmsSupportProjectService")
    ICommonService<PmsSupportProject> pmsSupportProjectService;//人才培养计划

    @Resource(name = "pmsYearCheckService")
    ICommonService<PmsYearCheck> pmsYearCheckService;//年度考核

    @Resource(name = "pmsLeaderEvaluationService")
    ICommonService<PmsLeaderEvaluation> pmsLeaderEvaluationService;//领导评价

    @Resource(
            name = "umsUserService"
    )
    IUmsUserService userService;

    @Resource(
            name = "umsRoleService"
    )
    IUmsRoleService RoleService;

    /**
     * 初始化服务实例
     */
    @Override
    public void initService() {
        this.service = SpringContextHolder.getBean("pmsUserService");
    }

    @Override
    public ICommonService<PmsUser> getServiceFromRequest(HttpServletRequest httpServletRequest) {
        return null;
    }

    @Override
    public PmsUser backFinalParameter(PmsUser pmsUser, HttpServletRequest httpServletRequest) {
        return pmsUser;
    }

    /**
     * 刷新用户部门关联
     * @param request
     * @param deptIds 部门id,非必填
     * @param userId 用户编号,必填项
     * @return
     */
    @Log("刷新用户部门关联")
    @RequestMapping({"/refreshUserDept"})
    @ResponseBody
    public Object refreshUserDept(HttpServletRequest request, String deptIds, String userId) throws Exception{
        Result result = new Result();
        if (StringUtils.isBlank(userId)){//用户编号不允许为空
            result.setCode(-1);
            result.setInfo("操作失败:用户编号不允许为空!");
        }else{
            userDeptService.refreshUserDept(userId, deptIds);
        }
        return result;
    }

    /**
     * 查询用户的关联部门信息
     * @param request
     * @param userId
     * @return
     * @throws Exception
     */
    @Log("查询用户的关联部门信息")
    @RequestMapping({"/getUserDeptByUserId"})
    @ResponseBody
    public Object getUserDeptByUserId(HttpServletRequest request, String userId) throws Exception{
        Result result = new Result();
        if (StringUtils.isBlank(userId)){//用户编号不允许为空
            result.setCode(-1);
            result.setInfo("操作失败:用户编号不允许为空!");
        }else{
            result.setData(userDeptService.getUserDeptByUserId(userId));
        }
        return result;
    }

    /**
     * 删除用户部门关联
     * @param request
     * @param id
     * @return
     * @throws Exception
     */
    @Log("删除用户部门关联")
    @RequestMapping({"/deleteUserDept"})
    @ResponseBody
    public Object deleteUserDept(HttpServletRequest request, String id) throws Exception{
        Result result = new Result();
        if (StringUtils.isBlank(id)){//用户编号不允许为空
            result.setCode(-1);
            result.setInfo("操作失败:待删除关系编号不允许为空!");
        }else{
            userDeptService.deleteUserDeptById(id);
        }
        return result;
    }

    /**
     * 查询管辖内的用户列表
     * @param request
     * @param pmsUser
     * @return
     * @throws Exception
     */
    @Log("查询管辖内的用户列表")
    @RequestMapping({"/getPageInDept"})
    @ResponseBody
    public Object getPageInDept(HttpServletRequest request, PmsUser pmsUser) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        User user = CommonUtil.getLoginUser(request);
        if (user != null){
            //查询当前用户所属部门
            pmsUser.setDeptList(userDeptService.getUserDeptByUserId(user.getId()));
            page.setData(pmsUserService.getPageInDept(pmsUser, page));
        }
        return page;
    }

    /**
     * 作废用户
     * @param request
     * @param userId
     * @return
     * @throws Exception
     */
    @Log("作废用户")
    @RequestMapping({"/trashUser"})
    @ResponseBody
    public Object trashUser(HttpServletRequest request, String userId) throws Exception{
        Result result = new Result();
        if(StringUtils.isNotBlank(userId)) {
            String[] idArr = userId.split(",");
            pmsUserService.trashUser(idArr);//批量作废
        }else {
            result.setCode(-1);
            result.setInfo("作废失败:待作废人员编号无效!");
        }
        return result;
    }

    @Log("批量关联用户(N)和角色(N)，同时同步信息")
    @RequestMapping({"/batchMakeUserAndRole"})
    @ResponseBody
    public Object batchMakeUserAndRole(HttpServletRequest request) throws Exception {
        Map<String, Object> parameter = CommonUtil.getParameterFromRequest(request);
        Result result = new Result();
        if (parameter.containsKey("roleId") && parameter.containsKey("userId")) {
            int num = this.RoleService.batchMakeUserAndRole(parameter.get("userId").toString().split(","), parameter.get("roleId").toString().split(","));
            //new start
            String[] roleIDArr = parameter.get("roleId").toString().split(",");
            String[] userIDArr = parameter.get("userId").toString().split(",");
            //roleID全部在hkycompany
            boolean hkycom = true;
            String hkyCompanyID = PmsConstants.HKY_COMPANY_ID;
            for (int i=0;i<roleIDArr.length;i++) {
                String roleID = roleIDArr[i];
                String roleCom = RoleService.getRoleById(roleID).getCompanyId();
                if (!hkyCompanyID.equals(roleCom)) {
                    System.out.println("不是本单位的：" + RoleService.getRoleById(roleID).getName());
                    hkycom = false;
                }else {
                    System.out.println("是本单位的：" + RoleService.getRoleById(roleID).getName());
                }
            }
            //全是本单位，插入Pms_suer
            if (hkycom) {
                for (int i=0;i<userIDArr.length;i++) {
                    PmsUser pmsUser = new PmsUser();
                    pmsUser.setId(userIDArr[i]);
                    PmsUser temp = pmsUserService2.get(pmsUser);
                    if (temp != null) {
                        logger.info("分配角色时插入，用户存在账号{}"+temp.getUserId());
                    }else {
                        User user = userService.getUserById(userIDArr[i]);
                        String name = user.getName();
                        String account = user.getAccount();
                        String sex = user.getSex();//0,1
                        String birth = user.getBirthday();
                        String state = user.getState();
                        pmsUser.setUserName(name);
                        pmsUser.setUserId(account);
                        if ("1".equals(sex)){
                            pmsUser.setSex("男");
                        }else if ("0".equals(sex)){
                            pmsUser.setSex("女");
                        }
                        pmsUser.setBirth(birth);
                        if (("0").equals(state)) {
                            pmsUser.setTrashFlag("1");
                        }else {
                            pmsUser.setTrashFlag("");
                        }
                        pmsUserService2.insert(pmsUser);
                    }
                }
            }
            //new end
            if (num < 0) {
                result.setCode(-1);
                result.setInfo("添加角色用户失败!");
            }
        } else {
            result.setCode(-1);
            result.setInfo("操作失败:角色id和用户id不允许为空!");
        }

        return result;
    }

    //插入
    @Log("新增用户_")
    @RequestMapping({"/ninsert"})
    @ResponseBody
    public Object ninsert(PmsUser pmsUser) throws Exception {
        pmsUserService2.insert(pmsUser);
        System.out.println("新增用户ID："+pmsUser.getId() + "name：" + pmsUser.getUserName());
        RoleService.batchMakeUserAndRole(pmsUser.getId().toString().split(","), "72b51c53a39744fe9d8b380910c77e63".toString().split(","));
        return new Result();
    }


    //admin账号通过用户管理菜单，新增用户，同步信息到pms_user（废弃）
    @Log("ADMIN用户管理新增用户")
    @RequestMapping({"/adinsert"})
    @ResponseBody
    public Object adinsert(HttpServletRequest request) throws Exception {
        Map<String, Object> parameter = CommonUtil.getParameterFromRequest(request);
        Result result = new Result();
        if (StringUtils.isBlank(parameter.get("COMPANY_ID") + "")) {
            result.setCode(-1);
            result.setInfo("单位不允许为空!");
        } else {
            String id = CommonUtil.getUUID();
            String birth = (String) parameter.get("BIRTHDAY");
            String userName = (String) parameter.get("NAME");
            String userId = (String) parameter.get("ACCOUNT");
            String sex = (String) parameter.get("SEX");
            String STATE = (String) parameter.get("STATE");
            String companyID = parameter.get("COMPANY_ID") + "";
            String hkyCompanyID = PmsConstants.HKY_COMPANY_ID;
            if (("0").equals(STATE)) {
                STATE = "1";//1作废用户pms_user
            }else {
                STATE = "";//只要不为1即可
            }
            parameter.put("ID", id);
            int num = this.userService.insertUser(parameter);
            //如果单位是环科院
            if(hkyCompanyID.equals(companyID)) {
                PmsUser pmsUser = new PmsUser();
                pmsUser.setId(id);
                pmsUser.setBirth(birth);
                pmsUser.setUserName(userName);
                pmsUser.setUserId(userId);
                if ("1".equals(sex)){
                    pmsUser.setSex("男");
                }else if ("0".equals(sex)){
                    pmsUser.setSex("女");
                }
                pmsUser.setTrashFlag(STATE);
                pmsUserService2.insert(pmsUser);
            }
            if (num < 0) {
                result.setCode(-1);
                result.setInfo("添加用户失败!");
            }
        }

        return result;
    }

    /**
     * 启用禁用用户
     * @param request
     * @return
     * @throws Exception
     */
    @Log("启用禁用用户")
    @RequestMapping({"/updateUser"})
    @ResponseBody
    public Object updateUser(HttpServletRequest request) throws Exception {
        Map<String, Object> parameter = CommonUtil.getParameterFromRequest(request);
        int num = userService.updateUser(parameter);
        Result result = new Result();
        if (num < 0) {
            result.setCode(-1);
            result.setInfo("禁用/启用用户失败!");
        }else {
            //STATE  ID  0禁止登陆1可以
            String ID = (String) parameter.get("ID");
            String STATE = (String) parameter.get("STATE");
            if (("0").equals(STATE)) {
                STATE = "1";//1作废用户pms_user
            }else {
                STATE = "";//只要不为1即可
            }
            PmsUser user = new PmsUser();
            user.setId(ID);
            user.setTrashFlag(STATE);
            //更新生日，性别，姓名、账号 ，其他信息start
            String birth = (String) parameter.get("BIRTHDAY");
            String userName = (String) parameter.get("NAME");
            String userId = (String) parameter.get("ACCOUNT");
            String sex = (String) parameter.get("SEX");
            user.setBirth(birth);
            user.setUserName(userName);
            user.setUserId(userId);
            if ("1".equals(sex)){
                user.setSex("男");
            }else if ("0".equals(sex)){
                user.setSex("女");
            }
            //更改其他信息end
            service.update(user);
            //管理员修改，同时更新审核库 start
            AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
            AuditRecordBaseinfo.setUserId(ID);
            List<AuditRecordBaseinfo> aBaseRecList = auditRecordBaseinfoService.getList(AuditRecordBaseinfo);
            if (aBaseRecList.size() > 0) {
                int itemId = aBaseRecList.get(0).getItemId();
                AuditRecordBaseinfo.setItemId(itemId);
                List<AuditRecordBaseinfo> tempList = auditRecordBaseinfoService.getList(AuditRecordBaseinfo);
                for (AuditRecordBaseinfo obj : tempList) {
                    if (("userName").equals(obj.getFieldKey())) {
                        AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
                        temp.setId(obj.getId());
                        temp.setFieldVal(userName);
                        temp.setAuditStatus(1);
                        auditRecordBaseinfoService.update(temp);
                    }
                    if (("userId").equals(obj.getFieldKey())) {
                        AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
                        temp.setId(obj.getId());
                        temp.setFieldVal(userId);
                        temp.setAuditStatus(1);
                        auditRecordBaseinfoService.update(temp);
                    }
                    if (("sex").equals(obj.getFieldKey())) {
                        AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
                        temp.setId(obj.getId());
                        if ("1".equals(sex)){
                            temp.setFieldVal("男");
                        }else if ("0".equals(sex)){
                            temp.setFieldVal("女");
                        }
                        temp.setAuditStatus(1);
                        auditRecordBaseinfoService.update(temp);
                    }
                    if (("birth").equals(obj.getFieldKey())) {
                        AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
                        temp.setId(obj.getId());
                        temp.setFieldVal(birth);
                        temp.setAuditStatus(1);
                        auditRecordBaseinfoService.update(temp);
                    }
/*                    if (("trashFlag").equals(obj.getFieldKey())) {
                        AuditRecordBaseinfo temp = new AuditRecordBaseinfo();
                        temp.setId(obj.getId());
                        temp.setFieldVal(STATE);
                        temp.setAuditStatus(1);
                        auditRecordBaseinfoService.update(temp);
                    }*/
                }
            }
            //end
        }

        return result;
    }

    /**
     * 导出用户简历
     * @param request
     * @param userId 用户id
     * @param response
     */
    @Log("导出用户简历")
    @RequestMapping({"/exportWord/{userId}"})
    public void exportWord(HttpServletRequest request, @PathVariable("userId")String userId, HttpServletResponse response) throws Exception {
        if(StringUtils.isNotBlank(userId)){
            PmsUser user = new PmsUser();
            user.setId(userId);
            //查询用户信息
            user = super.service.get(user);
            if (user != null){//如果用户不为空,则继续
                //文件下载响应头处理
                response.setContentType("application/x-msdownload");//;charset=UTF-8,设置响应流编码(要在response.getWriter()前设置),和response.setCharacterEncoding("UTF-8")效果相同
                String userAgent = request.getHeader("User-Agent");//浏览器信息
                //存在MSIE关键字,则是IE系列浏览器,没有Chrome/Safari/Firefox/AppleWebKit/Opera等关键字,默认按照IE处理
                if(userAgent != null && ( userAgent.contains("MSIE") || (!userAgent.contains("Chrome") && !userAgent.contains("Safari")
                        && !userAgent.contains("Firefox") && !userAgent.contains("AppleWebKit") && !userAgent.contains("Opera")) ) ){
                    System.out.println("-------------IE系列---------下载处理-------"+userAgent);
                    //IE系浏览器下载时要对中文做编码处理(测试谷歌也可以这样,火狐会直接显示编码)
                    //System.out.println(URLEncoder.encode("简历-"+user.getUserName()+".doc", "UTF-8"));
                    response.setHeader("Content-disposition", "attachment; filename=" + new String(URLEncoder.encode("简历-"+user.getUserName()+".doc", "UTF-8")));
                }else{//非ie的下载处理
                    //这里使用.doc后缀,使用docx会出错(在office上打不开,wps正常)
                    response.setHeader("Content-disposition", "attachment; filename=" + new String(("简历-"+user.getUserName()+".doc").getBytes("UTF-8"), "ISO-8859-1"));
                }
                response.setHeader("Content-Length", "");
                response.setCharacterEncoding("UTF-8");//设置响应流编码方式(此方式优先级最高),防止下载后word乱码,也可以在设置contentType时设置

                //配置
                Configuration configuration = new Configuration();
                configuration.setClassForTemplateLoading(this.getClass(), "/com/yy/young/pms/template/");//注意路径以斜杠'/'开头

                //获取模板文件
                Template template = configuration.getTemplate("resume.ftl", "UTF-8");//, "UTF-8"

                //待写入的流对象,在这里为http响应流
                BufferedWriter bw = new BufferedWriter(response.getWriter());
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("user", user);

                //获取用户头像
                map.put("userPhoto", "");
                if(StringUtils.isNotBlank(user.getPhotoAddress())){
                    FileInfo fileInfo = fileInfoService.getFileInfo(user.getPhotoAddress());
                    if (fileInfo != null && fileInfo.getAddr() != null){
                        File file = new File(fileInfo.getAddr());
                        if (file != null && file.exists()){//当文件存在时,将图片文件转为base64Url
                            InputStream is = new FileInputStream(file);
                            BASE64Encoder encoder = new BASE64Encoder();
                            //StringBuilder sb = new StringBuilder();
                            //将图片流读取到字节数组中
                           /* byte[] bytes = new byte[1024];//按kb读取
                            int i;
                            while((i=is.read(bytes)) != -1){
                                sb.append(encoder.encode(bytes).trim());
                            }*/
                            try {
                                byte[] bytes = new byte[is.available()];//(int) file.length()
                                is.read(bytes);
                                String img = encoder.encode(bytes);
                                map.put("userPhoto", CommonUtil.getDefaultValue(img, ""));
                            }catch (Exception e){
                                logger.error("[生成简历] 头像流操作异常!");
                                e.printStackTrace();
                            }finally {
                                is.close();//关闭流
                            }
                        }
                    }
                }


                //通讯信息
                Communication communication = new Communication();
                communication.setId(userId);
                communication = communicationService.get(communication);
                if (communication == null){//防止因为null的问题导致freemarker报错
                    communication = new Communication();
                }
                map.put("communication", communication);

                //自我评价
                PmsSelfEvaluation pmsSelfEvaluation = new PmsSelfEvaluation();
                pmsSelfEvaluation.setId(userId);
                pmsSelfEvaluation = selfEvaluationService.get(pmsSelfEvaluation);
                if (pmsSelfEvaluation == null){//防止因为null的问题导致freemarker报错
                    pmsSelfEvaluation = new PmsSelfEvaluation();
                }
                map.put("selfEvaluation", pmsSelfEvaluation);

                //教育经历
                Education education = new Education();
                education.setUserId(userId);
                List<Education> educationList = educationService.getList(education);
                map.put("educationList", educationList);

                //工作经历
                Work work = new Work();
                work.setUserId(userId);
                List<Work> workList = workService.getList(work);
                map.put("workList", workList);

                //社团兼职
                PmsMainTechGroup group = new PmsMainTechGroup();
                group.setUserId(userId);
                List<PmsMainTechGroup> groupList = pmsMainTechGroupService.getList(group);
                map.put("groupList", groupList);

                //荣誉称号
                PmsHonorTitle honorTitle = new PmsHonorTitle();
                honorTitle.setUserId(userId);
                List<PmsHonorTitle> honorTitleList = pmsHonorTitleService.getList(honorTitle);
                map.put("honorTitleList", honorTitleList);

                //获奖情况
                PmsTechAwards techAwards = new PmsTechAwards();
                techAwards.setUserId(userId);
                List<PmsTechAwards> techAwardsList = pmsTechAwardsService.getList(techAwards);
                map.put("techAwardsList", techAwardsList);

                //论文情况
                Paper paper = new Paper();
                paper.setUserId(userId);
                List<Paper> paperList = paperService.getList(paper);
                map.put("paperList", paperList);

                //出版著作
                Publish publish = new Publish();
                publish.setUserId(userId);
                List<Publish> publishList = publishService.getList(publish);
                map.put("publishList", publishList);

                //专利
                Patent patent = new Patent();
                patent.setUserId(userId);
                List<Patent> patentList = patentService.getList(patent);
                map.put("patentList", patentList);

                //项目经历
                JoinProject joinProject = new JoinProject();
                joinProject.setUserId(userId);
                List<JoinProject> joinProjectList = joinProjectService.getList(joinProject);
                map.put("joinProjectList", joinProjectList);

                //技术支撑
                TechnologyBrace technologyBrace = new TechnologyBrace();
                technologyBrace.setUserId(userId);
                List<TechnologyBrace> technologyBraceList = technologyBraceService.getList(technologyBrace);
                map.put("technologyBraceList", technologyBraceList);

                //人才培养计划
                PmsSupportProject supportProject = new PmsSupportProject();
                supportProject.setUserId(userId);
                List<PmsSupportProject> supportProjectList = pmsSupportProjectService.getList(supportProject);
                map.put("supportProjectList", supportProjectList);

                //年度考核
                PmsYearCheck yearCheck = new PmsYearCheck();
                yearCheck.setUserId(userId);
                List<PmsYearCheck> yearCheckList = pmsYearCheckService.getList(yearCheck);
                map.put("yearCheckList", yearCheckList);

                //领导评价
                PmsLeaderEvaluation leaderEvaluation = new PmsLeaderEvaluation();
                leaderEvaluation.setUserId(userId);
                List<PmsLeaderEvaluation> leaderEvaluationList = pmsLeaderEvaluationService.getList(leaderEvaluation);
                map.put("leaderEvaluationList", leaderEvaluationList);


                template.process(map, bw);//写入

                bw.close();//关闭流


            }else{
                response.getWriter().write("人员编号无效!");
            }
        }else{
            response.getWriter().write("人员编号无效!");
        }
    }


}