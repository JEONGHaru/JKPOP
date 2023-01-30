<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>     
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>JKPOP</title>
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- Custom fonts for this template-->
    <link href="/resources/pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
<script src="https://kit.fontawesome.com/462b5b874f.js" crossorigin="anonymous"></script>
    <!-- Custom styles for this template-->
    <link href="/resources/pages/css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">
#services .japan{
	width: 125px;
    height: 100px;
    border: 5px solid transparent;
    border-radius: 50%;
    background-image: linear-gradient(to top, #f21128 70%,#ffb199 100%);
    background-origin: border-box;
    background-clip: content-box, border-box;
    margin: 2rem auto;
    
}

.myCard{
	transition: 0.4s ease;
	
}
.myCard:hover {
	transform: translateY(-0.8rem);
	box-shadow: 0 5px 11px 0 rgba(0, 0, 0, 0.18), 0 4px 15px 0
		rgba(0, 0, 0, 0.15);
	cursor:pointer;	
}
</style>
<script type="text/javascript">
$(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(".myCard").on("click","img",function(){
		//alert("image click");
		var imagePath = $(this).attr("src");
		var likeCount = $(this).nextAll().find("span").text();
		var likeHerat = $(this).nextAll().find(".likeHeart").attr("class");
		console.log(likeHerat);
		console.log(imagePath);
		console.log(likeCount);
		$("#modalImage").find("img").attr("src",imagePath);
		$("#modalImage").find("span").text(likeCount);
		$("#modalImage").find("i").attr("class",likeHerat);
		$("#myModal").modal("show");
	});
	$(".modalClose").on("click",function(){
		$("#myModal").modal("hide");
	});
	$(".likeHeart").on("click",function(){
		//alert("heart click");
		var ano = $(this).data("idx");
		var likeCnt = $(this).prev();
		var likeHeart = $(this);
		console.log(ano);
		if($(this).attr("class") == "fa-regular fa-heart p-1 likeHeart"){
			$.ajax({
				url : "likeAdd",
				type: "POST",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				data: {ano : ano},
				success : function(result){
					console.log(result)
					if(result == "success"){
						$(likeCnt).text(parseInt($(likeCnt).text())+1);
						$(likeHeart).attr("class","fa-solid fa-heart p-1 likeHeart");
					}else{
						alert("いいねは一回しかできません");
					}
					
					//$("#modalHeart").attr("class","fa-solid fa-heart p-1");
				}			
				});//ajax ----end
		}else{
			$.ajax({
				url : "likeCancel",
				type: "POST",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				data: {ano : ano},
				success : function(result){
					if(result == "success"){
					$(likeHeart).attr("class","fa-regular fa-heart p-1 likeHeart");
					$(likeCnt).text(parseInt($(likeCnt).text())-1);
					$("#modalHeart").attr("class","fa-regular fa-heart p-1");
					}else{
						alert("いいねは一回しかできません");
					}
				}			
				});//ajax ----end
		} //else -- end
	})// likeHeart event -- end
	
	
});
</script>
</head>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/navToolbar.jsp" %>
 <sec:authentication property="principal" var="pinfo"/>
<section id="services">
	<div class="section-content">
		<div class="container services">
			<div class="services-header text-center py-5">
				<h1 class="diplay-5">韓国アーティスト（${year}年代)</h1>
				<div class="col divider japan"></div>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<form action="uploadAlbum" class="row"  method="POST" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="nation" value="japan">
					<input type="hidden" name="year" value="${year}">
						<div class="col-auto">
						<input class="form-control m-1" type="file" name="uploadFile" multiple>
						</div>
						<div class="col-auto mx-0">
							<button class="btn btn-primary" type="submit">登録</button>
						</div>
					</form>
					</sec:authorize>
			</div>
		</div>
	</div>
</section>
<div class="container-fulid">
	<div class="row justify-content-center">
	<c:forEach var="i" items="${image}">
			<div class="card m-2 myCard" style="width: 18rem;" >
				<img src="display?fileName=${i.uploadPath}/${i.fileName}" class="card-img-top" >
				<div class="card-body">
					<label class="card-title fs-4 fw-bolder">${fn:substringBefore(i.fileName,'.')}</label>
					<p class="card-text"></p>
					<div class="d-flex flex-column">
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<div>
						<form action="deleteImage" method="POST">
						<input type="hidden" name="ano" value="${i.ano}">
						<input type="hidden" name="nation" value="${i.nation }">
						<input type="hidden" name="year" value="${i.year}">
						<input type="hidden"name="${_csrf.parameterName }" value="${_csrf.token }">
						<button type="submit" class="btn"><i class="fa-solid fa-trash-can imageDelete"></i></button>
						</form>
						</div>
						</sec:authorize>
						<div class="fs-3 align-self-end">
						<span class="likeCount">${i.likeCnt }</span>
						<sec:authorize access="isAuthenticated()">
						<c:if test="${!i.liked}">
							<i class="fa-regular fa-heart p-1 likeHeart" data-idx="${i.ano}"
								style="color: red; cursor: poinnter"></i>
							</c:if>
						<c:if test="${i.liked}">
							<i class="fa-solid fa-heart p-1 likeHeart" data-idx="${i.ano}"
								style="color: red; cursor: poinnter"></i>
							</c:if>
								</sec:authorize>
						</div>
				</div>
				</div>
			</div>
			</c:forEach>
			
			<div class="modal fade" id="myModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-4" id="exampleModalLabel"></h1>
							<button type="button" class="btn-close modalClose" aria-label="Close"></button>
						</div>
						<div class="modal-body" id="modalImage">
						<img class="card-img-top">
								<div class="fs-3 float-end">
									<span></span><i id="modalHeart" class="fa-regular fa-heart p-1"
										style="color: red; cursor: poinnter"></i>
								</div>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp" %>           
            <!-- End of Footer -->
            <!-- Bootstrap core JavaScript-->
    <script src="/resources/pages/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/pages/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/pages/js/sb-admin-2.min.js"></script>

</body>
</html>