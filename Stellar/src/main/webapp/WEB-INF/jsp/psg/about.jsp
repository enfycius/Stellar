<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
    </script>
    
    <script src="<c:url value='/js/all.js' /> "></script>
    
    
    <!-- Favicon -->
    <link rel="icon" href="<c:url value='/images/favicon.png' /> " type="image/png"> <!-- Font Awesome -->
    
    <link rel="stylesheet" href="<c:url value='/css/all.css' /> ">
    <!-- StyleSheet -->
    <link rel="stylesheet" href="<c:url value='/css/main.css' /> " id="stylesheet">
</head>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>

    <!-- Navbar -->
    <jsp:include page="../include/header.jsp" />
    <!-- Main content -->
    <section class="slice py-8 bg-primary">
        <div class="container py-5">
            <div class="row row-grid align-items-center">
                <div class="col-lg-8 text-center text-lg-left">
                    <!-- Heading -->
                    <h1 class="text-white mb-4">
                        우리는 최고의 교육 플랫폼을 위해서 <br>끊임없이 노력합니다.
                    </h1>
                    <!-- Text -->
                    <p class="lead text-white opacity-8">
                        우리는 PSG Admin입니다.
                    </p>

                </div>
            </div>
        </div>
        <!-- SVG separator -->
        <div class="shape-container shape-line shape-position-bottom">
            <svg width="2560px" height="100px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" preserveAspectRatio="none" x="0px" y="0px" viewBox="0 0 2560 100" style="enable-background:new 0 0 2560 100;" xml:space="preserve" class="">
                <polygon points="2560 0 2560 100 0 100"></polygon>
            </svg>
        </div>
    </section>
    
    <section class="slice slice-lg">
        <div class="container">
            <span class="badge badge-primary badge-pill">Our Vision</span>
            <div class="row mt-4">
                <div class="col-lg-6 pr-lg-5">
                    <p class="h5 lh-180 mb-3">
                        최고의 프로그래밍 스터디그룹을 향해 끊임없이 노력할것입니다.
                    </p>
                </div>
                <div class="col-lg-6">
                    <p class="lead lh-180">
                        우리는 <strong class="text-primary">PSG</strong>입니다.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="slice slice-lg pt-10 bg-primary">
        <!-- SVG separator -->
        <div class="shape-container shape-line shape-position-top shape-orientation-inverse">
            <svg width="2560px" height="100px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" preserveAspectRatio="none" x="0px" y="0px" viewBox="0 0 2560 100" style="enable-background:new 0 0 2560 100;" xml:space="preserve" class="">
                <polygon points="2560 0 2560 100 0 100"></polygon>
            </svg>
        </div>
        <!-- Container -->
        <div class="container">
            <div class="row row-grid">
                <div class="col-lg-8">
                    <!-- Badge -->
                    <span class="badge badge-warning badge-pill">Info</span>
                    <!-- Title -->
                    <h2 class="my-4 text-white">현재 PSG는</h2>
                </div>
            </div>
            <!-- Milestones -->
            <div class="row mt-6">
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="card shadow-lg rounded-lg border-0 mb-sm-0">
                                <div class="p-4 text-center text-sm-left">
                                    <h3 class="mb-0">${memberCount}</h3>
                                    <p class="text-muted mb-0">
                                        Member
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card shadow-lg rounded-lg border-0 mb-sm-0">
                                <div class="p-4 text-center text-sm-left">
                                    <h3 class="mb-0">${commitCountToday}</h3>
                                    <p class="text-muted mb-0">
                                        Today Request
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="card shadow-lg rounded-lg border-0 mb-sm-0">
                                <div class="p-4 text-center text-sm-left">
                                    <h3 class="mb-0">xxx</h3>
                                    <p class="text-muted mb-0">
                                        Very Hard Studying Users
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="slice slice-lg pb-5">
        <div class="container">
            <!-- Section title -->
            <div class="row mb-5 justify-content-center text-center">
                <div class="col-lg-8 col-md-10">
                    <h2 class=" mt-4">The PSG Admin</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6 mb-5">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="#">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/kjh.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">김종혁</h5>
                            <p class="text-muted text-sm mb-0">Founder &amp; Manager</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mb-5">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="#">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/turtle.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">김지환</h5>
                            <p class="text-muted text-sm mb-0">Manager</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mb-5">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="#">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/kyg.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">김영관</h5>
                            <p class="text-muted text-sm mb-0">Manager</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mb-5">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="#">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/nice.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">이동호</h5>
                            <p class="text-muted text-sm mb-0">Manager</p>
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
