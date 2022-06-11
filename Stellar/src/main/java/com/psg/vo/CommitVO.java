package com.psg.vo;

import java.util.Date;

import lombok.Data;
import lombok.Getter;

@Data
@Getter
public class CommitVO {
	String username;
	String message;
	Date date;
	String url;

}
