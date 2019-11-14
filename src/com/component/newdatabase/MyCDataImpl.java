package com.component.newdatabase;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.regex.Pattern;

import javax.servlet.http.*;
import javax.servlet.*;
import com.util.*;
import oracle.sql.*;
import oracle.jdbc.driver.*;
import com.share.dbExchange.DataDealImpl;
import com.share.exchange.*;
import com.component.database.*;

public class MyCDataImpl extends MyCDataControl implements IDataControl,
		IDataSplitPage, IDataInfo {

	/**
	 * 常量，NULL:表示未设置，调用Update()时将不作任何操作 ADDNEW:表示新增状态 EDIT:表示更改状态
	 */
	private static int NULL = 0;

	private static int ADDNEW = 1;

	private static int EDIT = 2;

	/**
	 * 设置尾的显示样式的常量， TAILDEFAULT;默认 TAILTEXT:使用文本框直接跳转 TAILLIST:下接跳转 以后可以新增
	 */
	public static int TAILDEFAULT = 0;

	public static int TAILTEXT = 1;

	public static int TAILLIST = 2;
	/*
	 * 分页需要的变量
	 */
	private ResultSet rsPage = null; // 初始化分页时的rs变量

	private ResultSetMetaData rsmd = null; // 记录集行标题

	private int pageSize; // 每页显示的记录数目

	private int page; // 当前页

	private int rowCount; // 获取记录总数

	private int pageCount; // 页面的总数

	private int numCols; // 页面的列数

	private String pageUrl = ""; // 当前页面的链接地址

	private String inputContent; // 输入框的内容

	private String pageSql; // 分页的sql

	private String delSql; // 删除的sql

	public static final int INT = 0;

	public static final int FLOAT = 1;

	public static final int DOUBLE = 2;

	public static final int STRING = 3;

	public static final int BOOLEAN = 4;

	public static final int DATE = 5;

	// public static final int BLOB = 6;
	public static final int LONG = 7;

	public static final int SLONG = 8;

	// 主键类型
	public static final int PRIMARY_KEY_IS_NUMBER = 1;

	public static final int PRIMARY_KEY_IS_VARCHAR = 2;

	private int mode = 0;

	private int primaryKeyType = 1; // 默认的是LONG型的ID

	private ResultSet rs;

	/*
	 * 新增、编辑、保存需要用到的变量
	 */
	private Hashtable dataContent; // 放置数据的内容

	private Hashtable dataType; // 放置数据的类型

	private String strTableName; // 当前表的名字

	private String strPrimaryFieldName; // 当前主字段名称

	private long currentId; // 当前记录ID

	private String currentSId; // 当前记录的String类型ID

	protected PreparedStatement pStmt;

	private DataDeal dDealImpl; // 数据交换实现

	/**
	 * Method:CDataImpl()<br>
	 * Description:构造函数<br>
	 * 不推荐使用
	 * 
	 * @deprecated
	 */
	public MyCDataImpl() {
		super();

		/*
		 * try { dDealImpl = new DataDealImpl(dataCn.getConnection()); } catch
		 * (SRException ex) { ex.printStackTrace(); }
		 */
		// 数据交换实现
	}

	/**
	 * Method:CDataImpl(CDataCn dCn) Description:构造函数
	 * 
	 * @param dCn
	 */
	public MyCDataImpl(MyCDataCn dCn) {
		super(dCn);
		/*
		 * try { dDealImpl = new DataDealImpl(dataCn.getConnection()); } catch
		 * (SRException ex) { ex.printStackTrace(); } //数据交换实现 *
		 */
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	/**
	 * Method:setTableName(String tableName)<br>
	 * Description:设置表名称
	 * 
	 * @param tableName
	 *            表名称
	 * @roseuid 3BF1FE62032A
	 */
	public void setTableName(String tableName) {
		strTableName = tableName;
	}

	/**
	 * Method:getTableName()<br>
	 * Description:获得表名称
	 * 
	 * @return strTableName
	 */
	public String getTableName() {
		return strTableName;
	}

	/**
	 * Method:setPrimaryFieldName(String fieldName) Description:设置主字段名称
	 * 
	 * @param fieldName
	 *            字段名称
	 * @roseuid 3BF1FE62038E
	 */
	public void setPrimaryFieldName(String fieldName) {
		strPrimaryFieldName = fieldName;
	}

	/**
	 * Method:getPrimaryFieldName() Description:获取主字段名称
	 * 
	 * @return strPrimaryFieldName 主字段名称
	 */
	public String getPrimaryFieldName() {
		return strPrimaryFieldName;
	}

	/**
	 * @roseuid 3BF1FE630014
	 */
	public long addNew() {
		long id; // 当前记录ID

		dataContent = new Hashtable();
		dataType = new Hashtable();

		/*
		 * 判断是否已经设置表和主字段，如果没有设置返回 -1
		 */
		if (strTableName == null || strPrimaryFieldName == null)
			return -1;

		mode = MyCDataImpl.ADDNEW;
		id = getMaxId(strTableName); // 给当前ID赋值
		currentId = id; // 设置当前ID

		setValue(strPrimaryFieldName, Long.toString(id), CDataImpl.LONG); // 把最新的ID插入Hashtable

		return id;
	}

	public long addNew(String tableName, String fieldName) {

		setTableName(tableName);// 设置表
		setPrimaryFieldName(fieldName);// 设置主字段名
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_NUMBER; // 设置主键的类型

		return addNew();
	}

	public String addNew(int pPrimaryKeyType) {
		long id;
		String sId;
		dataContent = new Hashtable();
		dataType = new Hashtable();
		/*
		 * 判断是否已经设置表和主字段，如果没有设置返回 -1
		 */
		if (strTableName == null || strPrimaryFieldName == null)
			return "-1";

		mode = MyCDataImpl.ADDNEW;
		this.primaryKeyType = pPrimaryKeyType; // 设置当前的主键类型
		id = getMaxId(strTableName); // 给当前ID赋值

		sId = this.getInitParameter("inner_or_outer") + String.valueOf(id);
		this.currentSId = sId;
		setValue(strPrimaryFieldName, sId, CDataImpl.STRING); // 把最新的ID插入Hashtable

		return sId;
	}

	public String addNew(String tableName, String fieldName, int pPrimaryKeyType) {
		setTableName(tableName);// 设置表
		setPrimaryFieldName(fieldName);// 设置主字段名
		return addNew(pPrimaryKeyType);
	}

	/**
	 * @roseuid 3BF1FE63003C
	 */
	private void edit() {
		dataContent = new Hashtable();
		dataType = new Hashtable();

		/*
		 * 判断是否已经设置表和主字段
		 */
		if (strTableName != null && strPrimaryFieldName != null) {
			mode = MyCDataImpl.EDIT; // 设置模式为修改
		}
	}

	/**
	 * @roseuid 3BFC9F5601D5
	 */
	public void edit(long id) {
		currentId = id; // 设置当前ID
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_NUMBER;
		edit();
	}

	/**
	 * Method:edit(long id,String tableName,String fieldName)<br>
	 * Description:编辑<br>
	 * 
	 * @param id
	 * @param tableName
	 * @param fieldName
	 */
	public void edit(String tableName, String fieldName, long id) {
		setTableName(tableName); // 设置表
		setPrimaryFieldName(fieldName); // 设置主字段名
		edit(id); // 调用私有函数，编辑
	}

	/**
	 * 
	 * @param id
	 */
	public void edit(String id) {
		currentSId = id; // 设置当前ID
		this.primaryKeyType = this.PRIMARY_KEY_IS_VARCHAR;
		edit();
	}

	public void edit(String tableName, String fieldName, String id) {
		setTableName(tableName); // 设置表
		setPrimaryFieldName(fieldName); // 设置主字段名
		edit(id); // 调用私有函数，编辑
	}

	/**
	 * @roseuid 3BF1FE630064
	 */
	public void setValue(String fieldName, Object fieldValue, int pMode) {
		if (fieldValue != null) // 如果字段内容为NULl,不设置值
		{
			dataContent.put(fieldName, fieldValue); // 把值添加到相应Hashtable中
			dataType.put(fieldName, Integer.toString(pMode)); // 把类型添加到相应Hashtable中
		}
	}

	/**
	 * @roseuid 3BF1FE630119
	 */
	public void setValue() {
	}

	/**
	 * @roseuid 3BF1FE630137
	 */
	public boolean update() {
		String updateSql = "";// 更新的SQL语句
		String tempSql = ""; // 临时过渡用的sql
		Enumeration dataKeys; // 列举元素项
		int iDataKeys = 0; // 元素个数
		/*
		 * 如果没有设置，不能update
		 */
		if (dataContent != null && dataType != null) // 存储数据的hashtable不能为空
		{
			dataKeys = dataContent.keys();

			if (mode == MyCDataImpl.NULL) {
				return false; // 如果没有设置类型，退出
			}

			if (mode == MyCDataImpl.ADDNEW) // 如果是新增
			{
				/*
				 * 开始组合sql语句
				 */
				updateSql = "insert into " + strTableName + "(";

				/*
				 * 遍历所有元素项，组合sql语句
				 */
				while (dataKeys.hasMoreElements()) {
					tempSql = tempSql + dataKeys.nextElement().toString() + ",";// 组合字段
					iDataKeys++;
				}

				updateSql = updateSql
						+ tempSql.substring(0, tempSql.length() - 1);
				updateSql = updateSql + ") values (";

				tempSql = ""; // 重新初始化临时的sql

				for (int i = 0; i < iDataKeys; i++) {
					tempSql = tempSql + "?,"; // 组合问号
				}

				updateSql = updateSql
						+ tempSql.substring(0, tempSql.length() - 1);
				updateSql = updateSql + ")";

				// System.out.println(updateSql); //输出sql语句备查

			} else if (mode == MyCDataImpl.EDIT) {
				/*
				 * 开始组合sql语句
				 */
				updateSql = "update " + strTableName + " set ";

				/*
				 * 遍历所有元素项，组合sql语句
				 */
				String tempKey = "";
				while (dataKeys.hasMoreElements()) {
					tempKey = dataKeys.nextElement().toString();
					tempSql = tempSql + tempKey + " = ?,";// 组合字段
				}

				updateSql = updateSql
						+ tempSql.substring(0, tempSql.length() - 1);
				if (primaryKeyType == this.PRIMARY_KEY_IS_VARCHAR) {
					updateSql = updateSql + " where " + strPrimaryFieldName
							+ " = '" + currentSId + "'";
				} else {
					updateSql = updateSql + " where " + strPrimaryFieldName
							+ " = " + java.lang.Long.toString(currentId);
				}
				System.out.println(updateSql); // 输出updateSql语句
			}

			try {
				pStmt = cn.prepareStatement(updateSql); // 开始与处理声明
				dataKeys = dataContent.keys(); // 重新初始化
				int iCountParam = 1; // 初始化索引号从1开始
				String tempKey = ""; // 每个元素的值
				String tempCurrentId = ""; // 当前的ID

				while (dataKeys.hasMoreElements()) {
					tempKey = dataKeys.nextElement().toString();
					// System.out.println(java.lang.Integer.valueOf(dataType.get(tempKey).toString()).intValue());
					setPreparedParam(iCountParam, dataContent.get(tempKey)
							.toString(), java.lang.Integer.valueOf(
							dataType.get(tempKey).toString()).intValue()); // 设置参数
					iCountParam++; // 索引号增加
				}

				pStmt.execute(); // 提交
				//update by swj 20081105
				//pStmt.close();

				/*
				 * 开始统一处理数据交换操作
				 */
				// 判断当前主键的类型，给tempCurrentId赋值
				/*
				 * if(primaryKeyType == this.PRIMARY_KEY_IS_VARCHAR) {
				 * tempCurrentId = this.currentSId; } else { tempCurrentId =
				 * String.valueOf(this.currentId); }
				 * 
				 * if(mode==CDataImpl.ADDNEW) {
				 * //dDealImpl.setRecord(strTableName,ConstantList.RECORDINSERT,tempCurrentId);
				 * //insert类型的交换记录 } else if(mode==CDataImpl.EDIT) {
				 * //dDealImpl.setRecord(strTableName,ConstantList.RECORDUPDATE,tempCurrentId);
				 * //update类型的交换记录 }
				 */
				return true;
			} catch (Exception ex) {
				// System.out.println(ex);
				dataCn.raise(ex, "更新数据出错", "CDataImpl:update()");
				return false;
			}

		} else {
			return false;
		}
	}

	/**
	 * Method: public void setPreparedParam(int paramIndex,String content,int
	 * dataType)<br>
	 * Description:设置与处理参数
	 * 
	 * @param paramIndex
	 *            参数索引号
	 * @param content
	 *            内容
	 * @param dataType
	 *            类型
	 */
	public void setPreparedParam(int paramIndex, String content, int dataType) {
		try {
			switch (dataType) {
			case INT: {
				int iContent = java.lang.Integer.valueOf(content).intValue();
				pStmt.setInt(paramIndex, iContent);
				break;
			}

			case LONG: {
				long lContent = java.lang.Long.valueOf(content).longValue();
				pStmt.setLong(paramIndex, lContent);
				break;
			}

			case SLONG: {
				byte[] bContent = content.getBytes();
				ByteArrayInputStream streamContent = new ByteArrayInputStream(
						bContent);
				InputStreamReader readerContent = new InputStreamReader(
						streamContent);
				// System.out.println("length="+bContent.length);
				pStmt.setCharacterStream(paramIndex, readerContent,
						bContent.length);
				break;
			}

			case STRING: {
				// String sContent = CTools.iso2gb(content); //转换post过来的字符串
				pStmt.setString(paramIndex, content);
				break;
			}

			case FLOAT: {
				float fContent = java.lang.Float.valueOf(content).floatValue();
				pStmt.setFloat(paramIndex, fContent);
				break;
			}

			case DOUBLE: {
				double dContent = java.lang.Double.valueOf(content)
						.doubleValue();
				pStmt.setDouble(paramIndex, dContent);
				break;
			}

			case DATE: {
				Timestamp tContent;
				if (content.length() > 10) {
					tContent = java.sql.Timestamp.valueOf(content);
				} else {
					tContent = java.sql.Timestamp
							.valueOf(content + " 00:00:00");
				}
				pStmt.setTimestamp(paramIndex, tContent);
			}

			}
		} catch (Exception ex) {
			// System.out.println(ex.getMessage());
			dataCn
					.raise(ex, "设置sql参数的时候出错",
							"CDataImpl:setPreparedParam(int paramIndex,String content,int dataType)");
		}
	}

	/**
	 * @roseuid 3BF1FE63015F
	 */
	public boolean delete(long id) {
		String deleteSql = ""; // 删除语句

		currentId = id; // 设置当前ID

		deleteSql = "delete from " + strTableName + " where "
				+ strPrimaryFieldName + " = " + currentId;
		try {
			pStmt = cn.prepareStatement(deleteSql);
			pStmt.execute();
			dDealImpl.setRecord(strTableName, ConstantList.RECORDDELETE, String
					.valueOf(this.currentId)); // delete类型的交换记录
			return true;
		} catch (Exception ex) {
			dataCn.raise(ex, "删除时错误", "CDataImpl:delete(long id)");
			return false;
		}
	}

	/**
	 * Description:删除记录（varchar类型的主键）
	 * 
	 * @param id
	 * @return
	 */
	public boolean delete(String id) {
		String deleteSql = ""; // 删除语句

		currentSId = id; // 设置当前ID

		deleteSql = "delete from " + strTableName + " where "
				+ strPrimaryFieldName + " = '" + currentSId + "'";
		try {
			pStmt = cn.prepareStatement(deleteSql);
			pStmt.execute();
			// dDealImpl.setRecord(strTableName,ConstantList.RECORDDELETE,this.currentSId);
			// //delete类型的交换记录
			return true;
		} catch (Exception ex) {
			dataCn.raise(ex, "删除时错误", "CDataImpl:delete(long id)");
			return false;
		}
	}

	/**
	 * @roseuid 3BF1FE6301CD
	 */
	public boolean delete(String tableName, String primaryFieldName, long id) {
		setTableName(tableName); // 设置表名称
		setPrimaryFieldName(primaryFieldName); // 设置主字段
		return delete(id);
	}

	/**
	 * Description:删除记录
	 * 
	 * @param tableName
	 * @param primaryFieldName
	 * @param id
	 * @return
	 */
	public boolean delete(String tableName, String primaryFieldName, String id) {
		setTableName(tableName); // 设置表名称
		setPrimaryFieldName(primaryFieldName); // 设置主字段
		return delete(id);
	}

	/**
	 * @roseuid 3BF1FE6302C7
	 */
	public boolean setClobValue(String tableName, String primaryFieldName,
			long id, Object value) {

		return true;
	}

	/**
	 * @roseuid 3BFC9F560315
	 */
	public boolean setClobValue(String fieldName, Object value) {
		try {
			// OracleStatement oracleStmt;
			OracleResultSet rsClob;
			CLOB clobField = null; // clob字段的
			String strSql = "";

			// 如果是varchar类型的主键
			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				// 开始组合需要更新的sql语句，把当前字段设置为empty_clob()
				strSql = "update " + strTableName + " set " + fieldName
						+ " = empty_clob() where " + strPrimaryFieldName
						+ " = '" + currentSId + "'";
			} else {
				strSql = "update " + strTableName + " set " + fieldName
						+ " = empty_clob() where " + strPrimaryFieldName
						+ " = " + Long.toString(currentId);
			}
			// System.out.println(strSql);
			executeUpdate(strSql); // 更新

			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = '" + currentSId
						+ "'";// + " for update";
			} else {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = "
						+ Long.toString(currentId);// + " for update";
			}
			// oracleStmt =
			// (oracle.jdbc.driver.OracleStatement)cn.createStatement();
			rsClob = (OracleResultSet) executeQuery(strSql);

			if (rsClob.next()) {
				clobField = rsClob.getCLOB(fieldName); // 获取字段值
			}
			CTools.fillClob(clobField, value.toString());

			rsClob.close();
			// oracleStmt.close();

			return true;
		} catch (Exception ex) {
			dataCn
					.raise(
							ex,
							"设置clob的时候出错",
							"CDataImpl:setClobValue(String tableName, String primaryFieldName, long id, String fieldName, Object value)");
			return false;
		}
	}

	/**
	 * @roseuid 3BF1FE64000C
	 */
	public boolean setClobValue(String tableName, String primaryFieldName,
			long id, String fieldName, Object value) {
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		setCurrentId(id);

		return setClobValue(fieldName, value);
	}

	/**
	 * @roseuid 3BF1FE64016A
	 */
	public boolean setClobValue(Hashtable ht) {
		return true;
	}

	/**
	 * @roseuid 3BF1FE6401D8
	 */
	public boolean setClobValue(String tableName, String primaryFieldName,
			long id, Hashtable ht) {

		return true;
	}

	public String getClobValue(String tableName, String primaryFieldName,
			long id, String fieldName) {
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		setCurrentId(id);
		return getClobValue(fieldName);
	}

	/**
	 * 获得CLOB字段中的值
	 * 
	 * @param fieldName
	 * @return
	 */
	public String getClobValue(String fieldName) {
		try {
			ResultSet rsClob;
			String sql, rValue;

			/* 如果有变量没有设置，返回空 */
			if (fieldName == null || strTableName == null
					|| strPrimaryFieldName == null || fieldName.equals("")
					|| strTableName.equals("")
					|| strPrimaryFieldName.equals("")) {
				return "";
			}
			sql = "select " + fieldName + " from " + strTableName + " where "
					+ strPrimaryFieldName + " = " + Long.toString(currentId); // 组合语句
			rsClob = executeQuery(sql);
			if (rsClob.next()) {
				// System.out.println(rsClob.getClob(fieldName).toString());
				rValue = CTools.ClobToString(rsClob.getClob(fieldName)); // 转换CLOB为字符串
			} else
				rValue = "";
			rsClob.close(); // 关闭对象

			return rValue;
		} catch (Exception ex) {
			dataCn.raise(ex, "获取clob的时候出错",
					"CDataImpl:getClobValue(String fieldName)");
			return "";
		}
	}

	/**
	 * Description:插入文件到数据库中的一个blob字段中<br>
	 * 
	 * @param fieldName
	 *            字段名
	 * @param file
	 *            文件名
	 * @return 插入是否成功
	 */
	public boolean setBlobValue(String fieldName, File file) {
		try {
			OracleResultSet rsBlob;
			oracle.sql.BLOB blob = null; // blob字段的
			String strSql = "";

			// 如果是varchar类型的主键
			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				// 开始组合需要更新的sql语句，把当前字段设置为empty_clob()
				strSql = "update " + strTableName + " set " + fieldName
						+ " = empty_blob() where " + strPrimaryFieldName
						+ " = '" + currentSId + "'";
			} else {
				strSql = "update " + strTableName + " set " + fieldName
						+ " = empty_blob() where " + strPrimaryFieldName
						+ " = " + Long.toString(currentId);
			}
			// System.out.println(strSql);
			executeUpdate(strSql); // 更新

			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = '" + currentSId
						+ "'" + " for update";
			} else {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = "
						+ Long.toString(currentId);// + " for update";
			}
			// oracleStmt =
			// (oracle.jdbc.driver.OracleStatement)cn.createStatement();
			rsBlob = (OracleResultSet) executeQuery(strSql);

			while (rsBlob.next()) {
				blob = (oracle.sql.BLOB) rsBlob.getBlob(fieldName);
				BufferedOutputStream out = new BufferedOutputStream(blob
						.getBinaryOutputStream());
				BufferedInputStream in = new BufferedInputStream(
						new FileInputStream(file));

				int c;

				while ((c = in.read()) != -1) {
					out.write(c);
				}
				in.close();
				out.close();
			}

			return true;
		} catch (Exception ex) {
			dataCn.raise(ex, "setBlob的时候出错",
					"CDataImpl:setBlobValue(String fieldName,File file)");
			return false;
		}
	}

	public boolean updateBlob(File file) {
		CallableStatement cs = null;
		BLOB blob = null;
		String blobData = null;
		try {
			// call Stored DB procedure for updating CLOB column.
			Connection conn = dataCn.getConnection();
			cs = (CallableStatement) conn
					.prepareCall("begin updatewattach(?,?); end;");

			// create the CLOB object
			blob = oracle.sql.BLOB.createTemporary(conn, true,
					oracle.sql.BLOB.DURATION_SESSION);

			BufferedOutputStream out = new BufferedOutputStream(blob
					.getBinaryOutputStream());
			BufferedInputStream in = new BufferedInputStream(
					new FileInputStream(file));

			int c;
			while ((c = in.read()) != -1) {
				out.write(c);
			}
			in.close();
			out.close();

			// set id
			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				cs.setObject(1, currentSId);
			} else {
				cs.setObject(1, Long.toString(currentId));
			}

			// set clob data
			cs.setObject(2, blob);

			// Execute callable statement.
			cs.execute();

			// Close the Statement object
			cs.close();

		} catch (SQLException ex) {
			System.out.println("SQLException status : " + ex.getMessage());
		} catch (Exception ex) {
			System.out.println("some exception " + ex.getMessage());
		} finally {
			try {
				// Close Statement
				if (cs != null) {
					cs.close();
				}

				// Free CLOB
				if (blob != null) {
					blob = null;
				}
			} catch (Exception ex) {
				System.out
						.println("Some exception in callUpdate method of given "
								+ "status : " + ex.getMessage());
			}
		}
		return true;
	}

	public boolean setBlobValue(String fieldName, byte[] byteData) {
		try {
			OracleResultSet rsBlob;
			oracle.sql.BLOB blob = null; // blob字段的
			String strSql = "";

			// 如果是varchar类型的主键
			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				// 开始组合需要更新的sql语句，把当前字段设置为empty_clob()
				strSql = "update " + strTableName + " set " + fieldName
						+ " = empty_blob() where " + strPrimaryFieldName
						+ " = '" + currentSId + "'";
			} else {
				strSql = "update " + strTableName + " set " + fieldName
						+ " = empty_blob() where " + strPrimaryFieldName
						+ " = " + Long.toString(currentId);
			}
			// System.out.println(strSql);
			executeUpdate(strSql); // 更新

			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = '" + currentSId
						+ "'" + " for update";
			} else {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = "
						+ Long.toString(currentId);// + " for update";
			}
			// oracleStmt =
			// (oracle.jdbc.driver.OracleStatement)cn.createStatement();
			rsBlob = (OracleResultSet) executeQuery(strSql);

			while (rsBlob.next()) {
				blob = (oracle.sql.BLOB) rsBlob.getBlob(fieldName);
				BufferedOutputStream out = new BufferedOutputStream(blob
						.getBinaryOutputStream());
				BufferedInputStream in = new BufferedInputStream(
						new ByteArrayInputStream(byteData));

				int c;
				while ((c = in.read()) != -1) {
					out.write(c);
				}
				in.close();
				out.close();
			}

			return true;
		} catch (Exception ex) {
			dataCn.raise(ex, "setBlob的时候出错",
					"CDataImpl:setBlobValue(String fieldName,byte[] byteData)");
			return false;
		}
	}

	public boolean setBlobValue(String tableName, String primaryFieldName,
			String sId, String fieldName, byte[] byteData) {
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_VARCHAR; // 设定主键的类型
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		this.currentSId = sId;
		return (setBlobValue(fieldName, byteData));
	}

	public boolean setBlobValue(String tableName, String primaryFieldName,
			long id, String fieldName, byte[] byteData) {
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_NUMBER; // 设定主键的类型
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		setCurrentId(id);
		return (setBlobValue(fieldName, byteData));
	}

	public boolean setBlobValue(String tableName, String primaryFieldName,
			String sId, String fieldName, File file) {
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_VARCHAR; // 设定主键的类型
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		this.currentSId = sId;
		return (setBlobValue(fieldName, file));
	}

	public boolean setBlobValue(String tableName, String primaryFieldName,
			long id, String fieldName, File file) {
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_NUMBER; // 设定主键的类型
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		setCurrentId(id);
		return (setBlobValue(fieldName, file));
	}

	/**
	 * Description:把Blob中的数据写成文件
	 * 
	 * @param fieldName
	 * @param outFile
	 */
	public void getBolbValue(String fieldName, String outFile) {
		String strSql = "";
		OracleResultSet rsBlob;
		oracle.sql.BLOB blob = null;

		try {

			if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_VARCHAR) {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = '" + currentSId
						+ "'";// + " for update";
			} else {
				strSql = "select " + fieldName + " from " + strTableName
						+ " where " + strPrimaryFieldName + " = "
						+ Long.toString(currentId);// + " for update";
			}
			rsBlob = (OracleResultSet) executeQuery(strSql);
			while (rsBlob.next()) {
				blob = (oracle.sql.BLOB) rsBlob.getBlob(fieldName);

				/* 以二进制形式输出 */
				BufferedOutputStream out = new BufferedOutputStream(
						new FileOutputStream(outFile));
				BufferedInputStream in = new BufferedInputStream(blob
						.getBinaryStream());

				byte[] data = new byte[1000];
				int c;
				while ((c = in.read(data)) != -1) {
					out.write(data, 0, c);
				}
				in.close();
				out.close();
			}

		} catch (Exception ex) {
			dataCn.raise(ex, "获取blob数据时候错误",
					"CDataImpl:getBolbValue(String fieldName,String outFile)");
		}
	}

	public void getBolbValue(String tableName, String primaryFieldName,
			long id, String fieldName, String outFile) {
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		setCurrentId(id);
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_NUMBER;
		getBolbValue(fieldName, outFile);
	}

	public void getBolbValue(String tableName, String primaryFieldName,
			String sId, String fieldName, String outFile) {
		setTableName(tableName);
		setPrimaryFieldName(primaryFieldName);
		this.currentSId = sId;
		this.primaryKeyType = CDataImpl.PRIMARY_KEY_IS_VARCHAR;
		getBolbValue(fieldName, outFile);
	}

	/**
	 * @roseuid 3C0455030221
	 */
	public boolean setSequence(String paraName, String sequenceFieldName,
			HttpServletRequest request) {
		boolean result = true;
		String sp = "", sv, id, sql;
		int l;

		if (paraName == null || sequenceFieldName == null || request == null)
			return false;
		if (paraName.equals("") || sequenceFieldName.equals(""))
			return false;

		l = paraName.length();

		Enumeration Enumeration = request.getParameterNames();
		dataCn.beginTrans();

		try {
			while (Enumeration.hasMoreElements()) {
				sp = (String) Enumeration.nextElement();
				if (sp.length() > l) {
					if (sp.substring(0, l).equals(paraName)) {
						id = sp.substring(l);
						sv = request.getParameter(sp);
						if (sv == null)
							sv = "0";
						if (sv.equals(""))
							sv = "0";
						if (this.primaryKeyType == CDataImpl.PRIMARY_KEY_IS_NUMBER) {
							sql = "UPDATE " + strTableName + " set "
									+ sequenceFieldName + " = " + sv
									+ " WHERE " + strPrimaryFieldName + " = "
									+ id;
						} else {
							sql = "UPDATE " + strTableName + " set "
									+ sequenceFieldName + " = " + sv
									+ " WHERE " + strPrimaryFieldName + " = '"
									+ id + "'";
						}
						System.out.print(sql);
						executeUpdate(sql);
					}
				}
			}
		} catch (Exception ex) {
			dataCn
					.raise(
							ex,
							"排序时出错！",
							"CDataImpl:setSequence(String paraName, String sequenceFieldName, HttpServletRequest request)");
			result = false;
		}
		if (result)
			dataCn.commitTrans();
		else
			dataCn.rollbackTrans();
		return result;
	}

	/**
	 * @roseuid 3C0CB9D60315
	 */
	public boolean hasSameCode(String code, String codeFieldName, long id) {
		/*
		 * String sql; boolean t = false; if (code == null ) return false; if
		 * (code.equals("")) return false;
		 * 
		 * if (id > 0){ sql = "SELECT * FROM " + strTableName + " WHERE " +
		 * strPrimaryFieldName + " <> " + id + " and " + codeFieldName + " = '" +
		 * code + "'"; }else{ sql = "SELECT * FROM " + strTableName + " WHERE " +
		 * codeFieldName + " = '" + code + "'"; } try{ if (executeUpdate(sql) >
		 * 0 ) { t = true; }else{ t = false; } }catch(Exception ex){
		 * raise(ex,"判断是否有相同代码时出错！","hasSameCode"); t = false; } //closeStmt();
		 * return t;
		 */
		return hasSameValue(code, codeFieldName, id);
	}

	/**
	 * Method:hasSameValue(String value, String fieldName, long id) Description:
	 * 判断是否有相同的值
	 * 
	 * @param code
	 * @param codeFieldName
	 * @param id
	 * @return
	 */
	public boolean hasSameValue(String value, String fieldName, long id) {
		String sql;
		boolean t = false;
		if (value == null)
			return false;
		if (value.equals(""))
			return false;

		if (id > 0) {
			sql = "SELECT * FROM " + strTableName + " WHERE "
					+ strPrimaryFieldName + " <> " + id + " and " + fieldName
					+ " = '" + value + "'";
		} else {
			sql = "SELECT * FROM " + strTableName + " WHERE " + fieldName
					+ " = '" + value + "'";
		}
		try {
			if (executeUpdate(sql) > 0) {
				t = true;
			} else {
				t = false;
			}
		} catch (Exception ex) {
			dataCn
					.raise(ex, "判断是否有相同代码时出错！",
							"CDataImpl:hasSameValue(String value, String fieldName, long id)");
			t = false;
		}
		// closeStmt();
		return t;
	}

	/**
	 * @roseuid 3C0CB9D90143
	 */
	public boolean hasSubObject(String tableName, String parentIdFieldName,
			long id) {
		setTableName(tableName);
		return hasSubObject(parentIdFieldName, id);
	}

	public boolean hasSubObject(String parentIdFieldName, long id) {
		String sql;
		boolean t = false;
		if (id < 0)
			return false;
		sql = "SELECT * FROM " + strTableName + " WHERE " + parentIdFieldName
				+ " = " + id;
		try {
			if (executeUpdate(sql) > 0) {
				t = true;
			} else {
				t = false;
			}
		} catch (Exception ex) {
			dataCn
					.raise(ex, "判断是否子对象时出错！",
							"CDataImpl:hasSubObject(String tableName,String parentIdFieldName, long id)");
			t = false;
		}
		// closeStmt();
		return t;
	}

	/**
	 * @roseuid 3BF1FE6402FB
	 */

	public Vector splitPage(HttpServletRequest request) {
		Pattern pattern = Pattern.compile("[0-9]*");
		String strPage = request.getParameter("strPage"); // 获取变量
		if (strPage == null || strPage.equals(""))
			strPage = "1";
		if (strPage != null || !strPage.equals("")) {
			if (!pattern.matcher(strPage).matches())
				strPage = "1";
		}
		setPageNo(Integer.parseInt(strPage)); // 设置当前的页数

		if (page == 0) // 默认当前页为1
			page = 1;

		if (pageSize == 0) // 默认当前每页显示数目20
			pageSize = 20;

		if (pageSql == null || pageSql.equals("")) // 如果没有对sql语句赋值，返回空
			return null;

		createRsPage(pageSql); // 创建rsPage对象
		return getVectorCurrentPage(); // 返回当前页面的Vector
	}

	/**
	 * 
	 * 
	 * @param sql
	 * @param intPageSize
	 * @param intPage
	 * @return
	 */
	public Vector splitPage(String sql, int intPageSize, int intPage) {
		setSql(sql); // 设置当前sql语句
		setPageNo(intPage); // 设置当前的页数
		setPageSize(intPageSize); // 设置每页显示的数量
		createRsPage(pageSql); // 创建rsPage对象
		return getVectorCurrentPage(); // 返回当前页面的Vector
	}

	public Vector splitPage(String sql, HttpServletRequest request) {
		setSql(sql); // 设置当前的sql语句
		return splitPage(request); // 返回当前页面的Vector
	}

	public Vector splitPage(String sql, HttpServletRequest request,
			int intPageSize) {
		setPageSize(intPageSize); // 设置当前页数
		return splitPage(sql, request); // 返回当前页面的Vector
	}

	/**
	 * 
	 * 
	 * @param sql
	 * @param intPageSize
	 * @param intPage
	 * @return
	 */
	public Vector splitPageOpt(String sql, int intPageSize, int intPage) {
		setSql(sql); // 设置当前sql语句
		setPageNo(intPage); // 设置当前的页数
		setPageSize(intPageSize); // 设置每页显示的数量
		createRsPageOpt(pageSql); // 创建rsPage对象
		return getVectorCurrentPageOpt(); // 返回当前页面的Vector
	}

	public Vector splitPageOpt(String sql, HttpServletRequest request) {
		setSql(sql); // 设置当前的sql语句
		return splitPageOpt(request); // 返回当前页面的Vector
	}

	public Vector splitPageOpt(HttpServletRequest request) {
		Pattern pattern = Pattern.compile("[0-9]*");
		String strPage = request.getParameter("strPage"); // 获取变量
		if (strPage == null || strPage.equals(""))
			strPage = "1";
		if (strPage != null || !strPage.equals("")) {
			if (!pattern.matcher(strPage).matches())
				strPage = "1";
		}
		setPageNo(Integer.parseInt(strPage)); // 设置当前的页数

		if (page == 0) // 默认当前页为1
			page = 1;

		if (pageSize == 0) // 默认当前每页显示数目20
			pageSize = 20;

		if (pageSql == null || pageSql.equals("")) // 如果没有对sql语句赋值，返回空
			return null;

		createRsPageOpt(pageSql); // 创建rsPage对象
		return getVectorCurrentPageOpt(); // 返回当前页面的Vector
	}

	private Vector getVectorCurrentPageOpt() {
		try {
			Vector CurrentPage = new Vector(); // 当前页的Vector对象
			int i = 0; // 当前数据库指针的偏移量

			if (rowCount == 0) // 如果没有记录，返回空
				return null;

			while (rsPage.next()) {
				Hashtable perRow = new Hashtable();
				for (int k = 1; k <= numCols; k++) {
					// if(rsPage.getString(k)!=null &&
					// !rsPage.getString(k).equals(""))
					if (rsPage.getObject(k) != null
							&& !rsPage.getObject(k).toString().equals("")) {
						if (rsmd.getColumnTypeName(k).toLowerCase().equals(
								"clob")) {
							perRow.put(rsmd.getColumnName(k).toLowerCase(),
									CTools.ClobToString(rsPage.getClob(k))); // 为了处理CLOB
						} else {
							perRow.put(rsmd.getColumnName(k).toLowerCase(),
									rsPage.getObject(k));
						}

						// perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getObject(k).toString());
						// perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getString(k));
						// System.out.println(rsPage.getString(k));
						// perRow.put(rsmd.getColumnName(k).toLowerCase(),"中文");
					} else {
						perRow.put(rsmd.getColumnName(k).toLowerCase(), "");
					}
				}

				CurrentPage.addElement(perRow);

				i++;
			}
			/*
			 * 测试用例 Hashtable perRow = new Hashtable();
			 * perRow.put("sj_id","12"); perRow.put("sj_name"," 中文");
			 * CurrentPage.addElement(perRow);
			 */
			return CurrentPage; // 返回Vector对象
		} catch (Exception e) {
			// System.out.println("返回当前页的Vector对象时候出错，具体内容："+e);
			dataCn.raise(e, "返回当前页的Vector对象时候出错",
					"CDataImpl:getVectorCurrentPageOpt()");
			return null;
		}
	}

	public Vector splitPageOpt(String sql, HttpServletRequest request,
			int intPageSize) {
		setPageSize(intPageSize); // 设置当前页数
		return splitPageOpt(sql, request); // 返回当前页面的Vector
	}

	/**
	 * Description:创建rsPage对象，初始化相关的一些变量
	 * 
	 * @param sql
	 *            需要的sql语句
	 */
	private void createRsPageOpt(String sql) {
		int intRecordIndex = 0;
		String strSql = "";
		try {
			setRowCountOpt(sql); // 设置当前记录总数
			setPageCount(); // 设置当前的总页数
			intRecordIndex = (this.page - 1) * this.pageSize + 1;
			pageSql = sql; // 设置当前页面的SQL语句
			strSql = "select * from (select rownum rmn,t.* from (" + sql
					+ ") t where rownum<" + (intRecordIndex + pageSize)
					+ ") where rmn>=" + (intRecordIndex);
			rsPage = executeQuery(strSql); // 直接获取Rs对象
			// Statement stmta =
			// cn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_UPDATABLE);
			// rsPage = stmta.executeQuery(sql);
			setRsmd(); // 设置当前记录集中的列标题
			setNumCols(); // 设置总记录集中的列数
		} catch (Exception e) {
			// System.out.println(e);
			dataCn.raise(e, "创建rsPage对象时出错",
					"CDataImpl:createRsPage(String sql)");
		}
	}

	/**
	 * Description:创建rsPage对象，初始化相关的一些变量
	 * 
	 * @param sql
	 *            需要的sql语句
	 */
	private void createRsPage(String sql) {
		try {
			pageSql = sql; // 设置当前页面的SQL语句
			rsPage = executeQuery(sql); // 直接获取Rs对象
			// Statement stmta =
			// cn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_UPDATABLE);
			// rsPage = stmta.executeQuery(sql);
			setRowCount(); // 设置当前记录总数
			setPageCount(); // 设置当前的总页数
			setRsmd(); // 设置当前记录集中的列标题
			setNumCols(); // 设置总记录集中的列数
		} catch (Exception e) {
			// System.out.println(e);
			dataCn.raise(e, "创建rsPage对象时出错",
					"CDataImpl:createRsPage(String sql)");
		}
	}

	private void setRowCountOpt(String sql) {
		String RowSql = "";
		ResultSet rsCount = null;
		RowSql = "select count(*) as TotalCount from (" + sql + ")";
		try {
			rsCount = executeQuery(RowSql);
			while (rsCount.next()) {
				rowCount = rsCount.getInt("TotalCount");
			}
		} catch (Exception e) {

		}
	}

	/**
	 * Description:设置当前的页数
	 * 
	 * @param intPage
	 *            页数
	 */
	public void setPageNo(int intPage) {
		this.page = intPage;
	}

	/**
	 * Description:设置记录总数
	 */
	private void setRowCount() {
		try {
			rsPage.last(); // 记录指针移动到最后
			rowCount = rsPage.getRow();
			// rsPage.first(); //记录指针移动到第一
			rsPage.beforeFirst(); // 记录指针移动到最前面
		} catch (Exception e) {
			// System.out.println(e);
			dataCn.raise(e, "设置记录总数时候出错", "CDataImpl:setRowCount()");
		}
	}

	/**
	 * Description:设置页面总页数
	 */
	private void setPageCount() {
		pageCount = (this.rowCount + this.pageSize - 1) / this.pageSize;
	}

	/**
	 * Method: setRsmd() Description: 设置当前记录集中的列标题
	 */
	private void setRsmd() {
		try {
			rsmd = rsPage.getMetaData(); // 获得ResultSetMetaData，用于列标题
		} catch (Exception e) {
			// System.out.println("设置记录集中的列标题出错，具体内容：" + e);
			dataCn.raise(e, "设置记录集中的列标题出错", "CDataImpl:setRsmd()");
		}
	}

	/**
	 * Method: setNumCols() Description: 设置总记录集中的列数
	 */
	private void setNumCols() {
		try {
			numCols = rsmd.getColumnCount();
		} catch (Exception e) {
			// System.out.println("设置总记录集中的列数出错，具体内容：" + e);
			dataCn.raise(e, "设置总记录集中的列数出错", "CDataImpl:setNumCols()");
		}
	}

	/**
	 * Method:getVectorCurrentPage() Description:返回当前页的Vector对象
	 * 
	 * @return Vector
	 */
	private Vector getVectorCurrentPage() {
		try {
			Vector CurrentPage = new Vector(); // 当前页的Vector对象
			int i = 0; // 当前数据库指针的偏移量

			if (rowCount == 0) // 如果没有记录，返回空
				return null;

			rsPage.absolute((page - 1) * pageSize + 1); // 定位记录

			while (i < pageSize && !rsPage.isAfterLast()) {
				Hashtable perRow = new Hashtable();
				for (int k = 1; k <= numCols; k++) {
					// if(rsPage.getString(k)!=null &&
					// !rsPage.getString(k).equals(""))
					if (rsPage.getObject(k) != null
							&& !rsPage.getObject(k).toString().equals("")) {
						if (rsmd.getColumnTypeName(k).toLowerCase().equals(
								"clob")) {
							perRow.put(rsmd.getColumnName(k).toLowerCase(),
									CTools.ClobToString(rsPage.getClob(k))); // 为了处理CLOB
						} else {
							perRow.put(rsmd.getColumnName(k).toLowerCase(),
									rsPage.getObject(k));
						}

						// perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getObject(k).toString());
						// perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getString(k));
						// System.out.println(rsPage.getString(k));
						// perRow.put(rsmd.getColumnName(k).toLowerCase(),"中文");
					} else {
						perRow.put(rsmd.getColumnName(k).toLowerCase(), "");
					}
				}

				CurrentPage.addElement(perRow);

				rsPage.next();
				i++;
			}
			/*
			 * 测试用例 Hashtable perRow = new Hashtable();
			 * perRow.put("sj_id","12"); perRow.put("sj_name"," 中文");
			 * CurrentPage.addElement(perRow);
			 */
			return CurrentPage; // 返回Vector对象
		} catch (Exception e) {
			// System.out.println("返回当前页的Vector对象时候出错，具体内容："+e);
			dataCn.raise(e, "返回当前页的Vector对象时候出错",
					"CDataImpl:getVectorCurrentPage()");
			return null;
		}
	}

	/**
	 * Method:getVector() Description:返回完整的Vector对象
	 * 
	 * @return Vector
	 */
	/*
	 * private Vector getVector(String sql) { try{ rsPage = executeQuery(sql); //
	 * 直接获取Rs对象 setRsmd(); //设置当前记录集中的列标题 setNumCols(); //设置总记录集中的列数 Vector
	 * CurrentPage = new Vector(); //当前页的Vector对象
	 * 
	 * if(rowCount == 0) //如果没有记录，返回空 return null;
	 * 
	 * //rsPage.absolute((page-1) * pageSize + 1); //定位记录
	 * 
	 * while(rsPage.next()){
	 * 
	 * Hashtable perRow = new Hashtable(); for(int k=1; k<=numCols; k++) {
	 * //if(rsPage.getString(k)!=null && !rsPage.getString(k).equals(""))
	 * if(rsPage.getObject(k)!=null &&
	 * !rsPage.getObject(k).toString().equals("")) {
	 * perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getObject(k)); //
	 * 为了处理CLOB
	 * //perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getObject(k).toString());
	 * //perRow.put(rsmd.getColumnName(k).toLowerCase(),rsPage.getString(k));
	 * //System.out.println(rsPage.getString(k));
	 * //perRow.put(rsmd.getColumnName(k).toLowerCase(),"中文"); } else {
	 * perRow.put(rsmd.getColumnName(k).toLowerCase(),""); } }
	 * 
	 * CurrentPage.addElement(perRow); rsPage.next(); } return CurrentPage;
	 * //返回Vector对象 } catch(Exception e) {
	 * System.out.println("返回当前页的Vector对象时候出错，具体内容："+e); return null; } }
	 */

	/**
	 * @roseuid 3BF1FE640369
	 */

	/**
	 * Method: getTail(HttpServletRequest request) Description: 返回分页底部文件
	 * 
	 * @return String
	 */
	public String getTail(HttpServletRequest request) {
		if (pageUrl.equals(""))
			setPageUrl(request);// 初始化当前页面链接地址

		String tail = ""; // 底部文件需要返回的变量
		tail = "<script language=\"javascript\">";
		tail += "function docheck(formname)";
		tail += "{";
		tail += "if ( isNaN(formname.strPage.value) )";
		tail += "	{";
		tail += "	alert(\"转入页面必须为数字！\");";
		tail += "	formname.strPage.focus();";
		tail += "	return (false);";
		tail += "	}";
		tail += "if (formname.strPage.value > " + pageCount
				+ " || formname.strPage.value < 1)";
		tail += "	{";
		tail += "	alert(\"抱歉！你输入的页数不在查询对象的范围之内，请重新输入。\");";
		tail += "	formname.strPage.focus();";
		tail += "	return (false)";
		tail += "	}";
		tail += "return (true)";
		tail += "}";
		tail += "function dopage(strPage)";
		tail += "{";
		tail += "document.PageForm.strPage.value = strPage;";
		tail += "document.PageForm.submit()";
		tail += "}";
		tail += "</script>";
		tail += "<table width=\"100%\"><form action=\""
				+ pageUrl
				+ "\" method=\"post\" name=\"PageForm\" onsubmit=\"return docheck(this)\"><tr><td align=\"right\">";

		setInputContent(request); // 设置输入框的内容
		tail += inputContent; // 把输入框的内容加入到尾部文件中以其输出

		// tail += "<div align=\"right\">";
		// tail += "<table width=\"100%\" align=\"right\"><tr><td>";
		tail += "共有<span style=\"color:red\">" + rowCount + "</span>条匹配记录 ";

		if (page == 1) {
			tail += "<span style=\"color:silver\">第一页</span> ";
			tail += "<span style=\"color:silver\">上一页</span> ";
		}

		if (page > 1) {
			tail += "<a style=\"color:green\" href=\"javascript:dopage(1)\">第一页</a> ";
			tail += "<a style=\"color:green\" href=\"javascript:dopage("
					+ (page - 1) + ")\">上一页</a> ";
		}

		if (page < pageCount) {
			tail += "<a style=\"color:green\" href=\"javascript:dopage("
					+ (page + 1) + ")\">下一页</a> ";
			tail += "<a style=\"color:green\" href=\"javascript:dopage("
					+ pageCount + ")\">最后页</a> ";
		}

		if (page == pageCount) {
			tail += "<span style=\"color:silver\">下一页</span> ";
			tail += "<span style=\"color:silver\">最后页</span> ";
		}

		tail += "转到第<input style=\"background:transparent;border:0px solid white;border-bottom:1px solid black\" type=\"normal\" name=\"strPage\" size=\"1\">页 ";
		tail += "页数状态(<span style=\"color:red\">" + page + "/" + pageCount
				+ "</span>页)&nbsp; ";
		// tail += "</div>";
		tail += "</td></tr></form></table>";
		// tail += "</form>";

		return tail;
	}

	public String getNewTail(HttpServletRequest request) {
		if (pageUrl.equals(""))
			setPageUrl(request);// 初始化当前页面链接地址

		// System.out.println("page=" + page);

		String tail = ""; // 底部文件需要返回的变量
		// System.out.println(pageCount);
		if (pageCount > 1) {
			tail = "<script language=\"javascript\">";
			tail += "function docheck(formname)";
			tail += "{";
			tail += "if ( isNaN(formname.strPage.value) )";
			tail += "	{";
			tail += "	alert(\"转入页面必须为数字！\");";
			tail += "	formname.strPage.focus();";
			tail += "	return (false);";
			tail += "	}";
			tail += "if (formname.strPage.value > " + pageCount
					+ " || formname.strPage.value < 0)";
			tail += "	{";
			tail += "	alert(\"抱歉！你输入的页数不在查询对象的范围之内，请重新输入。\");";
			tail += "	formname.strPage.focus();";
			tail += "	return (false)";
			tail += "	}";
			tail += "return (true)";
			tail += "}";
			tail += "function dopage(strPage)";
			tail += "{";
			tail += "document.PageForm.strPage.value = strPage;";
			tail += "document.PageForm.submit()";
			tail += "}";
			tail += "</script>";
			tail += "<table border=\"0\" cellpadding=\"2\" cellspacing=\"0\" ><form action=\""
					+ pageUrl
					+ "\" method=\"post\" name=\"PageForm\" onsubmit=\"return docheck(this)\">";
			setInputContent(request);
			tail += inputContent; // 把输入框的内容加入到尾部文件中以其输出
			tail += "<tr><td>";
			tail += "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"2\">";
			tail += "<tr><td width=\"40\" align=\"center\" class=\"tail-font\">共&nbsp;"
					+ pageCount + "&nbsp;页</td>";
			tail += "<!--td width=\"1\"><img src=\"../images/tailDiv.gif\" width=\"1\" height=\"19\" /></td-->";
			tail += "<td width=\"2\"></td>";

			int tdcount = 1;
			if (page > 1) {
				tail += "<td align=\"left\" class=\"tail-font\"><a href=\"javascript:dopage(1)\" class=\"tail\">|&lt;</a></td>";
				tail += " <td align=\"left\" class=\"tail-font\"><a href=\"javascript:dopage("
						+ (page - 1) + ")\" class=\"tail\">&lt;</a></td>";
			}

			if (page == 1) {
				tail += "<td align=\"left\" class=\"tail-font\">|&lt;</td> ";
				tail += "<td align=\"left\" class=\"tail-font\">&lt;</td>";
			}

			if (page - 5 > 0) {
				for (int i = 5; i >= 1; i--) {
					tail += "<td width=\"15\" align=\"center\" class=\"tail-font\"><a href=\"javascript:dopage("
							+ (page - i)
							+ ")\" class=\"tail\">"
							+ (page - i)
							+ "</td>";
					tdcount++;
				}
			} else {
				for (int i = 1; i < page; i++) {
					tail += "<td width=\"15\" align=\"center\" class=\"tail-font\"><a href=\"javascript:dopage("
							+ (i) + ")\" class=\"tail\">" + i + "</td>";
					tdcount++;
				}
			}

			tail += "<td width=\"15\" align=\"center\" class=\"tail-selected\" href=\"><ajavascript:dopage("
					+ page + ")\" class=\"tail\">" + page + "</td>";

			if (page + 5 < pageCount) {

				if (page - 5 < 0) {
					if (pageCount > 10) {
						for (int i = 1; i <= 10 - page; i++) {
							tail += "<td width=\"15\" align=\"center\" class=\"tail-font\"><a href=\"javascript:dopage("
									+ (page + i)
									+ ")\" class=\"tail\">"
									+ (page + i) + "</td>";
							tdcount++;
						}
					} else {
						for (int i = 1; i <= pageCount - page; i++) {
							tail += "<td width=\"15\" align=\"center\" class=\"tail-font\"><a href=\"javascript:dopage("
									+ (page + i)
									+ ")\" class=\"tail\">"
									+ (page + i) + "</td>";
							tdcount++;
						}
					}
				} else {
					for (int i = 1; i <= 5; i++) {
						tail += "<td width=\"15\" align=\"center\" class=\"tail-font\"><a href=\"javascript:dopage("
								+ (page + i)
								+ ")\" class=\"tail\">"
								+ (page + i) + "</td>";
						tdcount++;
					}
				}

			} else {
				for (int i = 1; i <= pageCount - page; i++) {
					tail += "<td width=\"15\" align=\"center\" class=\"tail-font\"><a href=\"javascript:dopage("
							+ (page + i)
							+ ")\" class=\"tail\">"
							+ (page + i)
							+ "</td>";
					tdcount++;
				}
			}

			// for(;tdcount<=10;tdcount++){tail +="<td width=\"15\"
			// align=\"center\" class=\"tail-font\"></td>";}

			if (page < pageCount) {
				tail += "<td align=\"right\" class=\"tail-font\"><a class=\"tail\" href=\"javascript:dopage("
						+ (page + 1) + ")\">&gt;</a></td> ";
				tail += "<td align=\"right\" class=\"tail-font\"><a class=\"tail\" href=\"javascript:dopage("
						+ pageCount + ")\">&gt;|</a></td> ";
			}

			if (page == pageCount) {
				tail += "<td align=\"right\" class=\"tail-font\">&gt;</td> ";
				tail += "<td align=\"right\" class=\"tail-font\">&gt;|</td>";
			}

			tail += "</table></td></tr><input style=\"background:transparent;border:0px solid white;border-bottom:1px solid black\" type=\"hidden\" name=\"strPage\" size=\"1\"></form></table>";
		}

		return tail;

	}

	/**
	 * 英文版翻页
	 * 
	 * @param request
	 * @return
	 */
	public String getEnglishTail(HttpServletRequest request) {
		setPageUrl(request);
		String tail = "";
		tail = "<script language=\"javascript\">";
		tail = tail + "function docheck(formname)";
		tail = tail + "{";
		tail = tail + "if ( isNaN(formname.strPage.value) )";
		tail = tail + "\t{";
		tail = tail + "\talert(\"Need an integer number\uFF01\");";
		tail = tail + "\tformname.strPage.focus();";
		tail = tail + "\treturn (false);";
		tail = tail + "\t}";
		tail = tail + "if (formname.strPage.value > " + pageCount
				+ " || formname.strPage.value < 0)";
		tail = tail + "\t{";
		tail = tail
				+ "\talert(\"Sorry, the number you input is out of index.\");";
		tail = tail + "\tformname.strPage.focus();";
		tail = tail + "\treturn (false)";
		tail = tail + "\t}";
		tail = tail + "return (true)";
		tail = tail + "}";
		tail = tail + "function dopage(strPage)";
		tail = tail + "{";
		tail = tail + "document.PageForm.strPage.value = strPage;";
		tail = tail + "document.PageForm.submit()";
		tail = tail + "}";
		tail = tail + "</script>";
		tail = tail
				+ "<table width=\"100%\"><form action=\""
				+ pageUrl
				+ "\" method=\"post\" name=\"PageForm\" onsubmit=\"return docheck(this)\"><tr><td align=\"right\">";
		setInputContent(request);
		tail = tail + inputContent;
		tail = tail + "Total <span style=\"color:red\">" + rowCount
				+ "</span> records ";
		if (page == 1) {
			tail = tail
					+ "<span style=\"color:silver\"><img src=\"/englishweb/images/first.gif\" width=\"13\" height=\"9\" border=\"0\" title='First page'></span> ";
			tail = tail
					+ "<span style=\"color:silver\"><img src=\"/englishweb/images/prev.gif\" width=\"10\" height=\"9\" border=\"0\" title='Previous page'></span> ";
		}
		if (page > 1) {
			tail = tail
					+ "<a style=\"color:green\" href=\"javascript:dopage(1)\"><img src=\"/englishweb/images/first.gif\" width=\"13\" height=\"9\" border=\"0\" title='First page'></a> ";
			tail = tail
					+ "<a style=\"color:green\" href=\"javascript:dopage("
					+ (page - 1)
					+ ")\"><img src=\"/englishweb/images/prev.gif\" width=\"10\" height=\"9\" border=\"0\" title='Previous page'></a> ";
		}
		if (page < pageCount) {
			tail = tail
					+ "<a style=\"color:green\" href=\"javascript:dopage("
					+ (page + 1)
					+ ")\"><img src=\"/englishweb/images/next.gif\" width=\"10\" height=\"9\" border=\"0\" title='Next page'></a> ";
			tail = tail
					+ "<a style=\"color:green\" href=\"javascript:dopage("
					+ pageCount
					+ ")\"><img src=\"/englishweb/images/last.gif\" width=\"13\" height=\"9\" border=\"0\" title='Last page'></a> ";
		}
		if (page == pageCount) {
			tail = tail
					+ "<span style=\"color:silver\"><img src=\"/englishweb/images/next.gif\" width=\"10\" height=\"9\" border=\"0\" title='Next page'></span> ";
			tail = tail
					+ "<span style=\"color:silver\"><img src=\"/englishweb/images/last.gif\" width=\"13\" height=\"9\" border=\"0\" title='Last page'></span> ";
		}
		tail = tail
				+ " Go to page <input style=\"background:transparent;border:0px solid white;border-bottom:1px solid black\" type=\"normal\" name=\"strPage\" size=\"1\"> ";
		tail = tail + " (Page <span style=\"color:red\">" + page + " of "
				+ pageCount + "</span>)&nbsp; ";
		tail = tail + "</td></tr></form></table>";
		return tail;
	}

	/**
	 * Method:setPageUrl(HttpServletRequest request) Description:设置当前页面的链接地址
	 * 
	 * @param request
	 */
	private void setPageUrl(HttpServletRequest request) {
		pageUrl = request.getRequestURL().toString();
	}

	/**
	 * Method:getPageUrl() Description: 返回当前页面的链接地址
	 * 
	 * @return
	 */
	private String getPageUrl() {
		return pageUrl;
	}

	/**
	 * Method:setInputContent(HttpServletRequest request) Description:
	 * 设置输入框的中的内容
	 */
	private void setInputContent(HttpServletRequest request) {
		inputContent = ""; // 初识化为空
		Enumeration Enumeration = request.getParameterNames(); // 把所有的参数放入enum
		while (Enumeration.hasMoreElements()) {
			String paraName = (String) Enumeration.nextElement();
			String paraValue = (String) CTools.dealString(request
					.getParameter(paraName));
			if (!paraName.equals("strPage")) {
				inputContent += "<input type=\"hidden\" name=\"" + paraName
						+ "\" value=\"" + paraValue + "\">";
			}
		}
	}

	/**
	 * Method:getInputContent() Description: 获得输入框内容
	 * 
	 * @return inputContent
	 */
	private String getInputContent() {
		return inputContent;
	}

	/**
	 * @roseuid 3BF1FE6403D7
	 */

	public String getTail(HttpServletRequest request, int mode) {
		return "1";
	}

	/**
	 * @roseuid 3BF1FE650099
	 */
	public void setSql(String sql) {
		pageSql = sql;
	}

	/**
	 * @roseuid 3BF1FE650108
	 */
	public void setPageSize(int intPageSize) {
		pageSize = intPageSize;
	}

	/**
	 * @roseuid 3BF1FE650126
	 */

	public int getPageCount() {
		return pageCount;
	}

	/**
	 * @roseuid 3BF1FE65014E
	 */

	public long getRowCount() {
		return rowCount;
	}

	/**
	 * @roseuid 3BF1FE650176
	 */

	public int getPageNo() {
		return page;
	}

	/**
	 * 设置当前的ID
	 * 
	 * @param id
	 */
	public void setCurrentId(long id) {
		currentId = id;
	}

	public Hashtable getDataInfo() {
		try {
			if (pageSql == null || pageSql.equals(""))
				return null;
			else {
				rsPage = executeQuery(pageSql); // 直接获取Rs对象
				setRsmd(); // 设置当前记录集中的列标题
				setNumCols(); // 设置总记录集中的列数
				return getHashtablePage(); // 返回hashtable
			}
		} catch (Exception ex) {
			dataCn.raise(ex, "使用getDataInfo()出错", "CDataImpl:getDataInfo()");
			return null;
		}
	}

	/**
	 * @roseuid 3BFC9F5800F1
	 */

	public Hashtable getDataInfo(String sql) {
		if (sql == null || sql.equals(""))
			return null;
		else {
			setSql(sql); // 设置sql;
			return getDataInfo();
		}
	}

	public Hashtable getDataInfo(long id) {
		setCurrentId(id); // 设置当前的ID;
		/*
		 * 判断组合sql语句是否成功 如果成功，返回hastable 否则返回Null
		 */
		if (setSelectSql() == true) {
			return getDataInfo();
		} else {
			return null;
		}
	}

	/**
	 * 组合选择当前记录的语句
	 * 
	 * @return boolean 返回组合sql是否成功，主要是验证所有的变量是否全部设定
	 */
	public boolean setSelectSql() {
		if (strTableName == null || strPrimaryFieldName == null
				|| strTableName.equals("") || strPrimaryFieldName.equals("")
				|| currentId == 0)
			return false; // 没有设置完全所有的变量，返回错误
		else {
			pageSql = "select * from " + strTableName + " where "
					+ strPrimaryFieldName + " = " + Long.toString(currentId);
			return true;
		}
	}

	/**
	 * Method:getHashtablePage() Description:返回当前记录的Hashtable对象
	 * 
	 * @return Hashtable
	 */
	private Hashtable getHashtablePage() {
		try {
			Hashtable perRow = new Hashtable();
			if (rsPage.next()) {
				for (int k = 1; k <= numCols; k++) {
					if (rsPage.getObject(k) != null
							&& !rsPage.getObject(k).equals("")) {
						if (rsmd.getColumnTypeName(k).toLowerCase().equals(
								"clob")) {
							perRow.put(rsmd.getColumnName(k).toLowerCase(),
									CTools.ClobToString(rsPage.getClob(k))); // 为了处理CLOB
						} else {
							perRow.put(rsmd.getColumnName(k).toLowerCase(),
									rsPage.getObject(k));
						}
					} else {
						perRow.put(rsmd.getColumnName(k).toLowerCase(), "");
					}
				}
				return perRow;
			} else {
				return null;
			}
		}

		catch (Exception ex) {
			dataCn.raise(ex, "返回当前页的Hashtable对象时候出错",
					"CDataImpl:getHashtablePage()");
			return null;
		}
	}

	public String getInitParameter(String paramName) {
		try {
			ResultSet rsParam;
			Statement stmtParam = dataCn.getConnection().createStatement();
			String paramValue = "";
			paramName = paramName.toLowerCase(); // 转换为小写
			String strSql = "select IP_value from tb_initparameter where IP_name = '"
					+ paramName + "'";
			// rsParam = executeQuery(strSql); //执行sql语句，选出需要的记录集
			rsParam = stmtParam.executeQuery(strSql); // 执行sql语句，选出需要的记录集

			if (rsParam.next()) {
				paramValue = rsParam.getString(1); // 如果发现记录，返回值
			}

			rsParam.close();
			stmtParam.close();
			return paramValue;
		} catch (Exception ex) {
			dataCn.raise(ex, "获取系统参数错误",
					"CDataImpl:getInitParameter(String paramName)");
			return "";
		}
	}

	public void setPrimaryKeyType(int pPrimaryKeyType) {
		this.primaryKeyType = pPrimaryKeyType;
	}

	public static void main(String[] args) {
		// try
		// {
		/*
		 * 演示新增、编辑 CDataImpl x = new CDataImpl(); //x.edit("test","t_id",58);
		 * x.addNew("test","t_id");
		 * x.setValue("name","可编辑的数据",CDataImpl.STRING); x.update();
		 */
		/*
		 * CDataImpl x = new CDataImpl(); x.edit("tb_subject","sj_id",66);
		 * x.setValue("sj_name","tangli",CDataImpl.STRING);
		 * x.setValue("sj_parentid","1",CDataImpl.INT);
		 * x.setValue("sj_counseling_flag","1",CDataImpl.INT);
		 * x.setValue("sj_create_time","2002-3-2",CDataImpl.DATE); x.update();
		 */

		// x.delete("test","t_id",59); //删除一条记录
		// 演示分页
		/*
		 * CDataImpl x = new CDataImpl(); System.out.println("<table
		 * width=\"500\">"); System.out.println("<tr class=\"line-title\"><td>模块内容</td></tr>");
		 * Vector vectorPage = x.splitPage("select * from tb_subject",6,1);
		 * for(int j=0;j<vectorPage.size();j++) { Hashtable content =
		 * (Hashtable)vectorPage.get(j); if(j % 2 == 0) { System.out.println("<tr class=\"line-even\">"); }
		 * else { System.out.println("<tr class=\"line-odd\">"); }
		 * System.out.println("<td colspan=\"100\">" + content.get("sj_id") +
		 * "、" + content.get("sj_name") + "</td></tr>");
		 *  }
		 * 
		 * System.out.println("</table>");
		 */

		// 演示插入Clob值
		/*
		 * CDataImpl x = new CDataImpl(); //x.setClobValue("test",)
		 * x.setClobValue("test","t_id",10,"name","aa");
		 * 
		 * x = null;
		 */

		// 演示返回getDataInfo
		/*
		 * CDataImpl x = new CDataImpl(); //Hashtable bb = x.getDataInfo("select *
		 * from tb_subject"); //测试通过传入sql语句返回内容
		 * 
		 * //测试通过传入id返回内容 x.setTableName("tb_subject");
		 * x.setPrimaryFieldName("sj_id"); Hashtable bb = x.getDataInfo(60);
		 * System.out.println(bb.get("sj_url").toString() + "++");
		 */

		/*
		 * //测试isRepeat CDataImpl x = new CDataImpl();
		 * //System.out.println(x.isRepeat("tb_function","ft_code","newsSearch"));
		 * x.addNew("tb_function","ft_id");
		 * System.out.println(x.isRepeat("ft_code",""));
		 */

		/*
		 * //测试获取系统参数 CDataImpl dImpl = new CDataImpl(); String attach_save_path =
		 * dImpl.getInitParameter("attach_save_path"); //获取
		 * System.out.println(attach_save_path);
		 */

		/*
		 * //测试插入blob数据 CDataCn dCn = new CDataCn(); CDataImpl dImpl = new
		 * CDataImpl(dCn); File file = new File("d:\\test.rar");
		 * dCn.beginTrans();
		 * dImpl.addNew("test_attach","id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		 * dImpl.update(); dImpl.setBlobValue("BLOBCOL",file);
		 * dCn.commitTrans();
		 */

		// 测试按照插入blob数据
		/*
		 * try { CDataCn dCn = new CDataCn(); CDataImpl dImpl = new
		 * CDataImpl(dCn); FileInputStream in = new
		 * FileInputStream("d:\\test.rar");
		 * 
		 * dCn.beginTrans();
		 * dImpl.addNew("test_attach","id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		 * dImpl.update(); dImpl.setBlobValue("BLOBCOL",CDataImpl.getBytes(in));
		 * dCn.commitTrans(); }catch(Exception ex) {
		 *  }
		 */

		// 测试获取blob数据
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		// File file = new File("e:\\books.xml");
		dCn.beginTrans();

		dImpl.addNew("tb_frontinfo", "fi_id", CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		dImpl.setValue("fi_title", "sssss", CDataImpl.STRING);// 栏目名称
		dImpl.setValue("fi_url", "sss", CDataImpl.STRING);// 栏目代码
		dImpl.setValue("fi_sequence", "", CDataImpl.STRING);// 上级栏目代码
		dImpl.setValue("fi_content", "aaa", CDataImpl.STRING);// 上级栏目代码
		dImpl.setValue("fi_img", "", CDataImpl.STRING);// 上级栏目代码
		dImpl.setValue("fs_id", "o1", CDataImpl.STRING);// 上级栏目代码
		dImpl.setValue("fi_type", "", CDataImpl.STRING);// 上级栏目代码
		dImpl.update();

		if (dCn.getLastErrString().equals(""))
			dCn.commitTrans();
		else
			dCn.rollbackTrans();

		// }
		// catch(Exception ex)
		// {
		// System.out.println(ex);
		// }

	}

	public static byte[] getBytes(InputStream inStream)
			throws java.io.IOException {
		byte[] lBytes = new byte[inStream.available()];

		inStream.read(lBytes);

		return lBytes;
	}
}
