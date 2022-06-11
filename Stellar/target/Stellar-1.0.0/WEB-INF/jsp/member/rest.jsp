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

	<link rel="shortcut icon" href="<c:url value='/images/logo.png'/>" />

	<title>PSG Admin Page</title>

	<link href="<c:url value='/css/app.css' />" rel="stylesheet">
	
</head>

<body>
	<div class="wrapper">
		<nav id="sidebar" class="sidebar">
			<div class="sidebar-content js-simplebar">
				<a class="sidebar-brand" href="<c:url value='/Member/Management.do' />">
          <span class="align-middle">PSG Admin</span>
        </a>

				<ul class="sidebar-nav">
					<li class="sidebar-header">
						Pages
					</li>

					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Member/Management.do' />">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboard</span>
            </a>
					</li>
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Member/Settings.do' />">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Settings</span>
            </a>
					</li>
					
					<li class="sidebar-item active">
						<a class="sidebar-link" href="<c:url value='/Member/Rest.do' /> ">
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

					<h1 class="h3 mb-3">Blank Page</h1>

					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Empty card</h5>
								</div>
								<div class="card-body">
								</div>
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
								<a href="<c:url value='/Member/Management.do'/>" class="text-muted"><strong>PSG Admin Page</strong></a>
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
