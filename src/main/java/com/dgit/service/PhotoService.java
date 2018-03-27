package com.dgit.service;

import java.util.List;

import com.dgit.domain.PhotoVO;

public interface PhotoService {
	public List<PhotoVO> selectByid(String id);
	public void insert(String id, String fullName);
	public void delete(String id, String fullName);
}
