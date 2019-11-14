package com.beyondbit.struts.action;

import javax.servlet.http.*;

import org.apache.struts.action.*;
import org.apache.struts.actions.*;
import org.springframework.context.*;
import com.beyondbit.hibernate.*;
import com.beyondbit.struts.dao.*;
import com.beyondbit.struts.form.*;
import java.text.ParseException;
import java.util.Date;

public class SaveLawAction
    extends DispatchAction {
    public SaveLawAction() {
    }

    /**
     *
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward newlaw(ActionMapping mapping, ActionForm form,
                                HttpServletRequest request1,
                                HttpServletResponse response) {
        form.reset(mapping, request1);
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
            LawForm fileForm = (LawForm) form;
            //转换成步骤
            TbQlgkLaw law = this.formToStep(fileForm);
            ApplicationContext context = ContextSupport.getContext();
            com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                "commonDao");
                    law.setTbQlgkPowerstd(dao.loadPowerstd(fileForm.getPsid()));
            dao.saveLaw(law);
            fileForm.setId( String.valueOf(law.getId()));

            request1.setAttribute("Message", "保存成功！");
            return mapping.findForward("forward");
        }
        catch (Exception ex) {

            ex.printStackTrace();
        }
        return mapping.findForward("error");
    }



    /**
     *
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward loadlaw(ActionMapping mapping, ActionForm form,
                                  HttpServletRequest request1,
                                  HttpServletResponse response
                                  ) {
        ApplicationContext context = ContextSupport.getContext();
        com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
            "commonDao");
        LawForm fileForm = (LawForm) form;
        TbQlgkLaw law = dao.loadLaw(fileForm.getId());
        this.stepToForm(law, fileForm);
        return mapping.findForward("forward");
    }

    /**
     * stepToForm
     *
     * @param step TbQlgkLaw
     * @param fileForm LawForm
     */
    private void stepToForm(TbQlgkLaw law, LawForm fileForm) {
        fileForm.setId(law.getId().toString());
        fileForm.setBykind(law.getBykind());
        fileForm.setLawname(law.getLawname());
        fileForm.setConstedate(new java.text.SimpleDateFormat("yyyy-MM-dd").
                               format(law.getConstedate()));
        fileForm.setConsteorgan(law.getConsteorgan());
        fileForm.setDescribe(law.getDescribe());
        fileForm.setPsid(String.valueOf(law.getTbQlgkPowerstd().getPsid()));
    }

    /**
     * formToStep
     *
     * @param fileForm LawForm
     * @return TbQlgkLaw
     */
    private TbQlgkLaw formToStep(LawForm fileForm) throws ParseException {

        TbQlgkLaw law = new TbQlgkLaw();
        if(fileForm.getId() != null && !"".equals(fileForm.getId()) ){
            law.setId(new Integer(fileForm.getId()));
        }
        law.setLawname(fileForm.getLawname());

        law.setAuthorityby(fileForm.getConsteorgan());
        law.setConsteorgan(fileForm.getConsteorgan());
        if(fileForm.getConstedate() != null && !"".equals(fileForm.getConstedate()) ){
            law.setConstedate(new java.text.SimpleDateFormat("yyyy-MM-dd").
                              parse(fileForm.getConstedate()));
        }else{
            law.setConstedate(new Date());
        }
        law.setBykind(fileForm.getBykind());
        law.setDescribe(fileForm.getDescribe());



        return law;
    }

}
