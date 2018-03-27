package com.dgit.domain;

import java.util.Arrays;
import java.util.Date;

public class PhotoVO {
	private int pno;
	private String id;
	private String fullName;
	private Date regdate;
	public PhotoVO() {
		super();
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "PhotoVO [pno=" + pno + ", id=" + id + ", fullName=" + fullName + ", regdate=" + regdate + "]";
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
}
