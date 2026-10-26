<%-- 
    Document   : AdminDashboard
    Created on : 29 Dec 2025, 8:49:14 pm
    Author     : Administrator
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - Château Fido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    
    <style>
        .sidebar { min-height: 100vh; background-color: #2c3e50; }
        .sidebar .nav-link { color: rgba(255,255,255,0.85); padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: rgba(255,255,255,0.1); }
        .sidebar-brand { padding: 1.5rem; color: #fff; font-size: 1.5rem; font-weight: bold; text-align: center; }
        .card-stat { transition: transform 0.2s; }
        .card-stat:hover { transform: translateY(-5px); }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse p-0">
                <div class="sidebar-brand">Château Fido</div>
                <div class="position-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="admin-dashboard">
                                <i class="bi bi-speedometer2 me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-bookings">
                                <i class="bi bi-file-earmark-medical me-2"></i> Vaccines
                            </a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link" href="admin-reservations">
                                <i class="bi bi-calendar-week"></i> Reservations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-rooms">
                                <i class="bi bi-houses me-2"></i> Room Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="admin-inventory">
                                <i class="bi bi-box-seam me-2"></i> Inventory
                            </a>
                        </li>
                        <li class="nav-item mt-4 border-top border-secondary">
                            <a class="nav-link text-danger" href="logout">
                                <i class="bi bi-box-arrow-right me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-light min-vh-100">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-4 border-bottom">
                    <h1 class="h2">Admin Dashboard</h1>
                    <div class="text-muted">
                        <i class="bi bi-person-circle me-1"></i> Welcome, ${sessionScope.staffName}
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="card h-100 border-0 shadow-sm card-stat">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Pending Approvals</h6>
                                <h2 class="card-title text-warning mb-0 display-6 fw-bold">${pendingCount}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card h-100 border-0 shadow-sm card-stat">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Active Guests</h6>
                                <h2 class="card-title text-success mb-0 display-6 fw-bold">${activeGuestCount}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card h-100 border-0 shadow-sm card-stat">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Available Rooms</h6>
                                <h2 class="card-title text-info mb-0 display-6 fw-bold">${availableRoomsCount}</h2>
                            </div>
                        </div>
                    </div>
           
                </div>

            
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 card-title"><i class="bi bi-bell me-2"></i> Active Alerts</h5>
                    </div>
                    <div class="card-body">
                        
                        <c:if test="${pendingCount > 0}">
                            <div class="alert alert-light border border-warning d-flex justify-content-between align-items-center mb-3" role="alert">
                                <div>
                                    <strong class="text-dark">Vaccine Verification Needed</strong>
                                    <div class="text-muted small mt-1">${pendingCount} pet(s) require vaccination approval before booking.</div>
                                </div>
                                <a href="admin-bookings" class="btn btn-warning btn-sm text-dark fw-semibold">Review Now</a>
                            </div>
                        </c:if>

                        <c:if test="${lowStockCount > 0}">
                            <div class="alert alert-light border border-danger d-flex justify-content-between align-items-center mb-3" role="alert">
                                <div>
                                    <strong class="text-danger">Low Stock Warning</strong>
                                    <div class="text-muted small mt-1">${lowStockCount} item(s) are running low or critical.</div>
                                </div>
                                <a href="admin-inventory" class="btn btn-danger btn-sm text-white fw-semibold">Manage Inventory</a>
                            </div>
                        </c:if>

                        <c:if test="${pendingCount == 0 && lowStockCount == 0}">
                            <div class="text-center text-muted py-4">
                                <i class="bi bi-check-circle h1 d-block mb-3 text-success"></i>
                                All clear! No urgent tasks.
                            </div>
                        </c:if>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>