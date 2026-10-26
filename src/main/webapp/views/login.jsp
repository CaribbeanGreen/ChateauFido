<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Château Fido</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
</head>
<body>
    <jsp:include page="includes/headerHome.jsp" />
    <div class="site-container">
        <div class="card" style="max-width:480px;margin:28px auto;padding:24px">
            <div class="text-center">
                <div class="logo-emoji">🐕</div>
                <h2>Welcome Back!</h2>
                <p class="muted">Login to Château Fido</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="card" style="margin-top:18px;background:#fff6f1;border-left:4px solid #e07b58">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/login" method="post" id="loginForm" style="margin-top:18px">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>
                <div style="margin-top:12px">
                    <button class="btn btn-primary" type="submit">Login</button>
                </div>
            </form>

            <div class="text-center muted" style="margin-top:12px">
                Don't have an account? <a href="<%= request.getContextPath() %>/register">Sign up here</a>
            </div>
        </div>
    </div>
    <jsp:include page="includes/footer.jsp" />

   <script>
        // Client-side validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
                return false;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }
        });
    </script>
</body>
</html>