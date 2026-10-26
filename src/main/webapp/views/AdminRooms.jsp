<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Management - Château Fido</title>
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
        .table { background: white; border-radius: 10px; overflow: hidden; }
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin-dashboard">
                                <i class="bi bi-speedometer2 me-2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin-bookings">
                                <i class="bi bi-file-earmark-medical me-2"></i> Vaccines
                            </a>
                        </li>
                            <li class="nav-item">
                            <a class="nav-link" href="admin-reservations">
                                <i class="bi bi-calendar-week"></i> Reservations
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin-rooms">
                                <i class="bi bi-houses me-2"></i> Room Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin-inventory">
                                <i class="bi bi-box-seam me-2"></i> Inventory
                            </a>
                        </li>
                        <li class="nav-item mt-4 border-top border-secondary">
                            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-light min-vh-100">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-4 border-bottom">
                    <h1 class="h2">🏢 Room Management</h1>
                    <div class="text-muted">
                        <i class="bi bi-person-circle me-1"></i> Welcome, ${sessionScope.staffName}
                    </div>
                </div>

                <div class="mb-4">
                    <p class="text-muted mb-0">Register new rooms or monitor existing facility capacity.</p>
                </div>

                <c:if test="${param.success == 'RoomAdded'}">
                    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                        <i class="bi bi-check-circle me-2"></i>Room added successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${param.success == 'RoomDeleted'}">
                    <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                        <i class="bi bi-check-circle me-2"></i>Room deleted successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>Operation failed. Please try again.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card border-0 shadow-sm mb-5">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 card-title"><i class="bi bi-plus-circle me-2"></i>Add New Facility Room</h5>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/admin-rooms" method="POST" class="row g-3">
                            <input type="hidden" name="action" value="add"> 
                            
                            <div class="col-md-4">
                                <label class="form-label small fw-bold">Room ID</label>
                                <input type="text" name="roomID" class="form-control" placeholder="e.g., R-101" required>
                            </div>
                            
                            <div class="col-md-3">
                                <label class="form-label small fw-bold">Type</label>
                                <select name="roomType" class="form-select">
                                    <option value="Standard">Standard</option>
                                    <option value="Deluxe">Deluxe</option>
                                    <option value="Luxury Suite">Luxury Suite</option>
                                </select>
                            </div>
                            
                            <div class="col-md-3">
                                <label class="form-label small fw-bold">Price Per Night (RM)</label>
                                <input type="number" name="pricePerNight" class="form-control" placeholder="e.g., 150.00" min="0" step="0.01" required>
                            </div>
                            
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-success w-100 fw-bold">
                                    <i class="bi bi-plus-lg me-1"></i>Add Room
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 card-title"><i class="bi bi-houses me-2"></i>All Rooms</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Room ID</th>
                                        <th>Room Type</th>
                                        <th>Price Per Night</th>
                                        <th>Current Status</th>
                                        <th class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty rooms}">
                                            <c:forEach var="room" items="${rooms}">
                                                <tr>
                                                    <td class="ps-4 fw-bold text-primary">${room.roomID}</td>
                                                    <td>${room.roomType}</td>
                                                    <td>RM ${room.pricePerNight}</td>
                                                    <td>
                                                        <span class="badge rounded-pill ${room.status == 'Available' ? 'bg-success' : 'bg-danger'}">
                                                            ${room.status}
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <form action="${pageContext.request.contextPath}/admin-rooms" method="POST" style="display:inline;">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="roomID" value="${room.roomID}">
                                                            <button type="submit" class="btn btn-outline-danger btn-sm" 
                                                                    onclick="return confirm('Are you sure you want to delete room ${room.roomID}?');">
                                                                <i class="bi bi-trash me-1"></i>Delete
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center py-4 text-muted">
                                                    <i class="bi bi-house-slash display-6 d-block mb-2"></i>
                                                    No rooms found in the system.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>