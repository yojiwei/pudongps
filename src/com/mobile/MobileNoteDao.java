/**
 * @(#)MobileNoteDao.java
 *
 *
 * @author 
 * @version 1.00 2007/9/11
 */
package com.mobile;

public interface MobileNoteDao {
	public void insert(MobileNoteForm form) throws SubjectChangeException;
    public void delete(String id) throws SubjectChangeException;
    
}