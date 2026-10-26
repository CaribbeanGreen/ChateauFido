<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Château Fido - Dog Boarding</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/headerHome.jsp" />
    <div class="site-container">
        <div class="hero card">
            <div class="logo-emoji">🐕</div>
            <h2>Château Fido</h2>
            <p>Premium Dog Boarding & Care Services</p>
            <div style="margin-top:20px">
                <a class="btn btn-primary" href="<%= request.getContextPath() %>/login">Login</a>
                <a class="btn btn-secondary" href="<%= request.getContextPath() %>/register" style="margin-left:12px">Sign Up</a>
            </div>
        </div>
        <div style="margin-top:28px" class="grid">
            <div class="feature card text-center">
                <div class="icon">🏠</div>
                <h3>Luxury Rooms</h3>
                <p class="muted">Comfortable stays</p>
            </div>
            <div class="feature card text-center">
                <div class="icon">💝</div>
                <h3>Expert Care</h3>
                <p class="muted">Professional staff</p>
            </div>
            <div class="feature card text-center">
                <div class="icon">📱</div>
                <h3>Easy Booking</h3>
                <p class="muted">Online system</p>
            </div>
        </div>
    </div>
    
</body>
<jsp:include page="includes/footer.jsp" />
</html>