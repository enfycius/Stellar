package com.psg.vo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;

@Getter
public class MemberDetailsVO implements UserDetails{

	private static final long serialVersionUID = 1L;
	
	private String username;
	private String password;
	private String email;
	
	private List<GrantedAuthority> authorities;
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setAuthorities(List<String> authList) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		
		for(int i=0; i<authList.size(); i++)
			authorities.add(new SimpleGrantedAuthority(authList.get(i)));
		
		this.authorities = authorities;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	@Override
	public boolean isEnabled() {
		return true;
	}


}
