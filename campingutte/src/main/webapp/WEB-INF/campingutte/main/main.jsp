<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
		<link rel="stylesheet" href="resource/css/styles.css">
		<script src="resource/js/scripts.js"></script>
		
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>캠핑어때</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        

    </head>
    <script type="text/javascript">
    function searchList(){
    	var f = document.campList;
    	f.submit();
    }
    </script>
    <body class="d-flex flex-column h-100">
    
    <!-- header(메뉴바) 부분 -->
    <jsp:include page="/WEB-INF/campingutte/layout/header.jsp"></jsp:include>
    
    
        <main class="flex-shrink-0">
            <!-- Header-->
            <header class="bg-dark py-5">
     
                <div class="container px-5">
                    <div class="row gx-5 align-items-center justify-content-center">
                        <div class="col-lg-8 col-xl-7 col-xxl-6">
                        
				            <div class="ms-xl-4">
			                    <div class="small text-white-50">오늘은 어디로 가볼까?</div>
			                    <form name="campList"  action="${pageContext.request.contextPath}/book/campList.do" method="post">
			                	<div class="input-group mb-2">
			                    	<input class="form-control" type="text" name="campName" value="${campName}" placeholder="캠핑장 검색" aria-label="Email address..." aria-describedby="button-newsletter" />
			                        <button class="btn btn-outline-light" id="button-newsletter" type="button">Search</button>
			          				
			                    </div>
			                    </form>
			                </div>
			                
                            <!--  
                            <div class="my-5 text-center text-xl-start">                      
                                <h1 class="display-5 fw-bolder text-white mb-2">A Bootstrap 5 template for modern businesses</h1>
                                <p class="lead fw-normal text-white-50 mb-4">Quickly design and customize responsive mobile-first sites with Bootstrap, the worldâs most popular front-end open source toolkit!</p>
                                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                                    <a class="btn btn-primary btn-lg px-4 me-sm-3" href="#features">Get Started</a>
                                    <a class="btn btn-outline-light btn-lg px-4" href="#!">Learn More</a>
                                </div>
                            </div>
                            -->
                            
                        </div>
                        
                        <!--  
                        <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="https://dummyimage.com/600x400/343a40/6c757d" alt="..." /></div>
                    	-->
                    	
                    </div>
                </div>
            </header>
            
 
            <!-- Features section-->
            <!-- 
            <section class="py-5" id="features">
                <div class="container px-5 my-5">
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">A better way to start building.</h2></div>
                        <div class="col-lg-8">
                            <div class="row gx-5 row-cols-1 row-cols-md-2">
                                <div class="col mb-5 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-collection"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                                <div class="col mb-5 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-building"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                                <div class="col mb-5 mb-md-0 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                                <div class="col h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                    <h2 class="h5">Featured title</h2>
                                    <p class="mb-0">Paragraph of text beneath the heading to explain the heading. Here is just a bit more text.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
             -->
            
            <!-- Testimonial section-->
            <!-- 
            <div class="py-5 bg-light">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-10 col-xl-7">
                            <div class="text-center">
                                <div class="fs-4 mb-4 fst-italic">"Working with Start Bootstrap templates has saved me tons of development time when building new projects! Starting with a Bootstrap template just makes things easier!"</div>
                                <div class="d-flex align-items-center justify-content-center">
                                    <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                    <div class="fw-bold">
                                        Tom Ato
                                        <span class="fw-bold text-primary mx-1">/</span>
                                        CEO, Pomodoro
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			 -->
            
            <!-- Blog preview section-->
            <section class="py-5">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <div class="text-center">
                                <h2 class="fw-bolder">테마별로 떠나는 캠핑</h2>
                                <p class="lead fw-normal text-muted mb-5"></p>
                            </div>
                        </div>
                    </div>
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="/campingutte/resource/images/tvshow.jpg" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">가족과 함께 떠나기 좋은 캠핑장</h5></a>
                                    <p class="card-text mb-0">
                                    바쁘고 지친 일상에서 벗어나 가족들과 오붓한 시간 어떠신가요??<br>
                                    잠시 현실은 제쳐두고 가족들과 둘러앉아 바베큐도 하고, 캠프파이어도 하는 힐링여행을 떠나보세요!
                                    <br>캠핑어때가 당장 떠날 수 있는 곳을 소개해드립니다!
                                    </p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="resource/css/campfire.jpg" style="width: 50px; height: 50px;" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">캠핑장 보러가기!</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="/campingutte/resource/images/doggy.jpg" style="width: 376px; height: 250px;" alt="..."/>
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">Media</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">반려동물과 함께 하는 캠핑장</h5></a>
                                    <p class="card-text mb-0">
                                    반려동물과 함께하는 사람들이 천만에 가깝다는 얘기도 들리는 요즘, 함께 갈 수 있는 곳은 한정되어 있어 아쉬우셨죠?? <br>
                                    캠핑어때에서는 반려동물과 함께 소중한 하루를 보낼 수 있는 캠핑장을 찾아드립니다!!
                                    지금 당장 소중한 동물친구와 여행을 떠나 보세요!
                        
                                    </p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="resource/css/dog.jpg" alt="..." style="width: 50px; height: 50px;"/>
                                            <div class="small">
                                                <div class="fw-bold">캠핑장 보러가기!</div>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="/campingutte/resource/images/horse.jpg" alt="..." />
                                <div class="card-body p-4">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">액티브한 즐길거리가 가득한 캠핑장</h5></a>
                                    <p class="card-text mb-0">
                                    뻔한 캠핑은 그만! <br>
                                    액티브함을 느낄 수 있는 캠핑장은 어떠신가요??
                                    지금 바로 친구 또는 가족, 연인과 함께 떠나보세요!
                                    
                                    </p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="resource/css/acamp.jpg" alt="..." style="width: 50px; height: 50px;" />
                                            <div class="small">
                                                <div class="fw-bold">캠핑장 보러가기!</div>
                                            	
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Call to action-->
                    <!-- 
                    <aside class="bg-primary bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                        <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                            <div class="mb-4 mb-xl-0">
                                <div class="fs-3 fw-bold text-white">New products, delivered to you.</div>
                                <div class="text-white-50">Sign up for our newsletter for the latest updates.</div>
                            </div>
                            <div class="ms-xl-4">
                                <div class="input-group mb-2">
                                    <input class="form-control" type="text" placeholder="Email address..." aria-label="Email address..." aria-describedby="button-newsletter" />
                                    <button class="btn btn-outline-light" id="button-newsletter" type="button">Sign up</button>
                                </div>
                                <div class="small text-white-50">We care about privacy, and will never share your data.</div>
                            </div>
                        </div>
                    </aside>
                     -->
                </div>
            </section>
        </main>
         
  	<!-- footer 부분 -->
	<jsp:include page="/WEB-INF/campingutte/layout/footer.jsp"></jsp:include>        
      
    </body>
</html>
