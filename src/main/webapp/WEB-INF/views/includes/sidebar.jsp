<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
               Album
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
                         <a class="collapse-item" href="/album/korea?year=2020">２０２０年代</a>
                        <a class="collapse-item" href="/album/korea?year=2010">２０１０年代</a>
                        <a class="collapse-item" href="/album/korea?year=2000">２０００年代</a>
                        <a class="collapse-item" href="/album/korea?year=1990">１９９０年代</a>
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
                        <a class="collapse-item" href="/album/japan?year=2020">２０２０年代</a>
                        <a class="collapse-item" href="/album/japan?year=2010">２０１０年代</a>
                        <a class="collapse-item" href="/album/japan?year=2000">２０００年代</a>
                        <a class="collapse-item" href="/album/japan?year=1990">１９９０年代</a>
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
                    <span>User</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <sec:authorize access="isAnonymous()">
                        <a class="collapse-item" href="/user/login"> <i class="fas fa-sign-in-alt fa-sm fa-fw mr-2 text-gray-400"></i>Login</a>
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated()">
                                <form id="logoutForm" action="/logout" method="POST">
                                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                <button class="dropdown-item logoutBtn" >
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </button>
                                </form>
                                </sec:authorize>
                        <a class="collapse-item" href="/user/register">Register</a>
                        <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span></span></a>
            </li>

            

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        </ul>
        <!-- End of Sidebar -->