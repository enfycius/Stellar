<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="PSG Admin">
	<meta name="author" content="PSG Admin">
	<meta name="keywords" content="PSG Admin">
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />

	<link rel="shortcut icon" href="<c:url value='/images/logo.png'/> " />

	<title>PSG</title>

	<link href="<c:url value='/css/app.css'/> " rel="stylesheet">
	
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
	
	<script src="<c:url value='/js/jquery.min.js'/> "></script>
	
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
	</script>
	
	
	<script>
	
	function len_Chk(info, length) {
		
		if(info.length == 0 || info.length > length)
			return 1;
	
		return 0;
	}
	
	function korean_Chk(info) {
		var reg = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		
		if(reg.test(info)) {
			show_info("한글로 해당 항목을 설정할 수 없습니다.");
			
			return true;
		}
		
		return false;
	}
	
	function idValidChkFn(loginId) {
		var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,12}$/;
		
		if(!reg.test(loginId)) {
			show_info("아이디가 유효하지 않습니다");
			
			return false;
		}
		
		return true;
	}
	
	$(document).ready(function() {
		$('#username_save').click(function() {
			var username = $('#user_name').val();
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			if(!idValidChkFn(username))
				return false;
			
			$.ajax({
				url : "<c:url value='/Admin/Username_Update.do'/>",
				method : "get",
				data : {"username" : username},
				async : false,
			
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
			
				success : function(data) {
				
				if(data == 1) {
					show_info("해당 아이디가 존재합니다.");
				}else{
					window.location.href = "<c:url value='/Logout.do'/>";
				}	
			},
			error : function(request, status, error) {
				show_info("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
		});
			
		});
	});
	
	$(document).ready(function() {
		$('#kakao_save').click(function() {
			var kakao_name = $('#kakao_name').val();
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			if(len_Chk(kakao_name, 30) != 0) {
				show_info("카카오톡 닉네임 입력란이 공백이거나 30자를 초과합니다.");
				return;
			}
				
			$.ajax({
				url : "<c:url value='/Admin/Kakao_Save.do'/>",
				method : "get",
				data : {"kakao_name" : kakao_name},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success : function(data) {
					if(data == 1)
						show_info("데이터가 존재합니다.");
					else
						location.reload();
				},
				error : function(request, status, error) {
					show_info("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});

	$(document).ready(function(){
		$('#slack_table').on("click", ".delete_slack", function() {		
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var tr = $(this).parent().parent();
			var slack_name = tr.children().eq(0).text();
									
			$.ajax({
				url : "<c:url value='/Admin/Slack_Delete.do'/>",
				method : "get",
				data : {"slack_name" : slack_name},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},				
				success : function(data) {
					slack_delete_row(tr);
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});

			
		});
	}); 
	
	
	$(document).ready(function(){
		$('#append_slack_row').on("click", function() {		
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var slack_name = $('#slack_info').val();
			
			if(len_Chk(slack_name, 30) != 0) {
				show_info("슬랙 닉네임 입력란이 공백이거나 30자를 초과합니다.");
				return;
			}
			$.ajax({
				url : "<c:url value='/Admin/Slack_Append.do'/>",
				method : "get",
				data : {"slack_name" : slack_name},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},				
				success : function(data) {
					if(data == true) {
						slack_append_row();
						slack_input_blank();
					} else {
						show_info("데이터가 존재합니다.");
					}					
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		});
	});
	
	$(document).ready(function(){
		$('#github_table').on("click", ".delete_github", function() {		
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var tr = $(this).parent().parent();
			var github_name = tr.children().eq(0).text();
			var github_repo = tr.children().eq(1).text();
			var github_token = tr.children().eq(2).text();
						
			$.ajax({
				url : "<c:url value='/Admin/Github_Delete.do'/>",
				method : "get",
				data : {"github_name" : github_name, "github_repo" : github_repo, "github_token" : github_token},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},				
				success : function(data) {
					github_delete_row(tr);
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
				
			});

			
		});
	});
	
	$(document).ready(function(){
		$('#append_github_row').on("click", function() {		
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var github_name = $('#github_username').val();
			var github_repo = $('#github_repo').val();
			var github_token = $('#github_token').val();
			
			if(len_Chk(github_name, 50) != 0) {
				show_info("Github Username 입력란이 공백이거나 30자를 초과합니다.");
				return;
			}
			
			if(korean_Chk(github_name) == true)
				return;
			
			
			if(len_Chk(github_repo, 50) != 0) {
				show_info("Github Repo 입력란이 공백이거나 50자를 초과합니다.");
				return;
			}
			
			if(korean_Chk(github_repo) == true)
				return;
			
			if(len_Chk(github_token, 50) != 0) {
				show_info("Github Token 입력란이 공백이거나 50자를 초과합니다.");
				return;
			}
			
			if(korean_Chk(github_token) == true)
				return;
				
			$.ajax({
				url : "<c:url value='/Admin/Github_Append.do'/>",
				method : "get",
				data : {"github_name" : github_name, "github_repo" : github_repo, "github_token" : github_token},
				async : false,
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},				
				success : function(data) {
					if(data == true) {
						github_append_row();
						github_input_blank();
					} else {
						show_info("데이터가 존재합니다.");
					}
				},
				error : function(request, status, error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});	
		});
	});
	
	function slack_append_row() {
		$('#slack_table').append(
			$('<tr>').append(
				$('<td>').append($('#slack_info').val()),
				$('<td>').append($('<a>').addClass('delete_slack').append('Delete'))
			)
			
		);
		
	}
	
	function slack_input_blank() {
		$('#slack_info').prop('value', '');
	}
	
	function slack_delete_row(obj) {
		obj.remove();
	}
	
	function github_append_row() {
		$('#github_table').append(
			$('<tr>').append(
				$('<td>').append($('#github_username').val()),
				$('<td>').append($('#github_repo').val()),
				$('<td>').append($('#github_token').val()),
				$('<td>').append($('<a>').addClass('delete_github').append('Delete'))
			)
			
		);
		
	}
	
	function github_input_blank() {
		$('#github_username').prop('value', '');
		$('#github_repo').prop('value', '');
		$('#github_token').prop('value', '');
	}
	
	function github_delete_row(obj) {
		obj.remove();
	}
	
	
		
	
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
				<a class="sidebar-brand" href="<c:url value='/Admin/Management.do'/> ">
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
					
					<li class="sidebar-item active">
						<a class="sidebar-link" href="<c:url value='/Admin/Settings.do' />">
              <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Settings</span>
            </a>
					</li>
					
					<li class="sidebar-item">
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

					<h1 class="h3 mb-3">Settings</h1>

					<div class="row">
						<div class="col-md-3 col-xl-2">

							<div class="card">
								<div class="card-header">
									<h5 class="card-title mb-0">Profile Settings</h5>
								</div>

								<div class="list-group list-group-flush" role="tablist">
									<a class="list-group-item list-group-item-action active" data-toggle="list" href="#account" role="tab">
          								Account
        							</a>
									<a class="list-group-item list-group-item-action" data-toggle="list" href="#slack" role="tab">
          								Slack Settings
        							</a>
									<a class="list-group-item list-group-item-action" data-toggle="list" href="#github" role="tab">
          								Github Settings
       			 					</a>
								</div>
							</div>
						</div>

						<div class="col-md-9 col-xl-10">
							<div class="tab-content">
								<div class="tab-pane fade show active" id="account" role="tabpanel">

									<div class="card">
										<div class="card-header">

											<h5 class="card-title mb-0">PSG Info</h5>
										</div>
										<div class="card-body">
												<div class="row">
													<div class="col-md-8">
														<div class="mb-3">
															<label class="form-label" for="user_name">Username: </label>
															<sec:authorize access="isAuthenticated()">
            													<sec:authentication property="principal" var="user" />            
                													<label class="form-label" for="user_name">${user.username}</label>
                											</sec:authorize>
																														
															<input type="text" class="form-control" id="user_name" placeholder="Username">
														</div>													
													</div>							
												</div>

												<button id="username_save" type="button" class="btn btn-primary">Save changes</button>
											
										</div>
										
										<div class="card-body">
											
												<div class="row">
													<div class="col-md-8">
														<div class="mb-3">
															<label class="form-label" for="kakao_name">Kakao_Name: </label>
                													<label class="form-label" for="kakao_name">${kakao_info}</label>
                											
																														
															<input type="text" class="form-control" id="kakao_name" placeholder="Kakao_Name">
														</div>													
													</div>							
												</div>

												<button id="kakao_save" type="button" class="btn btn-primary">Save changes</button>
										</div>
									</div>

								</div>
								
								<div class="tab-pane fade" id="slack" role="tabpanel">
									<div class="card">
										<div class="card-header">

											<h5 class="card-title mb-0">Slack</h5>
										</div>
										<div class="card-body">
											<table class="table table-hover my-0" id="slack_table">
									<thead>
										<tr>
											<th>Slack Username</th>											
											<th>Settings</th>
										</tr>
									</thead>
									<c:forEach items="${slack_info}" var="slack">
									<c:choose>
									<c:when test="${not empty slack}">
									<tbody>
										<tr>
											<td class="d-none d-xl-table-cell">${slack.slack_name}</td>
											<td>
												<a class="delete_slack">Delete</a>
											</td>
										</tr>										
									</tbody>
									</c:when>
									</c:choose>									
									</c:forEach>
								</table>
									</div>
										
										<div class="card-body">
											<table class="table table-hover my-0" id="slack_append_table">
									<thead>
										<tr>
											<th>Slack Info 추가</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><input type="text" class="form-control" id="slack_info" placeholder="Slack Username"></td>
											<td><button type="button" class="btn btn-primary" id="append_slack_row">추가</button>
										</tr>										
									</tbody>
								</table>
										</div>
									</div>
								</div>
								
								<div class="tab-pane fade" id="github" role="tabpanel">
									<div class="card">
										<div class="card-header">

											<h5 class="card-title mb-0">Github</h5>
											<p>슬랙에 연동한 Github 유저네임을 추가해주세요.</p>
										</div>
										<div class="card-body">
											<table class="table table-hover my-0" id="github_table">
									<thead>
										<tr>
											<th>Github Username</th>	
											<th>Github Repo</th>
											<th>Github Token</th>										
											<th>Settings</th>
										</tr>
									</thead>
									<c:forEach items="${github_info}" var="github">
									<c:choose>
									<c:when test="${not empty github}">
									<tbody>
										<tr>
											<td class="d-none d-xl-table-cell">${github.github_name}</td>
											<td class="d-none d-xl-table-cell">${github.github_repo}</td>
											<td class="d-none d-xl-table-cell">${github.github_token}</td>
											<td>
												<a class="delete_github">Delete</a>
											</td>
										</tr>										
									</tbody>
									</c:when>
									</c:choose>									
									</c:forEach>
								</table>

										</div>
										
										<div class="card-body">
										
								
								<table class="table table-hover my-0" id="github_append_table">
									<thead>
										<tr>
											<th>Github Info 추가</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><input type="text" class="form-control" id="github_username" placeholder="Github Username"></td>
											<td><input type="text" class="form-control" id="github_repo" placeholder="Github Repo"></td>
											<td><input type="text" class="form-control" id="github_token" placeholder="Github Token"></td>
											<td><button type="button" class="btn btn-primary" id="append_github_row">추가</button></td>
										</tr>										
									</tbody>
								</table>
										
										
										</div>
										
										
									</div>
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
								<a href="<c:url value='/Admin/Management.do' /> " class="text-muted"><strong>PSG Admin Page</strong></a>
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

	<script src="<c:url value='/js/app.js'/> "></script>

</body>

</html>
