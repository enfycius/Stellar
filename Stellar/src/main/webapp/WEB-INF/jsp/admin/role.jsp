<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="PSG Admin Page">
	<meta name="author" content="PSG Admin">
	<meta name="keywords" content="PSG Admin">
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />

	<link rel="shortcut icon" href="<c:url value='/images/logo.png'/>" />

	<title>PSG Admin Page</title>

	<link href="<c:url value='/css/app.css' />" rel="stylesheet">
	
	<script src="<c:url value='/js/jquery.min.js'/> "></script>
	
	<script>
	$(document).ready(function() {
		$("select[name = 'RoleSettings']").on("change", function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var username = $(this).parent().parent().children().eq(0).text();			
			var auth = this.value;
						
			$.ajax({
				url : "<c:url value='/Admin/getRole.do'/>",
				method : "get",
				data : {"username" : username, "auth" : auth},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},				
				success : function(data) {
					location.reload();
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});

			
		});
		
		
		
		
			
	});
	</script>
	
</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="<c:url value='/Admin/Management.do' />">
          <span class="align-middle">PSG Admin</span>
        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						Pages
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Admin/Management.do' />">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboard</span>
            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Admin/Settings.do' />">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Settings</span>
            </a>
					</li>
					
					<li class="sidebar-item active">
						<a class="sidebar-link" href="<c:url value='/Admin/Role.do' /> ">
              <i class="align-middle" data-feather="book"></i> <span class="align-middle">Role</span>
            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Admin/Rest.do' /> ">
              <i class="align-middle" data-feather="book"></i> <span class="align-middle">Rest</span>
            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Admin/Commit.do' /> ">
              <i class="align-middle" data-feather="book"></i> <span class="align-middle">Commit</span>
            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Admin/CommitLog.do' /> ">
              <i class="align-middle" data-feather="book"></i> <span class="align-middle">Commit Log</span>
            </a>
					</li>
				</ul>
				</div>
			</nav>
		
			
		

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle d-flex">
          <i class="hamburger align-self-center"></i>
        </a>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-toggle="dropdown">
                <i class="align-middle" data-feather="settings"></i>
              </a>		                    	                                                    
							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-toggle="dropdown">
							<sec:authorize access="isAuthenticated()">
            					<sec:authentication property="principal" var="user" />            
                					<img src="<c:url value='/images/rabbit.png' /> " class="avatar img-fluid rounded mr-1" alt="${user.username}" /> <span class="text-dark">${user.username}</span>
                				</sec:authorize>     
              				</a>
							<div class="dropdown-menu dropdown-menu-right">
								<a class="dropdown-item" href="<c:url value='/Main.do'/> "><i class="align-middle mr-1" data-feather="home"></i> Home</a>								
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="<c:url value='/Logout.do'/> ">Log out</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>

			<main class="content">
				<div class="container-fluid p-0">

					<h1 class="h3 mb-3"></h1>

					<div class="row">
						<div class="col-12 col-lg-8 col-xxl-9 d-flex">
							<div class="card flex-fill">
								<div class="card-header">

									<h5 class="card-title mb-0">Role</h5>
								</div>
								<table class="table table-hover my-0">
									<thead>
										<tr>
											<th>User</th>
											<th>Kakao</th>
											<th class="d-none d-xl-table-cell">Email</th>
											<th class="d-none d-xl-table-cell">Registration Date</th>
											<th class="d-none d-xl-table-cell">Role</th>
											<th>Settings</th>
										</tr>
									</thead>
									<c:forEach items="${memberList}" var="member">
									<c:choose>
									<c:when test="${not empty member}">
									<tbody>
										<tr>
											<td>${member.username}</td>
											<td>
											<c:set var="loop_flag" value="false" />
											<c:forEach items="${memberKakao}" var="member_kakao">
												<c:if test="${not loop_flag}">
													<c:if test="${member.username eq member_kakao.username}">
														${member_kakao.kakao_name}
														<c:set var="loop_flag" value="true" />
													</c:if>
												</c:if>
											</c:forEach>
											</td>
											<td class="d-none d-xl-table-cell">${member.email}</td>
											<td class="d-none d-xl-table-cell"><fmt:formatDate value="${member.date}" pattern="yyyy-MM-dd"/>
											</td>
											<td class="d-none d-xl-table-cell">
												<c:if test="${member.auth eq 'ROLE_ADMIN'}">
											 		<span class="badge bg-primary">${member.auth}</span>
											 	</c:if>
											 	<c:if test="${member.auth eq 'ROLE_MEMBER'}">
											 		<span class="badge bg-success">${member.auth}</span>
											 	</c:if>
											 	<c:if test="${member.auth eq 'ROLE_USER'}">
											 		<span class="badge bg-warning">${member.auth}</span>
											 	</c:if>
											 	</td>
											<td>
												<c:if test="${member.auth ne 'ROLE_ADMIN'}">
												<select name="RoleSettings">
													<option value="ROLE_MEMBER" <c:if test="${member.auth eq 'ROLE_MEMBER'}">selected</c:if>>ROLE_MEMBER</option>
													<option value="ROLE_USER" <c:if test="${member.auth eq 'ROLE_USER'}">selected</c:if>>ROLE_USER</option>													
												</select>
												</c:if>
											</td>
										</tr>										
									</tbody>
									</c:when>
									</c:choose>									
									</c:forEach>
								</table>
							</div>
						</div>

					</div>


				</div>
			</main>

			<footer class="footer">
				<div class="container-fluid">
					<div class="row text-muted">
						<div class="col-6 text-left">
							<p class="mb-0">
								<a href="<c:url value='/Admin/Management.do'/>" class="text-muted"><strong>PSG Admin Page</strong></a>
							</p>
						</div>
						<div class="col-6 text-right">
							<ul class="list-inline">
								<li class="list-inline-item">
									<a class="text-muted" href="#">Support</a>
								</li>
								<li class="list-inline-item">
									<a class="text-muted" href="#">Help Center</a>
								</li>
								<li class="list-inline-item">
									<a class="text-muted" href="#">Privacy</a>
								</li>
								<li class="list-inline-item">
									<a class="text-muted" href="#">Terms</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<script src="<c:url value='/js/app.js'/>"></script>

</body>

</html>
