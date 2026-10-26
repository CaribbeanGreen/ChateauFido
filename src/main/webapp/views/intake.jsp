<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
        <title>Pet Intake Form - Château Fido</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />

    <div class="site-container">
        <div class="card form-container" style="max-width:640px;margin:28px auto;padding:24px">
            <h2>🐕 Pet Intake Form</h2>
          <form id="intakeForm" action="${pageContext.request.contextPath}/final" method="post" enctype="multipart/form-data" onsubmit="handleFormSubmit()">
                <input type="hidden" name="roomID" value="${roomID}">
                <div class="form-group">
                    <label>Dog Name</label>
                    <input type="text" name="dogName" placeholder="e.g. Buddy" required>
                </div>
                <div class="form-group">
                    <label>Dog Age</label>
                    <input type="number" name="dogAge" placeholder="Years" required>
                </div>
                <div class="form-group">
                    <label>Breed</label>
                    <input type="text" name="dogBreed" placeholder="e.g. Golden Retriever" required>
                </div>
                <div class="form-group">
                    <label>Vaccination Certificate (PDF/Image)</label>
                    <input type="file" name="vaccineFile" accept=".jpg,.png,.pdf" required>
                </div>
                <button type="submit" id="submitBtn" class="btn btn-primary">Submit Details</button>            
          </form>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />
</body>
<script>
function handleFormSubmit() {
    const btn = document.getElementById('submitBtn');
    // Disable button to prevent double clicks
    btn.disabled = true;
    btn.innerText = 'Processing...';
    btn.style.opacity = '0.7';
}
</script>
</html>