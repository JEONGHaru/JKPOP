<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/main">
                <div class="sidebar-brand-icon rotate-n-15">
                   <img src="/resources/images/jkpop.png"
				alt="" />
                </div>
                <div class="sidebar-brand-text mx-3"><sup>日韓</sup><br>JK POP </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="/main">
                   <i class="fa-solid fa-house"></i>
                    <span>HOME</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- K-POP -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseKorea"
                    aria-expanded="true" aria-controls="collapseKorea">
                   <i class="fa-solid fa-music"></i>
                    <span>K-POP</span>
                </a>
                <div id="collapseKorea" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">韓国アーティスト:</h6>
                         <a class="collapse-item" href="buttons.html">２０２０年代</a>
                        <a class="collapse-item" href="cards.html">２０１０年代</a>
                        <a class="collapse-item" href="cards.html">２０００年代</a>
                        <a class="collapse-item" href="cards.html">１９９０年代</a>
                    </div>
                </div>
            </li> <!-- J-POP -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseJapan"
                    aria-expanded="true" aria-controls="collapseJapan">
                   <i class="fa-solid fa-music"></i>
                    <span>J-POP</span>
                </a>
                <div id="collapseJapan" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">日本アーティスト</h6>
                        <a class="collapse-item" href="buttons.html">２０２０年代</a>
                        <a class="collapse-item" href="cards.html">２０１０年代</a>
                        <a class="collapse-item" href="cards.html">２０００年代</a>
                        <a class="collapse-item" href="cards.html">１９９０年代</a>
                    </div>
                </div>
            </li>
            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="/board/list">
                    <i class="fas fa-fw fa-table"></i>
                    <span>掲示板</span></a>
            </li>
            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Addons
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pages</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <a class="collapse-item" href="login.html">Login</a>
                        <a class="collapse-item" href="register.html">Register</a>
                        <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="404.html">404 Page</a>
                        <a class="collapse-item" href="blank.html">Blank Page</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li>

            

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        </ul>
        <!-- End of Sidebar -->