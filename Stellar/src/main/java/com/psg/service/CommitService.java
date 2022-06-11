package com.psg.service;

import java.util.ArrayList;

import com.psg.vo.CommitVO;
import com.psg.vo.MemberVO;

public interface CommitService {
	public ArrayList<CommitVO> request_commit_list(String start, String end) throws Exception;
	public ArrayList<String> commit_check(ArrayList<CommitVO> commitList, String start, String end) throws Exception;
}
