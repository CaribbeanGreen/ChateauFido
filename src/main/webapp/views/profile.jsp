<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="site-container">
        <div class="header-section" style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px">
            <div>
              
                <h2>My Profile</h2>
            </div>
            <a href="${pageContext.request.contextPath}/editProfile" class="btn btn-primary">✏️ Edit Profile</a>
        </div>

        <!-- Profile Information Card -->
        <div class="card profile-card">
            <div class="profile-header">
                <div style="font-size: 64px; margin-bottom: 16px;">👤</div>
                <h2 style="color: var(--accent); margin-bottom: 8px;">${customer.custName}</h2>
                <p class="muted">Customer ID: ${customer.custID}</p>
            </div>

            <div style="margin-top: 32px;">
                <!-- Contact Information -->
                <div style="padding: 24px; border-radius: 12px; background: linear-gradient(180deg, var(--glass), rgba(255,255,255,0.4)); margin-bottom: 20px;">
                    <h3 style="color: var(--accent); margin-bottom: 20px; border-bottom: 2px solid var(--accent); padding-bottom: 8px;">
                        Contact Information
                    </h3>
                    
                    <div style="display: grid; gap: 16px;">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <span style="font-size: 24px;">📧</span>
                            <div>
                                <p class="muted small" style="margin-bottom: 4px;">Email Address</p>
                                <p style="font-weight: 600; color: var(--accent);">${customer.custEmail}</p>
                            </div>
                        </div>
                        
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <span style="font-size: 24px;">📱</span>
                            <div>
                                <p class="muted small" style="margin-bottom: 4px;">Phone Number</p>
                                <p style="font-weight: 600; color: var(--accent);">
                                    <c:choose>
                                        <c:when test="${not empty customer.custNO}">
                                            ${customer.custNO}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="muted">Not provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Account Security -->
                <div style="padding: 24px; border-radius: 12px; background: linear-gradient(180deg, var(--glass), rgba(255,255,255,0.4)); margin-bottom: 20px;">
                    <h3 style="color: var(--accent); margin-bottom: 20px; border-bottom: 2px solid var(--accent); padding-bottom: 8px;">
                        Account Security
                    </h3>
                    
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <span style="font-size: 24px;">🔒</span>
                        <div style="flex: 1;">
                            <p class="muted small" style="margin-bottom: 4px;">Password</p>
                            <p style="font-weight: 600; color: var(--accent);">••••••••</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/changePassword" class="btn btn-secondary" style="padding: 8px 16px; font-size: 14px;">
                            Change Password
                        </a>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-top: 32px;">
                    <a href="${pageContext.request.contextPath}/myDogs" class="action-card" style="text-decoration: none;">
                        <div class="action-card-icon">🐶</div>
                        <h4 style="color: var(--accent); margin-bottom: 4px;">My Dogs</h4>
                        <p class="muted small">Manage your pets</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/dashboard" class="action-card" style="text-decoration: none;">
                        <div class="action-card-icon">📅</div>
                        <h4 style="color: var(--accent); margin-bottom: 4px;">My Bookings</h4>
                        <p class="muted small">View reservations</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/logout" class="action-card" style="text-decoration: none;">
                        <div class="action-card-icon">🚪</div>
                        <h4 style="color: var(--accent); margin-bottom: 4px;">Log Out</h4>
                        <p class="muted small">Sign out securely</p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script>
        // Show success message if redirected after update
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('update') === 'success') {
            Swal.fire({
                icon: 'success',
                title: 'Profile Updated!',
                text: 'Your information has been saved successfully.',
                confirmButtonColor: getComputedStyle(document.documentElement).getPropertyValue('--accent') || '#7a4b2a'
            }).then(() => {
                window.history.replaceState({}, document.title, window.location.pathname);
            });
        }
    </script>
</body>
</html>