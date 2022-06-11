package com.psg.service.impl;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.psg.mapper.CommitMapper;
import com.psg.mapper.MemberMapper;
import com.psg.service.CommitService;
import com.psg.vo.CommitVO;
import com.psg.vo.GithubVO;
import com.psg.vo.MemberVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service("CommitService")
public class CommitServiceImpl implements CommitService {
	
	private static final String PY_URL = "http://psg.or.kr:2253/Git/gitcommithistory";
	
	@Resource(name="CommitMapper")
	private CommitMapper commitMapper;
	
	@Resource(name="MemberMapper")
	private MemberMapper memberMapper;
	
	@Override
	public ArrayList<CommitVO> request_commit_list(String start, String end) throws Exception {
		RestTemplate restTemplate = new RestTemplate();
		ObjectMapper mapper = new ObjectMapper();
		
		String since = LocalDate.parse(start, DateTimeFormatter.ISO_DATE).atTime(15, 00, 00).minus(1, ChronoUnit.DAYS).toString()+":00Z";
		String until = LocalDate.parse(end, DateTimeFormatter.ISO_DATE).atTime(14, 59, 59).toString()+"Z";
	
		ArrayList<GithubVO> github_data = commitMapper.get_all_github_info();
		ArrayList<CommitVO> get_commit_info = new ArrayList<CommitVO>();
		ArrayList<CommitVO> commitList = new ArrayList<CommitVO>();
		
		int number_of_github_data = commitMapper.Count_Github_Info();
		
		for(int i=0; i < number_of_github_data; i++) {
			String owner = github_data.get(i).getGithub_name();
			String repo = github_data.get(i).getGithub_repo();
			String token = github_data.get(i).getGithub_token();
			String response = restTemplate.getForObject(PY_URL + "?owner=" + owner + "&repo=" + repo + "&token=" + token + "&since=" + since + "&until=" + until, String.class);
			
			if(response == null)
				continue;
			
			get_commit_info = mapper.readValue(response, mapper.getTypeFactory().constructCollectionType(List.class, CommitVO.class));
			
			commitList.add(get_commit_info.get(0));
		}
		
		return commitList;
	}
	
	@Override
	public ArrayList<String> commit_check(ArrayList<CommitVO> commitList, String start, String end) throws Exception {
		ArrayList<String> userList = memberMapper.memberNotRestList(start, end);
		
		if(userList != null) {
			for(int i=0; i<commitList.size(); i++) {
				if(commitList.get(i) != null) {
					int index = userList.indexOf(commitMapper.get_username_github_info(commitList.get(i).getUsername()));
					
					if(index != -1) 
						userList.remove(index);
				}
			}
		}
		
		return userList;
	}
}
