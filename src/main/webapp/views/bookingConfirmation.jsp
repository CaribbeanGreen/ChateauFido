<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmed - Château Fido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    <style>
        .success-icon {
            font-size: 80px;
            color: #28a745;
            animation: scaleIn 0.5s ease-in-out;
        }
        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }
        .confirmation-card {
            max-width: 700px;
            margin: 40px auto;
            padding: 40px;
            background: linear-gradient(180deg, #f0fff4, #fff);
            border: 2px solid #d4edda;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .detail-box {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="site-container">
        <div class="confirmation-card text-center">
            <div class="success-icon mb-3">
                ✓
            </div>
            <h1 class="mb-3">🐾 Booking Confirmed!</h1>
            <p class="lead text-muted mb-4">
                Your reservation has been successfully processed. We look forward to hosting your furry friend!
            </p>
            
            <hr class="my-4">
            
            <div class="text-start">
                <h5 class="fw-bold mb-3">Booking Details:</h5>
                
                <div class="detail-box">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Reservation ID:</span>
                        <strong>${sessionScope.lastReservationID}</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Check-in Date:</span>
                        <strong>${sessionScope.lastCheckIn}</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Check-out Date:</span>
                        <strong>${sessionScope.lastCheckOut}</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Payment Status:</span>
                        <span class="badge bg-success">PAID</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <span class="fw-bold">Total Amount:</span>
                        <h5 class="text-success mb-0">
                            RM <fmt:formatNumber value="${sessionScope.lastBookingAmount}" pattern="#,##0.00"/>
                        </h5>
                    </div>
                </div>
                
                <div class="alert alert-info mt-4" role="alert">
                    <strong>📧 Confirmation Email Sent!</strong><br>
                    A confirmation email with your booking details has been sent to your registered email address.
                </div>
            </div>
            
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/dashboard" 
                   class="btn btn-primary btn-lg me-2">
                    View My Bookings
                </a>
                <a href="${pageContext.request.contextPath}/booking" 
                   class="btn btn-outline-secondary btn-lg">
                    Book Another Room
                </a>
            </div>
            
            <p class="text-muted small mt-4">
                Need to make changes? Contact us at least 12 hours before check-in.<br>
                📞 Phone: 1-800-DOG-STAY | 📧 Email: support@chateaufido.com
            </p>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>