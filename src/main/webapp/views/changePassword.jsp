<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <div class="site-container">
        <div class="card form-container" style="max-width:540px;margin:28px auto;padding:32px">
            <div class="profile-header text-center">
                <div style="font-size: 48px; margin-bottom: 16px;">🔒</div>
                <h2 style="color: var(--accent);">Change Password</h2>
                <p class="muted">Keep your account secure with a strong password</p>
            </div>

            <!-- Error Messages -->
            <c:if test="${param.error == 'wrong_current'}">
                <div style="padding: 15px; margin: 20px 0; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px; color: #721c24;">
                    ⚠️ Current password is incorrect. Please try again.
                </div>
            </c:if>

            <c:if test="${param.error == 'mismatch'}">
                <div style="padding: 15px; margin: 20px 0; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px; color: #721c24;">
                    ⚠️ New passwords do not match. Please try again.
                </div>
            </c:if>

            <c:if test="${param.error == 'weak_password'}">
                <div style="padding: 15px; margin: 20px 0; background-color: #fff3cd; border: 1px solid #ffeaa7; border-radius: 4px; color: #856404;">
                    ⚠️ Password must be at least 6 characters long.
                </div>
            </c:if>

            <c:if test="${param.error == 'server_error'}">
                <div style="padding: 15px; margin: 20px 0; background-color: #f8d7da; border: 1px solid #f5c6cb; border-radius: 4px; color: #721c24;">
                    ⚠️ An error occurred. Please try again later.
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/changePassword" method="POST" style="margin-top: 28px;" id="passwordForm">
                
                <div class="form-group">
                    <label for="currentPassword">Current Password *</label>
                    <input type="password" id="currentPassword" name="currentPassword" 
                           required 
                           placeholder="Enter your current password">
                </div>
                
                <div class="form-group">
                    <label for="newPassword">New Password *</label>
                    <input type="password" id="newPassword" name="newPassword" 
                           required 
                           minlength="6"
                           placeholder="Enter new password (min 6 characters)">
                    <small class="muted" style="display: block; margin-top: 4px; font-size: 13px;">
                        Password must be at least 6 characters long
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           required 
                           minlength="6"
                           placeholder="Re-enter new password">
                </div>

                <!-- Password Strength Indicator -->
                <div style="margin-bottom: 20px;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px;">
                        <small class="muted">Password Strength:</small>
                        <small id="strengthText" class="muted">Not set</small>
                    </div>
                    <div style="height: 4px; background: #f0e6e0; border-radius: 2px; overflow: hidden;">
                        <div id="strengthBar" style="height: 100%; width: 0%; background: #ccc; transition: all 0.3s;"></div>
                    </div>
                </div>

                <div style="display: flex; gap: 12px; margin-top: 28px;">
                    <button type="submit" class="btn btn-primary" style="flex: 1;">
                        🔒 Update Password
                    </button>
                    <a href="${pageContext.request.contextPath}/profile" 
                       class="btn btn-secondary" 
                       style="flex: 1; text-align: center; line-height: inherit;">
                        Cancel
                    </a>
                </div>
            </form>

            <!-- Security Tips -->
            <div style="margin-top: 32px; padding: 20px; border-radius: 12px; background: linear-gradient(180deg, var(--glass), rgba(255,255,255,0.4));">
                <h4 style="color: var(--accent); margin-bottom: 12px; font-size: 14px;">Password Security Tips:</h4>
                <ul style="color: var(--muted); font-size: 13px; line-height: 1.8; margin-left: 20px;">
                    <li>Use at least 8 characters (6 minimum)</li>
                    <li>Include uppercase and lowercase letters</li>
                    <li>Add numbers and special characters</li>
                    <li>Avoid common words or personal information</li>
                    <li>Don't reuse passwords from other accounts</li>
                </ul>
            </div>
        </div>
    </div>

    <jsp:include page="includes/footer.jsp" />

    <script>
        const form = document.getElementById('passwordForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const strengthBar = document.getElementById('strengthBar');
        const strengthText = document.getElementById('strengthText');

        // Password strength checker
        newPassword.addEventListener('input', function() {
            const password = this.value;
            let strength = 0;
            
            if (password.length >= 6) strength++;
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;

            const colors = ['#e74c3c', '#e67e22', '#f39c12', '#2ecc71', '#27ae60'];
            const texts = ['Very Weak', 'Weak', 'Fair', 'Good', 'Strong'];
            const widths = ['20%', '40%', '60%', '80%', '100%'];

            if (password.length === 0) {
                strengthBar.style.width = '0%';
                strengthText.textContent = 'Not set';
                strengthBar.style.background = '#ccc';
            } else {
                strengthBar.style.width = widths[strength];
                strengthBar.style.background = colors[strength];
                strengthText.textContent = texts[strength];
                strengthText.style.color = colors[strength];
            }
        });

        // Form validation
        form.addEventListener('submit', function(e) {
            const newPass = newPassword.value;
            const confirmPass = confirmPassword.value;

            if (newPass !== confirmPass) {
                e.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Passwords Don\'t Match',
                    text: 'New password and confirmation password must match.',
                    confirmButtonColor: '#7a4b2a'
                });
                return false;
            }

            if (newPass.length < 6) {
                e.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Password Too Short',
                    text: 'Password must be at least 6 characters long.',
                    confirmButtonColor: '#7a4b2a'
                });
                return false;
            }
        });

        // Show success message if redirected with success parameter
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('success') === 'true') {
            Swal.fire({
                icon: 'success',
                title: 'Password Changed!',
                text: 'Your password has been updated successfully.',
                confirmButtonColor: '#7a4b2a'
            }).then(() => {
                window.location.href = '${pageContext.request.contextPath}/profile';
            });
        }
    </script>
</body>
</html>