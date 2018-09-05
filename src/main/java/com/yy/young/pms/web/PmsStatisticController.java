package com.yy.young.pms.web;


import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.interfaces.model.User;
import com.yy.young.pms.model.PmsDictionary;
import com.yy.young.pms.model.Statistic;
import com.yy.young.pms.model.UserDept;
import com.yy.young.pms.service.IStatisticService;
import com.yy.young.pms.util.PmsConstants;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * 人事统计服务
 * Created by rookie on 2018-03-27.
 */
@Controller
@RequestMapping("/pms/statistic")
public class PmsStatisticController{

    @Resource(name = "pmsStatisticService")
    IStatisticService statisticService;

    /**
     * 查询人才梯队信息
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询人才梯队信息")
    @RequestMapping({"/getTalentEchelon"})
    @ResponseBody
    public Object getTalentEchelon(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        statistic.setAttr10(request.getParameter("deptId"));
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        System.out.println("烛之武：" + request.getParameter("zw"));
        //获取人员类型
        statistic.setPersonType(request.getParameter("personType"));
        statistic = statisticService.getTalentEchelon(statistic);
        return new Result(statistic);
    }

    /**
     * 查询研究领域情况
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询研究领域情况")
    @RequestMapping({"/getResearchField"})
    @ResponseBody
    public Object getResearchField(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        statistic.setAttr10(request.getParameter("deptId"));
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        //获取人员类型
        statistic.setPersonType(request.getParameter("personType"));
        statistic = statisticService.getResearchField(statistic);
        return new Result(statistic);
    }

    /**
     * 查询男女比例情况
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询男女比例情况")
    @RequestMapping({"/getMenAndWomen"})
    @ResponseBody
    public Object getMenAndWomen(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        statistic.setAttr10(request.getParameter("deptId"));
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        //获取人员类型
        statistic.setPersonType(request.getParameter("personType"));
        statistic = statisticService.getMenAndWomen(statistic);
        return new Result(statistic);
    }

    /**
     * 查询学历分布情况
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询学历分布情况")
    @RequestMapping({"/getEducationSpread"})
    @ResponseBody
    public Object getEducationSpread(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        statistic.setAttr10(request.getParameter("deptId"));
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        //获取人员类型
        statistic.setPersonType(request.getParameter("personType"));
        statistic = statisticService.getEducationSpread(statistic);
        return new Result(statistic);
    }

    /**
     * 查询国外经历情况
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询国外经历情况")
    @RequestMapping({"/getForeignExperience"})
    @ResponseBody
    public Object getForeignExperience(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        statistic.setAttr10(request.getParameter("deptId"));
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        //获取人员类型
        statistic.setPersonType(request.getParameter("personType"));
        statistic = statisticService.getForeignExperience(statistic);
        return new Result(statistic);
    }

    /**
     * 查询工作年限情况
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询工作年限情况")
    @RequestMapping({"/getWorkYear"})
    @ResponseBody
    public Object getWorkYear(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        statistic.setAttr10(request.getParameter("deptId"));
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        //获取人员类型
        statistic.setPersonType(request.getParameter("personType"));
        statistic = statisticService.getWorkYear(statistic);
        return new Result(statistic);
    }

    /**
     * 查询奖励层次情况
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询奖励层次情况")
    @RequestMapping({"/getAwardLevel"})
    @ResponseBody
    public Object getAwardLevel(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();

        statistic = statisticService.getAwardLevel(statistic);
        return new Result(statistic);
    }

    /**
     * 查询系统内所有用户数量
     * @param request
     * @return
     * @throws Exception
     */
    @Log("根据条件查询系统内所有用户数量")
    @RequestMapping({"/getAllUserCount"})
    @ResponseBody
    public Object getAllUserCount(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        //获取部门编号
        if("undefined".equals(request.getParameter("deptId"))){
            statistic.setAttr10(null);
        }else{
            statistic.setAttr10(request.getParameter("deptId"));
        }
        System.out.println("[查询系统内所有用户数量，条件deptId="+request.getParameter("deptId")+"]");
        //获取职称
        statistic.setAttr9(request.getParameter("zc"));
        //获取职务
        statistic.setAttr8(request.getParameter("zw"));
        System.out.println("[查询系统内所有用户数量，条件职称="+statistic.getAttr9()+"]");
        System.out.println("[查询系统内所有用户数量，条件职务="+statistic.getAttr8()+"]");
        statistic = statisticService.getAllUserCount(statistic);
        return new Result(statistic);
    }


    /**
     * 查询系统内录入的所有人数
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询系统内录入的所有人数")
    @RequestMapping({"/getSystemInputCount"})
    @ResponseBody
    public Object getSystemInputCount(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        statistic = statisticService.getSystemInputCount(statistic);
        return new Result(statistic);
    }



    /**
     * 查询系统内所有科技奖数量
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询系统内所有科技奖数量")
    @RequestMapping({"/getAllTechAwardsCount"})
    @ResponseBody
    public Object getAllTechAwardsCount(HttpServletRequest request) throws Exception {
        Statistic statistic = new Statistic();
        statistic = statisticService.getAllTechAwardsCount(statistic);
        return new Result(statistic);
    }

    /**
     *
     * @param request
     * @return
     * @throws Exception
     */
    @Log("获取当前用户的角色名称和部门名称")
    @RequestMapping({"/getRoleNameAndDeptName"})
    @ResponseBody
    public Object getRoleNameAndDeptName(HttpServletRequest request) throws Exception {
        Result result = new Result();
        User user = CommonUtil.getLoginUser(request);
        String deptName = user.getDeptName();
        String roleName = user.getRoleName();
        if(roleName.contains(PmsConstants.ROLENAME.RSC_ROLE)){
            roleName = PmsConstants.ROLENAME.RSC_ROLE;
        }else if(roleName.contains(PmsConstants.ROLENAME.EJDWLD_ROLE)){
            roleName = PmsConstants.ROLENAME.EJDWLD_ROLE;
        }else{
            roleName = PmsConstants.ROLENAME.PTYG_ROLE;
        }

        //得到deptId
        String deptId = user.getDeptId();
        if(StringUtils.isBlank(deptId)){
            result.setCode(-1);
            result.setInfo("请先给用户填写部门信息！");
        }else{
            //根据deptId查询到wholeId
            UserDept dept = new UserDept();
            System.out.println("原始deptId:"+deptId);
            //解决第一个部门编号
            dept.setDeptId(deptId.substring(0,32));
            System.out.println("切割后的deptId:"+dept.getDeptId());

            dept =  statisticService.getWholeId(dept);
            System.out.println("查询后的wholeId:"+dept.getWholeId());
            //根据wholeId查询到wholeName
            dept.setWholeId(dept.getWholeId().substring(0,71));
            System.out.println("分割后的wholeId:"+dept.getWholeId());
            dept =  statisticService.getWholeName(dept);
            System.out.println("查询后的wholeName:"+dept.getWholeName());
            System.out.println("查询后的deptId:"+dept.getDeptId());
            System.out.println("查询后的deptName:"+dept.getDeptName());

            List list = new ArrayList();
            list.add(deptName);
            list.add(roleName);
            list.add(dept.getWholeName());
            list.add(dept.getDeptId());
            list.add(dept.getDeptName());
            result.setData(list);
        }

        return result;
    }


    /**
     * 查询所有一级单位列表
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询所有一级单位列表")
    @RequestMapping({"/getDeptList"})
    @ResponseBody
    public Object getDeptList(HttpServletRequest request) throws Exception {

        User user = CommonUtil.getLoginUser(request);
        String roleName = user.getRoleName();
        String deptName = user.getDeptName();
        return new Result(statisticService.getDeptList(roleName,deptName));
    }


    /**
     * 查询数据字典值
     * @param request
     * @return
     * @throws Exception
     */
    @Log("获取数据字典值")
    @RequestMapping({"/getDicValue/{bedic_id}"})
    @ResponseBody
    public Object getDicValue(HttpServletRequest request,@PathVariable("bedic_id")String bedic_id) throws Exception {
        PmsDictionary dic = new PmsDictionary();
        Result result = new Result();
        System.out.println("获取数据字典编号"+bedic_id);

        if("ADMINISTRATIVE_LEVEL".equals(bedic_id)){//行政级别
            dic.setBedicId("ADMINISTRATIVE_LEVEL");
        }else if("TECHNICAL_POSITION".equals(bedic_id)){
            dic.setBedicId("TECHNICAL_POSITION");//专业技术职务
        }else if("PERSON_TYPE".equals(bedic_id)){
            dic.setBedicId("PERSON_TYPE");//人员类型
        }else{
            result.setCode(-1);
            result.setInfo("操作失败:无法解析字典编号!");
        }
        return new Result(statisticService.getDicValue(dic));
    }


    /**
     * 根据deptId查询到whole_name
     * @param request
     * @return
     * @throws Exception
     */
    /*@Log("根据deptId查询到whole_name")
    @RequestMapping({"/getWholeName"})
    @ResponseBody
    public Object getWholeName(HttpServletRequest request) throws Exception {
        UserDept dept = new UserDept();
        dept.setDeptId(request.getParameter("deptId"));
        return new Result(statisticService.getWholeName(dept));
    }*/

}