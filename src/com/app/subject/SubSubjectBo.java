package com.app.subject;

public interface SubSubjectBo {

	public void addChange(String modelids) throws SubjectChangeException;
	public void updateChage(String modelids) throws SubjectChangeException;
	public void delChange(String modelids) throws SubjectChangeException;
}
