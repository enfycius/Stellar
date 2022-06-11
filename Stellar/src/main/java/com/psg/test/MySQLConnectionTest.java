package com.psg.test;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySQLConnectionTest {
	
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://221.159.102.58:3306/psg";
	
	private static final String USER = "stellar";
	private static final String PW = "psg@10026";
	
	@Test
	public void testConnection() throws Exception {
		Class.forName(DRIVER);
		
		try(Connection conn = DriverManager.getConnection(URL, USER, PW)) {
			System.out.println(conn);
		}catch(Exception e) {
			
		}
	}

}
