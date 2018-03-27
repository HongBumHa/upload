package com.dgit.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgit.domain.UserVO;
import com.dgit.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	public UserDAO dao;

	@Override
	public UserVO readWithpw(String id, String pw) {
		return dao.selectByUser(id, pw);
	}

	@Override
	public void create(UserVO vo) {
		dao.insert(vo);
	}

	@Override
	public UserVO readWithId(String id) {
		return dao.selectById(id);
	}
	
}
