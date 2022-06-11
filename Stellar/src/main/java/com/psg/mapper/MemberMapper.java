package com.psg.mapper;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.psg.vo.MemberVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("MemberMapper")
public interface MemberMapper {

	void register(MemberVO vo) throws Exception;
	
	int DupIdChk(String loginId) throws Exception;
	
	int Number_Member() throws Exception;
	
	MemberVO selectUserInfoOne(String username) throws Exception;
	
	List<String> selectUserAuthOne(String username) throws Exception;
	
	ArrayList<MemberVO> memberList() throws Exception;
	
	ArrayList<String> memberNotRestList(@Param("start")String start, @Param("end")String end) throws Exception;
	
	ArrayList<MemberVO> memberRest() throws Exception;
	
	void updateRole(@Param("username")String username, @Param("auth")String auth) throws Exception;
	
	void Username_Update(@Param("username") String username, @Param("old_username") String old_username) throws Exception;
}
