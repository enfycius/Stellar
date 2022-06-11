<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PSG 유저목록</title>
</head>
<body>
	<jsp:include page="../include/header.jsp" />

	<table class="table">
		<thead>
			<tr>
				<th>이름</th>
				<th>슬랙 닉네임</th>
				<th>깃 닉네임</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="mvo" items="${mvo}">
				<tr>
					<td>${mvo.real_name}</td>
					<td>${mvo.name}</td>
					<td>${mvo.git_name}</td>
					<td>${mvo.comment}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</body>
</html>