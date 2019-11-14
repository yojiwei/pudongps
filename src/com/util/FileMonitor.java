package com.util;

import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random; 
import java.util.Set;
import javax.imageio.ImageIO;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;


public class FileMonitor
{
  private HashMap<String, String> hash = new HashMap();
  private List listDir = new ArrayList();
  private HashMap<String, String> hashPic = new HashMap();
  private HashMap<String, String> hashVideo = new HashMap();

  private String tempPath = "";
  private String relPath = "";
  private String filetype = "";
  private File dir = null;

  public void foreachFile(String path, String pptype)
  {
    try {
      String file_sname = "";
      String filePath = "";
      String filegzPath = "";
      String filetempPath = "";
      String file_srcname = "";
      this.dir = new File(path);
      String[] fs = this.dir.list();
      if (fs.length > 0)
        for (int i = 0; i < fs.length; i++) {
          filePath = path + "\\" + fs[i];
          this.dir = new File(filePath);
          if (this.dir.isFile())
          {
            file_sname = filePath.substring(filePath.lastIndexOf(".") + 1).toUpperCase();
            file_srcname = filePath.substring(filePath.lastIndexOf("\\") + 1, filePath.lastIndexOf("."));

            if ((file_sname.equals("JPG")) || (file_sname.equals("PNG")) || (file_sname.equals("GIF")) || (file_sname.equals("BMP")) || (file_sname.equals("JPEG"))) {
              this.dir = new File(filePath);

              this.hashPic.put(this.dir.getName(), file_srcname);
              filegzPath = filePath.substring(0, filePath.lastIndexOf("\\")) + "\\";

              if ("middle".equals(pptype)) {
                if (zipPicmi(filePath, this.filetype, filegzPath, 300, 160)) {
                  this.dir = new File(filegzPath + this.filetype + this.dir.getName());
                  this.hash.put(this.dir.getName(), filegzPath + this.dir.getName());
                }
              } else {
                if ((!"small".equals(pptype)) || 
                  (!zipPicsm(filePath, this.filetype, filegzPath, 300, 160))) continue;
                this.dir = new File(filegzPath + this.filetype + this.dir.getName());
                this.hash.put(this.dir.getName(), filegzPath + this.dir.getName());
              }
            }

          }
          else
          {
            this.listDir.add(filePath);
            foreachFile(filePath, pptype);
          }
        }
    }
    catch (Exception e) {
      System.out.println(e.toString() + "***" + path);
    }
  }

  public void copyFile(String srcFilename, String dstFilename)
  {
    try
    {
      FileChannel srcChannel = new FileInputStream(srcFilename)
        .getChannel();

      FileChannel dstChannel = new FileOutputStream(dstFilename)
        .getChannel();

      dstChannel.transferFrom(srcChannel, 0L, srcChannel.size());

      srcChannel.close();
      dstChannel.close();
    } catch (IOException e) {
      System.out.println(e.toString());
    }
  }

  public void copyDir(String srcFilename, String dstFilename)
  {
    File file = null;
    file = new File(getPinYinStr(dstFilename));
    if (!file.exists())
      if (file.mkdir())
        System.out.println("OK");
      else
        System.out.println("NO");
  }

  public static String getPinYinStr(String cnstr)
  {
    StringBuffer sb = new StringBuffer();
    HanyuPinyinOutputFormat PINYIN_FORMAT = new HanyuPinyinOutputFormat();

    PINYIN_FORMAT.setToneType(HanyuPinyinToneType.WITHOUT_TONE);

    PINYIN_FORMAT.setVCharType(HanyuPinyinVCharType.WITH_V);
    for (int i = 0; i < cnstr.length(); i++) {
      char c = cnstr.charAt(i);
      if (c <= 'ÿ') {
        sb.append(c);
      } else {
        String pinyin = null;
        try {
          String[] pinyinArray = 
            PinyinHelper.toHanyuPinyinStringArray(c, PINYIN_FORMAT);
          pinyin = pinyinArray[0];
        } catch (BadHanyuPinyinOutputFormatCombination e) {
          e.getMessage();
        }
        catch (NullPointerException localNullPointerException) {
        }
        if (pinyin != null) {
          sb.append(pinyin);
        }
      }
    }

    return sb.toString();
  }

  public String fileRun(String inpath, String outpath, String pptype)
  {
    String path = "";
    if (this.hash != null) {
      this.hash.clear();
    }
    if (this.listDir != null) {
      this.listDir.clear();
    }
    if (this.hashPic != null) {
      this.hashPic.clear();
    }
    if (this.hashPic != null) {
      this.hashPic.clear();
    }
    if (this.hashVideo != null) {
      this.hashVideo.clear();
    }
    try
    {
      System.out.println("图片 视频 关键字 监听开始 开启连接...");

      foreachFile(inpath, pptype);
      if ((this.listDir != null) && (this.listDir.size() > 0)) {
        for (int i = 0; i < this.listDir.size(); i++)
        {
          this.tempPath = this.listDir.get(i).toString();
          this.relPath = 
            getPinYinStr(this.tempPath
            .replace(inpath, 
            outpath));
          copyDir(this.tempPath, this.relPath);
        }
      }

      if ((this.hash != null) && (this.hash.size() > 0))
        for (Iterator localIterator = this.hash.keySet().iterator(); localIterator.hasNext(); ) { Object o = localIterator.next();

          this.tempPath = ((String)this.hash.get(o)).toString();
          this.relPath = ((String)this.hash.get(o)).toString()
            .replace(inpath, 
            outpath);
          copyFile(this.tempPath, this.relPath);
          this.dir = new File(this.relPath);
          path = this.dir.getParent();
          path = path.substring(path.lastIndexOf("attach") + "attach".length());
          path = path.replace("\\", "/") + "/";

          this.dir = new File(this.tempPath);
          if (this.dir.delete())
            System.out.println("删除文件：" + this.dir.getName());
        }
    }
    catch (Exception ex)
    {
      System.out.println(ex.toString());
    } finally {
      System.out.println("图片 视频 关键字 监听结束关闭连接...");
    }

    return "it is over!";
  }

  public boolean gzPic(String srcpath, String newpath, int maxsize, int gw, String worh)
  {
    try
    {
      File fi = new File(srcpath);
      File fo = new File(newpath);

      AffineTransform transform = new AffineTransform();
      BufferedImage bis = ImageIO.read(fi);

      int w = bis.getWidth();
      int h = bis.getHeight();
      double scale = w / h;

      int nw = 0;
      int nh = 0;
      if (worh.equals("w")) {
        nw = gw;
        nh = nw * h / w;
        if (nh > maxsize) {
          nh = maxsize;
          nw = nh * w / h;
        }
      } else {
        nh = gw;
        nw = nh * w / h;
        if (nw > maxsize) {
          nw = maxsize;
          nh = nw * h / w;
        }
      }

      double sx = nw / w;
      double sy = nh / h;

      transform.setToScale(sx, sy);

      AffineTransformOp ato = new AffineTransformOp(transform, null);
      BufferedImage bid = new BufferedImage(nw, nh, 
        5);
      ato.filter(bis, bid);
      return ImageIO.write(bid, "jpeg", fo);
    } catch (Exception e) {
      System.out.println(e.toString() + "**********************");
    }return false;
  }

  public boolean zipPicmi(String srcpath, String newtype, String newpath, int maxwidth, int maxheight)
  {
    try
    {
      File fi = new File(srcpath);
      AffineTransform transform = new AffineTransform();
      BufferedImage bis = ImageIO.read(fi);

      int w = bis.getWidth();
      int h = bis.getHeight();

      if ((w > h) && (w > 300)) {
        newtype = "middle_";
        maxwidth = 300;
        maxheight = 225;
      }
      if ((h > w) && (h > 300)) {
        newtype = "middle_";
        maxwidth = 300;
        maxheight = 225;
      }

      this.filetype = newtype;
      File fo = new File(newpath + newtype + this.dir.getName());

      double scale = w / h;

      double nw = 0.0D;
      double nh = 0.0D;

      if (scale > 1.333333333333333D) {
        nw = maxwidth;
        nh = h / (w / maxwidth);
      } else {
        nw = w / (h / maxheight);
        nh = maxheight;
      }

      double sx = nw / w;
      double sy = nh / h;

      transform.setToScale(sx, sy);

      AffineTransformOp ato = new AffineTransformOp(transform, null);
      BufferedImage bid = new BufferedImage((int)nw, (int)nh, 
        5);
      ato.filter(bis, bid);
      return ImageIO.write(bid, "jpeg", fo);
    } catch (Exception e) {
      System.out.println(e.toString() + "**********************");
    }return false;
  }

  public boolean zipPicsm(String srcpath, String newtype, String newpath, int maxwidth, int maxheight)
  {
    try
    {
      File fi = new File(srcpath);
      AffineTransform transform = new AffineTransform();
      BufferedImage bis = ImageIO.read(fi);

      int w = bis.getWidth();
      int h = bis.getHeight();

      if ((w > h) && (w > 160)) {
        newtype = "small_";
        maxwidth = 160;
        maxheight = 120;
      }
      if ((h > w) && (h > 160)) {
        newtype = "small_";
        maxwidth = 160;
        maxheight = 120;
      }

      this.filetype = newtype;
      File fo = new File(newpath + newtype + this.dir.getName());

      double scale = w / h;

      double nw = 0.0D;
      double nh = 0.0D;

      if (scale > 1.333333333333333D) {
        nw = maxwidth;
        nh = h / (w / maxwidth);
      } else {
        nw = w / (h / maxheight);
        nh = maxheight;
      }

      double sx = nw / w;
      double sy = nh / h;

      transform.setToScale(sx, sy);

      AffineTransformOp ato = new AffineTransformOp(transform, null);
      BufferedImage bid = new BufferedImage((int)nw, (int)nh, 
        5);
      ato.filter(bis, bid);
      return ImageIO.write(bid, "jpeg", fo);
    } catch (Exception e) {
      System.out.println(e.toString() + "**********************");
    }return false;
  }

  public String changeFilename(String filepath)
  {
    String RandomFilename = "";
    Random rand = new Random();
    int random = rand.nextInt();

    Calendar calCurrent = Calendar.getInstance();
    int intDay = calCurrent.get(5);
    int intMonth = calCurrent.get(2) + 1;
    int intYear = calCurrent.get(1);
    String now = String.valueOf(intYear) + "_" + String.valueOf(intMonth) + 
      "_" + String.valueOf(intDay) + "_";

    RandomFilename = now + 
      String.valueOf(random > 0 ? random : -1 * random);
    File file = new File(filepath);
    RandomFilename = filepath.substring(0, filepath.lastIndexOf("\\")) + 
      "\\" + RandomFilename + 
      filepath.substring(filepath.lastIndexOf("."));

    if (file.renameTo(new File(RandomFilename))) {
      return RandomFilename;
    }
    return filepath;
  }

  public static void main(String[] args)
  {
    System.out.println("**********" + "\\aaa\\".replace("\\\\", "\\"));
    String inpath = "";
    String outpath = "";
    String pptype = "";
    FileMonitor fm = new FileMonitor();
    fm.fileRun(inpath, outpath, pptype);
  }
}