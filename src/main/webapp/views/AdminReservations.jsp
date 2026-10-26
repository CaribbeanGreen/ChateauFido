<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reservation Management - Château Fido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    
    <style>
        .sidebar { min-height: 100vh; background-color: #2c3e50; }
        .sidebar .nav-link { color: rgba(255,255,255,0.85); padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: rgba(255,255,255,0.1); }
        .sidebar-brand { padding: 1.5rem; color: #fff; font-size: 1.5rem; font-weight: bold; text-align: center; }
        
        .status-badge {
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-confirmed { background-color: #d1ecf1; color: #0c5460; }
        .status-checked-in { background-color: #d4edda; color: #155724; }
        .status-completed { background-color: #e2e3e5; color: #383d41; }
        .status-cancelled { background-color: #f8d7da; color: #721c24; }
        
        .table-hover tbody tr:hover { background-color: #f8f9fa; cursor: pointer; }
        .filter-btn.active { background-color: #0d6efd; color: white; }
        
        .receipt-modal .modal-body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .receipt-content { background: white; border-radius: 15px; padding: 2rem; }
        .receipt-header { border-bottom: 2px solid #667eea; padding-bottom: 1rem; margin-bottom: 1.5rem; }
        .receipt-row { padding: 0.5rem 0; border-bottom: 1px solid #e9ecef; }
        .receipt-total { background: #f8f9fa; padding: 1rem; border-radius: 8px; margin-top: 1rem; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <!-- Sidebar -->
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
                            <a class="nav-link" href="admin-bookings">
                                <i class="bi bi-file-earmark-medical me-2"></i> Vaccines
                            </a>
                        </li>
                          <li class="nav-item">
                            <a class="nav-link active" href="admin-reservations">
                                <i class="bi bi-calendar-check me-2"></i> Reservations
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

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-light min-vh-100">
                
                <!-- Header -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-4 border-bottom">
                    <h1 class="h2"><i class="bi bi-calendar-check me-2"></i> Reservation Management</h1>
                    <div class="text-muted">
                        <i class="bi bi-person-circle me-1"></i> ${sessionScope.staffName}
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${param.update == 'success'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle me-2"></i> Reservation status updated successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i> An error occurred. Please try again.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

            

                <!-- Reservations Table -->
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0"><i class="bi bi-list-ul me-2"></i> All Reservations</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Reservation ID</th>
                                        <th>Customer ID</th>
                                        <th>Dog ID</th>
                                        <th>Room</th>
                                        <th>Check-In</th>
                                        <th>Check-Out</th>
                                        <th>Status</th>
                                        <th>Amount</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty reservations}">
                                            <tr>
                                                <td colspan="9" class="text-center py-5 text-muted">
                                                    <i class="bi bi-inbox h1 d-block mb-3"></i>
                                                    No reservations found
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="reservation" items="${reservations}">
                                                <tr>
                                                    <td><strong>${reservation.reservID}</strong></td>
                                                    <td>${reservation.custID}</td>
                                                    <td>${reservation.dogID}</td>
                                                    <td><span class="badge bg-secondary">${reservation.roomID}</span></td>
                                                    <td><fmt:formatDate value="${reservation.checkInDate}" pattern="MMM dd, yyyy"/></td>
                                                    <td><fmt:formatDate value="${reservation.checkOutDate}" pattern="MMM dd, yyyy"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${reservation.status == 'PENDING'}">
                                                                <span class="status-badge status-pending">Pending</span>
                                                            </c:when>
                                                            <c:when test="${reservation.status == 'Confirmed'}">
                                                                <span class="status-badge status-confirmed">Confirmed</span>
                                                            </c:when>
                                                            <c:when test="${reservation.status == 'Checked-In'}">
                                                                <span class="status-badge status-checked-in">Checked-In</span>
                                                            </c:when>
                                                            <c:when test="${reservation.status == 'Completed'}">
                                                                <span class="status-badge status-completed">Completed</span>
                                                            </c:when>
                                                            <c:when test="${reservation.status == 'Cancelled'}">
                                                                <span class="status-badge status-cancelled">Cancelled</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td><strong>RM <fmt:formatNumber value="${reservation.totalAmount}" pattern="#,##0.00"/></strong></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-primary" 
                                                                onclick="viewReceipt('${reservation.reservID}', '${reservation.custID}', '${reservation.dogID}', '${reservation.roomID}', '${reservation.checkInDate}', '${reservation.checkOutDate}', '${reservation.status}', '${reservation.totalAmount}')">
                                                            <i class="bi bi-receipt"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
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

    <!-- Receipt Modal -->
    <div class="modal fade" id="receiptModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-body">
                    <div class="receipt-content">
                        <div class="receipt-header text-center">
                            <h2 class="mb-1" style="color: #667eea;">Château Fido</h2>
                            <p class="text-muted mb-0">Premium Pet Resort & Boarding</p>
                            <p class="small text-muted">123 Luxury Lane, Pet City | Tel: (123) 456-7890</p>
                        </div>
                        
                        <div class="row mb-4">
                            <div class="col-6">
                                <h6 class="text-muted mb-2">RECEIPT DETAILS</h6>
                                <p class="mb-1"><strong>Receipt #:</strong> <span id="modal-reservID"></span></p>
                                <p class="mb-1"><strong>Date Issued:</strong> <span id="modal-date"></span></p>
                            </div>
                            <div class="col-6 text-end">
                                <h6 class="text-muted mb-2">CUSTOMER INFO</h6>
                                <p class="mb-1"><strong>Customer ID:</strong> <span id="modal-custID"></span></p>
                                <p class="mb-1"><strong>Pet ID:</strong> <span id="modal-dogID"></span></p>
                            </div>
                        </div>
                        
                        <h6 class="mb-3">BOOKING DETAILS</h6>
                        <div class="receipt-row">
                            <div class="d-flex justify-content-between">
                                <span>Room Number:</span>
                                <strong id="modal-roomID"></strong>
                            </div>
                        </div>
                        <div class="receipt-row">
                            <div class="d-flex justify-content-between">
                                <span>Check-In Date:</span>
                                <strong id="modal-checkIn"></strong>
                            </div>
                        </div>
                        <div class="receipt-row">
                            <div class="d-flex justify-content-between">
                                <span>Check-Out Date:</span>
                                <strong id="modal-checkOut"></strong>
                            </div>
                        </div>
                        <div class="receipt-row">
                            <div class="d-flex justify-content-between">
                                <span>Number of Nights:</span>
                                <strong id="modal-nights"></strong>
                            </div>
                        </div>
                        <div class="receipt-row">
                            <div class="d-flex justify-content-between">
                                <span>Status:</span>
                                <strong id="modal-status"></strong>
                            </div>
                        </div>
                        
                        <div class="receipt-total mt-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">TOTAL AMOUNT</h5>
                                <h4 class="mb-0 text-primary">RM <span id="modal-amount"></span></h4>
                            </div>
                        </div>
                        
                        <div class="text-center mt-4 pt-3 border-top">
                            <p class="text-muted small mb-2">Thank you for choosing Château Fido!</p>
                            <p class="text-muted small">For inquiries, please contact us at support@chateaufido.com</p>
                        </div>
                        
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-primary me-2" onclick="window.print()">
                                <i class="bi bi-printer me-1"></i> Print Receipt
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden form for status updates -->
    <form id="statusUpdateForm" method="post" action="admin-reservations" style="display: none;">
        <input type="hidden" name="action" value="updateStatus">
        <input type="hidden" name="reservID" id="statusReservID">
        <input type="hidden" name="newStatus" id="newStatus">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewReceipt(reservID, custID, dogID, roomID, checkIn, checkOut, status, amount) {
            document.getElementById('modal-reservID').textContent = reservID;
            document.getElementById('modal-custID').textContent = custID;
            document.getElementById('modal-dogID').textContent = dogID;
            document.getElementById('modal-roomID').textContent = roomID;
            document.getElementById('modal-checkIn').textContent = new Date(checkIn).toLocaleDateString('en-US', {year: 'numeric', month: 'long', day: 'numeric'});
            document.getElementById('modal-checkOut').textContent = new Date(checkOut).toLocaleDateString('en-US', {year: 'numeric', month: 'long', day: 'numeric'});
            document.getElementById('modal-status').textContent = status;
            document.getElementById('modal-amount').textContent = parseFloat(amount).toFixed(2);
            document.getElementById('modal-date').textContent = new Date().toLocaleDateString('en-US', {year: 'numeric', month: 'long', day: 'numeric'});
            
            // Calculate nights
            const checkInDate = new Date(checkIn);
            const checkOutDate = new Date(checkOut);
            const nights = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));
            document.getElementById('modal-nights').textContent = nights;
            
            new bootstrap.Modal(document.getElementById('receiptModal')).show();
        }
        
        function updateStatus(reservID, newStatus) {
            if (confirm('Are you sure you want to update the status to "' + newStatus + '"?')) {
                document.getElementById('statusReservID').value = reservID;
                document.getElementById('newStatus').value = newStatus;
                document.getElementById('statusUpdateForm').submit();
            }
        }
    </script>
</body>
</html>