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
ul{
list-style:none;
}
textarea {
    width: 100%;
    height: 6.25em;
    border: none;
    resize: none;
  }
</style>
<script type="text/javascript">
	$(function(){
		$("button[data-oper='delete']").on("click",function(e){
			//alert("clilck!")
			//alert(${param.bno});
			if(!confirm("정말 삭제 하시겠습니까?")) return false;
			var bno = ${param.bno};
			var deleteForm = $("<form></form>")
			deleteForm.append($("<input>",{name:'bno',value: bno}))
			deleteForm.attr("method","POST");
			deleteForm.attr("action","delete");
			$('body').append(deleteForm);
			deleteForm.submit();
			//formData.append(inputBno,"${param.bno}").submit();
		})
	});
</script>    
</head>
<!-- side bar -->
<%@ include file="../includes/sidebar.jsp" %>
<%@ include file="../includes/navToolbar.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-lg-12">
		<!-- ページタイトル -->
			<h1 class="page-header">掲示作成</h1>
		</div>
		<!-- /.row -->
		<div class="row mb-4">
			<div class="col-lg-12">
				<div class="form-group">
					<label>Title</label>
					<input class="form-control mb-3" type="text" name="title" value="${board.title }" readonly="readonly" >
					</div>
					<div class="form-group">
					<label>content</label>
					<textarea class="form-control mb-3" rows="3" name="content" readonly="readonly" >${board.content }</textarea>
					</div>
					<div class="form-group">
					<label>Title</label>
					<input class="form-control mb-3" type="text" name="writer" value="${board.writer }" readonly="readonly" >
					</div>
					<div class="float-right">
					<button class="btn btn-primary" onclick="location = 'list'">リストへ</button>
					<button class="btn btn-warning"
					onclick="location='update?bno=${board.bno}&pageNum=${param.pageNum}&amount=${param.amount}&field=${param.field}&keyword=${param.keyword}'">修正</button>
					<button data-oper="delete" class="btn btn-danger">削除</button>
                   	</div>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="card shadow">
			<div class="card-header">
				<h5>File</h5>
			</div>
			<div class="card-body">
			<!-- 첨부파일 선택 div -> 파일을 선택하면 값이 변경 -> change 이벤트 발생 -->
				<div class="form-group uploadDiv">
					<input class="form-control" type="file"  name="uploadFile"multiple>
				</div>
				<div class="uploadResult">
					<ul></ul>
				</div>
				<!-- /.uploadResult -->
			</div>
			<!-- /.card-body -->
		</div>
		<!-- /.card shadow -->
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

<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>