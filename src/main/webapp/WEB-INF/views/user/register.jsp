<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>会員登録</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/pages/css/sb-admin-2.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <link href="/resources/css/custom/custom.css" rel="stylesheet">

    
<script type="text/javascript">
	$(function(){
		var idChecked = false;
		var pwChecked = false;
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		var idCheckResult = $("#idCheckResult");
		$(".idCheckBtn").on("click",function(e){
			//alert("idCheckBtn click");
			e.preventDefault();
			var userId = $("#userId").val();
			$.ajax({
				url : "/user/idCheck",
				type:"POST",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				data: {userId: userId},
				success:function(result){
					if(result == 'OK'){
						idCheckResult.text("登録可能なIDです");
						idChecked = true;
					}
					else {
						idCheckResult.text("そのIDはご登録いただけません");
						idChecked = false;
					}
				}
			});//ajax -- end
			//alert(userId);
		}); // idCheckBtn event -- end
		
		$("#userId").on("change",function(){
			idChecked = false;
		})
		
		
		$("#userPassword").keyup(function(){
			idCheckResult.text("");
			var pw = $(this).val();
			var pw2 = $("#RepeatPassword").val();
			if(pw != pw2) {
				pwChecked = false;
			}else{
				$("#pwCheckResult").text("");
				pwChecked = true;
			}
		})
		$("#RepeatPassword").keyup(function(){
			idCheckResult.text("");
			var pw = $("#userPassword").val();
			var pw2 = $(this).val();
			if(pw != pw2) {
				$("#pwCheckResult").text("パスワードが一致しません");
				pwChecked = false;
			}else{
				$("#pwCheckResult").text("");
				pwChecked = true;
			}
		})
		$("#registerForm").submit(function(){
			//alert("submit click");
			var userChecked = true; 
			if(!idChecked) {
				idCheckResult.text("IDCHECKをお願いします");
				userChecked = false;
			}
			if(!pwChecked){
				 $("#pwCheckResult").text("パスワードが一致しません");
				userChecked = false;
			}
			return userChecked;
		})//registerForm submit -- end
		
	});
</script>
</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">会員登録</h1>
                            </div>
                            <form id="registerForm" class="user" method="POST" action="/user/register">
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                <div class="form-group row">
                                	<div class="col-sm-8 mb-3 mb-sm-0">
                                    <input type="text" class="form-control form-control-user" id="userId"
                                        placeholder="ID" name="userId" required >
                                	</div>
                                	<div class="col-auto">
                                		 <button class="btn btn-primary btn-user btn-block idCheckBtn">
                                   ID CHECK
                                </button>
                                	</div>
                                </div>
                                <div id="idCheckResult" class="text-center mb-4 text-danger"></div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="userPassword" placeholder="パスワード" name="userPassword" required>
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            id="RepeatPassword" placeholder="パスワード (再確認)" required>
                                    </div>
                                </div>
                                    <div id="pwCheckResult" class="text-center mb-4 text-danger"></div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="exampleInputEmail"
                                        placeholder="Eメール（パスワードを忘れた時臨時パスワードをEメールに送信します）" name="email" required>
                                </div>
                                 <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" name="userFirstName"  id="exampleFirstName"
                                            placeholder="姓" required>
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" name="userLastName" id="exampleLastName"
                                            placeholder="名" required>
                                    </div>
                                </div>
                                <button class="btn btn-primary btn-user btn-block">
                                   会員登録
                                </button>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgotPassword">パスワードを忘れた方</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="login.html">ログインページへ</a>
                            </div>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="/main">ホームへ戻る</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/pages/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/pages/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/pages/js/sb-admin-2.min.js"></script>

</body>

</html>