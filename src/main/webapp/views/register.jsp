<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Château Fido</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/headerHome.jsp" />
    <div class="site-container">
        <div class="card" style="max-width:520px;margin:28px auto;padding:20px">
            <div class="text-center">
                <div class="logo-emoji">🐕</div>
                <h2>Join Château Fido</h2>
                <p class="muted">Create your account today</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="card" style="margin-top:18px;background:#fff6f1;border-left:4px solid #e07b58">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/register" method="post" id="registerForm" style="margin-top:18px">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="0123456789" required>
                    <small class="muted">Format: 10-11 digits</small>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="your@email.com" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required>
                    <small class="muted">At least 6 characters</small>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter your password" required>
                    <span class="password-match" id="passwordMatch"></span>
                </div>
                <div style="margin-top:12px">
                    <button class="btn btn-primary" type="submit">Create Account</button>
                </div>
            </form>

            <div class="text-center muted" style="margin-top:12px">
                Already have an account? <a href="<%= request.getContextPath() %>/login">Login here</a>
            </div>
        </div>
    </div>
    <jsp:include page="includes/footer.jsp" />

    <script>
        // Password match validation
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const passwordMatch = document.getElementById('passwordMatch');
    
        confirmPassword.addEventListener('keyup', function() {
            if (confirmPassword.value === '') { passwordMatch.textContent = ''; return; }
            if (password.value === confirmPassword.value) { passwordMatch.textContent = '✓ Passwords match'; passwordMatch.className = 'password-match match'; }
            else { passwordMatch.textContent = '✗ Passwords do not match'; passwordMatch.className = 'password-match no-match'; }
        });
    
        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const email = document.getElementById('email').value.trim();
            const pass = password.value;
            const confirmPass = confirmPassword.value;
      
            if (!name || !phone || !email || !pass || !confirmPass) { e.preventDefault(); alert('Please fill in all fields'); return false; }
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {e.preventDefault(); alert('Please enter a valid email address');return false;}
            const phoneRegex = /^[0-9]{10,11}$/; if (!phoneRegex.test(phone)) { e.preventDefault(); alert('Please enter a valid phone number (10-11 digits)'); return false; }
            if (pass.length < 6) { e.preventDefault(); alert('Password must be at least 6 characters long'); return false; }
            if (pass !== confirmPass) { e.preventDefault(); alert('Passwords do not match'); return false; }
        });
    </script>
</body>
</html>
            
<script>
            if (pass !== confirmPass) {
                e.preventDefault();
                alert('Passwords do not match');
                return false;
            }
        });
    </script>
</body>
</html>