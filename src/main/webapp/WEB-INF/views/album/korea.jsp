<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
#services .korea{
	width: 125px;
    height: 100px;
    border: 5px solid transparent;
    border-radius: 90%;
    background-image: linear-gradient(to top,#083be2 10%,#f21128 );
    background-origin: border-box;
    background-clip: content-box, border-box;
    margin: 2rem auto;
    
}
</style>
</head>
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/navToolbar.jsp" %>
<section id="services">
	<div class="section-content">
		<div class="container services">
			<div class="services-header text-center py-5">
				<h1 class="diplay-5">韓国アイドル（${years}年代)</h1>
				<div class="col divider korea"></div>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<form action="/uploadAlbum" class="row"  method="POST" enctype="multipart/form-data">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						<div class="col-auto">
						<input class="form-control m-1" type="file" >
						</div>
						<div class="col-auto mx-0">
							<button class="btn btn-primary" type="submit">登録</button>
						</div>
					</form>
					</sec:authorize>
			</div>
			<div id="slick-slide" class="services-body">
					<div class="services-col mx-2 my-3">
						<div class="card">
							<a href="#'"> <img
								src="" alt="" class="card-img-top" />
							</a>
							<div class="card-body">
								<h4 class="card-title"></h4>
								<p class="card-text fw-light mb-4">デビュー年：</p>
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>
</section>

<div class="container-fulid">
	<div class="row justify-content-center">
			<div class="card m-2 myCard" style="width: 18rem;">
				<img src="${n.filePath}" class="card-img-top" id="myImage"
					data-bs-toggle="modal" data-bs-target="#exampleModal${vs.index }">
				<div class="card-body" id="${n.groupName}">
					<label class="card-title fs-4">${n.groupName}</label>
					<p class="card-text"></p>
					<div class="d-flex flex-column">
							<form class="" method="POST">
								<button class="btn" type="submit">
									<i class="fa-solid fa-trash-can"></i>
								</button>
							</form>
							<div class="fs-3 align-self-end">
								<span></span><a onclick="login()"><i
									class="fa-regular fa-heart p-1"
									style="color: red; cursor: poinnter"></i></a>
							</div>
								<div class="fs-3 align-self-end">
									<span></span><a data-bs-target="#emailCheckModal"
										data-bs-toggle="modal"><i class="fa-regular fa-heart p-1"
										style="color: red; cursor: poinnter"></i></a>
								</div>
									<div class="fs-3 align-self-end">
										<span id=""></span><a id="like"
											idx=""><input type="hidden" id="user"
											value="" /><i
											class="fa-regular fa-heart p-1" id="heart"
											style="color: red; cursor: poinnter"></i></a>
									</div>
									<div class="fs-3 align-self-end">
										<span id="count"></span><a id="like"
											idx=""><input type="hidden" id="user"
											value="" /><i
											class="fa-solid fa-heart p-1" id="heart"
											style="color: red; cursor: poinnter"></i></a>
									</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<input type="hidden" id="imageID" value="" />
							<h1 class="modal-title fs-4" id="exampleModalLabel"></h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<img src="" class="card-img-top">
								<div class="fs-3 align-self-end">
									<span></span><a onclick="login()"><i
										class="fa-regular fa-heart p-1"
										style="color: red; cursor: poinnter"></i></a>
								</div>

									<div class="fs-3 align-self-end">
										<span></span><a
											data-bs-target="#emailCheckModal" data-bs-toggle="modal"><i
											class="fa-regular fa-heart p-1"
											style="color: red; cursor: poinnter"></i></a>
									</div>
										<div class="fs-3 align-self-end">
											<span id="mCount"></span><a
												id="like" idx=""><i
												class="fa-regular fa-heart p-1" id="mHeart"
												style="color: red; cursor: poinnter"></i></a>
										</div>

										<div class="fs-3 align-self-end">
											<span id="mCount"></span><a
												id="like" idx="}"><i
												class="fa-solid fa-heart p-1" id="mHeart"
												style="color: red; cursor: poinnter"></i></a>
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