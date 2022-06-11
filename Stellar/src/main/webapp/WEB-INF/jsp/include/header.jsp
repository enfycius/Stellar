<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Webpixels">
    <title>PSG</title>
    <!-- Preloader -->
    
    <!-- Favicon -->
    <link rel="icon" href="<c:url value='/images/favicon.png'/>" type="image/png">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<c:url value='/css/all.css'/>">
    <!-- StyleSheet -->
    <link rel="stylesheet" href="<c:url value='/css/main.css'/>" id="stylesheet">
    
    
    <script defer src="<c:url value='/js/all.js' />"> </script>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white">
    <div class="container">
        <!-- Brand -->
        <a class="navbar-brand" href="<c:url value='/Main.do' /> ">
            <img alt="Image placeholder" src="<c:url value='/images/logo.png' />" id="navbar-logo">
        </a>
        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Collapse -->
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mt-4 mt-lg-0 ml-auto">
                <li class="nav-item ">
                    <a class="nav-link" href="<c:url value='/Main.do'/> ">Home</a>
                </li>
                <li class="nav-item dropdown dropdown-animate" data-toggle="hover">
                    <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Info</a>
                    <div class="dropdown-menu dropdown-menu-single">
                        <a href="<c:url value='/About.do' />" class="dropdown-item">About us</a>
                        <a href="<c:url value='/Contact.do' />" class="dropdown-item">Contact</a>
                        <a href="<c:url value='/Developer.do' />" class="dropdown-item">Developer</a>                       	
            		</div>
            	</li>		 
            				<sec:authorize access="hasRole('ROLE_MEMBER')">
            		<sec:authentication property="principal" var="user" />
	            		<li class="nav-item dropdown dropdown-animate" data-toggle="hover">
	                    <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Management</a>
	                    <div class="dropdown-menu dropdown-menu-single">
	                        <div class="dropdown-item">PSG Member : ${user.username}</div>
	                        <a href="<c:url value='/Member/Management.do'/>" class="navbar-btn btn btn-sm btn-primary">
               					Management Page
            				</a>
	                        
	                    </div>
	
	               		</li>
		              
                
                </sec:authorize>  
                
                <sec:authorize access="hasRole('ROLE_ADMIN')">
            		<sec:authentication property="principal" var="user" />            		
	            		<li class="nav-item dropdown dropdown-animate" data-toggle="hover">
	                    <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Management</a>
	                    <div class="dropdown-menu dropdown-menu-single">
	                        <div class="dropdown-item">PSG Admin : ${user.username}</div>
	                        <a href="<c:url value='/Admin/Management.do'/>" class="navbar-btn btn btn-sm btn-primary">
               					Management Page
            				</a>	                        
	                    </div>	
	               		</li>
                </sec:authorize>   
            	
                            
				            		<li class="nav-item dropdown dropdown-animate" data-toggle="hover">
	            			        <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Profile</a>
	                    			<div class="dropdown-menu dropdown-menu-single">
	                    				<sec:authorize access="isAuthenticated()">
	            							<sec:authentication property="principal" var="user" />
	                        					<div class="dropdown-item">${user.username}</div>
	                       				 			<a href="<c:url value='/Logout.do'/> " class="dropdown-item">
               											Logout
            							 			</a>
            							 </sec:authorize>   
            							 
            							 <sec:authorize access="isAnonymous()">
            								<a href="<c:url value='/Login.do'/>" class="dropdown-item">
               									Login
            								</a>
            							 </sec:authorize>
	                        
	                   				 </div>
	
	               					</li>
		              
                
                			
                			
                	      
                            
            </ul>
            
                    </div>
                    
                    

                
            
            <!-- Button -->

            <sec:authorize access="isAnonymous()">
            	<a href="<c:url value='/Login.do'/>" class="navbar-btn btn btn-sm btn-primary d-none d-lg-inline-block ml-3">
               		Login
            	</a>
            </sec:authorize> 
            
            
            
         
            <!-- Mobile button -->

        </div>
</nav>
</body>
</html>
