<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="home">
	<div class="header-top">

		<div class="header-right font-jalnan">
			<div style="text-align: right;">
				<c:if test="${not empty sessionScope.member}">
					<span style="color:cyan;">${sessionScope.member.memberName} &nbsp;님</span>
					&nbsp;&nbsp;
				</c:if>	
				
				<a href="#">Home&nbsp;|&nbsp;</a>
				<c:if test="${empty sessionScope.member}">
					<a href="#">회원가입 (비활성화)</a>
					<span style="color: white;">&nbsp;|&nbsp;</span>
					<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
				</c:if>
				<c:if test="${not empty sessionScope.member}">					
					<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
					<span style="color: white;">&nbsp;|&nbsp;</span>
					<a href="#">정보수정 (비활성화)</a>
				</c:if>
				
			</div>
		</div>
	</div>

</div>
