package com.psg.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.psg.vo.MemberDetailsVO;

public class MemberLoginAuthenticationProvider implements AuthenticationProvider{
	
	@Autowired
	MemberServiceImpl memberDetailsService;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();
		String password = (String)authentication.getCredentials();
		
		
		MemberDetailsVO memberDetails = (MemberDetailsVO) memberDetailsService.loadUserByUsername(username);
		
		if(memberDetails == null || !username.equals(memberDetails.getUsername()) || !bcryptPasswordEncoder.matches(password, memberDetails.getPassword())) {
			throw new BadCredentialsException(username);
		}else if(!memberDetails.isAccountNonLocked()) {
			throw new LockedException(username);
		}else if(!memberDetails.isEnabled()) {
			throw new DisabledException(username);
		}else if(!memberDetails.isAccountNonExpired()) {
			throw new AccountExpiredException(username);
		}else if(!memberDetails.isCredentialsNonExpired()) {
			throw new CredentialsExpiredException(username);
		}
		
		memberDetails.setPassword(null);
		
		Authentication newAuth = new UsernamePasswordAuthenticationToken(memberDetails, null, memberDetails.getAuthorities());
		
		return newAuth;
	}
	
	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}
		
}
