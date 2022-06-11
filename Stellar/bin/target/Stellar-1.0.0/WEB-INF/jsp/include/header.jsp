<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <link rel="icon" href="images/favicon.png" type="image/png">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="css/all.css">
    <!-- StyleSheet -->
    <link rel="stylesheet" href="css/main.css" id="stylesheet">
    
    
    <script defer src="js/all.js"></script>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white">
    <div class="container">
        <!-- Brand -->
        <a class="navbar-brand" href="./Main.do">
            <img alt="Image placeholder" src="images/logo.png" id="navbar-logo">
        </a>
        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Collapse -->
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mt-4 mt-lg-0 ml-auto">
                <li class="nav-item ">
                    <a class="nav-link" href="./Main.do">Home</a>
                </li>
                <li class="nav-item dropdown dropdown-animate" data-toggle="hover">
                    <a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pages</a>
                    <div class="dropdown-menu dropdown-menu-single">
                        <a href="./Intro.do" class="dropdown-item">Intro</a>
                        <a href="./About.do" class="dropdown-item">About us</a>
                        <a href="./Contact.do" class="dropdown-item">Contact</a>
                        <sec:authorize access="isAnonymous()">
                        	<div class="dropdown-divider"></div>
                       	 	<a href="./Login.do" class="dropdown-item">Login</a>
                        </sec:authorize>
                        
                        <sec:authorize access="isAuthenticated()">
                        	<form:form action="./logout" method="POST">
                        		<div class="dropdown-divider"></div>
                       	 		<a class="dropdown-item">Logout</a>
                       	 	</form:form>
                        </sec:authorize>
                        
                    </div>

                </li>
            </ul>
            <!-- Button -->
            <a class="navbar-btn btn btn-sm btn-primary d-none d-lg-inline-block ml-3" href="/Login.do">
                Login
            </a>
            <!-- Mobile button -->

        </div>
    </div>
</nav>
</body>
</html>
