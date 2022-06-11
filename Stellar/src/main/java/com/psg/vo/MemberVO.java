package com.psg.vo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter@Setter@Data
public class MemberVO{
	
	private String username;
	private String password;
	private String email;
	private String auth;
	private Date date;
	
}
