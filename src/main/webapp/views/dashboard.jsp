<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.chateaufido.model.*, com.chateaufido.DAO.*" %>
<%
    String custName = (String) session.getAttribute("custName");
    String custID = (String) session.getAttribute("custID");

    if (custName == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Initialize DAO and fetch real data from the database 
    ReservationDAO resDAO = new ReservationDAO();
    List<Reservation> reservations = resDAO.getReservationsByCustomer(custID);
%>
<!DOCTYPE html>
<html lang="en">
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Dashboard - Château Fido</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="site-container">
        <div class="card welcome-section">
            <h1>Welcome back, <%= custName %>! 👋</h1>
            <p class="muted">Manage your dog boarding reservations and keep track of your pets' stays</p>
        </div>

        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/booking" class="action-card">
                <div class="action-card-icon">📅</div>
                <h3>New Bookings</h3>
                <p class="muted">Book a new stay for your furry friend</p>
            </a>
            <a href="${pageContext.request.contextPath}/myDogs" class="action-card">
                <div class="action-card-icon">🐶</div>
                <h3>My Dogs</h3>
                <p class="muted">Manage your dogs' profiles</p>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="action-card">
                <div class="action-card-icon">👤</div>
                <h3>My Profile</h3>
                <p class="muted">Update your account information</p>
            </a>
        </div>

        <div class="card reservations-section">
            <h2>Recent Bookings</h2>
            <% if (reservations == null || reservations.isEmpty()) { %>
                <div class="no-reservations">
                    <p>You don't have any bookings yet.</p>
                    <p><a href="${pageContext.request.contextPath}/booking" class="btn btn-link">Make your first booking now!</a></p>
                </div>
            <% } else { %>
                <% for (Reservation reservation : reservations) { 
                        String statusClass = "status-" + reservation.getStatus().toLowerCase().replace("_", "-").replace(" ", "-");
                %>
                    <div class="reservation-card">
                        <div class="reservation-info">
                            <h4>Reservation #<%= reservation.getReservID() %></h4>
                            <p><strong>Check-in:</strong> <%= reservation.getCheckInDate() %></p>
                            <p><strong>Check-out:</strong> <%= reservation.getCheckOutDate() %></p>
                            <p><strong>Room:</strong> <%= reservation.getRoomID() %></p>
                            <p><strong>Amount:</strong> RM <%= reservation.getTotalAmount() %></p>
                        </div>
                        <div>
                            <span class="status-badge <%= statusClass %>">
                                <%= reservation.getStatus() %>
                            </span>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script>
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('booking') === 'success') {
            Swal.fire({
                title: 'Booking Confirmed! 🐾',
                text: 'Your dog\'s stay has been successfully reserved at Château Fido.',
                icon: 'success',
                confirmButtonColor: getComputedStyle(document.documentElement).getPropertyValue('--accent') || '#764ba2',
                confirmButtonText: 'Great!'
            }).then((result) => {
                window.history.replaceState({}, document.title, window.location.pathname);
            });
        }
    </script>
</body>
</html>