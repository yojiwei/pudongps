/**
 * @(#)Text1.java
 *
 *
 * @author 
 * @version 1.00 2007/9/11
 */
package com.mobile;
public class MobileNoteDaoImpl extends SubCDataImpl implements MobileNoteDao {

    public MobileNoteDaoImpl() {
    }

	public void delete(String id) throws SubjectChangeException {
		String sql="delete from table where id="+id;
		executeUpdate(sql);
		// TODO Auto-generated method stub
		
	}

	public void insert(MobileNoteForm form) throws SubjectChangeException {
		String sql="insert into table() values('""')";
		executeUpdate(sql);
		// TODO Auto-generated method stub
		
	}
    
    
}