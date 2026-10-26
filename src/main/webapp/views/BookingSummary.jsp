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
    
   <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h3>🐾 Review Your Stay</h3>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Dog Details</h5>
                        <p><strong>Name:</strong> ${selectedDog.dogName}</p>
                        <p><strong>Breed:</strong> ${selectedDog.dogBreed}</p>
                    </div>
                    <div class="col-md-6">
                        <h5>Room Details</h5>
                        <p><strong>Type:</strong> ${selectedRoom.roomType}</p>
                        <p><strong>Price per Night:</strong> RM ${pricePerNight}</p>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-6">
                        <h5>Stay Period</h5>
                        <p><strong>Check-in:</strong> ${checkInDate}</p>
                        <p><strong>Check-out:</strong> ${checkOutDate}</p>
                        <p><strong>Duration:</strong> ${nights} Night(s)</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <h4 class="text-success">Total Amount: RM <fmt:formatNumber value="${totalPrice}" pattern="#,##0.00"/></h4>
                    </div>
                </div>
            </div>
            <div class="card-footer d-flex justify-content-between">
                <a href="booking" class="btn btn-secondary">Go Back</a>
                
                <form action="${pageContext.request.contextPath}/confirmBooking" method="POST">
                    <input type="hidden" name="dogID" value="${selectedDog.dogID}">
                    <input type="hidden" name="roomID" value="${selectedRoom.roomID}">
                    <input type="hidden" name="checkIn" value="${checkInDate}">
                    <input type="hidden" name="checkOut" value="${checkOutDate}">
                    <input type="hidden" name="totalAmount" value="${totalPrice}">
                    
                    <button type="submit" class="btn btn-success btn-lg">Confirm & Pay Now</button>
                </form>
            </div>
        </div>
    </div>>
    
    <jsp:include page="includes/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>