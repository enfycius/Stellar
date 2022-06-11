package com.psg.service;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.security.core.userdetails.UserDetails;

import com.psg.vo.GithubVO;
import com.psg.vo.KakaoVO;
import com.psg.vo.MemberVO;
import com.psg.vo.RestVO;
import com.psg.vo.SlackVO;

public interface MemberService {

	public boolean register(MemberVO vo) throws Exception;
	
	public int Count_Commit_Today() throws Exception;
	
	public int Count_Commit_Weekly() throws Exception;
	
	public int Count_Commit_Monthly() throws Exception;
	
	public int DupIdChk(String loginId) throws Exception;
	
	public int Number_Member() throws Exception;
	
	public int DupSlackChk(String slack_name) throws Exception;
	
	public int DupGithubChk(String github_name, String github_repo, String github_token) throws Exception;
	
	public int DupKakaoChk(String kakao_name) throws Exception;
	
	public int DupRestChk(String kakao_name, Date start_date, Date end_date) throws Exception;
	
	public int ExistKakaoChk(String username) throws Exception;
	
	public UserDetails loadUserByUsername(String inputUserId) throws Exception;
	
	public ArrayList<MemberVO> memberList() throws Exception;
	
	public ArrayList<RestVO> get_rest() throws Exception;
	
	public ArrayList<KakaoVO> get_kakao() throws Exception;
	
	public ArrayList<RestVO> get_member_rest(String username) throws Exception;
	
	public ArrayList<GithubVO> get_github_info(String username) throws Exception;
	
	public ArrayList<SlackVO> get_slack_info(String username) throws Exception;
	
	public String get_kakao_info(String username) throws Exception;
	
	public String get_kakao_info_github(String github_name) throws Exception;
	
 	public void updateRole(String username, String auth) throws Exception;
 	
 	public void Username_Update(String username, String old_username) throws Exception;
 	
 	public void delete_rest(String username, Date start_date, Date end_date) throws Exception;
 	
 	public void put_rest(String kakao_name, Date start_date, Date end_date) throws Exception;
 	
	public void delete_slack_info(String username, String slack_name) throws Exception;
	
	public void put_slack_info(String username, String slack_name) throws Exception;
	
	public void delete_github_info(String username, String github_name, String github_repo, String github_token) throws Exception;
	
	public void put_github_info(String username, String github_name, String github_repo, String github_token) throws Exception;
	
	public void delete_kakao_info(String username, String kakao_name) throws Exception;
	
	public void put_kakao_info(String username, String kakao_name) throws Exception;
	
	public void update_kakao_info(String username, String kakao_name) throws Exception;
	
}
