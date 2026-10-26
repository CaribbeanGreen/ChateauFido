<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Dogs - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
  <jsp:include page="includes/header.jsp" />
  <div class="site-container">
    <div class="header-section" style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px">
      <div>
        <a href="dashboard" class="back-link">← Back to Dashboard</a>
        <h2>My Registered Dogs</h2>
      </div>
      <a href="${pageContext.request.contextPath}/AddDog" class="btn btn-primary">➕ Add a New Dog</a>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty successMessage}">
      <div class="alert alert-success" style="padding: 15px; margin-bottom: 20px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 4px; color: #155724;">
        ✓ ${successMessage}
      </div>
    </c:if>

    <!-- Empty State -->
    <c:if test="${empty dogs}">
      <div class="card empty-state text-center" style="padding:28px">
        <div style="font-size: 4rem; margin-bottom: 20px;">🦴</div>
        <p>You haven't registered any furry friends yet. Start by adding your first dog!</p>
        <c:if test="${not empty roomID}">
          <p style="margin-top: 15px;">
            <a href="${pageContext.request.contextPath}/AddDog?roomID=${roomID}" class="btn btn-primary">
              Register Your First Dog to Continue Booking
            </a>
          </p>
        </c:if>
      </div>
    </c:if>

    <!-- Dogs Grid -->
    <c:if test="${not empty dogs}">
      <div class="dog-grid">
        <c:forEach var="dog" items="${dogs}">
          <div class="card dog-card">
            <div class="dog-info">
              <h3>${dog.dogName}</h3>
              <span class="dog-breed">${dog.dogBreed}</span>
              <div class="dog-details">Age: ${dog.dogAge} years old</div>
              <div class="dog-details" style="margin-top: 8px; font-size: 0.85em; color: #666;">
                Dog ID: ${dog.dogID}
              </div>
            </div>
            <div class="status-section">
              <c:choose>
                <c:when test="${dog.vaccineStatus == 'Approved'}">
                  <span class="status-badge status-verified"><span>✔</span> Verified</span>
                </c:when>
                <c:when test="${dog.vaccineStatus == 'Rejected'}">
                  <span class="status-badge status-rejected"><span>✗</span> Rejected</span>
                </c:when>
                <c:otherwise>
                  <span class="status-badge status-pending"><span>⏳</span> Awaiting Verification</span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
        </c:forEach>
      </div>
      
      <!-- If user came from booking flow and has verified dogs, show next step -->
      <c:if test="${not empty roomID}">
        <div style="margin-top: 30px; text-align: center;">
          <a href="${pageContext.request.contextPath}/booking/select-dog?roomID=${roomID}" class="btn btn-primary">
            Continue with Booking
          </a>
        </div>
      </c:if>
    </c:if>
  </div>
  <jsp:include page="includes/footer.jsp" />
</body>
</html>