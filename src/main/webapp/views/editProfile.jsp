<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="site-container">
        <div class="card form-container" style="max-width:640px;margin:28px auto;padding:32px">
            <div class="profile-header text-center">
                <div style="font-size: 48px; margin-bottom: 16px;">✏️</div>
                <h2 style="color: var(--accent);">Edit Profile</h2>
                <p class="muted">Update your personal information</p>
            </div>

            <!-- Error Message -->
            <c:if test="${param.error == 'not_found'}">
                <div style="padding: 15px; margin: 20px 0; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px; color: #721c24;">
                    ⚠️ Error: Profile not found. Please try again.
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/updateProfile" method="POST" style="margin-top: 28px;">
                <div class="form-group">
                    <label for="custName">Full Name *</label>
                    <input type="text" id="custName" name="custName" 
                           value="${customer.custName}" 
                           required 
                           placeholder="Enter your full name">
                </div>
                
                <div class="form-group">
                    <label for="custEmail">Email Address *</label>
                    <input type="email" id="custEmail" name="custEmail" 
                           value="${customer.custEmail}" 
                           required 
                           placeholder="your.email@example.com">
                    <small class="muted" style="display: block; margin-top: 4px; font-size: 13px;">
                        This will be your login email
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="custPhone">Phone Number</label>
                    <input type="tel" id="custPhone" name="custPhone" 
                           value="${customer.custNO}" 
                           placeholder="+60 12-345 6789"
                           pattern="[0-9+\-\s]*">
                    <small class="muted" style="display: block; margin-top: 4px; font-size: 13px;">
                        Optional - For booking confirmations and updates
                    </small>
                </div>

                <div style="display: flex; gap: 12px; margin-top: 28px;">
                    <button type="submit" class="btn btn-primary" style="flex: 1;">
                        💾 Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/profile" 
                       class="btn btn-secondary" 
                       style="flex: 1; text-align: center; line-height: inherit;">
                        Cancel
                    </a>
                </div>
            </form>

            <div style="margin-top: 32px; padding-top: 24px; border-top: 1px solid #f0e6e0; text-align: center;">
                <p class="muted small" style="margin-bottom: 12px;">Need to change your password?</p>
                <a href="${pageContext.request.contextPath}/changePassword" class="btn btn-secondary" style="font-size: 14px;">
                    🔒 Change Password
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />
</body>
</html>