<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
        <title>Book a Room - Château Fido</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="site-container">
        <h2 class="mb-4">🐾 Book a Luxury Stay</h2>
        <form action="${pageContext.request.contextPath}/reserveRoom" method="POST">
            <div class="card step-card">
                <h3 style="margin-top: 0; color: var(--accent);">Step 1: Stay Details</h3>
                <div style="display:flex;flex-wrap:wrap;align-items:center;gap:15px;">
                    <div>
                        <label for="checkIn">Check-in Date:</label>
                        <input type="date" name="checkIn" id="checkIn" required>
                    </div>
                    <div>
                        <label for="checkOut">Check-out Date:</label>
                        <input type="date" name="checkOut" id="checkOut" required>
                    </div>
                    <div>
                        <label>Select Dog:</label>
                        <select name="dogID" required>
                            <option value="">-- Choose your dog --</option>
                            <c:forEach var="dog" items="${userDogs}">
                                <option value="${dog.dogID}">${dog.dogName} (${dog.dogBreed})</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <h3 style="color: var(--accent);">Step 2: Choose a Room</h3>
            <table class="room-table" style="width:100%;border-collapse:collapse">
                <thead>
                    <tr>
                        <th>Room ID</th>
                        <th>Room Type</th>
                        <th>Status</th>
                        <th>Price/Night</th>
                        <th>Selection</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td><strong>${room.roomID}</strong></td>
                            <td>${room.roomType}</td>
                            <td>
                                <span style="color: ${room.status == 'Available' ? 'green' : 'red'}; font-weight: bold;">● ${room.status}</span>
                            </td>
                            <td class="fw-bold">RM <fmt:formatNumber value="${room.pricePerNight}" pattern="#,##0.00"/></td>
                            <td>
                                <button type="submit" name="roomID" value="${room.roomID}" class="btn btn-primary" ${room.status != 'Available' ? 'disabled' : ''}>
                                    Select Room
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </form>
    </div>
    <jsp:include page="includes/footer.jsp" />
    <script>
        const checkInInput = document.getElementById('checkIn');
        const checkOutInput = document.getElementById('checkOut');
        checkInInput?.addEventListener('change', function() { if (checkOutInput) checkOutInput.min = this.value; });
    </script>
</body>
</html>