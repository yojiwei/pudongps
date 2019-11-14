package com.beyondbit.struts.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.springframework.context.ApplicationContext;
import com.beyondbit.hibernate.ContextSupport;
import com.beyondbit.hibernate.TbQlgkPsfile;
import com.beyondbit.struts.dao.IDao;
import com.beyondbit.struts.form.FileForm;
import org.hibernate.Session;

public class SaveFileAction
    extends DispatchAction {
    public SaveFileAction() {
    }

    /**
     * 新建附件
     * @param mapping ActionMapping
     * @param form ActionForm
     * @param request1 HttpServletRequest
     * @param response HttpServletResponse
     * @return ActionForward
     */
    public ActionForward newfile(ActionMapping mapping, ActionForm form,
                                 HttpServletRequest request1,
                                 HttpServletResponse response
                                 ) {
//        FileForm fileForm = (FileForm) form;
//        ApplicationContext context = ContextSupport.getContext();
//        com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
//            "commonDao");
//        fileForm.setFile(dao.loadPsfile(fileForm.getFileid()));
        return mapping.findForward("forward");
    }

    /**
     * 加载附件
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
        FileForm fileForm = (FileForm) form;
        ApplicationContext context = ContextSupport.getContext();
        com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
            "commonDao");
        fileForm.setFile(dao.loadPsfile(String.valueOf(fileForm.getFile().getFileid())));

        return mapping.findForward("forward");
    }

    /**
     * 加载附件
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


            FileForm fileForm = (FileForm) form;
            ApplicationContext context = ContextSupport.getContext();
            com.beyondbit.struts.dao.IDao dao = (IDao) context.getBean(
                "commonDao");
                    TbQlgkPsfile file = null;
            //附件
            if(fileForm.getFile().getFileid() != null && 0 !=fileForm.getFile().getFileid().intValue() ){
                file = (dao.loadPsfile(fileForm.getFile().getFileid().toString()));
                file.setFilecode(fileForm.getFile().getFilecode());
                file.setIsinput(fileForm.getFile().getIsinput());
                file.setIsmust(fileForm.getFile().getIsmust());
                file.setIsopen(fileForm.getFile().getIsopen());
                file.setIsoutput(fileForm.getFile().getIsoutput());
                file.setPsid(fileForm.getFile().getPsid());
                file.setFilename(fileForm.getFile().getFilename());
            }else{
                file = fileForm.getFile();
            }
//
            //存内容
            if (fileForm.getDiagrampicdata() != null && fileForm.getDiagrampicdata().getFileSize() > 0) {
//                file.setFilename(fileForm.getDiagrampicdata().getFileName());
                file.setDiagrampicdata(fileForm.getDiagrampicdata().getFileData());
                file.setDiagrampicname(fileForm.getDiagrampicdata().getFileName());
                file.setDiagrampictype("");//根据判断决定
            }

            if (fileForm.getEdocdata() != null && fileForm.getEdocdata().getFileSize() > 0) {
                file.setEdocname(fileForm.getEdocdata().getFileName());
                file.setEdocdata(fileForm.getEdocdata().getFileData());
                file.setEdoctype("");//根据判断决定
            }
            //保存附件
            dao.savePsfile(file);
            fileForm.setFile(file);
            request1.setAttribute("Message", "保存成功！");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        return mapping.findForward("forward");
    }

}
