package com.dgit.persistance;

import com.dgit.domain.UserVO;

public interface UserDAO {
	public UserVO selectByUser(String id, String pw);
	public void insert(UserVO vo);
	
}
