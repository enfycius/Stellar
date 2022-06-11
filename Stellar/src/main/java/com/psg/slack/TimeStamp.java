package com.psg.slack;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;


public class TimeStamp {

	public static void main(String[] args) {
		LocalDate localDate = LocalDate.now();
		Timestamp timestamp = Timestamp.valueOf(localDate.atStartOfDay());
		Timestamp timestamp2 = Timestamp.valueOf(localDate.atTime(23, 59,59));
		System.out.println(timestamp.getTime()/1000);
		System.out.println(timestamp2.getTime()/1000);
		Long L = System.currentTimeMillis()/1000;
		System.out.println(L);
		
	}

}
