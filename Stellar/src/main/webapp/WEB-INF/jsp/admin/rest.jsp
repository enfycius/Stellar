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
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script> 
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script> 
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />

  	<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />
	
	<style>
        
        /* The Modal (background) */
		.modal {
		    display: none; /* Hidden by default */
		    position: fixed; /* Stay in place */
		    z-index: 1; /* Sit on top */
		    left: 0;
		    top: 0;
		    width: 100%; /* Full width */
		    height: 100%; /* Full height */
		    overflow: auto; /* Enable scroll if needed */
		    background-color: rgb(0,0,0); /* Fallback color */
		    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		}
		
		/* Modal Content/Box */
		.modal-content {
		    background-color: #fefefe;
		    margin: 15% auto; /* 15% from the top and centered */
		    padding: 20px;
		    border: 1px solid #888;
		    width: 50%; /* Could be more or less, depending on screen size */                          
		}
		/* The Close Button */
		.close {
		    color: #aaa;
		    float: right;
		    font-size: 28px;
		    font-weight: bold;
		}
		.close:hover,
		.close:focus {
		    color: black;
		    text-decoration: none;
		    cursor: pointer;
		}
    </style>
	
	
	<script>
	
	function show_info(info) {
    	var modal = document.getElementById("info_modal");
    	document.getElementById("contents").innerHTML = info;
    	modal.style.display = "block";
    }
    
    function close_info() {
    	var modal = document.getElementById("info_modal");
    	modal.style.display = "none";
    }
    
    window.onclick = function(event) {
    	var modal = document.getElementById("info_modal");
    	if(event.target == modal)
    		modal.style.display = "none";
    }
    
    
	$(function() {
		$('#start_date').datetimepicker({format: 'L'});
		$('#end_date').datetimepicker({format: 'L'}); 
	});
 
	$(document).ready(function(){
		$('#append_rest_row').on("click", function() {		
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var kakao_name = $('#member_option').val();
			var start_date = $('#start').val();
			var end_date = $('#end').val();
					
			$.ajax({
				url : "<c:url value='/Admin/Append_Rest.do'/>",
				method : "get",
				data : {"kakao_name" : kakao_name, "start_date" : start_date, "end_date" : end_date},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},				
				success : function(data) {
					switch(data) {
					case 0:
						show_info("데이터를 선택해주세요.");
						break;
					case 1:
						show_info("해당 데이터가 존재합니다.");
						break;
					case 2:
						location.reload();
						break;
					}
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});
			
		});
	});
	
	$(document).ready(function(){
		$('#rest_table').on("click", ".delete_rest", function() {		
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var tr = $(this).parent().parent();
			var username = tr.children().eq(0).text();
			var start_date = tr.children().eq(2).text();
			var end_date = tr.children().eq(3).text();
						
			$.ajax({
				url : "<c:url value='/Admin/Delete_Rest.do'/>",
				method : "get",
				data : {"username" : username, "start_date" : start_date, "end_date" : end_date},
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

<div id="info_modal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Info</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" onclick="close_info()">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p id="contents"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="close_info()">Okay</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="close_info()">Close</button>
      </div>
    </div>
  </div>
</div>
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
					
					<li class="sidebar-item">
						<a class="sidebar-link" href="<c:url value='/Admin/Role.do' /> ">
              <i class="align-middle" data-feather="book"></i> <span class="align-middle">Role</span>
            </a>
					</li>
					
					<li class="sidebar-item active">
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
								<!-- <a class="dropdown-item" href="pages-profile.html"><i class="align-middle mr-1" data-feather="user"></i> Profile</a> -->
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

					<h1 class="h3 mb-3">Rest Settings</h1>
					
					<div class="row">
						<div class="col-12">
							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Rest List</h5>
								</div>
								<div class="card-body">
								<table class="table table-hover my-0" id="rest_table">
									<thead>
										<tr>
											<th>Username</th>
											<th>Kakao_Name</th>
											<th class="d-none d-xl-table-cell">Start Date</th>
											<th class="d-none d-xl-table-cell">End Date</th>
											<th>Settings</th>
										</tr>
									</thead>
									<c:forEach items="${memberRest}" var="member_rest">
									<c:choose>
									<c:when test="${not empty member_rest}">
									<tbody>
										<tr>
											<td>${member_rest.username}</td>
											<td>
											<c:set var="loop_flag" value="false" />
											<c:forEach items="${memberKakao}" var="member_kakao">
												<c:if test="${not loop_flag}">
													<c:if test="${member_rest.username eq member_kakao.username}">
														${member_kakao.kakao_name}
														<c:set var="loop_flag" value="true" />
													</c:if>
												</c:if>
											</c:forEach>
											</td>
											
											<td class="d-none d-xl-table-cell"><fmt:formatDate value="${member_rest.start_date}" pattern="yyyy-MM-dd"/>
											</td>
											<td class="d-none d-xl-table-cell"><fmt:formatDate value="${member_rest.end_date}" pattern="yyyy-MM-dd" />
											</td>
											<td>
												<a class="delete_rest">Delete</a>
											 </td>
											
										</tr>										
									</tbody>
									</c:when>
									</c:choose>									
									</c:forEach>
								</table>
								
								
								</div>
								
								<div class="card-body">
									<table class="table table-hover my-0">
									<thead>
										<tr>
											<th>Kakao_Name</th>
											<th class="d-none d-xl-table-cell">Start Date</th>
											<th class="d-none d-xl-table-cell">End Date</th>
										</tr>
									</thead>
									
									<tbody>
										<tr>
											<td>
												<select id="member_option">
													<c:forEach items="${memberKakao}" var="member" varStatus="status">
														<c:choose>
															<c:when test="${not empty member}">
																<option value="${member.kakao_name}">${member.kakao_name}</option>																					
															</c:when>
														</c:choose>									
													</c:forEach>												
												</select>
											 </td>
											 
											 
											 <td>
											 <div class="form-group"> 
													<div class="input-group date" id="start_date"  data-target-input="nearest"> 
													<input type="text" class="form-control datetimepicker-input" id="start" data-target="#start_date"> 
														<div class="input-group-append" data-target="#start_date" data-toggle="datetimepicker"> 
															<div class="input-group-text">
																<i class="fa fa-calendar"></i>
															</div>
												 		</div> 
												 	</div> 
												 </div>
											 </td>
											<td>
												<div class="form-group"> 
													<div class="input-group date" id="end_date"  data-target-input="nearest"> 
													<input type="text" class="form-control datetimepicker-input" id="end" data-target="#end_date"> 
														<div class="input-group-append" data-target="#end_date" data-toggle="datetimepicker"> 
															<div class="input-group-text">
																<i class="fa fa-calendar"></i>
															</div>
												 		</div> 
												 	</div> 
												 </div>
											</td>
											
											<td>
												<button type="button" class="btn btn-primary" id="append_rest_row">추가</button>
											</td>
										</tr>										
									</tbody>
								</table>
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
