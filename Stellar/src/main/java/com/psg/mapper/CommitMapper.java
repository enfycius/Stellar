package com.psg.mapper;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.psg.vo.GithubVO;
import com.psg.vo.KakaoVO;
import com.psg.vo.RestVO;
import com.psg.vo.SlackVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("CommitMapper")
public interface CommitMapper {
	
	int Count_Commit_Today() throws Exception;
	
	int Count_Commit_Weekly() throws Exception;
	
	int Count_Commit_Monthly() throws Exception;
	
	int Count_Github_Info() throws Exception;
	
	int DupSlackChk(String slack_name) throws Exception;
	
	int DupGithubChk(@Param("github_name") String github_name, @Param("github_repo") String github_repo, @Param("github_token") String github_token) throws Exception;
	
	int DupKakaoChk(String kakao_name) throws Exception;
	
	int DupRestChk(@Param("kakao_name") String kakao_name, @Param("start_date") Date start_date, @Param("end_date") Date end_date) throws Exception;
	
	int ExistKakaoChk(String username) throws Exception;
	
	ArrayList<RestVO> get_rest() throws Exception;
	
	ArrayList<KakaoVO> get_kakao() throws Exception;
	
	ArrayList<RestVO> get_member_rest(String username) throws Exception;
	
	ArrayList<GithubVO> get_github_info(String username) throws Exception;
	
	String get_username_github_info(String github_username) throws Exception;
	
	ArrayList<GithubVO> get_all_github_info() throws Exception;
	
	ArrayList<SlackVO> get_slack_info(String username) throws Exception;
	
	String get_kakao_info(String username) throws Exception;
	
	String get_kakao_info_github(String github_name) throws Exception;
	
	void delete_rest(@Param("username") String username, @Param("start_date") Date start_date, @Param("end_date") Date end_date) throws Exception;
	
	void put_rest(@Param("kakao_name") String kakao_name, @Param("start_date") Date start_date, @Param("end_date") Date end_date) throws Exception;
	
	void delete_slack_info(@Param("username") String username, @Param("slack_name") String slack_name) throws Exception;
	
	void put_slack_info(@Param("username") String username, @Param("slack_name") String slack_name) throws Exception;	
	
	void delete_github_info(@Param("username") String username, @Param("github_name") String github_name, @Param("github_repo") String github_repo, @Param("github_token") String github_token) throws Exception;
	
	void put_github_info(@Param("username") String username, @Param("github_name") String github_name, @Param("github_repo") String github_repo, @Param("github_token") String github_token) throws Exception;
	
	void delete_kakao_info(@Param("username") String username, @Param("kakao_name") String kakao_name) throws Exception;
	
	void put_kakao_info(@Param("username") String username, @Param("kakao_name") String kakao_name) throws Exception;
	
	void update_kakao_info(@Param("username") String username, @Param("kakao_name") String kakao_name) throws Exception;
}
