package com.dgit.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dgit.domain.PhotoVO;

@Repository
public class PhotoDAOImpl implements PhotoDAO {
	private static final String namespace = "com.dgit.mapper.PhotoMapper";
	@Autowired
	public SqlSession session;

	@Override
	public List<PhotoVO> selectByid(String id) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".selectByid",id);
	}

	@Override
	public void insert(String id, String fullName) {
		HashMap<String,Object> map = new HashMap<>();
		map.put("id",id);
		map.put("fullName",fullName);
		session.insert(namespace+".insert",map);

	}

	@Override
	public void delete(String id, String fullName) {
		HashMap<String,Object> map = new HashMap<>();
		map.put("id",id);
		map.put("fullName",fullName);
		session.delete(namespace+".delete",map);
	}

}
