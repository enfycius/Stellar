<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML>
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
    
    <script defer src="js/all.js"></script>
    
    
    <!-- Favicon -->
    <link rel="icon" href="images/favicon.png" type="image/png">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="css/all.css">
    <!-- StyleSheet -->
    <link rel="stylesheet" href="css/main.css" id="stylesheet">
    
</head>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="spinner-border text-primary" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
     
    <div class="modal fade" tabindex="-1" role="dialog" id="modal-cookies" data-backdrop="false" aria-labelledby="modal-cookies" aria-hidden="true">
        <div class="modal-dialog modal-dialog-aside left-4 right-4 bottom-4">
            <div class="modal-content bg-dark-dark">
                <div class="modal-body">
                    <!-- Text -->
                    <p class="text-sm text-white mb-3">
                        We use cookies so that our themes work for you. By using our website, you agree to our use of cookies.
                    </p>
                    <!-- Buttons -->
                    <a href="pages/utility/terms.html" class="btn btn-sm btn-white" target="_blank">Learn more</a>
                    <button type="button" class="btn btn-sm btn-primary mr-2" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    
    

    <!-- Navbar -->
    <jsp:include page="../include/header.jsp" />
    <!-- Main content -->
    
        
    <section class="slice py-7">
        <div class="container">
            <div class="row row-grid align-items-center">
                <div class="col-12 col-md-5 col-lg-6 order-md-2 text-center">
                    <!-- Image -->
                    <figure class="w-100">
                        <img alt="Image placeholder" src="images/main.svg" class="img-fluid mw-md-120">
                    </figure>
                </div>
                <div class="col-12 col-md-7 col-lg-6 order-md-1 pr-md-5">
                    <!-- Heading -->
                    <h1 class="display-4 text-center text-md-left mb-3">
                        <strong class="text-primary">P</strong>ractical,<br><strong class="text-primary">S</strong>truggling,<br><strong class="text-primary">G</strong>roup
                    </h1>
                    <!-- Text -->
                    <p class="lead text-center text-md-left text-muted">
                      Welcome to <strong class="text-primary">PSG</strong>
                    </p>
                    <!-- Buttons -->

                </div>
            </div>
        </div>
    </section>

    <section class="slice slice-lg bg-section-dark pt-5 pt-lg-8">
        <!-- SVG separator -->
       
        <div class="shape-container shape-line shape-position-top shape-orientation-inverse">
            <svg width="2560px" height="100px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" preserveAspectRatio="none" x="0px" y="0px" viewBox="0 0 2560 100" style="enable-background:new 0 0 2560 100;" xml:space="preserve" class="">
                <polygon points="2560 0 2560 100 0 100"></polygon>
            </svg>
        </div>
        
        <!-- Container -->
        <div class="container position-relative zindex-100">
            <div class="col">
                <div class="row justify-content-center">
                    <div class="col-md-10 text-center">
                        <div class="mt-4 mb-6">
                            <h2 class="h1 text-white">
                                준비되셨나요?
                            </h2>
                            <h4 class="text-white mt-3">이곳에서 새로운 경험을 해보세요 !</h4>
                            <!-- Play button -->
                            <a href="intro.html" class="btn btn-primary btn-icon mt-4">시작하기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="slice pt-5">
        <div class="container position-relative zindex-100">
            <div class="row justify-content-center">
                <div class="col-xl-4 col-sm-6">
                    <div class="card">
                        <div class="d-flex p-5">
                            <div>
                                <span class="badge badge-success badge-pill">Info</span>
                            </div>
                            <div class="pl-4">
                                <h5 class="lh-130">Total Team Members</h5>
                                <p class="text-muted mb-0">
                                      23
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-4 col-sm-6">
                    <div class="card">
                        <div class="d-flex p-5">
                            <div>
                                <span class="badge badge-success badge-pill">Info</span>
                            </div>
                            <div class="pl-4">
                                <h5 class="lh-130">Commit Traffic (Today)</h5>
                                <p class="text-muted mb-0">
                                    100
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

            <div class="container position-relative zindex-100">
              <div class="row justify-content-center">

                <div class="col-xl-4 col-md-6 col-sm-6">
                    <div class="card">
                        <div class="d-flex p-5">
                            <div>
                                <span class="badge badge-success badge-pill">Info</span>
                            </div>
                            <div class="pl-3">
                                <h5 class="lh-130">Commit Traffic (Monthly)</h5>
                                <p class="text-muted mb-0">
                                    1000
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-4 col-md-6 col-sm-6">
                    <div class="card">
                        <div class="d-flex p-5">
                            <div>
                                <span class="badge badge-success badge-pill">Info</span>
                            </div>
                            <div class="pl-3">
                                <h5 class="lh-130">Commit Traffic (Annually)</h5>
                                <p class="text-muted mb-0">
                                    100000
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
              </div>
            </div>
          </div>

        </div>
    </section>





	<jsp:include page="../include/footer.jsp" />

    
    <!-- Core JS  -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/svg-injector.min.js"></script>
    <script src="js/feather.min.js"></script>
    <!-- JS -->
    <script src="js/main.js"></script>
    <!-- Feather Icons -->
    <script>
        feather.replace({
            'width': '1em',
            'height': '1em'
        })
    </script>
</body>

</html>
