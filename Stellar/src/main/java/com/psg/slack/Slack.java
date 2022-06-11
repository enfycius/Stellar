//package com.psg.slack;
//
//import java.sql.Timestamp;
//import java.time.LocalDate;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Iterator;
//import java.util.List;
//import java.util.Map;
//import java.util.Map.Entry;
//import java.util.Set;
//
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//
//import org.apache.commons.collections.MapUtils;
//import org.apache.logging.log4j.core.util.JsonUtils;
//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.json.simple.JSONValue;
//import org.json.simple.parser.JSONParser;
//import org.junit.internal.matchers.SubstringMatcher;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.client.RestTemplate;
//
//import com.fasterxml.jackson.core.JsonProcessingException;
//import com.fasterxml.jackson.core.type.TypeReference;
//import com.fasterxml.jackson.databind.JsonMappingException;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.psg.dao.Member;
//import com.psg.dao.MemberDao;
//import com.psg.service.MemberService;
//import com.psg.service.UserService;
//import com.psg.vo.MemberVO;
//import com.psg.vo.SlackVO;
//import com.psg.vo.UserListVO;
//import com.psg.vo.UserVO;
//
//import lombok.extern.log4j.Log4j2;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.support.ClassPathXmlApplicationContext;
//
//@RestController
//@Log4j2
//public class Slack {
//
//	private static final String slackurl = "https://slack.com/api/";
//	private static final String token = "xoxb-992233197952-1249394514658-PuRhTF4L2cNevShVqIMlnEw6";
//	private static final String commitchannel = "CUW4CLH4Z";
//
//	@Resource(name="UserService")
//	private UserService userService;
//	
//	@Resource(name="MemberService")
//	private MemberService memberService;
//	
//	@GetMapping("test.do")
//	public Object SlackMessage() throws Exception {
//		
//		LocalDate localDate = LocalDate.now();
//		Timestamp timestamp = Timestamp.valueOf(localDate.atStartOfDay());
//		Timestamp timestamp2 = Timestamp.valueOf(localDate.atTime(23, 59, 59));
//		Long latest = timestamp2.getTime() / 1000;
//		Long oldest = timestamp.getTime() / 1000;
//		
//		
//		ArrayList<HashMap<String, Object>> messagesmap = new ArrayList<HashMap<String, Object>>();
//		ArrayList<HashMap<String, Object>> attachmentsmap = new ArrayList<HashMap<String, Object>>();
//		ArrayList<HashMap<String, Object>> test = new ArrayList<HashMap<String, Object>>();
//		
//		String[] username;
//
//		SlackVO vo = new SlackVO();
//		String history = "conversations.history";
//		String response = "";
//		List<UserVO> luvo = userService.userlist();
//		log.info("userList : "+luvo.get(0).getAuthor_name());
//		/*
//		 * HttpComponentsClientHttpRequestFactory factory = new
//		 * HttpComponentsClientHttpRequestFactory();
//		 */
//		RestTemplate restTemplate = new RestTemplate();
//
//		response = restTemplate.getForObject(slackurl + history + "?token=" + token + "&channel=" + commitchannel
//				+ "&latest=" + latest + "&oldest=" + oldest + "&pretty=1", String.class);
//		log.info(slackurl + history + "?token=" + token + "&channel=" + commitchannel + "&pretty=1");
//		/* log.info(response); */
//
//		ObjectMapper mapper = new ObjectMapper();
//		
//		List<UserVO> commitlist = new ArrayList<UserVO>();
//
//		try {
//			vo = new ObjectMapper().readerFor(SlackVO.class).readValue(response);
//
//			for (int i = 0; i < vo.getMessages().size(); i++) {
//				messagesmap.add((HashMap<String, Object>) vo.getMessages().get(i));
//				attachmentsmap.add((HashMap<String, Object>) messagesmap.get(i));
//				try {
//				
//				test = (ArrayList<HashMap<String, Object>>) attachmentsmap.get(i).get("attachments");
//				
//				UserVO uvo = new UserVO();
//				
//				uvo.setAuthor_name(test.get(0).get("author_name").toString());
//				uvo.setText(test.get(0).get("fallback").toString());
//				userService.commitinsert(uvo);
//				commitlist.add(uvo);
//				
//				
//				}catch(Exception e) {log.info("null");}
//			}
//
//		} catch (Exception e) {
//			
//		}
//		
//		for(int i=0; i<commitlist.size(); i++) {
//			log.info(commitlist.get(i));
//		}
//
//		return vo;
//	}
//	
//	@GetMapping("test1.do") 
//		public void dbTest() {
//			ApplicationContext ctx = new ClassPathXmlApplicationContext("context-datasource.xml");
//			
//			MemberDao dao = (MemberDao)ctx.getBean("edao");
//			
//			int status = dao.saveMember(new Member("hello", "hello", "hello"));
//			
//			System.out.println(status);
//		}
//	
//	
//	@GetMapping("TodayCommit.do")
//	public Object SlackTodayCommit() {
//		LocalDate localDate = LocalDate.now();
//		Timestamp timestamp = Timestamp.valueOf(localDate.atStartOfDay());
//		Timestamp timestamp2 = Timestamp.valueOf(localDate.atTime(23, 59, 59));
//		String history = "conversations.history";
//		Long latest = timestamp2.getTime() / 1000;
//		Long oldest = timestamp.getTime() / 1000;
//
//		log.info("lastest : " + latest + " oldest : " + oldest);
//
//		ArrayList<HashMap<String, Object>> messagesmap = new ArrayList<HashMap<String, Object>>();
//		ArrayList<HashMap<String, Object>> attachmentsmap = new ArrayList<HashMap<String, Object>>();
//		ArrayList<HashMap<String, Object>> test = new ArrayList<HashMap<String, Object>>();
//		HashMap<String, Object> commitPerson = new HashMap<String, Object>();
//		String response = "";
//
//		RestTemplate restTemplate = new RestTemplate();
//		SlackVO vo = new SlackVO();
//		response = restTemplate.getForObject(slackurl + history + "?token=" + token + "&channel=" + commitchannel
//				+ "&latest=" + latest + "&oldest=" + oldest + "&pretty=1", String.class);
//		ObjectMapper mapper = new ObjectMapper();
//
//		try {
//			vo = new ObjectMapper().readerFor(SlackVO.class).readValue(response);
//
//			for (int i = 0; i < vo.getMessages().size(); i++) {
//				messagesmap.addAll(vo.getMessages());
//				attachmentsmap.add((HashMap<String, Object>) messagesmap.get(i));
//				log.info("bot_profile : "+messagesmap.get(i).get("bot_profile").toString());	
//				String[] updated = messagesmap.get(i).get("bot_profile").toString().split(",");
//				String time = updated[3].substring(7);
//				log.info("time"+time);
//			}
//		} catch (Exception e) {
//			log.info(e.toString());
//		}
//		log.info("오늘의 커밋 수 : " + vo.getMessages().size());
//		List<UserVO> commitlist = new ArrayList<UserVO>();
//
//		for (int j = 0; j < attachmentsmap.size(); j++) {
//
//			
//			for (Entry<String, Object> commitkey : attachmentsmap.get(j).entrySet()) {
//				if (commitkey.getKey().equals("attachments")) {
//					log.info("key : " + commitkey.getKey());
//					log.info("value : " + commitkey.getValue());
//					
//					String[] Author_name = commitkey.getValue().toString().split(",");
//					log.info("split0:" + Author_name[0]);
//					log.info("split2 : " + Author_name[2]);
//					UserVO uvo = new UserVO();
//					uvo.setAuthor_name(Author_name[0].substring(14));
//					uvo.setText((Author_name[2]));
//					/*uvo.setTime(time);*/
//					commitlist.add(uvo);
//					log.info("uvo 객체 : " + uvo.getAuthor_name());
//
//				}
//			}
//		}
//		return commitlist;
//	}
//	
//	@GetMapping("userinfo.do")
//	public Object SlackUsers(String slackuser) {
//		String response = "";
//		String users = "users.list";
//		UserListVO vo = new UserListVO();
//		RestTemplate restTemplate = new RestTemplate();
//		response = restTemplate.getForObject(slackurl + users + "?token="+token+"&user="+"UV5NWALH2"+"&pretty=1", String.class);
//		log.info(slackurl + users + "?token="+token + "&pretty=1");
//		ArrayList<HashMap<String, Object>> usermap = new ArrayList<HashMap<String, Object>>();
//		ArrayList<HashMap<String, Object>> usermap2 = new ArrayList<HashMap<String, Object>>();
//		ArrayList<HashMap<String, Object>> usermap3 = new ArrayList<HashMap<String, Object>>();
//		List<MemberVO> mvo = new ArrayList<MemberVO>();
//		try {
//			vo = new ObjectMapper().readerFor(UserListVO.class).readValue(response);
//
//			
//			for (int i = 0; i < vo.getMembers().size(); i++) {
//				usermap.add((HashMap<String, Object>) vo.getMembers().get(i));
//				usermap2.add((HashMap<String, Object>) usermap.get(i));
//				
//				try {
//				UserVO uvo = new UserVO();
//				
//				if(usermap2.get(i).get("is_bot").toString().equals("false")) {
//					//bot이면  is_bot = true, 실제 사용자면 false
//					
//					usermap3.add((HashMap<String, Object>) usermap2.get(i).get("profile"));
//					//실제 사용자의 profile을 가져옴
//					
//					
//					
//					/*if(usermap2.get(i).get("real_name").toString().equals("") && usermap2.get(i).get("real_name").toString() == null) {
//						log.info("real_name 존재 x : " + usermap2.get(i).get("name"));
//					}else {
//						log.info("실제이름 : "+usermap2.get(i).get("real_name"));
//						log.info("슬랙name : "+usermap2.get(i).get("name"));
//					}*/
//					
//					log.info("name : "+usermap2.get(i).get("name"));
//					log.info("real_name : " + usermap2.get(i).get("real_name"));
//					log.info("id : "+usermap2.get(i).get("id"));
//					MemberVO mmvo = new MemberVO();
//					mmvo.setId(usermap2.get(i).get("id").toString());
//					mmvo.setSlack_name(usermap2.get(i).get("name").toString());
//					mmvo.setReal_name(usermap2.get(i).get("real_name").toString());
//					mmvo.setTeam_id(usermap2.get(i).get("team_id").toString());
//					memberService.memberinsert(mmvo);
//					mvo.add(mmvo);
//					
//				}
//				
//				
//				}catch(Exception e) {log.info("null");}
//			}
//			
//				/*for(int j=1; j<usermap3.size(); j++) {
//					log.info("real_name : "+ usermap3.get(j).get("real_name"));
//					log.info("slack_name : "+ usermap3.get(j).get("name"));
//					//log.info("slack_id : "+ usermap3.get(j).get("id"));
//				}*/
//			log.info("mvo 사이즈"+mvo.size());
//
//		} catch (Exception e) {
//			
//		}
//		return mvo;
//	}
//}
