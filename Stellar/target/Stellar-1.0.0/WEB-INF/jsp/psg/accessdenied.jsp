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
    
    <script defer src="<c:url value='/js/all.js' />"> </script>
    
    
    <!-- Favicon -->
    <link rel="icon" href="<c:url value='/images/favicon.png' />" type="image/png">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<c:url value='/css/all.css' />">
    <!-- StyleSheet -->
    <link rel="stylesheet" href="<c:url value='/css/main.css' />" id="stylesheet">
    
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
                    <a href="<c:url value='/pages/utility/terms.html' />" class="btn btn-sm btn-white" target="_blank">Learn more</a>
                    <button type="button" class="btn btn-sm btn-primary mr-2" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    
    

    <!-- Navbar -->
    <jsp:include page="../include/header.jsp" />
    <!-- Main content -->
    
        
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
                                AccessDenied 403
                            </h2>
                            
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
     <section class="slice slice-lg">
        <div class="container">
            <span class="badge badge-warning badge-pill">Condition</span>
            <div class="row mt-4">
                <div class="col-lg-6 pr-lg-5">
                    <p class="h5 lh-180 mb-3">
                        운영진만 접근가능합니다.
                    </p>
                </div>
            </div>
        </div>
    </section>
    




	<jsp:include page="../include/footer.jsp" />

    
    <!-- Core JS  -->
    <script src="<c:url value='/js/jquery.min.js' />"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
    <script src="<c:url value='/js/svg-injector.min.js' />"></script>
    <script src="<c:url value='/js/feather.min.js' />"></script>
    <!-- JS -->
    <script src="<c:url value='/js/main.js' />"></script>
    <!-- Feather Icons -->
    <script>
        feather.replace({
            'width': '1em',
            'height': '1em'
        })
    </script>
</body>

</html>
