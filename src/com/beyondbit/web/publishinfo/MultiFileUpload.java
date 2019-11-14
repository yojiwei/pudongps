package com.beyondbit.web.publishinfo;
import java.text.SimpleDateFormat;
import java.io.FileNotFoundException;
import java.util.Date;
import org.apache.struts.upload.MultipartRequestHandler;
import java.util.Hashtable;
import org.apache.struts.action.ActionForm;
import java.io.InputStream;
import java.io.IOException;
import java.util.Collection;
import org.apache.struts.upload.FormFile;
import java.io.File;
import java.util.Iterator;
import java.io.FileOutputStream;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
/*
使用实例：
MultiFileUpActionForm formbean = (MultiFileUpActionForm) actionForm;
try {
    databean.MultiFileUp(actionForm,servletRequest);
} catch (Exception ex) {
}
returnbean.setServerFileName(databean.getServerFileName());
returnbean.setSourceFileName(databean.getSourceFileName());
servletRequest.setAttribute("returnclass",returnbean);
*/
public class MultiFileUpload {
    private static final String FILE_SAVE_PATH = "d:/";
    private String sSaveFilePath = "C:\\struts\\"; // 上传文件的目录
    Random random = new Random();
    private String realPath;
    private String virtualpath;
    private String savefilename;
    private String[] sourceFileName; //原文件名数组
    private String[] serverFileName; //上传到服务器上的文件名数组
    private String[] virtualFileName; //上传到服务器上的文件名
    private int filecount; //本次上传的文件数
    private StringBuffer fileName = new StringBuffer();

    public MultiFileUpload() {
        try {
            jbInit();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }
    //取得上传的文件在站点下的绝对名称（含绝对路径的文件名）
    public void setVirtualFileName(String[] virtualFileName) {
        this.virtualFileName = virtualFileName;
    }
    public String[] getVirtualFileName() {
        return virtualFileName;
    }
    //取得上传的文件在站点下的绝对名称（含绝对路径的文件名）
    public void setSaveFileName(String savefilename) {
        this.savefilename = savefilename;
    }
    public String getSaveFileName() {
        return savefilename;
    }

    public void setVirtualPath(HttpServletRequest servletRequest,String virtualpath) {
        this.virtualpath = virtualpath;
        sSaveFilePath = servletRequest.getRealPath("");
        System.out.println("sSaveFilePath:"+sSaveFilePath);
        if(!virtualpath.startsWith("\\")){
          virtualpath = "\\"+virtualpath;
        }
        if (!virtualpath.endsWith("\\")) {
          virtualpath= virtualpath + "\\";
        }
        sSaveFilePath += virtualpath;
        setFileInServerPath(sSaveFilePath);
        if(!sSaveFilePath.endsWith("\\")){
          sSaveFilePath += java.io.File.separator;
        }
        System.out.println("sSaveFilePath:"+sSaveFilePath);
    }
    public String getVirtualPath() {
        return virtualpath;
    }

    public void setFileInServerPath(String filepath) {
      String path = filepath;
      if (filepath == null) {
        path = "";
      }
      else {
        path = filepath.replace('\\', '/');
        String[] paths = path.split("/");
        path = paths[0];
        for (int i = 1; i < paths.length; i++) {
          path += "\\" + paths[i];
          File d = new File(path); //建立代表Sub目录的File对象，并得到它的一个引用
          if (!d.exists()) { //检查Sub目录是否存在
            d.mkdir(); //建立Sub目录
          }
        }
        if(filepath.endsWith("\\")){
          fileName.append(filepath);
        }else{
          fileName.append(filepath+"\\");
        }
      }
      filepath = path;
    }

    public void setRealPath(String pRealPath) {
        this.realPath = pRealPath;
    }
    public String getRealPath() {
        return realPath;
    }

    public void setFilecount(int filecount) {
        this.filecount = filecount;
    }
    public int getFilecount() {
        return filecount;
    }

    public void setSourceFileName(String[] sourceFileName) {
        this.sourceFileName = sourceFileName;
    }
    public String[] getSourceFileName() {
        return sourceFileName;
    }

    public void setServerFileName(String[] serverFileName) {
        this.serverFileName = serverFileName;
    }
    public String[] getServerFileName() {
        return serverFileName;
    }

    public void MultiFileUp(ActionForm actionForm) {
        MultipartRequestHandler MultiHash = actionForm.getMultipartRequestHandler();
        Hashtable elements = MultiHash.getFileElements();
        System.out.println("sfs" + elements.size());
        
        Collection values = elements.values();
        Iterator Iter = values.iterator();

        String[] sourceFileName = new String[elements.size()];
        String[] serverFileName = new String[elements.size()];
        String[] virtualFileName = new String[elements.size()];
        filecount = elements.size();
        int i = 0;

        try {
            while (Iter.hasNext()) {
                FormFile file = (FormFile) Iter.next();
                if(!"".equals(file.getFileName())){
                  String contentType = file.getContentType();
                  String fileName = file.getFileName();
                  System.out.println(file.getFileName());
                  sourceFileName[i] = fileName;
                  InputStream streamin = file.getInputStream();
                  String pathfilename = getSaveFileName(sSaveFilePath,
                      file.getFileName());
                  serverFileName[i] = pathfilename;
                  virtualFileName[i] = virtualpath + "\\" + serverFileName;
                  SaveAsFile(streamin, pathfilename);
                }
                i++;
            }
            this.setSourceFileName(sourceFileName);
            this.setServerFileName(serverFileName);
            this.setVirtualFileName(virtualFileName);
            this.setFilecount(filecount);
        } catch (FileNotFoundException ex) {
            System.out.println("FileNotFoundException:" + ex.getMessage());
        } catch (IOException ex) {
            System.out.println("IOException:" + ex.getMessage());
        }
    }

    private void SaveAsFile(InputStream streamin, String sFileName) {
        FileOutputStream streamout;
        //这里可以保存倒数据库或者磁盘
        try {
            streamout = new FileOutputStream(sFileName);
            int byteRead = 0;
            byte[] buffer = new byte[8192];
            int i = 0;
            while ((byteRead = streamin.read(buffer, 0, 8192)) != -1) {
                streamout.write(buffer, 0, byteRead);
            }
            streamout.close();
            streamin.close();
        } catch (Exception ex) {
            System.err.println("保存" + sFileName + " 失败!");
            System.err.println(ex.getMessage());
        }
    }

    private String getSaveFileName(String filepath, String sFileName) {
      savefilename = getCurDateTime() +
          Math.abs(random.nextInt()) % 100 +
          sFileName.substring(sFileName.lastIndexOf("."),
                              sFileName.length());
      sFileName = filepath + savefilename;
      return sFileName;
    }

    private String getCurDateTime() {
        SimpleDateFormat df = new SimpleDateFormat("yyMMddHHmmss");
        return df.format(new Date());
    }

    public static void main(String[] args) {
        MultiFileUpload multifileupload = new MultiFileUpload();
    }

    private void jbInit() throws Exception {
    }
}


