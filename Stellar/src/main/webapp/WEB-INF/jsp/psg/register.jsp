<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Webpixels">
    <title>PSG</title>
    <!-- Preloader -->
    <style>
        @keyframes hidePreloader {
            0% {
                width: 100%;
                height: 100%;
            }

            100% {
                width: 0;
                height: 0;
            }
        }

        body>div.preloader {
            position: fixed;
            background: white;
            width: 100%;
            height: 100%;
            z-index: 1071;
            opacity: 0;
            transition: opacity .5s ease;
            overflow: hidden;
            pointer-events: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        body:not(.loaded)>div.preloader {
            opacity: 1;
        }

        body:not(.loaded) {
            overflow: hidden;
        }

        body.loaded>div.preloader {
            animation: hidePreloader .5s linear .5s forwards;
        }
      </style>
      
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
        window.addEventListener("load", function() {
            setTimeout(function() {
                document.querySelector('body').classList.add('loaded');
            }, 300);
        });
            
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
        
        function show_password() {
        	var x = document.getElementById("password");
        	
        	if(x.type == "password")
        		x.type = "text";
        	else
        		x.type = "password";
        }
        
        function show_check_password() {
        	var x = document.getElementById("passwordCheck");
        	
        	if(x.type == "password")
        		x.type = "text";
        	else
        		x.type = "password";
        }
 
        var MbrInput = {
        		
        		joinSubmitFn : function() {
        			
        			if (!($('#username').prop('readonly'))) 
        				return false;        			
        			if(!this.pwdChkFn())
        				return false;
        			if(!this.emailChkFn())
        				return false;
        			
        			$("form").submit();
        		},
        		
        		duplicateChkFn : function() {
    				var loginId = $('#username').val();
    				
    				var token=$("input[name='_csrf']").val();
    				var header = "X-CSRF-TOKEN";
    				    				
    				if(!this.idValidChkFn(loginId))
    					return false;
    				
    				$.ajax({
    					url : "<c:url value='/DupIdChk.do'/>",
    					method : "get",
    					data : {"loginId" : loginId},
    					async : false,
    					
    					beforeSend : function(xhr) {
    						xhr.setRequestHeader(header, token);
    					},
    					
    					success : function(data) {
    						var dupCnt = data;
    						
    						if(dupCnt > 0) {
    							show_info(loginId + "은/는 사용하실 수 없습니다.");
    						}
    						else {
    							show_info(loginId + "은/는 사용가능 합니다.");
    							$("#username").attr("readonly",true);
    						}
    						    		
    					},
    					error : function(request, status, error) {
    						show_info("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    					}
    					
    				})
    			},
    			
    			idValidChkFn : function(loginId) {
    				var reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,12}$/;
    				
    				if(!reg.test(loginId)) {
    					show_info("아이디가 유효하지 않습니다");
    					
    					return false;
    				}
    				
    				return true;
    			}, 
    			 			
    			// 비밀번호 유효성 체크
            	pwdChkFn : function() {
            		var reg 	  		= /^(?=.*[a-zA-Z])(?=.*[!@#$^*+=-])(?=.*[0-9]).{8,15}$/;
            		var password 		= $("#password").val();
            		var passwordCheck 	= $("#passwordCheck").val();
            		
            		
            		if (!reg.test(password)) {       			        			
            			show_info("비밀번호는 영문/숫자/특수문자 포함 8~15 자리 입력해 주세요.");
            			
            			return false;
            		}
    				
            		// 비밀번호 확인
            		if (password !== passwordCheck) {					
    					show_info("비밀번호가 일치하지 않습니다. 일치하게 입력해 주세요.");
            			
            			return false;
            		}
            		
            		return true;
            	},
            	
    			// 이메일 유효성 체크
            	emailChkFn	: function() {
            		var reg    = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
            		var email = $("#email").val();
    				
            		if (!reg.test(email)) {				
    					show_info("이메일 형식에 맞게 입력해 주세요.");
            			
            			return false;
            		}
            		
            		return true;
            	}

    			    			
    			
    	}
    
    </script>
    <!-- Favicon -->
    <link rel="icon" href="<c:url value='/images/favicon.png' /> " type="image/png"><!-- Font Awesome -->
    <link rel="stylesheet" href="<c:url value='/css/all.css' /> ">
    <!-- Quick CSS -->
    <link rel="stylesheet" href="<c:url value='/css/main.css' /> " id="stylesheet">
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
    
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
    	<div class="container">
        	<!-- Brand -->
        	<a class="navbar-brand" href="<c:url value='/Main.do' /> ">
          	  <img alt="Image placeholder" src="<c:url value='/images/logo.png' /> " id="navbar-logo">
        	</a>
    	</div>
    </nav>
    
    <!-- Main content -->
    <section>
        <div class="container d-flex flex-column">
            <div class="row align-items-center justify-content-center min-vh-100">
                <div class="col-md-6 col-lg-5 col-xl-5 py-6 py-md-0">
                    <div class="card shadow zindex-100 mb-0">
                        <div class="card-body px-md-5 py-5">
                            <div class="mb-5">
                                <h6 class="h3">Sign up</h6>
                                <p class="text-muted mb-0">Sign up to your account to continue.</p>
                            </div>
                            <span class="clearfix"></span>
                            
                            <form name="f" action="<c:url value='/Register.do' /> " method="POST">
                                <div class="form-group">
                                	
                                
                                    <label class="form-control-label">ID</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="user"></i></span>
                                        </div>
                                        <input type="text" class="form-control" id="username" name="username" placeholder="아이디">
                                                                              
                                    </div>
                                </div>
                                
                                
                                <div class="form-group">
                                	<button type="button" class="btn btn-block btn-primary" onclick="MbrInput.duplicateChkFn()">아이디 중복 확인</button>
                                </div>
                                
                             
                                <div class="form-group">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <label class="form-control-label">Password</label>
                                        </div>
                                        <div class="mb-2">
                                            <a href="#" class="small text-muted text-underline--dashed border-primary" data-toggle="password-text" data-target="#input-password" onclick="show_password()">Show password</a>
                                        </div>
                                    </div>
                                    
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="key"></i></span>
                                        </div>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <label class="form-control-label">Confirm Password</label>
                                        </div>
                                        <div class="mb-2">
                                            <a href="#" class="small text-muted text-underline--dashed border-primary" data-toggle="password-text" data-target="#input-password" onclick="show_check_password()">Show password</a>
                                        </div>
                                    </div>
                                    
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="key"></i></span>
                                        </div>
                                        <input type="password" class="form-control" id="passwordCheck" name="passwordCheck" placeholder="비밀번호 확인">
                                    </div>
                                </div>
                                
                                
                                <div class="form-group">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <label class="form-control-label">Email</label>
                                        </div>                                    
                                    </div>
                                    
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="key"></i></span>
                                        </div>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="이메일">
                                    </div>
                                </div>
                               
                                <div class="mt-4">
                                    <button type="button" class="btn btn-block btn-primary" onclick="MbrInput.joinSubmitFn()">Sign up</button>
                                </div>
                                
                                <input type="hidden" class="form-control" name="${_csrf.parameterName}" value="${_csrf.token}">
                                        
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Core JS  -->
    <script src="<c:url value='/js/jquery.min.js' /> "></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js' /> "></script>
    <script src="<c:url value='/js/svg-injector.min.js' /> "></script>
    <script src="<c:url value='/js/feather.min.js' /> "></script>
    <!-- JS -->
    <script src="<c:url value='/js/main.js' /> "></script>
    <!-- Feather Icons -->
    <script>
        feather.replace({
            'width': '1em',
            'height': '1em'
        })
    </script>
</body>

</html>
