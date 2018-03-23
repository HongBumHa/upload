package com.dgit.domain;

import java.util.Arrays;
import java.util.Date;

public class PhotoVO {
	private int pno;
	private String id;
	private String[] filename;
	private Date regdate;
	public PhotoVO() {
		super();
	}
	@Override
	public String toString() {
		return "PhotoVO [pno=" + pno + ", id=" + id + ", filename=" + Arrays.toString(filename) + ", regdate=" + regdate
				+ "]";
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
	public String[] getFilename() {
		return filename;
	}
	public void setFilename(String[] filename) {
		this.filename = filename;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
}
