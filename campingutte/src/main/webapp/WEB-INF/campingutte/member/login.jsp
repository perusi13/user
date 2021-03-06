<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑어때 로그인 </title>
<jsp:include page="/WEB-INF/campingutte/layout/staticHeader.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="${pageContext.request.contextPath}/resource/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resource/css/header_footer-layout.css" rel="stylesheet" />
<style type="text/css">


main .container {
	margin: 80px auto 50px;
	width: 380px;
	padding: 10px;
	min-height: 200px; 
}

main, td {
	
	color: black;
}

.title-body {
	padding: 10px 0; text-align: center;
}

.title-body .article-title {
	color: white;
    font-size: 30px;
    font-weight: 600;
}

.form-body {
	text-align: center;
}

.form-body .inputTF {
	width: 350px;
	height: 45px;
	padding: 0px;
	padding-left: 15px;
	border:1px solid #666;
	margin-bottom: 5px;
}
.btnConfirm {
	width: 368px;
	padding: 10px;
	padding-right: 17px;
	margin-bottom: 10px;

}
.msg-box {
	text-align: center; color: blue;
}

 td {
	border: none;
}


</style>
<script type="text/javascript">
function inputsFocus( id ) {
	// 객체를 보이지 않게 숨긴다.
	document.getElementById(id).style.display="none"; 
}

function sendLogin() {
    var f = document.loginForm;

	var str = f.userId.value;
    if(!str) {
        alert("아이디를 입력하세요. ");
        f.userId.focus();
        return;
    }

    str = f.userPwd.value;
    if(!str) {
        alert("패스워드를 입력하세요. ");
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/login_ok.do";
    f.submit();
}
</script>

</head>
<body class="d-flex flex-column h-100">

<header>
	<jsp:include page="/WEB-INF/campingutte/layout/header.jsp"></jsp:include>
</header>

<main>
	<div class="search">
	<div class="container">
		<div class="title-body" >
			<h3> 캠핑어때 로그인 </h3>
		</div>
	
		<div class="form-body">
			<form name="loginForm" method="post" action="">
				<table class="table">
					<tr align="center"> 
						<td>
							<input type="text" name="userId" id="userId" class="inputTF" maxlength="15"
								tabindex="1" placeholder="아이디">
						</td>
					</tr>
					<tr align="center"> 
					    <td>
							<input type="password" name="userPwd" id="userPwd" class="inputTF" maxlength="20" 
								tabindex="2"
								placeholder="패스워드">
					    </td>
					</tr>
					<tr align="center"> 
					    <td>
							<button type="button" onclick="sendLogin();" class="btnConfirm">로그인</button>
					    </td>
					</tr>
					<tr align="center">
					    <td style="padding-right: 17px;">
							<span onclick="location.href='#'" >아이디 찾기</span>&nbsp;|&nbsp; 
							<span onclick="location.href='#'" >비밀번호 찾기</span>&nbsp;|&nbsp;
							<span onclick="location.href='${pageContext.request.contextPath}/member/member.do'">회원가입</span>
					    </td>
					</tr>
				</table>
				
				<table class="table">
					<tr>
						<td class="msg-box">${message}</td>
					</tr>
				</table>

			</form>
</div>           
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/campingutte/layout/footer.jsp"></jsp:include>
</body>
</html>