package com.beyondbit.struts.action;

import java.math.*;
import javax.servlet.http.*;

import org.apache.struts.action.*;
import org.apache.struts.actions.*;
import org.springframework.context.*;
//import net.sf.hibernate.Transaction;
//import net.sf.hibernate.SessionFactory;
//import net.sf.hibernate.Session;
import com.beyondbit.hibernate.*;
import com.beyondbit.struts.dao.*;
import com.beyondbit.struts.form.*;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import java.util.List;

public class SavePowstdstepAction
    extends DispatchAction {
    public SavePowstdstepAction() {
    }

    private void stepToForm(TbQlgkPowerstdstep step, PowstdStepForm fileForm) {
        fileForm.setDes(step.getDes());
        fileForm.setGroupname(step.getGroupname());
        if (step.getIsinner() != null) {
            fileForm.setIsinner(step.getIsinner().toString());
        }
        if (step.getIskey() != null) {
            fileForm.setIskey(step.getIskey().toString());
        }
        if (step.getMaxduetimelimit() != null) {
            fileForm.setMaxduetimelimit(step.getMaxduetimelimit().toString());
        }
        if (step.getMaxpslimit() != null) {
            fileForm.setMaxpslimit(step.getMaxpslimit().toString());
        }
        if (step.getNextstepid() != null) {
            fileForm.setNextstepid(step.getNextstepid().toString());
        }
        if (step.getPrevstepid() != null) {
            fileForm.setPrevstepid(step.getPrevstepid().toString());
        }
        if (step.getPsid() != null) {
            fileForm.setPsid(step.getPsid().toString());
        }
        fileForm.setMaxpslimitunit(step.getMaxpslimitunit());
        fileForm.setRolename(step.getRolename());
        fileForm.setSpsid(step.getTbQlgkSubpowerstd().getId().toString());
        fileForm.setStepid(step.getStepid().toString());
        fileForm.setStepname(step.getStepname());

    }

    /**
     * 转化
     * @param fileForm PowstdStepForm
     * @return TbQlgkPowerstdstep
     */
    private TbQlgkPowerstdstep formToStep(TbQlgkPowerstdstep step,
                                          PowstdStepForm fileForm) {
//        TbQlgkPowerstdstep step = new TbQlgkPowerstdstep();
        //接收提交的数据
//        step = new TbQlgkPowerstdstep();
        //分权力标准

        //步骤id
        if (fileForm.getStepid() != null && !"".equals(fileForm.getStepid())) {
            step.setStepid(new Integer(fileForm.getStepid()));
        }

        //备注
        step.setDes(fileForm.getDes());
        //分组名
        step.setGroupname(fileForm.getGroupname());
        if (fileForm.getIsinner() != null &&
            !"".equals(fileForm.getIsinner())) {
            //是否是内部步骤，如果是(值为1)则不能向公众展示
            step.setIsinner(new BigDecimal(fileForm.getIsinner()));
        }
        if (fileForm.getIskey() != null &&
            !"".equals(fileForm.getIskey())) {
            //是否是关键步骤(如果值为1则在显示时在步骤名称上做标示)
            step.setIskey(new BigDecimal(fileForm.getIskey()));
        }
        if (fileForm.getMaxduetimelimit() != null &&
            !"".equals(fileForm.getMaxduetimelimit())) {
            //最长权力标准的时限
            step.setMaxduetimelimit(new BigDecimal(fileForm.
                getMaxduetimelimit()));
        }
        else {
            step.setMaxduetimelimit(new BigDecimal(0));
        }
        if (fileForm.getMaxpslimit() != null &&
            !"".equals(fileForm.getMaxpslimit())) {
            //最大权力标准的时限
            step.setMaxpslimit(new BigDecimal(fileForm.getMaxpslimit()));
        }
        else {
            step.setMaxpslimit(new BigDecimal(0));
        }

        //下一步ID(仅供显示参考，并不起到标示顺序的作用)
        step.setNextstepid(fileForm.getNextstepid());
        //上一步ID(仅供显示参考，并不起到标示顺序的作用)
        step.setPrevstepid(fileForm.getPrevstepid());
        if (fileForm.getPsid() != null &&
            !"".equals(fileForm.getPsid())) {
            //停用，仅用于兼容性。
            step.setPsid(new BigDecimal(fileForm.getPsid()));
        }
        //角色名称
        step.setRolename(fileForm.getRolename());
        //步骤名称
        step.setStepname(fileForm.getStepname());
        step.setMaxpslimitunit(fileForm.getMaxpslimitunit());
        return step;
    }

    /**
     *
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward loadstep(ActionMapping mapping, ActionForm form,
                                  HttpServletRequest request1,
                                  HttpServletResponse response
                                  ) {
        ApplicationContext context = ContextSupport.getContext();
        com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
            "commonDao");
        PowstdStepForm fileForm = (PowstdStepForm) form;
        TbQlgkPowerstdstep step = dao.loadStep(fileForm.getStepid());
        this.stepToForm(step, fileForm);
        request1.setAttribute("STEPFILES",
                                  dao.listStepFiles(step.getStepid().toString()));
        return mapping.findForward("forward");
    }

    /**
     * 保存
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request1,
                              HttpServletResponse response) {
        try {
            //接收数据
            PowstdStepForm fileForm = (PowstdStepForm) form;
            ApplicationContext context = ContextSupport.getContext();
            com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                "commonDao");
            TbQlgkPowerstdstep step;

            if (fileForm.getStepid() != null && !"".equals(fileForm.getStepid())) {
                //转换成步骤
                step = dao.loadStep(fileForm.getStepid());
            }
            else {
                step = new TbQlgkPowerstdstep();
            }

            step = this.formToStep(step, fileForm);

            step.setTbQlgkSubpowerstd(dao.loadSubpowerstd(fileForm.getSpsid()));
            //虽然停用但是仍然保存
//            step.setPsid(new BigDecimal(substd.getTbQlgkPowerstd().getPsid().intValue()));

//            com.beyondbit.hibernate.TbQlgkPsfile file = new com.beyondbit.
//                hibernate.TbQlgkPsfile();

            //保存步骤附件
            if ( (fileForm.getFile1() != null &&
                  fileForm.getFile1().getFileSize() > 0) ||
                (fileForm.getFile2() != null &&
                 fileForm.getFile2().getFileSize() > 0)) {
                //判断是新建还是更新
                /**
                   if (step.getStepid() == null) {
                       //新建
                   }
                   else {
                       //更新
                       dao.delPsfileByStepId(String.valueOf(step.getStepid()));
                   }

                   //附件1
                   if (fileForm.getFile1() != null &&
                       fileForm.getFile1().getFileSize() > 0) {
                       file.setFilename(fileForm.getFile1().getFileName());
                       file.setFilecode("");
                       file.setEdocname(fileForm.getFile1().getFileName());
                       file.setEdoctype("application/octet-stream");
                       file.setEdocdata(fileForm.getFile1().getFileData());
                   }
                   //附件2
                   if (fileForm.getFile2() != null &&
                       fileForm.getFile2().getFileSize() > 0) {
                       file.setFilename(fileForm.getFile2().getFileName());
                       file.setFilecode("");
                 file.setDiagrampicname(fileForm.getFile2().getFileName());
                       file.setDiagrampictype("application/octet-stream");
                 file.setDiagrampicdata(fileForm.getFile2().getFileData());

                   }
                   file.setFilecode(fileForm.getFilecode());
                   //保存附件
                   dao.savePsfile(file);
                 **/
                if (fileForm.getFile1() != null &&
                    fileForm.getFile1().getFileSize() > 0) {
                    //示意图
                    step.setDiagrampic(fileForm.getFile1().getFileData());
                }
                if (fileForm.getFile2() != null &&
                    fileForm.getFile2().getFileSize() > 0) {
                    step.setAudiodesname(fileForm.getFile1().getFileName());
//                    step.setAudiodestype();//mime类型 image/* audio/*
                     //音频
                    step.setAudiodesdata(fileForm.getFile2().getFileData());
                }
                //保存步骤
                dao.saveStep(step);

                fileForm.setStepid(step.getStepid().toString());

                /**
                                 //建立关联
                 TbQlgkStepfile stepfile = new TbQlgkStepfile();
                 stepfile.setPsfid(new BigDecimal(file.getFileid().intValue()));
                 stepfile.setSid(new BigDecimal(step.getStepid().intValue()));

//                stepfile.setSfid();
                                 dao.saveStepfile(stepfile);
//                com.beyondbit.hibernate.TbQlgkPsfile file = new com.beyondbit.
//                    hibernate.TbQlgkPsfile();
                 **/
            }
            else {
                //只保存步骤，不需要保存附件
                dao.saveStep(step);

                fileForm.setStepid(step.getStepid().toString());
            }
            request1.setAttribute("Message", "保存成功！");

            //保存完毕 需要将附件列表带出来
            request1.setAttribute("STEPFILES",
                                  dao.listStepFiles(step.getStepid().toString()));


            return mapping.findForward("forward");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return mapping.findForward("error");
    }

    public ActionForward newstep(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request1,
                                 HttpServletResponse response) {
        form.reset(mapping, request1);
        return mapping.findForward("forward");
    }

    public static void main(String args[]) {
        try {
//                ApplicationContext context = new org.springframework.context.
//                support.FileSystemXmlApplicationContext(
//                "E:\\WorkPath\\svn\\07_代码\\源代码\\权力公开透明运行专网\\web\\WEB-INF\\ApplicationContext.xml");
//            ( (com.beyondbit.struts.dao.IDao) context.getBean(
//                "stepSave")).read(2);
            System.out.println(SavePowstdstepAction.class.getResource(
                "../applicationContext.xml"));
            ApplicationContext context = ContextSupport.getContext();
            com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                "commonDao");
            List list = dao.listStepFiles("16651");
            System.out.println(list.size());


        }
        catch (Throwable ex) {
            ex.printStackTrace();
        }
    }

}
