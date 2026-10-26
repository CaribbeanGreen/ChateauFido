<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
        <title>Booking Confirmed - Château Fido</title>
       <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    <div class="site-container">
        <div class="card success-box text-center" style="max-width:700px;margin:40px auto;padding:28px;background:linear-gradient(180deg,#f7fff6,#fff);border:1px solid #f0f0f0">
            <h1>🐾 Dog Registration Request Received!</h1>
            <p>Thank you for choosing Château Fido. We have received your information.</p>
            <hr>
            <p><strong>Status: PENDING</strong></p>
            <p class="muted">Our staff is currently reviewing your dog's vaccination documents. You will see an update on your dashboard once approved.</p>
            <a href="${pageContext.request.contextPath}/myDogs" class="btn btn-primary" style="margin-top:18px;display:inline-block">Return to Dashboard</a>
        </div>
    </div>
    <jsp:include page="includes/footer.jsp" />
</body>
</html>