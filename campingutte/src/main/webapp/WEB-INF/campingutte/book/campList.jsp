<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.8.8/i18n/jquery.ui.datepicker-ko.js"></script>
<script src="${pageContext.request.contextPath}/resource/js/scripts.js"></script>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" type="text/css"/>
<link href="${pageContext.request.contextPath}/resource/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resource/css/header_footer-layout.css" rel="stylesheet" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<script type="text/javascript">
$(function(){
	$("#checkIn").datepicker({
		showMonthAfterYear:true,
		minDate:0
	});
});

$(function(){
	$("#checkOut").datepicker({
		showMonthAfterYear:true,
		minDate:"+2D"
	});
});

//숙박일 수 계산
function dateCalcul(){
	var start = $("input[name=srtDate]").datepicker('getDate');
	var end = $("input[name=endDate]").datepicker('getDate');
	
	var day = (end - start)/1000/60/60/24;

}

// 인원수 증가 및 감소
$(function(){
	$("body").on("click", ".btnPlus", function(){
		var count = parseInt($(this).parent("div").find("input[type=text]").val());
		
		
		count=count+1;
		
		$(this).parent("div").find("input[type=text]").val(count);
		
		var total = 0;
		$(this).closest(".peopleCount").find("input").each(function(){
			total += parseInt($(this).val());
			
		});
		$(".people").val(total);
		
	});
	
	$("body").on("click", ".btnMinus", function(){
		var count = parseInt($(this).parent("div").find("input[type=text]").val());
		count=count-1;
		
		if(count < 0) {
			return false;
		}
		$(this).parent("div").find("input[type=text]").val(count);
		
		var total = 0;
		$(this).closest(".peopleCount").find("input").each(function(){
			total += parseInt($(this).val());
			
		});
		$(".people").val(total);
		
	});
	
});


// 검색
function searchList(){
	var f = document.campList;
	f.submit();
}

</script>
<style type="text/css">

.col-lg-3 > input {
 	margin-bottom: 12px;
}

.headcount {
	box-sizing: border-box;
	display: block;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
}

.btnPlus {
	border: none;
}

.btnMinus {
	border: none;
}


.campsite-list {
	display: flex;
	width: 800px;
	margin: 10px 0;
	border: 1px solid black;
	border-radius: 10px;
}
 
.campsite-list > img {
	width: 300px;
	height: 200px;
}

.campsite-list1 {
	display: flex;
	flex-direction: column;
	justify-content: center;
	margin-left: 20px;
}


</style>
<title>검색리스트</title>

</head>
<body class="d-flex flex-column">
<!-- header(메뉴바) 부분 -->
<jsp:include page="/WEB-INF/campingutte/layout/header.jsp"></jsp:include>
	<main class="flex-shrink-0">
		
		<!-- Page Content-->
		<section class="py-5">
			<form name="campList" action="${pageContext.request.contextPath}/book/campList.do" method="post">

		    <div class="container px-5 my-5">
		        <div class="row gx-5">
		            <div class="col-lg-3">
		            <input type="text" id="checkIn" name="srtDate" value="${srtDate}" readonly="readonly" placeholder="체크인" class="form-control font-size-h5 font-weight-bolder" required="required">
		            <input type="text" id="checkOut" name="endDate" value="${endDate}" readonly="readonly" placeholder="체크아웃" class="form-control font-size-h5 font-weight-bolder" required="required">
		            <input type="text" name="addr1"  value="${addr1}" placeholder="지역" class="form-control font-size-h5 font-weight-bolder">
		            <input type="text" name="campName" value="${campName}" placeholder="캠핑장명" class="form-control font-size-h5 font-weight-bolder">
		            <div class="peopleCount">
			            <div>
			            	<span style="margin-right: 50px;">성인</span>
				            <button type="button" class="btnMinus">-</button>
				            <input type="text" name="adult" id="adult" readonly="readonly" value="1" style="border: none; padding: 0; text-align: center;">
				            <button type="button" class="btnPlus">+</button>
						</div>
						<div>
							<span style="margin-right: 50px;">아동</span>
				            <button type="button" class="btnMinus">-</button>
				            <input type="text" name="kid" id="kid" readonly="readonly" value="0" style="border: none; padding: 0; text-align: center;">
				            <button type="button" class="btnPlus">+</button>
						</div>
					</div>
					<div>
					
						<input type="hidden" class="people" name="people" value="${people}" readonly="readonly">
					</div>
		            <div><button class="btn btn-primary btn-lg" id="submitButton" type="button" style="width: 100%" onclick="searchList();">숙소 검색</button></div>
		                
		            </div>
		            
		            <div class="col-lg-9">
		                <!-- Post content-->
		                <article>
		                    <!-- Post header-->
		                    <header class="mb-4">
		                        <!-- Post title-->
		                        <h1 class="fw-bolder mb-1">캠핑장/글램핑/카라반 검색&예약</h1>
		                        <!-- Post meta content-->
		                        
		                        <div class="text-muted fst-italic mb-2">January 1, 2021</div>
		                        <hr>
		                    </header>

		                    <!-- 
		                    <div class="list-container">
			                   	<c:forEach var="dto" items="${list}">
									<div class="campsite-list"onclick="location.href='${articleUrl}&campNo=${dto.campNo}';" >
											<c:forEach var="vo" items="${dto.images}" varStatus="status">
												<c:if test="${status.index==0}">
												  <img src="${pageContext.request.contextPath}/uploads/admin/${vo.imgName}">
												</c:if>
											</c:forEach>
											<div class="campsite-list1">
													<p>캠핑장 : ${dto.campName}</p>
													<p>지역 : ${dto.campAddr1}</p>
											</div>
									</div>
								</c:forEach>
							</div> 
							-->
		                    
			                    
							<div class="card mb-3" >
			                   	<c:forEach var="dto" items="${list}">
									<div class="row g-0" onclick="location.href='${articleUrl}&campNo=${dto.campNo}';" >
										<div class="col-md-4">
											<c:forEach var="vo" items="${dto.images}" varStatus="status">
												<c:if test="${status.index==0}">
												  <img class="img-fluid rounded-start" src="${pageContext.request.contextPath}/uploads/admin/${vo.imgName}">
												</c:if>
											</c:forEach>
										</div>
										<div class="col-md-8">
											<div class="card-body">
												<h5 class="card-title">캠핑장 : ${dto.campName}</h5>
												<p class="card-text">지역 : ${dto.campAddr1}</p>
												<button type="button" class="btn btn-danger" style="width: 100%">둘러보기</button>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
		

		                    
		                </article>

		            </div>
		        </div>
		    </div>
		    </form>
		</section>
	</main>
        <!-- footer 부분 -->
		<jsp:include page="/WEB-INF/campingutte/layout/footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
         
    </body>
</html>