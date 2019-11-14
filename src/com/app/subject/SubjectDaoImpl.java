package com.app.subject;

import com.beyondbit.web.form.SubjectForm;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SubjectDaoImpl extends SubCDataImpl implements SubjectDao {

	public SubjectForm load(String id) throws SubjectChangeException {
		// TODO Auto-generated method stub
		SubjectForm form = new SubjectForm();
		String sql = "select sj_id,sj_name,sj_parentid from tb_subject where sj_id='" + id + "'";
		ResultSet rs = dImpl.executeQuery(sql);
		try {
			if(rs.next()) {
				form.setSjId(rs.getString("sj_id"));
				form.setName(rs.getString("sj_name"));
				form.setParentid(rs.getString("sj_parentid"));
			}
			return form;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new SubjectChangeException("load() is error");
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
