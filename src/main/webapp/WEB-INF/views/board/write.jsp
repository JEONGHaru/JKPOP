<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.deleteX:hover{
	cursor:pointer;
	color:red;
}
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
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			//alert("submit click");
			var str = "";
			$(".uploadResult ul li").each(function(i,obj){
				var jobj = $(obj);
				console.dir(jobj);
				//console.log(jobj.data("filename"));
				//console.log(jObj.data("filename"));
				str += "<input type='hidden' name='uploadFileList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='uploadFileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='uploadFileList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='uploadFileList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});//append input tag -- end
			formObj.append(str).submit();
		});//file upload -- end
		
		var regEx = new RegExp("(.*?)\.(exe|sh|zip|alz)$","i");
		var maxSize = 10485760 // 1024 * 1024 * 10 = 10MB
		
		function chechExtension(fileName,fileSize){
			if(fileSize > maxSize){
				alert("10MB以下のファイルをアップロードしてください");
				return false;
			}
			if(regEx.test(fileName)){
				alert("そのファイルはアップロードできません");
				return false;
			}
			return true;
		} //chechExtension -- end
		
		var uploadResult = $(".uploadResult ul");
		function showUploadFile(list){
			var str = "";
			$(list).each(function(i,obj){
				str +=  "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName
				+"' data-type='"+obj.image+"'>";
				str += "<div>";
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath +"/"+obj.uuid+"_"+obj.fileName);
				str += obj.fileName
				}else{
					//이미지의 경우
					//불러온 파일 정보
					var fileCallPath = decodeURIComponent(obj.uploadPath +"/s_"+obj.uuid+"_"+obj.fileName);
					var originPath = obj.uploadPath +"/"+obj.uuid+"_"+obj.fileName
					console.log("fileCallPath : " +decodeURIComponent(fileCallPath));
					//originPath = originPath.replace(new RegExp(/\\/g),"/");
					str += "<img src='/display?fileName="+fileCallPath+"'>";
			}
				str += "<span class='deleteX' data-file=\'"+fileCallPath+"\' data-type=\'"+(obj.image?"image":"file")+"\'>";
				str += " <i class='fa-solid fa-xmark'></i>";
				str += "</span>";
				str += "</div>";
				str += "</li>";
			});
			
			uploadResult.append(str);
			
		}// showUploadFile-- end
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$("input[type='file']").on("change",function(e){
			console.log("ファイル選択");
			var formData = new FormData();
			console.log(formData);
			var inputFile = $("input[name='uploadFile']")
			console.log(inputFile);
			var files = inputFile[0].files;
			console.log(files);
			for(var i = 0; i< files.length; i++){
				//ファイルチェック
				if(!chechExtension(files[i].name,files[i].size)){
					return false;
				}
				formData.append("uploadFile",files[i]);
			}
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				data : formData,
				type : "POST",
				dataType : "JSON",
				success : function(result){
					console.log(JSON.stringify(result));
					//ファイル画面に表示
					showUploadFile(result);
					//$(".uploadDiv input").val("");
				}
			});
		});//input change -- end
		
		$(".uploadResult").on("click",".deleteX",function(e){
			//alert("Delete Click!")
			var deleteX = $(this);
			//서버에 넘겨줄 데이터 수집
			var targetFile = $(this).data("file");
			var targetType = $(this).data("type");
			//console.log(targetFile,targetType);
			$.ajax({
				url: '/deleteFile',
				data : {fileName :targetFile,
						type : targetType},
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				dataType : 'text', //서버에서 결과로 전달되는 데이텨 형식
				type : "POST",
				success : function(result){
					//alert(result);
					deleteX.closest("li").remove();
				}
			});
		});// fileDelete Event --end
	});//function() --end
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
				<form role="form" action="write" method="POST">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<div class="form-group">
					<label>Title</label>
					<input class="form-control mb-3" type="text" name="title" required="required" >
					</div>
					<div class="form-group">
					<label>Content</label>
					<textarea class="form-control mb-3" rows="3" name="content" required="required" ></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label>
						<input class="form-control mb-3" name="writer"  value='<sec:authentication property="principal.username"/>' readonly="readonly">
					</div>
					<button type="submit" class="btn btn-primary">作成</button>
                   	<button type="reset" class="btn btn-success">リセット</button>
				</form>
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
					<input class="form-control" type="file"  name="uploadFile" multiple>
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