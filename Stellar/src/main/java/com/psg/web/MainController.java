package com.psg.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.psg.service.CommitService;
import com.psg.service.MemberService;
import com.psg.vo.CommitVO;
import com.psg.vo.GithubVO;
import com.psg.vo.KakaoVO;
import com.psg.vo.MemberDetailsVO;
import com.psg.vo.MemberVO;
import com.psg.vo.RestVO;
import com.psg.vo.SlackVO;

import lombok.extern.log4j.Log4j2;



@Controller @Log4j2
public class MainController {
	
	@Resource(name="MemberService")
	private MemberService memberService;
	
	@Resource(name="CommitService")
	private CommitService commitService;
	
	@GetMapping(value="/Main.do")
	public String Main(Authentication authentication, Model model) throws Exception{
		int memberCount = memberService.Number_Member();
		int commitCountToday = memberService.Count_Commit_Today();
		int commitCountWeekly = memberService.Count_Commit_Weekly();
		int commitCountMonthly = memberService.Count_Commit_Monthly();
		
		if(authentication != null) {
			System.out.println("타입 정보: " + authentication.getClass());
			
			WebAuthenticationDetails web = (WebAuthenticationDetails)authentication.getDetails();
			System.out.println("세션ID: " + web.getSessionId());
			System.out.println("접속IP : " + web.getRemoteAddress());
			
			MemberDetailsVO memberDetails = (MemberDetailsVO)authentication.getPrincipal();
			System.out.println("ID정보 : " + memberDetails.getUsername());
		}
		
		model.addAttribute("memberCount", memberCount);
		model.addAttribute("commitCountToday", commitCountToday);
		model.addAttribute("commitCountWeekly", commitCountWeekly);
		model.addAttribute("commitCountMonthly", commitCountMonthly);
		
		return "psg/Main";
	}
	
	@GetMapping(value="/About.do")
	public String About(Model model) {
		int memberCount = 0;
		int commitCountToday = 0;
		try {
			memberCount = memberService.Number_Member();
			commitCountToday = memberService.Count_Commit_Today();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("memberCount", memberCount);
		model.addAttribute("commitCountToday", commitCountToday);
		
		return "psg/about";
	}
	
	@GetMapping(value="/Developer.do")
	public String Developer() {
		return "psg/developer";
	}
	
	@RequestMapping(value="/Login.do")
	public String Login(HttpServletRequest request) {
		String uri = request.getHeader("Referer");
		
		if(uri != null) {
			if(!uri.contains("/Login.do")) {
				request.getSession().setAttribute("prevPage", request.getHeader("Referer"));
			}
		}
		
		return "psg/login";
	}
	
	@GetMapping(value="/Register.do")
	public String getRegister() {
		log.info("register");
		return "psg/register";
	}
	
	@PostMapping(value="/Register.do")
	public String postRegister(MemberVO vo) throws Exception {
		
		memberService.register(vo);
		
		return "redirect:/Login.do";
	}
	
	@GetMapping(value="/Logout.do")
	public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/Login.do";
	}
	
	@GetMapping@PostMapping(value="/Access_Denied")
	public String accessDeniedPage(ModelMap model) {
		model.addAttribute("user", getPrincipal());
		
		return "accessDenied";
	}
	
	@GetMapping(value="/Contact.do")
	public String Contact() {
		log.info("contact");
		return "psg/contact";
	}
	
	@GetMapping(value="/Commit.do")
	public String Commit() {
		log.info("commit");
		return "psg/commit";
	}
	
	@GetMapping(value="/Admin/Management.do")
	public String AdminManagement() {
		return "admin/management";
	}
	
	@GetMapping(value="/Admin/Settings.do")
	public String Admin_Settings(Model model) {
		ArrayList<GithubVO> get_github_info = null;
		ArrayList<SlackVO> get_slack_info = null;
		String get_kakao_info = null;
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		
		try {
			get_github_info = memberService.get_github_info(username);
			get_slack_info = memberService.get_slack_info(username);
			get_kakao_info = memberService.get_kakao_info(username);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("slack_info", get_slack_info);
		model.addAttribute("github_info", get_github_info);
		model.addAttribute("kakao_info", get_kakao_info);
		
		return "admin/settings";
	}
	
	@GetMapping(value="/Admin/Username_Update.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int Admin_Username_Update(String username) {		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String old_username = authentication.getName();
		
		try {
			if(DupIdChk(username) > 0)
				return 1;
			
			memberService.Username_Update(username, old_username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	@GetMapping(value="/Admin/Kakao_Save.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int Admin_Kakao_Save(String kakao_name) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		try {
			if(memberService.DupKakaoChk(kakao_name) > 0) {
				return 1;
			} else {
				if(memberService.ExistKakaoChk(username) > 0) {
					memberService.update_kakao_info(username, kakao_name);
				} else {
					memberService.put_kakao_info(username, kakao_name);
				}				
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		return 0;
	}
	
	@GetMapping(value="/Admin/Rest.do")
	public String Admin_Member_Rest(Model model) {
		ArrayList<RestVO> memberRest = null;
		ArrayList<KakaoVO> memberKakao = null;
		
		try {
			memberRest = memberService.get_rest();
			memberKakao = memberService.get_kakao();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("memberRest", memberRest);
		model.addAttribute("memberKakao", memberKakao);
		
		return "admin/rest";
	}
	
	@GetMapping(value="/Admin/Append_Rest.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int Append_Rest(String kakao_name, String start_date, String end_date) {
		Date start=null;
		Date end=null;
		
		if((start_date == null || start_date.equals("")) || (end_date == null || end_date.equals("")) || (kakao_name == null || kakao_name.equals(""))) {
			return 0;
		}else {
			SimpleDateFormat transFormat = new SimpleDateFormat("MM/dd/yyyy");
			
			try {
				start = transFormat.parse(start_date);
				end = transFormat.parse(end_date);
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			try {
				if(memberService.DupRestChk(kakao_name, start, end) > 0)
					return 1;
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			log.info("test");
			
			try {
				memberService.put_rest(kakao_name, start, end);
			} catch (Exception e) {
						// TODO Auto-generated catch block	
			}
				return 2;
		}
			
	}
	
	@GetMapping(value="/Admin/Delete_Rest.do", produces="application/json; charset=utf8")
	@ResponseBody
	public void Delete_Rest(String username, String start_date, String end_date) {
		Date start=null;
		Date end=null;
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			start = transFormat.parse(start_date);
			end = transFormat.parse(end_date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			memberService.delete_rest(username, start, end);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	@GetMapping(value="/Admin/Role.do")
	public String Admin_Member_Info(Model model) {
		ArrayList<MemberVO> memberList=null;
		ArrayList<KakaoVO> memberKakao=null;
		try {
			memberList = memberService.memberList();
			memberKakao = memberService.get_kakao();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("memberList", memberList);
		model.addAttribute("memberKakao", memberKakao);
		
		return "admin/role";
	}
	
	@GetMapping(value="/Admin/getRole.do", produces="application/json; charset=utf8")
	@ResponseBody
	public void MemberRole(String username, String auth) throws Exception {
		
		memberService.updateRole(username, auth);
	}
	
	@GetMapping(value="/Admin/Slack_Delete.do", produces="application/json; charset=utf8")
	@ResponseBody
	public void Admin_Slack_Delete(String slack_name) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		memberService.delete_slack_info(username, slack_name);
	}
	
	@GetMapping(value="/Admin/Slack_Append.do", produces="application/json; charset=utf8")
	@ResponseBody
	public boolean Admin_Slack_Append(String slack_name) throws Exception {		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		if(memberService.DupSlackChk(slack_name) > 0) {
			
			log.info(memberService.DupSlackChk(slack_name));
			return false;
		} else {
			memberService.put_slack_info(username, slack_name);
			return true;
		}
	}
	
	@GetMapping(value="/Admin/Github_Delete.do", produces="application/json; charset=utf8")
	@ResponseBody
	public void Admin_Github_Delete(String github_name, String github_repo, String github_token) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		memberService.delete_github_info(username, github_name, github_repo, github_token);
	}
	
	@GetMapping(value="/Admin/Github_Append.do", produces="application/json; charset=utf8")
	@ResponseBody
	public boolean Admin_Github_Append(String github_name, String github_repo, String github_token) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		if(memberService.DupGithubChk(github_name, github_repo, github_token) > 0) {
			return false;
		} else {
			memberService.put_github_info(username, github_name, github_repo, github_token);
			return true;
		}		
	}
	
	@GetMapping(value="/Admin/Commit.do")
	public String Admin_Commit(Model model, String start_date, String end_date) throws Exception {
		
		Date start = null;
		Date end = null;
		
		if(start_date == null || end_date == null)
			return "admin/commit";
		else {
			SimpleDateFormat fromFormat = new SimpleDateFormat("MM/dd/yyyy");
			SimpleDateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				start = fromFormat.parse(start_date);
				end = fromFormat.parse(end_date);
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			log.info(toFormat.format(end));
			
			ArrayList<String> not_commit_List = commitService.commit_check(commitService.request_commit_list(toFormat.format(start), toFormat.format(end)), toFormat.format(start), toFormat.format(end));
			ArrayList<String> kakao_username = new ArrayList<String>();
			
			for(int i=0; i<not_commit_List.size(); i++) {
				String username = not_commit_List.get(i);
				
				kakao_username.add(memberService.get_kakao_info(username));	
			}
			
			if(toFormat.format(start).equals(toFormat.format(end))) {
				model.addAttribute("check_date", toFormat.format(start));
				model.addAttribute("validate", "true");
			}
			
			model.addAttribute("not_commit_List", not_commit_List);
			model.addAttribute("kakao_username", kakao_username);
			
			return "admin/commit";
		}
		
		
	}
	
	@GetMapping(value="/Admin/CommitLog.do")
	public String Admin_Commit_Log(Model model, String start_date, String end_date) throws Exception {
		Date start = null;
		Date end = null;
		
		if(start_date == null || end_date == null)
			return "admin/log";
		else {
			SimpleDateFormat fromFormat = new SimpleDateFormat("MM/dd/yyyy");
			SimpleDateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				start = fromFormat.parse(start_date);
				end = fromFormat.parse(end_date);
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
			ArrayList<CommitVO> commit_Log = commitService.request_commit_list(toFormat.format(start), toFormat.format(end));
			ArrayList<String> kakao_username = new ArrayList<String>();
			
			for(int i=0; i<commit_Log.size(); i++)
				kakao_username.add(memberService.get_kakao_info_github(commit_Log.get(i).getUsername()));
				
			model.addAttribute("commit_Log", commit_Log);
			model.addAttribute("kakao_username", kakao_username);
			
			return "admin/log";
		}
	}
	
	
	@GetMapping(value="/Member/Management.do")
	public String MemberManagement() {
		return "member/management";
	}
	
	@GetMapping(value="/Member/Settings.do")
	public String Member_Settings(Model model) {
		ArrayList<GithubVO> get_github_info = null;
		ArrayList<SlackVO> get_slack_info = null;
		String get_kakao_info = null;
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		
		try {
			get_github_info = memberService.get_github_info(username);
			get_slack_info = memberService.get_slack_info(username);
			get_kakao_info = memberService.get_kakao_info(username);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("slack_info", get_slack_info);
		model.addAttribute("github_info", get_github_info);
		model.addAttribute("kakao_info", get_kakao_info);
		
		return "member/settings";
	}
	
	@GetMapping(value="/Member/Username_Update.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int Member_Username_Update(String username) {		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String old_username = authentication.getName();
		
		try {
			if(DupIdChk(username) > 0)
				return 1;
			
			memberService.Username_Update(username, old_username);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	
	@GetMapping(value="/Member/Kakao_Save.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int Member_Kakao_Save(String kakao_name) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		try {
			if(memberService.DupKakaoChk(kakao_name) > 0) {
				return 1;
			} else {
				if(memberService.ExistKakaoChk(username) > 0) {
					memberService.update_kakao_info(username, kakao_name);
				} else {
					memberService.put_kakao_info(username, kakao_name);
				}				
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		return 0;
	}
	
	@GetMapping(value="/Member/Slack_Delete.do", produces="application/json; charset=utf8")
	@ResponseBody
	public void Member_Slack_Delete(String slack_name) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		memberService.delete_slack_info(username, slack_name);
	}
	
	@GetMapping(value="/Member/Slack_Append.do", produces="application/json; charset=utf8")
	@ResponseBody
	public boolean Member_Slack_Append(String slack_name) throws Exception {		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		if(memberService.DupSlackChk(slack_name) > 0) {
			
			log.info(memberService.DupSlackChk(slack_name));
			return false;
		} else {
			memberService.put_slack_info(username, slack_name);
			return true;
		}
	}
	
	@GetMapping(value="/Member/Github_Delete.do", produces="application/json; charset=utf8")
	@ResponseBody
	public void Member_Github_Delete(String github_name, String github_repo, String github_token) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		memberService.delete_github_info(username, github_name, github_repo, github_token);
	}
	
	@GetMapping(value="/Member/Github_Append.do", produces="application/json; charset=utf8")
	@ResponseBody
	public boolean Member_Github_Append(String github_name, String github_repo, String github_token) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		if(memberService.DupGithubChk(github_name, github_repo, github_token) > 0) {
			return false;
		} else {
			memberService.put_github_info(username, github_name, github_repo, github_token);
			return true;
		}		
	}
	
	
	@GetMapping(value="/Member/Rest.do")
	public String Member_Rest(Model model) {
		ArrayList<RestVO> memberRest = null;
		ArrayList<KakaoVO> memberKakao = null;
		
		try {
			memberRest = memberService.get_rest();
			memberKakao = memberService.get_kakao();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("memberRest", memberRest);
		model.addAttribute("memberKakao", memberKakao);
		
		return "member/rest";
	}
	
	@RequestMapping(value="/AccessDenied.do")
	public String Denied(Model model, Authentication auth, HttpServletRequest req) {
		AccessDeniedException ade = (AccessDeniedException) req.getAttribute(WebAttributes.ACCESS_DENIED_403);
		
		log.info("ex : {}", ade);
		model.addAttribute("auth", auth);
		model.addAttribute("errMsg", ade);
		return "psg/accessdenied";
	}
	
	@GetMapping(value="/DupIdChk.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int DupIdChk(@RequestParam(required=true) String loginId) throws Exception {
		int dupIdCnt = memberService.DupIdChk(loginId);
		
		return dupIdCnt;
	}
	
	@GetMapping(value="/DupSlackChk.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int DupSlackChk(@RequestParam(required=true) String slack_name) throws Exception {
		int dupSlackCnt = memberService.DupSlackChk(slack_name);
		
		return dupSlackCnt;
	}
	
	@GetMapping(value="/DupGithubChk.do", produces="application/json; charset=utf8")
	@ResponseBody
	public int DupGithubChk(@RequestParam(required=true) String github_name, String github_repo, String github_token) throws Exception {
		int dupGithubCnt = memberService.DupGithubChk(github_name, github_repo, github_token);
		
//		return String.valueOf(dupIdCnt);
		return dupGithubCnt;
	}
	
	private String getPrincipal() {
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		
		return userName;
	}

}
