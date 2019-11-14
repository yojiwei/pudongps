package com.applyopenService;

import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;
/**
 * 政府信息公开申请网上处理系统区县数据接入标准
 * 上海市正式接口http://10.200.254.21:8080/spnet/Shen2ExchangeWebService?wsdl
 * @author yaojiwei
 * 连接到gwba数据库
 * 20100129
 */
public class ApplyOpenSeService {
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	
	public ApplyOpenSeService(){}
	/**
	 * 同步申请基本信息Ad||同步补正申请信息Dd
	 * @return string 拼接好的基本信息字符串
	 * @param id 申请事项ID
	 * @param type报送类型Ad基本信息Dd补正信息Ed报送未报送成功的申请
	 * 
	 */
	private String getApplyAdorDd(String type,String id){
		StringBuffer applyadordds = new StringBuffer();
		String strSql = "";//基本信息报送SQL|补正信息报送SQL
		String signmode = "";//申请方式
		String signmodeValue = "";//申请方式文本
		String offermode = "";//政府信息的载体形式
		String offermodeValue = "";//政府信息的载体形式文本
		String gainmode = "";//获取信息方式
		String gainmodeValue = "";//获取信息方式文本
		String free = "";//个人申请免除收费主要理由
		String freeValue = "";//个人申请免除收费主要理由文本
		Hashtable contentad = null;
		try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		//issendsh是否报送上海市0未报送1转交报送成功2办理完成默认0
		//不报送公安、食药、工商、质监、税务（'XB4','XC6','XB7','XB8','XC5'）
		if("Ad".equals(type)){
		//step = 2待处理
		strSql = "select i.id,to_char(i.applytime,'yyyy-MM-dd hh24:mi:ss') applytime,i.proposer,i.pname,i.punit,i.pcard," +
				"i.pcardnum,i.paddress,i.pzipcode,i.ptele,i.pemail,i.ename,i.ecode,i.ebunissinfo,i.edeputy,i.elinkman,i.etele,i.eemail," +
				"i.infotitle,i.commentinfo,i.flownum,i.purpose,i.memo,i.ischarge,i.free,i.indexnum,i.signmode,i.offermode,i.gainmode,t.dt_code,t.dt_name as dtname from infoopen " +
				"i,tb_deptinfo t where i.step=2 and t.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.issendsh=0 and i.did = t.dt_id and i.id = "+id+"  order by i.id ";
		}else if("Dd".equals(type)||"Ed".equals(type)){
		//19补正申请告知 issendsh是否报送上海市0未报送1转交报送成功2办理完成默认0
		strSql = "select i.id,to_char(i.applytime,'yyyy-MM-dd hh24:mi:ss') applytime,i.proposer,i.pname,i.punit,i.pcard," +
			"i.pcardnum,i.paddress,i.pzipcode,i.ptele,i.pemail,i.ename,i.ecode,i.ebunissinfo,i.edeputy,i.elinkman,i.etele,i.eemail," +
			"i.infotitle,i.commentinfo,i.flownum,i.purpose,i.memo,i.ischarge,i.free,i.indexnum,i.signmode,i.offermode,i.gainmode,t.dt_name as dtname,t.dt_code from infoopen i,tb_deptinfo t" +
			" where i.did = t.dt_id and t.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.id = "+id+" order by i.id ";
		}
		System.out.println(type+"= strSql = "+strSql);
		contentad = (Hashtable)dImpl.getDataInfo(strSql);
		if(contentad!=null){
			if("Ad".equals(type)||"Ed".equals(type)){
				applyadordds.append("2Ad,");//表明同步基本信息数据内容
			}else if("Dd".equals(type)){
				applyadordds.append("2Dd,");//表明同步补正信息数据内容
			}
			applyadordds.append(CTools.dealNull(contentad.get("id"))+",");//区县系统申请编号 主键ID
			//用流水号代替依申请ID提交给上海市
			//applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("flownum")))+",");//依申请公开系统内部的处理编号——流水号
			applyadordds.append("SH"+CTools.dealNull(contentad.get("dt_code"))+"PD,");//部门编号-eg:浦东新区工商局 SHGSPD
			applyadordds.append("SH00PD,");//区县编号-浦东新区SH00PD
			
			signmode = CTools.dealNull(contentad.get("signmode"));
			if("0".equals(signmode)){
				signmodeValue = "网上";//网上申请
			}else if("1".equals(signmode)){
				signmodeValue = "当面";//现场申请
			}else if("2".equals(signmode)){
				signmodeValue = "电子邮件";//E-mail申请
			}else if("3".equals(signmode)){
				signmodeValue = "信函";
			}else if("4".equals(signmode)){
				signmodeValue = "电报";
			}else if("5".equals(signmode)){
				signmodeValue = "传真";
			}else if("6".equals(signmode)){
				signmodeValue = "其他";
			}
			applyadordds.append(signmodeValue+",");//申请方式 0网上申请、1现场申请、2E-mail申请、3信函、4电报、5传真、6其它 存的是“1”
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("pname")))+",");//申请人（个人）姓名
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("pcard")))+",");//证件名称
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("pcardnum")))+",");//证件号码
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("paddress")))+",");//通讯地址
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("pzipcode")))+",");//邮政编码
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("ptele")))+",");//联系电话
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("pemail")))+",");//电子邮箱
			
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("ename")))+",");//申请人（法人或者其他组织）名称
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("edeputy")))+",");//法定代表人
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("elinkman")))+",");//申请人（法人或者其他组织）的联系人姓名
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("paddress")))+",");//申请人（法人或者其他组织）的通讯地址
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("pzipcode")))+",");//申请人（法人或者其他组织）的邮政编码
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("etele")))+",");//申请人（法人或者其他组织）的电话
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("eemail")))+",");//申请人（法人或者其他组织）的电子邮箱
			
			applyadordds.append(CTools.dealNull(contentad.get("applytime"))+",");//申请提交时间
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("commentinfo")))+",");//所需信息的内容描述
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("indexnum")))+",");//文号
			
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("purpose")).replaceAll(",", "#"))+",");//所需政府信息的用途可多选，以“#”分割 存的是“科研的需要,查验自身信息,”
			offermode = CTools.dealNull(contentad.get("offermode"));
			if("0".equals(offermode)){
				offermodeValue = "纸质文本";
			}else if("1".equals(offermode)){
				offermodeValue = "电子邮件";
			}else if("2".equals(offermode)){
				offermodeValue = "磁盘";
			}else if("3".equals(offermode)){
				offermodeValue = "光盘";
			}
			applyadordds.append(offermodeValue+",");//政府信息的载体形式 0纸质文本1电子邮件2磁盘3光盘   单选 存的是“1”
			gainmode = CTools.dealNull(contentad.get("gainmode"));
			if("0".equals(gainmode)){
				gainmodeValue = "邮寄";
			}else if("1".equals(gainmode)){
				gainmodeValue = "快递";
			}else if("2".equals(gainmode)){
				gainmodeValue = "电子邮件";
			}else if("3".equals(gainmode)){
				gainmodeValue = "传真";
			}else if("4".equals(gainmode)){
				gainmodeValue = "当面领取";
			}else if("5".equals(gainmode)){
				gainmodeValue = "现场查阅";
			}
			applyadordds.append(gainmodeValue+",");//获取信息方式 如 0邮寄1快递2电子邮件3传真4当面领取5现场查阅 单选 存的是“1”
			
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("elinkman")))+",");//申请人（个人）的联系人姓名
			free = CTools.dealNull(contentad.get("free"));
			if("1".equals(free)){
				freeValue = "属于享受城乡居民最低生活保障对象#";
			}else if("2".equals(free)){
				freeValue = "确有其他经济困难的#";
			}else if("12".equals(free)){
				freeValue = "属于享受城乡居民最低生活保障对象#确有其他经济困难的#";
			}
			applyadordds.append(freeValue+",");//个人申请免除收费主要理由1属于享受城乡居民最低生活保障对象2确有其他经济困难的 多选，以“#”分割 存的是“12”
			applyadordds.append(replaceQuan(CTools.dealNull(contentad.get("infotitle")))+",");//所需政府信息的名称
			applyadordds.append("浦东新区"+CTools.dealNull(contentad.get("dtname")));//区县具体处理申请部门名称，如浦东新区公安局
			applyadordds.append("\r\n");
          }
		
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("getApplyOpens==error=="+CDate.getThisTime()+"=="+ex.getMessage());
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
		return applyadordds.toString();
	}
	/**
	 * 申请处理信息(处理结果)
	 * @return String 拼接好的申请处理信息字符串
	 * @param id 申请ID
	 */
	private String getApplyBd(String id){
		StringBuffer applybds = new StringBuffer();
		String strBdSql = "";
		String status = "";
		String step = "";
		String statusValue = "";
		Hashtable contentbd = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			//不报送上海市的部门公安、食药、工商、质监、税务
			//i.step=2 待处理
			strBdSql = "select * from (select i.id,i.status,i.step,i.lastmessage,to_char(t.endtime,'yyyy-MM-dd hh24:mi:ss') as endtime,i.flownum, " +
					"to_char(i.limittime,'yyyy-MM-dd hh24:mi:ss') as limittime,s.dt_code from infoopen i,taskcenter t,tb_deptinfo s " +
					"where i.id = t.iid and s.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.did = s.dt_id " +
					" and i.step<>2 and i.id = "+id+" order by t.id desc) where rownum=1";
			
			//System.out.println("strBdSql = "+strBdSql);
			
			contentbd = (Hashtable)dImpl.getDataInfo(strBdSql);
			if(contentbd!=null){
				applybds.append("2Bd,");//同步代码\表明同步数据内容
				applybds.append(CTools.dealNull(contentbd.get("id"))+",");//区县系统申请编号 主键ID
				applybds.append("SH"+CTools.dealNull(contentbd.get("dt_code"))+"PD,");//部门编号-eg:浦东新区工商局 SHGSPD
				applybds.append("SH00PD,");//区县编号-浦东新区SH00PD
				applybds.append(replaceQuan(CTools.dealNull(contentbd.get("flownum")))+",");//依申请公开系统内部的处理编号
				step = CTools.dealNull(contentbd.get("step"));//处理状态
				status = CTools.dealNumber(contentbd.get("status"));

				if(!"".equals(status)){
					switch (Integer.parseInt(status)){
						case 1: statusValue = "4";//属于公开范围
						break;
						case 2: statusValue = "5";//属于部分公开范围
						break;
						case 3: statusValue = "6";//属于国家秘密
						break;
						case 4:
						case 5:
						case 6:
						case 7: statusValue = "7";//属于商业秘密
						break;
						case 8:
						case 9:
						case 10:
						case 11: statusValue = "8";//属于个人隐私
						break;
						case 12: statusValue = "21";//权利人意见征询
						break;
						case 13: statusValue = "15";//非《规定》所指政府信息
						break;
						case 14: statusValue = "14";//信息不存在
						break;
						case 15: statusValue = "13";//不属于受理机关掌握范围
						break;
						case 16: statusValue = "9";//属于过程中且影响安全稳定
						break;
						case 17: statusValue = "10";//属于安全稳定
						break;
						case 18: statusValue = "18";//非政府信息公开申请
						break;
						case 19: statusValue = "19";//补正申请
						break;
						case 20: statusValue = "20";//重复申请
						break;
						case 21: statusValue = "3";//延期
						break;
						case 22: statusValue = "16";//申请人主动撤销
						break;
						case 23:
						case 24: statusValue = "17";//垃圾申请、多次重复不作处理——申请办结
						break;
					}
				}
				//2．已收件：申请信息形式基本完整，接受并开始后续处理； 3．延期
				//4．属于公开范围；5．属于部分公开范围；
				//6．属于国家秘密；7．属于商业秘密；
				//8．属于个人隐私；9．属于过程中且影响安全稳定： 
				//10．属于安全稳定；11．属于法律法规规定的其他情形；
				//13．不属于受理机关掌握范围；14．信息不存在；
				//15．非《规定》所指政府信息；16．申请人主动撤销；
				//17．申请已办结；18．非政府信息公开申请；
				//19．补正申请；20．重复申请；21．权利人意见征询。
				applybds.append(statusValue+",");
				if("23".equals(status)){
					applybds.append(replaceQuan("垃圾申请，"+CTools.dealNull(contentbd.get("lastmessage")))+",");//处理意见|备注 字符串（长度限制1000汉字）
				}else if("24".equals(status)){
					applybds.append(replaceQuan("多次重复不作处理，"+CTools.dealNull(contentbd.get("lastmessage")))+",");//处理意见|备注 字符串（长度限制1000汉字）
				}else{
					applybds.append(replaceQuan(CTools.dealNull(contentbd.get("lastmessage")))+",");//处理意见|备注 字符串（长度限制1000汉字）
				}
				applybds.append(CTools.dealNull(contentbd.get("endtime"))+",");//处理时间 处理发生的时间
				applybds.append(CTools.dealNull(contentbd.get("limittime"))+",");//承诺日期 日期格式2010-01-14
				applybds.append("");//主题词  当该步操作未修改主题词时，为空即可(为空)
				applybds.append("\r\n");
            }
			
			
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("getApplyCs==error=="+CDate.getThisTime()+"=="+ex.getMessage());
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
		return applybds.toString() ;
	}
	/**
	 * 申请已办结信息(处理方式)
	 * @return 拼接好的已办结申请字符串
	 * @param id 申请ID
	 */
	private String getApplyCd(String id){
		StringBuffer applybds = new StringBuffer();
		String strBdSql = "";
		String statusValue = "";
		Hashtable contentcd = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			//不报送上海市的部门公安、食药、工商、质监、税务
			//i.step=5已办结 t.status=2已办结
			strBdSql = "select i.id,i.status,i.step,i.lastmessage,to_char(t.endtime,'yyyy-MM-dd hh24:mi:ss') as endtime,i.flownum, " +
					"to_char(i.limittime,'yyyy-MM-dd hh24:mi:ss') as limittime,s.dt_code from infoopen i,taskcenter t,tb_deptinfo s " +
					"where i.id = t.iid and s.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.did = s.dt_id " +
					" and i.step=5 and t.status = 2 and i.id = "+id+" order by t.id desc";
			
			//System.out.println("strBdSql = "+strBdSql);
			contentcd = (Hashtable)dImpl.getDataInfo(strBdSql);
			if(contentcd!=null){
				applybds.append("2Bd,");//同步代码\表明同步数据内容
				applybds.append(CTools.dealNull(contentcd.get("id"))+",");//区县系统申请编号 主键ID
				applybds.append("SH"+CTools.dealNull(contentcd.get("dt_code"))+"PD,");//部门编号-eg:浦东新区工商局 SHGSPD
				applybds.append("SH00PD,");//区县编号-浦东新区SH00PD
				applybds.append(replaceQuan(CTools.dealNull(contentcd.get("flownum")))+",");//依申请公开系统内部的处理编号
				statusValue = "申请已办结";
				applybds.append(statusValue+",");
				applybds.append(replaceQuan(CTools.dealNull(contentcd.get("lastmessage")))+",");//处理意见|备注 字符串（长度限制1000汉字）
				applybds.append(CTools.dealNull(contentcd.get("endtime"))+",");//处理时间 处理发生的时间
				applybds.append(CTools.dealNull(contentcd.get("limittime"))+",");//承诺日期 日期格式2010-01-14
				applybds.append("");//主题词  当该步操作未修改主题词时，为空即可(为空)
				applybds.append("\r\n");
            }
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("getApplyCs==error=="+CDate.getThisTime()+"=="+ex.getMessage());
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
		return applybds.toString() ;
	}
	/**
	 * 替换半角,为全角，
	 * 去掉多余空格
	 * @param quan 原字符串
	 * @return 已经过滤好的字符串
	 */
	private String replaceQuan(String quan){
		return quan.replaceAll(",", "，").replaceAll("\r\n", "").replaceAll(" ", "");//
	}
	/**
	 * 报送到上海市
	 * @throws Exception
	 * @param type 报送类型 id 申请ID
	 * http://10.200.254.21:8080/spnet/Shen2ExchangeWebService正式接口地址
	 */
	public void sendShInfoopen(String type,String id) throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        String orgId = "SH00PD";//区县组织编号
        String userId = "pdUser";//分配的用户名pdUser
        String password = "111111"; //分配的密码111111
        String info = "";//数据交换文件
        String infos = "";
        String infoid = "";
        String infostatus = "";
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        // Time out after a minute
        binding.setTimeout(60000);
        // Test operation
        java.lang.String value = null;
        
        //依申请公开报送上海市类型Ad报送基本信息、Bd报送处理信息、Cd报送已完结信息、Dd报送补正|第三方意见征询、Ed报送上海市失败的
        if("Ad".equals(type)||"Dd".equals(type)||"Ed".equals(type)){
        	infos = getApplyAdorDd(type,id);
        }else if("Bd".equals(type)){
        	infos = getApplyBd(id);
        }else if("Cd".equals(type)){
        	infos = getApplyCd(id);
        }
        
        info = "上海市政府信息依申请公开,1 \r\n";
        info += infos;//得到组成的文本字符串 char(13)char(10)回车
        info += "EOF";
        try{
	        System.out.println("组合后的字符串="+info);
	        value = binding.addInfo(orgId,userId,password,info);//去调用上海市接口
	        value = value.replaceAll("\n", ",");//上海市政府信息依申请公开,1,SUCCESS,SH00HP-000000009,10089,0,EOF
	        System.out.println("报送情况=="+value);
	        String feedback [] = value.split(",");
	        infostatus = feedback[2];
	        infoid = feedback[4];
	        if("SUCCESS".equals(infostatus)){
	        	if("Ad".equals(type)||"Ed".equals(type)){//报送基本申请信息和报送补正、征询信息、报送上海市申请失败
	        		this.updateStatus(infoid,"1");//去修改公文备案数据库表infoopen-issendsh=1
	        	}else if("Bd".equals(type)){
	        		this.updateStatus(infoid,"2");//处理完成issendsh=2
	        	}
	        }
        }catch(Exception ex){
        	ex.printStackTrace();
        	System.out.println("失败:"+CDate.getNowTime()+" ApplyOpenSeService.sendShInfoopen " +ex.getMessage());
        }
//        报送情况==上海市政府信息依申请公开,1,SUCCESS
//        SH00PD-000000060,1613,0,
//        EOF
    }
	/**
	 * 修改infoopen申请表issendsh是否报送上海市0未报送1转交报送成功2办理完成默认0
	 * @param id 申请ID
	 * @param status 是否报送上海市0未报送1转交报送成功2办理完成
	 */
	private void updateStatus(String id,String status){
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			dImpl.executeUpdate("update infoopen set issendsh="+status+" where id='"+id+"'");
			
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("updateStatus==error=="+CDate.getThisTime()+"=="+ex.getMessage());
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
	}
	/**
	 * main
	 * @param args
	 */
	public static void main(String args[]){
		ApplyOpenSeService aoss = new ApplyOpenSeService();
		try {
			aoss.sendShInfoopen("Ed","2703");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
