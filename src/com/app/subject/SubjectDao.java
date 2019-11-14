package com.app.subject;

import com.beyondbit.web.form.SubjectForm;


public interface SubjectDao {
	
	public SubjectForm load(String id) throws SubjectChangeException;

}
