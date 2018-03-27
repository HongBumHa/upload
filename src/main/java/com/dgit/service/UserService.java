package com.dgit.service;

import com.dgit.domain.UserVO;

public interface UserService {
	public UserVO readWithpw(String id, String pw);
	public UserVO readWithId(String id);
	public void create(UserVO vo);
}
