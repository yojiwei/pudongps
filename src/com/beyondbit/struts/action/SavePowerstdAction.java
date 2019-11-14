package com.beyondbit.struts.action;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import com.beyondbit.hibernate.ContextSupport;
import com.beyondbit.hibernate.TbQlgkPowerstd;
import com.beyondbit.hibernate.TbQlgkSubpowerstd;
import com.beyondbit.struts.dao.IDao;
import com.beyondbit.struts.form.NewPowerstdForm;
import com.beyondbit.struts.form.PowerstdForm;
import java.util.Iterator;
import com.beyondbit.hibernate.TbQlgkPowerstdstep;
import java.util.HashSet;

/**
 *
 * <p>Title: 淇濆瓨鏉冨姏鏍囧噯鐨凙ction</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
public class SavePowerstdAction
    extends DispatchAction {
    public SavePowerstdAction() {
    }


      /**
       * 新加载方法
       * @param mapping ActionMapping
       * @param form ActionForm
       * @param request1 HttpServletRequest
       * @param response HttpServletResponse
       * @return ActionForward
       */
      public ActionForward copytopc(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request1,
                                HttpServletResponse response
                                ) {

          //加载权力标准 加载分标准 加载依据材料 加载步骤 加载依据
          NewPowerstdForm newForm = (NewPowerstdForm) form;




          ApplicationContext context = ContextSupport.getContext();
          com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
              "commonDao");

          if (newForm.getPsid() != null) {
              TbQlgkPowerstd std = dao.loadPowerstd(newForm.getPsid());
              newForm.setStd(std);
              newForm.setFiles(dao.listPsFiles(newForm.getPsid()));


          }
          if (newForm.getSubstdid() != null) {
              newForm.setSubstd(dao.loadSubpowerstd(newForm.getSubstdid()));
          }else{
              Iterator it  = newForm.getStd().getTbQlgkSubpowerstds().iterator();
              if(it.hasNext()){
                  newForm.setSubstd((TbQlgkSubpowerstd)it.next());
                  newForm.setSubstdid(newForm.getSubstd().getId().toString());
              }
          }
          //将当前的substdid拷贝一份
          Iterator it = newForm.getStd().getTbQlgkSubpowerstds().iterator();
          boolean hasPC= false;
          while (it.hasNext()) {
              TbQlgkSubpowerstd substd = (TbQlgkSubpowerstd) it.next();
              if ("市民中心".equals(substd.getCreateunitname())){
                  hasPC = true;
                  //dao.saveSubstd(substd);
              }
          }
          if(!hasPC){
              TbQlgkSubpowerstd substd = newForm.getSubstd();
              substd.setId(new Integer(0));
              substd.setCreateunitname("市民中心");
              substd.setCreateunitid("-1");
              dao.saveSubstd(substd);
//              TbQlgkPowerstd std = dao.loadPowerstd(newForm.getPsid());
//              newForm.setStd(std);
              //保存分标准同时保存分标准的步骤，及步骤附件
              Iterator stepit = substd.getTbQlgkPowerstdsteps().iterator();
              while(stepit.hasNext()){
                  TbQlgkPowerstdstep step = (TbQlgkPowerstdstep) stepit.next();
                  step.setStepid(new Integer(0));
                  step.setTbQlgkSubpowerstd(substd);
                  dao.saveStep(step);
              }
              //设置页面显示的分标准
              newForm.setSubstd(substd);
              newForm.setSubstdid(substd.getId().toString());
              newForm.getStd().getTbQlgkSubpowerstds().add(substd);
          }

          return mapping.findForward("forward");
      }


         /**
          * 删除
          * @param mapping ActionMapping
          * @param form ActionForm
          * @param request1 HttpServletRequest
          * @param response HttpServletResponse
          * @return ActionForward
          */
         public ActionForward deleteit(ActionMapping mapping, ActionForm form,
                                       HttpServletRequest request1,
                                       HttpServletResponse response
                                       ) {
             //加载权力标准 加载分标准 加载依据材料 加载步骤 加载依据
             NewPowerstdForm newForm = (NewPowerstdForm) form;
             ApplicationContext context = ContextSupport.getContext();
             com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                 "commonDao");
             if (newForm.getSubstdid() != null) {
                 dao.delSubstd(newForm.getSubstdid());
                 newForm.setSubstdid(null);
             }

             if (newForm.getPsid() != null) {
                 TbQlgkPowerstd std = dao.loadPowerstd(newForm.getPsid());
                 newForm.setStd(std);
                 newForm.setFiles(dao.listPsFiles(newForm.getPsid()));
             }
             if (newForm.getSubstdid() != null) {
                 newForm.setSubstd(dao.loadSubpowerstd(newForm.getSubstdid()));
             }
             else {
                 Iterator it = newForm.getStd().getTbQlgkSubpowerstds().iterator();
                 if (it.hasNext()) {
                     newForm.setSubstd( (TbQlgkSubpowerstd) it.next());
                     newForm.setSubstdid(newForm.getSubstd().getId().toString());
                 }
             }
             return mapping.findForward("forward");
         }



    /**
     * 新加载方法
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward load(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request1,
                              HttpServletResponse response
                              ) {
        //加载权力标准 加载分标准 加载依据材料 加载步骤 加载依据
        NewPowerstdForm newForm = (NewPowerstdForm) form;
        ApplicationContext context = ContextSupport.getContext();
        com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
            "commonDao");

        if (newForm.getPsid() != null) {
            TbQlgkPowerstd std = dao.loadPowerstd(newForm.getPsid());
            newForm.setStd(std);
            newForm.setFiles(dao.listPsFiles(newForm.getPsid()));
        }
        if (newForm.getSubstdid() != null) {
            newForm.setSubstd(dao.loadSubpowerstd(newForm.getSubstdid()));
        }else{
            Iterator it  = newForm.getStd().getTbQlgkSubpowerstds().iterator();
            if(it.hasNext()){
                newForm.setSubstd((TbQlgkSubpowerstd)it.next());
                newForm.setSubstdid(newForm.getSubstd().getId().toString());
            }
        }
        return mapping.findForward("forward");
    }

    /**
     * 保存，新的保存方法
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward newsave(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request1,
                                 HttpServletResponse response
                                 ) {

        try {
            NewPowerstdForm stdForm = (NewPowerstdForm) form;
            ApplicationContext context = ContextSupport.getContext();
            com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                "commonDao");
            TbQlgkPowerstd std = null;
            if (stdForm.getPsid() != null && !"".equals(stdForm.getPsid())) {
                std = dao.loadPowerstd(stdForm.getPsid());
            }
            else {
                std = new TbQlgkPowerstd();
                std.setCreatedate(new Date());
            }
            //将form的数据转换到powerstd中去
            //标准表保存
            //事项名称
            std.setPsname(stdForm.getStd().getPsname());
            //事项编号
            std.setPscode(stdForm.getStd().getPscode());
            //行为领域
            std.setDomain(stdForm.getStd().getDomain());
//            std.setAttr1id(stdForm.getStd().getAttr1id());
            //行为种类
//            std.set
            //是否三重一大
            std.setAttr1name(stdForm.getStd().getAttr1name());
            //公开类型
            std.setOpenscope(stdForm.getStd().getOpenscope());
            //前一个
            std.setPrevstep(stdForm.getStd().getPrevstep());
            //后一个
            std.setNextstep(stdForm.getStd().getNextstep());
            //个人企业办事
            std.setConsumer(stdForm.getStd().getConsumer());

            std.setCateid(stdForm.getStd().getCateid());
            std.setDes(stdForm.getStd().getDes());
            //示意图大
            if (stdForm.getLpic() != null &&
                stdForm.getLpic().getFileSize() > 0) {
                std.setDiagrampiclname(stdForm.getLpic().getFileName());
                std.setDiagrampicltype("");
                std.setDiagrampicldata(stdForm.getLpic().getFileData());
            }

            //示意图小
            if (stdForm.getSpic() != null &&
                stdForm.getSpic().getFileSize() > 0) {
                std.setDiagrampicsname(stdForm.getSpic().getFileName());
                std.setDiagrampicstype("");
                std.setDiagrampicsdata(stdForm.getSpic().getFileData());
            }
            //保存权力标准
            dao.saveStd(std);
            stdForm.setStd(std);
            stdForm.setPsid(std.getPsid().toString());
            //加载材料
            stdForm.setFiles(dao.listPsFiles(stdForm.getPsid()));
            if (std.getTbQlgkSubpowerstds() == null) {
                std.setTbQlgkSubpowerstds(new HashSet());
            }

            TbQlgkSubpowerstd substd = null;
            //处理权力分标准
            if (stdForm.getSubstdid() != null && !"".equals(stdForm.getSubstdid())) {
                substd = dao.loadSubpowerstd(stdForm.getSubstdid());
            }
            else {

                substd = new TbQlgkSubpowerstd();
                substd.setCreatetime(new Date());
                substd.setTbQlgkPowerstd(std);
                //设置为市民中心
                substd.setCreateunitname("市民中心");
                substd.setCreateunitid("-1");

                std.getTbQlgkSubpowerstds().add(substd);
            }
//            System.out.println("substd id is " + substd.getId() + " new value:" +
//                               stdForm.getSubstd().getAunitname());
            //将form的数据转换到subpowerstd中去
            substd.setAttr1name(stdForm.getSubstd().getAttr1name());
            //职权主体
//            substd.setAunitname(stdForm.getSubstd().getAunitname());
            substd.setZt(stdForm.getSubstd().getZt());
            //负责人
            substd.setAusername(stdForm.getSubstd().getAusername());
            //责任人岗位
            substd.setAjob(stdForm.getSubstd().getAjob());
            //承办机构
//            substd.setBunitname(stdForm.getSubstd().getBunitname());
            substd.setCb(stdForm.getSubstd().getCb());
            //责任人
            substd.setBusername(stdForm.getSubstd().getBusername());
            //责任岗位
            substd.setBjob(stdForm.getSubstd().getBjob());
            //总时限
            substd.setDuetimelimit(stdForm.getSubstd().getDuetimelimit());
            //总权限
            substd.setPslimit(stdForm.getSubstd().getPslimit());
            //权限单位
            substd.setPslimitunit(stdForm.getSubstd().getPslimitunit());

            //保存分标准
            dao.saveSubstd(substd);
            //设置页面显示
            stdForm.setSubstd(substd);
            stdForm.setSubstdid(substd.getId().toString());


        }
        catch (Exception ex) {
            request1.setAttribute("error",ex.getMessage());
            ex.printStackTrace();
        }
        return mapping.findForward("forward");
    }

    /**
         /**
      * 鍔犺浇
      * @param mapping ActionMapping
      * @param form ActionForm
      * @param request1 HttpServletRequest
      * @param response HttpServletResponse
      * @return ActionForward
      */
     public ActionForward loadstd(ActionMapping mapping, ActionForm form,
                                  HttpServletRequest request1,
                                  HttpServletResponse response
                                  ) {

         PowerstdForm stdForm = (PowerstdForm) form;

         try {
             ApplicationContext context = ContextSupport.getContext();
             com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                 "commonDao");

             TbQlgkPowerstd std = dao.loadPowerstd(stdForm.getPsid());
             stdForm.setPsid(std.getPsid().toString());
             this.voToForm(std, stdForm);
             request1.setAttribute("std", std);
         }
         catch (BeansException ex) {
             ex.printStackTrace();
         }
         return mapping.findForward("forward");
     }

    /**
     * voToForm
     *
     * @param std TbQlgkPowerstd
     * @param stdForm ActionForm
     */
    private void voToForm(TbQlgkPowerstd std, PowerstdForm form) {
        form.setAjob(std.getAjob());
        form.setAttr1name(std.getAttr1name());
        form.setAunitname(std.getAunitname());
        form.setAusername(std.getAusername());
        if (std.getCateid() != null) {
            form.setCateid(String.valueOf(std.getCateid()));
        }
        if (std.getDuetimelimit() != null) {
            form.setDuetimelimit(String.valueOf(std.getDuetimelimit()));
        }
        if (std.getOpenscope() != null) {
            form.setOpenscope(String.valueOf(std.getOpenscope()));
        }
        form.setPscode(std.getPscode());
        form.setPsid(String.valueOf(std.getPsid()));
        if (std.getPslimit() != null) {
            form.setPslimit(String.valueOf(std.getPslimit()));
        }
        form.setPslimitunit(std.getPslimitunit());
        form.setPsname(std.getPsname());
        form.setPsid(String.valueOf(std.getPsid()));
    }

    /**
     * 淇濆瓨
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward save(ActionMapping mapping, ActionForm form,
                              HttpServletRequest request1,
                              HttpServletResponse response
                              ) {
        try {
            PowerstdForm stdForm = (PowerstdForm) form;
            ApplicationContext context = ContextSupport.getContext();
            com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                "commonDao");
            TbQlgkPowerstd std = null;
            if (stdForm.getPsid() != null && !"".equals(stdForm.getPsid())) {
                std = dao.loadPowerstd(stdForm.getPsid());
            }
            else {
                std = new TbQlgkPowerstd();
                std.setCreatedate(new Date());
            }
            //灏唂orm杞崲鎴恦o
            this.formToVo(stdForm, std);

            //淇濆瓨澶у浘鐗\uFFFD
            if (stdForm.getLpic() != null &&
                stdForm.getLpic().getFileSize() > 0) {
                std.setDiagrampicldata(stdForm.getLpic().getFileData());
                std.setDiagrampiclname(stdForm.getLpic().getFileName());
                if (stdForm.getLpic().getFileName().toLowerCase().endsWith(
                    ".jpg")) {
                    std.setDiagrampicltype("image/jpeg");
                }
                else if (stdForm.getLpic().getFileName().toLowerCase().endsWith(
                    ".gif")) {
                    std.setDiagrampicltype("image/gif");
                }
                else {
                    std.setDiagrampicltype("image/*");
                }
            }

            //淇濆瓨灏忓浘鐗\uFFFD
            if (stdForm.getSpic() != null &&
                stdForm.getSpic().getFileSize() > 0) {
                std.setDiagrampicsdata(stdForm.getSpic().getFileData());
                std.setDiagrampicsname(stdForm.getSpic().getFileName());
                if (stdForm.getSpic().getFileName().toLowerCase().endsWith(
                    ".jpg")) {
                    std.setDiagrampicstype("image/jpeg");
                }
                else if (stdForm.getSpic().getFileName().toLowerCase().endsWith(
                    ".gif")) {
                    std.setDiagrampicstype("image/gif");
                }
                else {
                    std.setDiagrampicstype("image/*");
                }
            }

            dao.saveStd(std);
            this.voToForm(std, stdForm);
            request1.setAttribute("std", std);
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return mapping.findForward("forward");

    }

    /**
     * formToVo
     *
     * @param stdForm PowerstdForm
     * @param std TbQlgkPowerstd
     */
    private void formToVo(PowerstdForm form, TbQlgkPowerstd std) {
        //鍙渶瑕佷繚瀛\uFFFD2涓\uFFFD硷紝鍓嶄竴姝ラ 鍚庝竴姝ラ 鍙\uFFFD 鏄惁鏄競姘\uFFFD 浼佷笟
        std.setPrevstep(form.getPrevstep());
        std.setNextstep(form.getNextstep());
        std.setConsumer(form.getConsumer());
//        std.setPsname(form.getPsname());
//        std.setPscode(form.getPscode());
//        if (form.getCateid() != null && !"".equals(form.getCateid())) {
//            std.setCateid(new BigDecimal(form.getCateid()));
//        }
//        if (form.getOpenscope() != null && !"".equals(form.getOpenscope())) {
//            std.setOpenscope(new BigDecimal(form.getOpenscope()));
//        }
//        std.setAttr1name(form.getAttr1name());
//        if (form.getDuetimelimit() != null && !"".equals(form.getDuetimelimit())) {
//            std.setDuetimelimit(new BigDecimal(form.getDuetimelimit()));
//        }
//        if (form.getPslimit() != null && !"".equals(form.getPslimit())) {
//            std.setPslimit(new BigDecimal(form.getPslimit()));
//        }
//        std.setPslimitunit(form.getPslimitunit());
//        std.setAusername(form.getAusername());
//        std.setAjob(form.getAjob());
//        std.setAunitname(form.getAunitname());
//    std.setState(new BigDecimal(form.getstate));
//        std.setAttr1name(form.getAttr1name());
//        std.setAjob(form.getAjob());

    }

}
