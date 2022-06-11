<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>PSG 멤버수정</title>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<form action="./ModifyMember.do" method="get">
		<input type="hidden" name="id" value="${mvo.id}"> <input
			type="hidden" name="team_id" value="${mvo.team_id}">
		<table class="table">
			<thead>
				<tr>
					<th>회원정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>이름</th>
					<td><input type="text" name="real_name"
						value="${mvo.real_name}"></td>
				</tr>
				<tr>
					<th>슬랙 닉네임</th>
					<td><input type="text" name="slack_name"
						value="${mvo.slack_name}"></td>
				</tr>
				<tr>
					<th>ID</th>
					<td>${mvo.id}</td>
				</tr>
				<tr>
					<th>슬랙팀ID</th>
					<td>${mvo.team_id}</td>
				</tr>
				<tr>
					<th>비고</th>
					<td><input type="text" name="comment" value="${mvo.comment}"></td>
				</tr>
				<tr>
					<th>깃 닉네임</th>
					<c:forEach var="gvo" items="${gvo}">
						
							<td><input type="text" name="git_name"
								value="${gvo.git_name}"></td>
						
					</c:forEach>
				</tr>



				<tr>
					<td colspan="3"><button class="btn btn-primary pull-right"
							type="button" onclick='history.back(-1)'>취소</button></td>
					<td colspan="3"><button class="btn btn-primary pull-right"
							type="submit">저장</button></td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>