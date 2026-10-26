<%-- 
    Document   : AdminBookings
    Created on : 29 Dec 2025, 8:55:42 pm
    Author     : Administrator
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Vaccine Management - Château Fido</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #2c3e50;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.85);
            padding: 1rem 1.5rem;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: #fff;
            background-color: rgba(255,255,255,0.1);
        }
        .sidebar-brand {
            padding: 1.5rem;
            color: #fff;
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <!-- SIDEBAR -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse p-0">
                <div class="sidebar-brand">Château Fido</div>
                <div class="position-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="admin-dashboard">
                                <i class="bi bi-speedometer2 me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="admin-bookings">
                                <i class="bi bi-file-earmark-medical me-2"></i>Vaccines
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
                        <li class="nav-item">
                            <!-- FIXED: Now points to the correct servlet -->
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

            <!-- MAIN CONTENT -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-light min-vh-100">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-4 border-bottom">
                    <h1 class="h2">Vaccine Management</h1>
                </div>
                
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i> ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 text-warning"><i class="bi bi-clock-history me-2"></i> Pending Vaccine Approvals</h5>
                    </div>
                    <div class="card-body p-0">
                        <c:if test="${empty pendingDogs}">
                            <div class="p-5 text-center text-muted">
                                <i class="bi bi-inbox h1 d-block mb-3"></i>
                                No pending approvals found.
                            </div>
                        </c:if>

                        <c:if test="${not empty pendingDogs}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">Dog ID</th>
                                            <th>Name</th>
                                            <th>Breed</th>
                                            <th>Document</th>
                                            <th>Status</th>
                                            <th class="text-end pe-4">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="dog" items="${pendingDogs}">
                                            <tr>
                                                <td class="ps-4 fw-bold text-secondary">${dog.dogID}</td>
                                                <td>${dog.dogName}</td>
                                                <td>${dog.dogBreed}</td>
                                                <td>
                                                    <!-- Updated to use the correct property name 'vaccineDocPath' -->
                                                   <a href="${pageContext.request.contextPath}/viewDocument/${dog.vaccineDocPath}" arget="_blank" class="btn btn-sm btn-outline-primary">View Document</a>
                                                </td>
                                                <td>
                                                    <span class="badge bg-warning text-dark">
                                                        <i class="bi bi-hourglass-split me-1"></i> ${dog.vaccineStatus}
                                                    </span>
                                                </td>
                                                <td class="text-end pe-4">
                                                    <form action="admin-bookings" method="post" class="d-inline">
                                                        <input type="hidden" name="dogID" value="${dog.dogID}">
                                                        <button type="submit" name="action" value="approve" class="btn btn-sm btn-success me-1">
                                                            <i class="bi bi-check-lg"></i> Approve
                                                        </button>
                                                        <button type="submit" name="action" value="reject" class="btn btn-sm btn-danger">
                                                            <i class="bi bi-x-lg"></i> Reject
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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