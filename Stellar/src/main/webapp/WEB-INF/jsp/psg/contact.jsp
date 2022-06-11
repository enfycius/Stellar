<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">

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
    
    <script defer src="<c:url value='/js/all.js' /> "></script>
    
    <!-- Favicon -->
    <link rel="icon" href="<c:url value='/images/favicon.png' /> " type="image/png"><!-- Font Awesome -->
    <link rel="stylesheet" href="<c:url value='/css/all.css' /> ">
    <!-- Quick CSS -->
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
    <section class="slice py-6 pt-lg-7 pb-lg-8 bg-dark">
        <!-- Container -->
        <div class="container">
            <div class="row row-grid align-items-center">
                <div class="col-lg-6">
                    <!-- Heading -->
                    <h1 class="h1 text-white text-center text-lg-left my-4">
                        PSG에 처음 오셨나요?
                    </h1>
                    <!-- Text -->
                    <p class="lead text-white text-center text-lg-left opacity-8">
                        카카오톡 채널 PSG를 추가해주세요.
                    </p>
                    <!-- Buttons -->
                    <div class="mt-5 text-center text-lg-left">
                        <a href="http://pf.kakao.com/_PEmxfxb/chat" data-scroll-to class="btn btn-white btn-lg btn-icon">
                            <span class="btn-inner--icon">
                                <img src="<c:url value='/images/kakaotalk.svg' /> " alt="kakaotalk">
                            </span>
                            <span class="btn-inner--text">카카오톡 채널(PSG)</span>
                        </a>
                    </div>

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
            <div class="row">
                <div class="col-lg-4">
                    <div class="card text-center hover-translate-y-n10 hover-shadow-lg">
                        <div class="px-5 pb-5 pt-5">
                            <div class="py-4">
                                <div class="icon text-warning icon-sm mx-auto">
                                    <i data-feather="phone-call"></i>
                                </div>
                            </div>
                            <h5 class="">김종혁</h5>
                            <p class="mt-2 mb-0">카카오톡 아이디 <br> <strong class="text-warning">hexk0131</strong></p>
                            <p class="mt-2 mb-0">이메일 주소 <br> <strong class="text-warning">hexk0131@gmail.com</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card text-center hover-translate-y-n10 hover-shadow-lg">
                        <div class="px-5 pb-5 pt-5">
                            <div class="py-4">
                                <div class="icon text-warning icon-sm mx-auto">
                                    <i data-feather="phone-call"></i>
                                </div>
                            </div>
                            <h5 class="">김지환</h5>
                            <p class="mt-2 mb-0">카카오톡 아이디 <br> <strong class="text-warning">shinbian11</strong></p>
                            <p class="mt-2 mb-0">이메일 주소 <br> <strong class="text-warning">shinbian11@naver.com</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card text-center hover-translate-y-n10 hover-shadow-lg">
                        <div class="px-5 pb-5 pt-5">
                            <div class="py-4">
                                <div class="icon text-warning icon-sm mx-auto">
                                    <i data-feather="phone-call"></i>
                                </div>
                            </div>
                            <h5 class="">김영관</h5>
                            <p class="mt-2 mb-0">카카오톡 아이디 <br> <strong class="text-warning">positiveperson</strong></p>
                            <p class="mt-2 mb-0">이메일 주소 <br> <strong class="text-warning">timeundtime@gmail.com</strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card text-center hover-translate-y-n10 hover-shadow-lg">
                        <div class="px-5 pb-5 pt-5">
                            <div class="py-4">
                                <div class="icon text-warning icon-sm mx-auto">
                                    <i data-feather="phone-call"></i>
                                </div>
                            </div>
                            <h5 class="">도호</h5>
                            <p class="mt-2 mb-0">카카오톡 아이디 <br> <strong class="text-warning">nach4176</strong></p>
                            <p class="mt-2 mb-0">이메일 주소 <br> <strong class="text-warning">edh1021@gmail.com</strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="slice slice-lg pt-10 bg-dark">
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
                    <h2 class="my-4 text-white">Manager Info</h2>
                </div>
            </div>
        </div>
    </section>

    <section class="slice slice-lg">
        <div class="container text-center text-lg-left">
            <!-- Title -->
            <div class="row">
                <div class="col-lg-6 col-md-10">
                    <span class="badge badge-primary badge-pill">Support</span>
                </div>
            </div>
            <!-- Team -->
            <div class="row mt-3">
                <div class="col-lg-3 col-sm-6 mb-5 mb-lg-0">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="https://github.com/enfycius">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/kjh.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">김종혁</h5>
                            <p class="text-muted text-sm mb-0">Founder &amp; Manager</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mb-5 mb-lg-0">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="https://github.com/shinbian11">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/turtle.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">김지환</h5>
                            <p class="text-muted text-sm mb-0">Manager</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mb-5 mb-lg-0">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="https://github.com/zedonora">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/kyg.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">김영관</h5>
                            <p class="text-muted text-sm mb-0">Manager</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mb-5 mb-lg-0">
                    <div data-animate-hover="2">
                        <div class="animate-this">
                            <a href="https://github.com/LeeDongHo">
                                <img alt="Image placeholder" class="img-fluid rounded shadow" src="<c:url value='/images/nice.png' /> ">
                            </a>
                        </div>
                        <div class="mt-3">
                            <h5 class="h6 mb-0">도호</h5>
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
