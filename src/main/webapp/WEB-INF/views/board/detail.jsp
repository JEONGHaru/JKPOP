<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

textarea {
    width: 100%;
    height: 6.25em;
    border: none;
    resize: none;
  }
  .uploadResult {
  	width:100%
  }
  .uploadResult ul{
  	display:flex;
  	flex-flow:row;
  	justify-content:center;
  	align-items:center;
  }
  .uploadResult ul li {
  	list-style: none;
  	padding: 10px;
  	text-color:white;
  }
 
</style>
<script type="text/javascript">
	$(function(){
		//delete butonn click event
		$("button[data-oper='delete']").on("click",function(e){
			//alert("clilck!")
			//alert(${param.bno});
			if(!confirm("本当に削除しますか？")) return false;
			var bno = ${param.bno};
			var deleteForm = $("<form></form>")
			deleteForm.append($("<input>",{name:'bno',value: bno}))
			deleteForm.append($("<input>",{name:'writer',value: '${board.writer}'}))
			deleteForm.append($("<input>",{name:'${_csrf.parameterName}',value: '${_csrf.token}'}))
			deleteForm.attr("method","POST");
			deleteForm.attr("action","delete");
			$('body').append(deleteForm);
			deleteForm.submit();
			//formData.append(inputBno,"${param.bno}").submit();
		});//delete butonn click event -- end
		
		(function(){
			var bno = "${board.bno}";
			$.getJSON("/board/getFileList",{bno:bno},function(arr){
				//console.log(arr);
				showUploadFile(arr);
			});
		})();
		
		//showUploadFile
		var uploadResult = $(".uploadResult ul");
		function showUploadFile(list){
			var str = "";
			$(list).each(function(i,obj){
				str += "<li data-path="+obj.uploadPath+" data-uuid="+obj.uuid+" data-filename="+obj.fileName
				+" data-type="+obj.fileType+">";
				str += "<div>";
				//not image
				if(!obj.fileType){
					str += "<span>"+obj.fileName+"</span><br>"
					//image
				}else{
					var fileCallPath = encodeURIComponent(obj.uploadPath +"/s_"+obj.uuid+"_"+obj.fileName);
					var originPath = obj.uploadPath +"/"+obj.uuid+"_"+obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					str += "<img src='/display?fileName="+fileCallPath+"'>";
				}
				str += "</div>";
				str += "</li>";
			});//each -- end
			uploadResult.append(str);
		}//showUploadFile -- end
		
		$(".uploadResult").on("click","li",function(){
				//alert("uploadResult Click!");
				var liObj = $(this);
				var path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
				//console.log(path);
				if(liObj.data("type")) showImage(path.replace(new RegExp(/\\/g),"/"));
				else location="/download?fileName=" + path;
		})//uploadResult li Click event -- end
		
		function showImage(fileCallPath){
			//alert(fileCallPath);
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%',height:'100%'},1000);
		}; // showImage -- end
		
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'},1000);
			setTimeout(
				() => {$(this).hide()},
				1000
			);// showImage hide -- end
		});
	}); //$(function()) -- end
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
					<label>NO</label>
					<input class="form-control mb-3" type="text" name="bno" value="${board.bno}" readonly="readonly">
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
					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer }">
							<button class="btn btn-warning"
							onclick="location='update?bno=${board.bno}'">修正</button>
							<button data-oper="delete" class="btn btn-danger">削除</button>
						</c:if>
					</sec:authorize>
                   	</div>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="bigPictureWrapper">
				<div class="bigPicture"></div>
			</div>
		<div class="card shadow">
			<div class="card-header">
				<h5>File</h5>
			</div>
			<div class="card-body">
				<div class="uploadResult bg-secondary text-light">
					<ul></ul>
				</div>
				<!-- /.uploadResult -->
			</div>
			<!-- /.card-body -->
		</div>
		<!-- /.card shadow -->
	</div>
	<!-- /.row -->
</div>
<!-- /.container -->
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