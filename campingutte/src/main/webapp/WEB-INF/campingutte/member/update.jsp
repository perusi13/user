<%@ page contentType="text/html; charset=UTF-8"%>dld
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑어때</title>
<jsp:include page="/WEB-INF/campingutte/layout/staticHeader.jsp"/>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link href="${pageContext.request.contextPath}/resource/css/styles.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resource/css/header_footer-layout.css" rel="stylesheet" />


<style type="text/css">
main .container {
	margin: 70px auto 50px;
	width: 450px;
	padding: 10px;
	min-height: 200px; 
}

.title-body {
	padding: 10px 0;
	text-align: center;
}

.title-body .article-title {
	font-weight: bold;
	font-size: 27px;
	color: #424951;
}

.form-body {
	text-align: center;
}

.form-body .inputTF {
  width: 100%;
  height: 45px;
  padding: 5px;
  padding-left: 15px;
  border:1px solid #666;
}

.form-table {
	border: 1px solid #DAD9FF;
}
.form-table tr:first-child td {
	padding-top: 20px;
}

.form-table td {
	padding-left: 25px; padding-right: 25px;
}
.form-table tr:last-child td {
	padding-bottom: 20px;
}

.msg-box {
	text-align: center; color: blue;
}
</style>

<script type="text/javascript">
function sendOk() {
	var f = document.pwdForm;

	var str = f.memberPwd.value;
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.memberPwd.focus();
		return;
	}

	f.action = "${pageContext.request.contextPath}/member/pwd_ok.do";
	f.submit();
}
</script>

<body>


<header>
	<jsp:include page="/WEB-INF/campingutte/layout/header.jsp"></jsp:include>
</header>
<main>


<div class="main">
		<div class="title-body">
			<span class="article-title">패스워드 재확인</span>
		</div>
	
		<div class="form-body">
			<form name="pwdForm" method="post" action="">
				<table class="table form-table">
					<tr>
						<td align="center">
							정보 수정을 위해 패스워드를 입력해주세요.
						</td>
					</tr>
					<tr align="center"> 
						<td> 
							<input type="text" name="memberId" class="inputTF"
								tabindex="1"
								value="${sessionScope.member.memberId}"
								readonly="readonly">
						</td>
					</tr>
					<tr align="center"> 
					    <td>
							<input type="password" name="memberPwd" class="inputTF" maxlength="20"
								placeholder="패스워드" 
								tabindex="2">
					    </td>
					</tr>
					<tr align="center"> 
					    <td>
							<button type="button" onclick="sendOk();" class="btnConfirm">로그인</button>
							<input type="hidden" name="mode" value="${mode}">
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


</main>
<footer>
	<jsp:include page="/WEB-INF/campingutte/layout/footer.jsp"></jsp:include>
</footer>

</body>
</html>