package com.applyopenService;

import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;
/**
 * 政府信息公开申请网上处理系统区县数据接入标准初始化程序生成.txt文件
 * @author Administrator
 * 连接到gwba数据库
 * 20100114
 */
public class ApplyOpenSeServiceBak{
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	
	public ApplyOpenSeServiceBak(){}
	/**
	 * 同步申请基本信息全部申请
	 * @return string
	 */
	private void getApplyAd(){
		StringBuffer applyads = new StringBuffer();
		String strAdSql = "";
		String signmode = "";//申请方式
		String signmodeValue = "";//申请方式文本
		String offermode = "";//政府信息的载体形式
		String offermodeValue = "";//政府信息的载体形式文本
		String gainmode = "";//获取信息方式
		String gainmodeValue = "";//获取信息方式文本
		String free = "";//个人申请免除收费主要理由
		String freeValue = "";//个人申请免除收费主要理由文本
		Vector vectorad = null;
		Hashtable contentad = null;
		try{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		//issendsh是否报送上海市0未报送1转交报送成功2办理完成默认0
		//不报送公安、食药、工商、质监、税务（'XB4','XC6','XB7','XB8','XC5'）
		//step = 2待处理
		strAdSql = "select i.id,to_char(i.applytime,'yyyy-MM-dd hh24:mi:ss') applytime,i.proposer,i.pname,i.punit,i.pcard," +
				"i.pcardnum,i.paddress,i.pzipcode,i.ptele,i.pemail,i.ename,i.ecode,i.ebunissinfo,i.edeputy,i.elinkman,i.etele,i.eemail," +
				"i.infotitle,i.commentinfo,i.flownum,i.purpose,i.memo,i.ischarge,i.free,i.indexnum,i.signmode,i.offermode,i.gainmode,t.dt_code,t.dt_name as dtname from infoopen " +
				"i,tb_deptinfo t where  t.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.issendsh=0 and i.did = t.dt_id  order by i.id desc";
		
		System.out.println("strAdSql = "+strAdSql);
		vectorad = dImpl.splitPage(strAdSql,1400,1);
		if(vectorad!=null){
			for(int j=0;j<vectorad.size();j++)
            {
				contentad = (Hashtable)vectorad.get(j);
				
				applyads.append("2Ad,");//表明同步数据内容
				applyads.append(CTools.dealNull(contentad.get("id"))+",");//区县系统申请编号 主键ID
				applyads.append("SH"+CTools.dealNull(contentad.get("dt_code"))+"PD,");//部门编号-eg:浦东新区工商局 SHGSPD
				applyads.append("SH00PD,");//区县编号-浦东新区SH00PD
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
				applyads.append(signmodeValue+",");//申请方式 0网上申请、1现场申请、2E-mail申请、3信函、4电报、5传真、6其它 存的是“1”
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("pname")))+",");//申请人（个人）姓名
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("pcard")))+",");//证件名称
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("pcardnum")))+",");//证件号码
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("paddress")))+",");//通讯地址
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("pzipcode")))+",");//邮政编码
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("ptele")))+",");//联系电话
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("pemail")))+",");//电子邮箱
				
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("ename")))+",");//申请人（法人或者其他组织）名称
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("edeputy")))+",");//法定代表人
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("elinkman")))+",");//申请人（法人或者其他组织）的联系人姓名
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("paddress")))+",");//申请人（法人或者其他组织）的通讯地址
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("pzipcode")))+",");//申请人（法人或者其他组织）的邮政编码
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("etele")))+",");//申请人（法人或者其他组织）的电话
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("eemail")))+",");//申请人（法人或者其他组织）的电子邮箱
				
				applyads.append(CTools.dealNull(contentad.get("applytime"))+",");//申请提交时间
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("commentinfo")))+",");//所需信息的内容描述
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("indexnum")))+",");//文号
				
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("purpose")).replaceAll(",", "#"))+",");//所需政府信息的用途可多选，以“#”分割 存的是“科研的需要,查验自身信息,”
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
				applyads.append(offermodeValue+",");//政府信息的载体形式 0纸质文本1电子邮件2磁盘3光盘   单选 存的是“1”
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
				applyads.append(gainmodeValue+",");//获取信息方式 如 0邮寄1快递2电子邮件3传真4当面领取5现场查阅 单选 存的是“1”
				
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("elinkman")))+",");//申请人（个人）的联系人姓名
				free = CTools.dealNull(contentad.get("free"));
				if("1".equals(free)){
					freeValue = "属于享受城乡居民最低生活保障对象#";
				}else if("2".equals(free)){
					freeValue = "确有其他经济困难的#";
				}else if("12".equals(free)){
					freeValue = "属于享受城乡居民最低生活保障对象#确有其他经济困难的#";
				}
				applyads.append(freeValue+",");//个人申请免除收费主要理由1属于享受城乡居民最低生活保障对象2确有其他经济困难的 多选，以“#”分割 存的是“12”
				applyads.append(replaceQuan(CTools.dealNull(contentad.get("infotitle")))+",");//所需政府信息的名称
				applyads.append("浦东新区"+CTools.dealNull(contentad.get("dtname")));//区县具体处理申请部门名称，如浦东新区公安局
				applyads.append("\r\n");
				
				//每100个生成一个文件
				if((j!=0&&j%100==0)||j==(vectorad.size()-1)){
					String info = "";
					info = "上海市政府信息依申请公开,1 \r\n";
			        info += applyads.toString();//得到组成的文本字符串 char(13)char(10)回车+getApplyDd()+getApplyBd()
			        info += "EOF";
			        
			        //System.out.println("组合后的字符串="+info);
			        com.util.CFile cfile = new com.util.CFile();
			        String filename = "D:/bsshs/infoad/infoad"+j+".txt";
			        cfile.write(filename, info);
			        applyads = new StringBuffer();
				}
				
				if(j%200==0){
					dImpl.closeStmt();
					dCn.closeCn();
					
					dCn = new CDataCn();
					dImpl = new CDataImpl(dCn);
				}
				
            }
		}
		
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("getApplyOpens==error=="+CDate.getThisTime()+"=="+ex.toString());
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
	}
	/**
	 * 申请处理信息(处理方式)处理中、已完成所以处理方式
	 * @return
	 */
	private void getApplyBd(){
		StringBuffer applybds = new StringBuffer();
		String strBdSql = "";
		String status = "";
		String step = "";
		String statusValue = "";
		Vector vectorbd = null;
		Hashtable contentbd = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			//issendsh是否报送上海市0未报送1转交报送成功2办理完成默认0
			//不报送上海市的部门公安、食药、工商、质监、税务
			//i.step= 2 待处理 t.status = 3待补正
			strBdSql = "select i.id,i.status,i.step,i.lastmessage,to_char(t.endtime,'yyyy-MM-dd hh24:mi:ss') as endtime," +
					"to_char(i.limittime,'yyyy-MM-dd') as limittime,s.dt_code from infoopen i,taskcenter t,tb_deptinfo s " +
					"where i.id = t.iid and s.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.did = s.dt_id " +
					"and i.step=5 and t.status = 2 union ";
			
			strBdSql += "select i.id,i.status,i.step,i.lastmessage,to_char(t.endtime,'yyyy-MM-dd hh24:mi:ss') as endtime," +
					"to_char(i.limittime,'yyyy-MM-dd') as limittime,s.dt_code from infoopen i,taskcenter t,tb_deptinfo s " +
					"where i.id = t.iid and s.dt_code not in('XB4','XC6','XB7','XB8','XC5') and i.did = s.dt_id " +
					"and i.step = 3";
			
			System.out.println("strBdSql = "+strBdSql);
			
			vectorbd = dImpl.splitPage(strBdSql,1080,1);
			if(vectorbd!=null){
				for(int j=0;j<vectorbd.size();j++)
	            {
					contentbd = (Hashtable)vectorbd.get(j);
					applybds.append("2Bd,");//同步代码\表明同步数据内容
					applybds.append(CTools.dealNull(contentbd.get("id"))+",");//区县系统申请编号 主键ID
					applybds.append("SH"+CTools.dealNull(contentbd.get("dt_code"))+"PD,");//部门编号-eg:浦东新区工商局 SHGSPD
					applybds.append("SH00PD,");//区县编号-浦东新区SH00PD
					applybds.append(replaceQuan(CTools.dealNull(contentbd.get("id")))+",");//处理编号
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
					
					//每100个生成一个文件
					if((j!=0&&j%100==0)||j==(vectorbd.size()-1)){
						String info = "";
						info = "上海市政府信息依申请公开,1 \r\n";
				        info += applybds.toString();//得到组成的文本字符串 char(13)char(10)回车+getApplyDd()+getApplyBd()
				        info += "EOF";
				        
				        //System.out.println("组合后的字符串="+info);
				        com.util.CFile cfile = new com.util.CFile();
				        String filename = "D:/bsshs/infobd/infobd"+j+".txt";
				        cfile.write(filename, info);
				        applybds = new StringBuffer();
					}
					
					if(j%200==0){
						dImpl.closeStmt();
						dCn.closeCn();
						
						dCn = new CDataCn();
						dImpl = new CDataImpl(dCn);
					}
					
	            }
			}
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("getApplyCs==error=="+CDate.getThisTime()+"=="+ex.toString());
		}finally{
			if(dImpl!=null)
				dImpl.closeStmt();
			if(dCn!=null)
				dCn.closeCn();
		}
	}
	/**
	 * 替换半角,为全角，
	 * 去掉多余空格
	 * @param quan
	 * @return
	 */
	private String replaceQuan(String quan){
		return quan.replaceAll(",", "，").replaceAll("\r\n", "").replaceAll(" ", "");//
	}
	/**
	 * main
	 * @param args
	 */
	public static void main(String args[]){
		ApplyOpenSeServiceBak aoss = new ApplyOpenSeServiceBak();
		try {
			aoss.getApplyAd();//初始化基本信息
			aoss.getApplyBd();//初始化办理信息
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
