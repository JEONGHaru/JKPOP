<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>JKPOP</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<!-- Custom fonts for this template-->
<link href="/resources/pages/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/462b5b874f.js"
	crossorigin="anonymous"></script>
<!-- Custom styles for this template-->
<link href="/resources/pages/css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">
.carousel-item>img {
	height: 500px;
}
.mainCard{
	left:-1000px;
}
.card-img-top{
	height:200px;
}
@keyframes kSlide {
	from {
		 left:-100px;
		 opacity:0;
	}
	
	to {
		left:100px;
		opacity:1;
	}
}

@keyframes disappear{
	from{
		left: 150px;
		opacity:1;
	}
	to{
		 left:-100px;
		 opacity:0;
	}
}
.mainJapanCard{
	right:-100px;
}

@keyframes jSlide {
	from {
		 right:-100px;
		 opacity:0;
	}
	
	to {
		right: 100px;
	}
}

</style>
<script type="text/javascript">
	$(function(){
		var mainCard = $(".mainCard");
		var mainJapanCard = $(".mainJapanCard");
		//$(mainKoreaCard).css("display","none");
		$(window).scroll(function(){
			var value = $(document).scrollTop();
			//console.log(value);
			 if(value > 200) {
				 $(mainCard).css("animation","kSlide 2s ease-out forwards");
				 $(window).scroll(function(){
					 var value = $(document).scrollTop();
					 if(value < 200) $(mainCard).css("animation","disappear 1s ease-out forwards");
				 })
			 }
			 //else $(mainKoreaCard).css("animation","disappear 2s ease-out forwards");
		})
			
		
	});//function -- end 
</script>
</head>
<!-- side bar -->
<%@ include file="includes/sidebar.jsp"%>
<%@ include file="includes/navToolbar.jsp"%>


<!-- Begin Page Content -->
<div class="container-fluid mb-5">
	<!-- Content Row -->
	<div class="container py-4">
		<div class="row mt-4">
			<div class="col-sm-5">
				<div class="fs-1">
					韓アーティスト
				</div>
				<div id="carouselExampleSlidesOnly" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner ">
						<div class="carousel-item active" data-bs-interval="2000">
							<img src="/album/display?fileName=${kList.get(0).uploadPath }/${kList.get(0).fileName}"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item ">
							<img src="/album/display?fileName=${kList.get(1).uploadPath }/${kList.get(1).fileName}" class="d-block w-100"
								alt="...">
						</div>
						<div class="carousel-item">
							<img src="/album/display?fileName=${kList.get(2).uploadPath }/${kList.get(2).fileName}" class="d-block w-100 lesse"
								alt="...">
						</div>

					</div>

				</div>
			</div>
			<div class="col-sm-5 offset-sm-2">
				<div class="fs-1">
					日アーティスト
				</div>

				<div id="carouselExampleSlidesOnly" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner badge border p-2">
						<div class="carousel-item active" data-bs-interval="2000">
							<img src="/album/display?fileName=${jList.get(0).uploadPath }/${jList.get(0).fileName}"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/album/display?fileName=${jList.get(1).uploadPath }/${jList.get(1).fileName}" 
							class="d-block w-100"
								alt="...">
						</div>
						<div class="carousel-item">
							<img src="/album/display?fileName=${jList.get(2).uploadPath }/${jList.get(2).fileName}" class="d-block w-100"
								alt="...">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>
<div class="container-fluid my-3 bg-primary">
<div class="row">
	<c:forEach begin="0" end="2" var="k" items="${kList}">
	<div class="card shadow mainCard sm-12 mx-1" style="width: 18rem;">
		<img src="/album/display?fileName=${k.uploadPath }/${k.fileName}"
			class="card-img-top" alt="...">
		<div class="card-body">
			<p class="card-text">${fn:substringBefore(k.fileName,'.') }</p>
		</div>
	</div>
	</c:forEach>
	</div>
</div>
<div class="container-fluid my-3 bg-danger">
<div class="row">
	<c:forEach begin="0" end="2" var="j" items="${jList}">
	<div class="card shadow mainCard sm-12 mx-1" style="width: 18rem;">
		<img src="/album/display?fileName=${j.uploadPath }/${j.fileName}"
			class="card-img-top" alt="...">
		<div class="card-body">
			<p class="card-text">${fn:substringBefore(j.fileName,'.') }</p>
		</div>
	</div>
	</c:forEach>
	</div>
</div>
<!-- Footer -->
<%@ include file="includes/footer.jsp"%>
<!-- End of Footer -->
<!-- Bootstrap core JavaScript-->
<script src="/resources/pages/vendor/jquery/jquery.min.js"></script>
<script
	src="/resources/pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/resources/pages/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/resources/pages/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/resources/pages/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
</body>

</html>

