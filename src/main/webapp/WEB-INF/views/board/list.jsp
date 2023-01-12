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

    <title>BOARD</title>

    <!-- Custom fonts for this template -->
    <link href="/resources/pages/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/pages/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/resources/pages/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>
<body>
<!-- sidebar -->
<%@include file="../includes/sidebar.jsp" %>
<!--navToolbar  -->
<%@include file="../includes/navToolbar.jsp" %>
 <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                        </div>
                        
                        <div class="card-body">
                            <div class="table-responsive">
                            <div class="row">
                        	<div class="col-sm-12 col-md-6">
                        		<div class="tableLength">
                        			<label>
                        				Show
                        				<select class="form-select form-select-sm">
                        					<option value="10">10</option>
                        					<option value="10">15</option>
                        					<option value="10">20</option>
                        				</select>
                        			</label>
                        		</div>
                        	</div>
                        </div>
                                <table class="table table-bordered table-hover"  width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>NO</th>
                                            <th>タイトル</th>
                                            <th>作成者</th>
                                            <th>日付</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>NO</th>
                                            <th>タイトル</th>
                                            <th>作成者</th>
                                            <th>日付</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <tr>
                                            <td>Donna Snider</td>
                                            <td>Customer Support</td>
                                            <td>New York</td>
                                            <td>27</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                		<form class="col-lg-12 searchForm">
                                	
                                			<select name="field" >
                                				<option value="W">作成者</option>
                                				<option value="T">タイトル</option>
                                				<option value="C">内容</option>
                                				<option value="TC">内容＋タイトル</option>
                                			</select>
                                			<input name="keyWord">
                                			<button class="btn btn-secondary">検索</button>
                                			
                                		</form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->
<!-- footer -->
<%@include file="../includes/footer.jsp" %>
  <!-- Bootstrap core JavaScript-->
    <script src="/resources/pages/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/pages/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/pages/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/pages/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/pages/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/pages/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/pages/js/demo/datatables-demo.js"></script>
</body>
</html>