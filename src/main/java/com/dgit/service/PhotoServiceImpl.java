package com.dgit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.PhotoVO;
import com.dgit.persistence.PhotoDAO;

@Service
public class PhotoServiceImpl implements PhotoService {
	@Autowired
	private PhotoDAO dao;
	@Override
	public List<PhotoVO> selectByid(String id) {
		// TODO Auto-generated method stub
		return dao.selectByid(id);
	}

	@Override
	public void insert(String id, String fullName) {
		dao.insert(id,fullName);

	}

	@Override
	public void delete(String id, String fullName) {
		dao.delete(id, fullName);
	}

}
