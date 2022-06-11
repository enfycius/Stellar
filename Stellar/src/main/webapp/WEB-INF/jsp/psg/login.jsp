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
    <script>
        window.addEventListener("load", function() {
            setTimeout(function() {
                document.querySelector('body').classList.add('loaded');
            }, 300);
        });
        
        function show_password() {
        	var x = document.getElementById("password");
        	
        	if(x.type == "password")
        		x.type = "text";
        	else
        		x.type = "password";
        }
        
    </script>
    <!-- Favicon -->
    <link rel="icon" href="<c:url value='/images/favicon.png' />" type="image/png"><!-- Font Awesome -->
    <link rel="stylesheet" href="<c:url value='/css/all.css' /> ">
    <!-- Quick CSS -->
    <link rel="stylesheet" href="<c:url value='/css/main.css' /> " id="stylesheet">
</head>

<body>
    
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
    	<div class="container">
        	<!-- Brand -->
        	<a class="navbar-brand" href="<c:url value='/Main.do' /> ">
          	  <img alt="Image placeholder" src="<c:url value='/images/logo.png' />" id="navbar-logo">
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
                                <h6 class="h3">Login</h6>
                                <p class="text-muted mb-0">Sign in to your account to continue.</p>
                            </div>
                            <span class="clearfix"></span>
                            
                            
                            <form name="f" action="<c:url value='/Login.do'/>" method="POST">
                                <div class="form-group">
                                
                                    <label class="form-control-label">ID</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="user"></i></span>
                                        </div>
                                        <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                                    </div>
                                </div>
                                <div class="form-group mb-0">
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
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <button type="submit" class="btn btn-block btn-primary">Sign in</button>
                                </div>
                                
                              	<div class="mt-4">
                              		<p>${requestScope.loginFailMsg}</p>
                              	</div>
                                
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            </form>
                        </div>
                        <div class="card-footer px-md-5"><small>Not registered?</small>
                            <a href="<c:url value='/Register.do' /> " class="small font-weight-bold">Create account</a></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Core JS  -->
    <script src="<c:url value='/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
    <script src="<c:url value='/js/svg-injector.min.js'/>"></script>
    <script src="<c:url value='/js/feather.min.js' />"></script>
    <!-- JS -->
    <script src="<c:url value='/js/main.js' />" ></script>
    <!-- Feather Icons -->
    <script>
        feather.replace({
            'width': '1em',
            'height': '1em'
        })
    </script>
</body>

</html>
