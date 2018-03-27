package com.dgit.persistence;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {
	private static final String namespace = "com.dgit.mapper.UserMapper";
	@Autowired
	public SqlSession session;
	@Override
	public UserVO selectByUser(String id, String pw) {
		HashMap<String,Object> map = new HashMap<>();
		map.put("id", id);
		map.put("password", pw);
		return session.selectOne(namespace+".selectByUser",map);
	}

	@Override
	public void insert(UserVO vo) {
		session.insert(namespace+".insert",vo);
	}

	@Override
	public UserVO selectById(String id) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".selectById",id);
	}
}
