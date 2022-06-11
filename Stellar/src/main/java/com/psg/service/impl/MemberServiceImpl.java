package com.psg.service.impl;

import java.util.ArrayList;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.psg.mapper.CommitMapper;
import com.psg.mapper.MemberMapper;
//import com.psg.security.CustomUserDetails;
import com.psg.service.MemberService;
import com.psg.vo.GithubVO;
import com.psg.vo.KakaoVO;
import com.psg.vo.MemberDetailsVO;
import com.psg.vo.MemberVO;
import com.psg.vo.RestVO;
import com.psg.vo.SlackVO;

import lombok.extern.log4j.Log4j2;


@Service("MemberService")
public class MemberServiceImpl implements MemberService, UserDetailsService {

	@Resource(name="MemberMapper")
	private MemberMapper memberMapper;
	
	@Resource(name="CommitMapper")
	private CommitMapper commitMapper;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@Override
	public boolean register(MemberVO vo) throws Exception {
		
		Integer memberCount = memberMapper.DupIdChk(vo.getUsername());
		
		if(memberCount > 0) {
			return false;
		}else {
			vo.setPassword(bcryptPasswordEncoder.encode(vo.getPassword()));
			
			memberMapper.register(vo);
			
			return true;
		}
	}
	
	@Override
	public int Count_Commit_Today() throws Exception {
		return commitMapper.Count_Commit_Today();
	}
	
	@Override
	public int Count_Commit_Weekly() throws Exception {
		return commitMapper.Count_Commit_Weekly();
	}
	
	@Override
	public int Count_Commit_Monthly() throws Exception {
		return commitMapper.Count_Commit_Monthly();
	}
	
	@Override
	public int DupIdChk(String loginId) throws Exception {
		return memberMapper.DupIdChk(loginId);
	}
	
	@Override
	public int Number_Member() throws Exception {
		return memberMapper.Number_Member();
	}
	
	@Override
	public int DupSlackChk(String slack_name) throws Exception {
		return commitMapper.DupSlackChk(slack_name);
	}
	
	@Override
	public int DupGithubChk(String github_name, String github_repo, String github_token) throws Exception {
		return commitMapper.DupGithubChk(github_name, github_repo, github_token);
	}
	
	@Override
	public int DupKakaoChk(String kakao_name) throws Exception {
		return commitMapper.DupKakaoChk(kakao_name);
	}
	
	@Override
	public int DupRestChk(String username, Date start_date, Date end_date) throws Exception {
		return commitMapper.DupRestChk(username, start_date, end_date);
	}
	
	@Override
	public int ExistKakaoChk(String username) throws Exception {
		return commitMapper.ExistKakaoChk(username);
	}
	
	@Override
	public void updateRole(String username, String auth) throws Exception {
		memberMapper.updateRole(username, auth);
	}
	
	@Override
	public void Username_Update(String username, String old_username) throws Exception {
		memberMapper.Username_Update(username, old_username);
	}
	
	@Override
	public void delete_rest(String username, Date start_date, Date end_date) throws Exception {
		commitMapper.delete_rest(username, start_date, end_date);
	}
	
	@Override
	public void put_rest(String kakao_name, Date start_date, Date end_date) throws Exception {
		commitMapper.put_rest(kakao_name, start_date, end_date);
	}
	
	@Override
	public void delete_slack_info(String username, String slack_name) throws Exception {
		commitMapper.delete_slack_info(username, slack_name);
	}
	
	@Override
	public void put_slack_info(String username, String slack_name) throws Exception {
		commitMapper.put_slack_info(username, slack_name);
	}
	
	@Override
	public void delete_github_info(String username, String github_name, String github_repo, String github_token) throws Exception {
		commitMapper.delete_github_info(username, github_name, github_repo, github_token);
	}
	
	@Override
	public void put_github_info(String username, String github_name, String github_repo, String github_token) throws Exception {
		commitMapper.put_github_info(username, github_name, github_repo, github_token);
	}
	
	@Override
	public void delete_kakao_info(String username, String kakao_name) throws Exception {
		commitMapper.delete_kakao_info(username, kakao_name);
	}
	
	@Override
	public void put_kakao_info(String username, String kakao_name) throws Exception {
		commitMapper.put_kakao_info(username, kakao_name);
	}
	
	@Override
	public void update_kakao_info(String username, String kakao_name) throws Exception {
		commitMapper.update_kakao_info(username, kakao_name);
	}
	
	@Override
	public ArrayList<MemberVO> memberList() throws Exception {
		return memberMapper.memberList();
	}
	
	@Override
	public ArrayList<RestVO> get_rest() throws Exception {
		return commitMapper.get_rest();
	}
	
	@Override
	public ArrayList<KakaoVO> get_kakao() throws Exception {
		return commitMapper.get_kakao();
	}
	
	@Override
	public ArrayList<RestVO> get_member_rest(String username) throws Exception {
		return commitMapper.get_member_rest(username);
	}
	
	@Override
	public ArrayList<GithubVO> get_github_info(String username) throws Exception {
		return commitMapper.get_github_info(username);
	}
	
	@Override
	public ArrayList<SlackVO> get_slack_info(String username) throws Exception {
		return commitMapper.get_slack_info(username);
	}
	
	@Override
	public String get_kakao_info(String username) throws Exception {
		return commitMapper.get_kakao_info(username);
	}
	
	@Override
	public String get_kakao_info_github(String github_username) throws Exception {
		return commitMapper.get_kakao_info_github(github_username);
	}
	
	
	@Override
	public UserDetails loadUserByUsername(String username) {
		MemberDetailsVO memberDetails = new MemberDetailsVO();
		
		MemberVO memberInfo=null;
		try {
			memberInfo = memberMapper.selectUserInfoOne(username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(memberInfo == null) {
			return null;
		}else {
			memberDetails.setUsername(memberInfo.getUsername());
			memberDetails.setPassword(memberInfo.getPassword());
			memberDetails.setEmail(memberInfo.getEmail());
			
			try {
				memberDetails.setAuthorities(memberMapper.selectUserAuthOne(username));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return memberDetails;
		
	}
	
	
	
}
