<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
					alert("Success");
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

					
				</ul>

				
				</div>
			</nav>
		
			
		

		<div class="main">
			<nav class="navbar navbar-expand navbar-light navbar-bg">
				<a class="sidebar-toggle d-flex">
          <i class="hamburger align-self-center"></i>
        </a>

				<form class="d-none d-sm-inline-block">
					<div class="input-group input-group-navbar">
						<input type="text" class="form-control" placeholder="Search" aria-label="Search">
						<button class="btn" type="button">
              <i class="align-middle" data-feather="search"></i>
            </button>
					</div>
				</form>

				<div class="navbar-collapse collapse">
					<ul class="navbar-nav navbar-align">
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="alertsDropdown" data-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="bell"></i>
									<span class="indicator">4</span>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right py-0" aria-labelledby="alertsDropdown">
								<div class="dropdown-menu-header">
									4 New Notifications
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-danger" data-feather="alert-circle"></i>
											</div>
											<div class="col-10">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-warning" data-feather="bell"></i>
											</div>
											<div class="col-10">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-primary" data-feather="home"></i>
											</div>
											<div class="col-10">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<i class="text-success" data-feather="user-plus"></i>
											</div>
											<div class="col-10">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">Show all notifications</a>
								</div>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle" href="#" id="messagesDropdown" data-toggle="dropdown">
								<div class="position-relative">
									<i class="align-middle" data-feather="message-square"></i>
								</div>
							</a>
							<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right py-0" aria-labelledby="messagesDropdown">
								<div class="dropdown-menu-header">
									<div class="position-relative">
										4 New Messages
									</div>
								</div>
								<div class="list-group">
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-5.jpg" class="avatar img-fluid rounded-circle" alt="">
											</div>
											<div class="col-10 pl-2">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-2.jpg" class="avatar img-fluid rounded-circle" alt="">
											</div>
											<div class="col-10 pl-2">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-4.jpg" class="avatar img-fluid rounded-circle" alt="">
											</div>
											<div class="col-10 pl-2">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
									<a href="#" class="list-group-item">
										<div class="row g-0 align-items-center">
											<div class="col-2">
												<img src="img/avatars/avatar-3.jpg" class="avatar img-fluid rounded-circle" alt="">
											</div>
											<div class="col-10 pl-2">
												<div class="text-dark"></div>
												<div class="text-muted small mt-1"></div>
												<div class="text-muted small mt-1"></div>
											</div>
										</div>
									</a>
								</div>
								<div class="dropdown-menu-footer">
									<a href="#" class="text-muted">Show all messages</a>
								</div>
							</div>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-icon dropdown-toggle d-inline-block d-sm-none" href="#" data-toggle="dropdown">
                <i class="align-middle" data-feather="settings"></i>
              </a>

							<a class="nav-link dropdown-toggle d-none d-sm-inline-block" href="#" data-toggle="dropdown">
							<sec:authorize access="isAuthenticated()">
            					<sec:authentication property="principal" var="user" />            
                					<img src="<c:url value='/images/rabbit.png'/> " class="avatar img-fluid rounded mr-1" alt="Charles Hall" /> <span class="text-dark">${user.username}</span>
                				</sec:authorize>     
              				</a>
							<div class="dropdown-menu dropdown-menu-right">
								<!-- <a class="dropdown-item" href="pages-profile.html"><i class="align-middle mr-1" data-feather="user"></i> Profile</a> -->
								<a class="dropdown-item" href="<c:url value='/Main.do' />" ><i class="align-middle mr-1" data-feather="home"></i> Home</a>								
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="<c:url value='/Logout.do'/>">Log out</a>
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

									<h5 class="card-title mb-0">Latest Projects</h5>
								</div>
								<table class="table table-hover my-0">
									<thead>
										<tr>
											<th>Username</th>
											<th class="d-none d-xl-table-cell">Email</th>
											<th class="d-none d-xl-table-cell">Registration Date</th>
											<th>Role</th>
											<th class="d-none d-md-table-cell">Settings</th>
										</tr>
									</thead>
									<c:forEach items="${memberList}" var="member">
									<c:choose>
									<c:when test="${not empty member}">
									<tbody>
										<tr>
											<td>${member.username}</td>
											<td class="d-none d-xl-table-cell">${member.email}</td>
											<td class="d-none d-xl-table-cell">${member.date}</td>
											<td>
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
											<td class="d-none d-md-table-cell">
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
