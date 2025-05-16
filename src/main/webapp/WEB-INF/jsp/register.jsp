<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register | CandleStore</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    /* Register page specific styles */
    .register-header {
      background-color: #fff0e6;
      padding: 40px 0;
      margin-bottom: 40px;
    }

    .register-container {
      max-width: 500px;
      margin: 0 auto;
    }

    .register-card {
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      border: none;
      overflow: hidden;
    }

    .register-card .card-header {
      background-color: #fff8f4;
      border-bottom: 2px solid #f0e0d6;
      padding: 20px;
    }

    .register-card .card-title {
      color: #7b3f00;
      font-weight: 600;
      margin-bottom: 0;
    }

    .register-card .card-body {
      padding: 40px;
    }

    .form-label {
      color: #7b3f00;
      font-weight: 500;
    }

    .form-control {
      padding: 12px;
      border-color: #f0e0d6;
      border-radius: 8px;
    }

    .form-control:focus {
      border-color: #d46a6a;
      box-shadow: 0 0 0 0.25rem rgba(212, 106, 106, 0.25);
    }

    .btn-candle {
      background-color: #d46a6a;
      color: white;
      border: none;
      padding: 12px 25px;
      border-radius: 8px;
      font-weight: 600;
      transition: background-color 0.3s;
    }

    .btn-candle:hover {
      background-color: #b04f4f;
      color: white;
    }

    .divider {
      display: flex;
      align-items: center;
      margin: 25px 0;
      color: #999;
    }

    .divider::before, .divider::after {
      content: "";
      flex: 1;
      border-bottom: 1px solid #f0e0d6;
    }

    .divider::before {
      margin-right: 15px;
    }

    .divider::after {
      margin-left: 15px;
    }

    .login-link {
      text-align: center;
      margin-top: 20px;
      color: #666;
    }

    .login-link a {
      color: #d46a6a;
      text-decoration: none;
      font-weight: 600;
    }

    .login-link a:hover {
      text-decoration: underline;
    }

    .password-requirements {
      font-size: 0.85rem;
      color: #666;
      margin-top: 5px;
    }

    .breadcrumb-item + .breadcrumb-item::before {
      color: #d46a6a;
    }

    .breadcrumb-item a {
      color: #7b3f00;
      text-decoration: none;
    }

    .breadcrumb-item.active {
      color: #d46a6a;
    }

    .form-check-input:checked {
      background-color: #d46a6a;
      border-color: #d46a6a;
    }

    .password-strength {
      height: 5px;
      border-radius: 5px;
      margin-top: 10px;
    }

    .strength-weak {
      background-color: #dc3545;
      width: 30%;
    }

    .strength-medium {
      background-color: #ffc107;
      width: 60%;
    }

    .strength-strong {
      background-color: #28a745;
      width: 100%;
    }
  </style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="fragments/navbar.jsp"/>

<!-- Register Header -->
<section class="register-header">
  <div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li class="breadcrumb-item active">Register</li>
      </ol>
    </nav>
    <h1 class="mt-4 text-candle">Create an Account</h1>
  </div>
</section>

<!-- Register Form -->
<section class="container mb-5">
  <div class="register-container">
    <div class="card register-card">
      <div class="card-header">
        <h4 class="card-title">Join CandleStore</h4>
      </div>
      <div class="card-body">
        <!-- Error Message (shown if registration fails) -->
        <c:if test="${error != null}">
          <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle me-2"></i>
              ${error}
          </div>
        </c:if>

        <!-- Success Message (shown after successful registration) -->
        <c:if test="${success != null}">
          <div class="alert alert-success">
            <i class="fas fa-check-circle me-2"></i>
              ${success}
          </div>
        </c:if>

        <!-- Register Form - Simplified version with only username and password -->
        <form action="${pageContext.request.contextPath}/register" method="post">
          <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-user-tag text-muted"></i>
                            </span>
              <input type="text" name="username" class="form-control border-start-0" id="username" required>
            </div>
          </div>

          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-lock text-muted"></i>
                            </span>
              <input type="password" name="password" class="form-control border-start-0" id="password" required onkeyup="checkPasswordStrength()">
              <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                <i class="fas fa-eye"></i>
              </button>
            </div>
            <div class="password-strength" id="passwordStrength"></div>
            <div class="password-requirements">
              Password must be at least 8 characters long and include uppercase, lowercase, numbers, and special characters.
            </div>
          </div>

          <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <div class="input-group">
                            <span class="input-group-text bg-light border-end-0">
                                <i class="fas fa-lock text-muted"></i>
                            </span>
              <input type="password" class="form-control border-start-0" id="confirmPassword" required>
            </div>
            <div id="passwordMatch" class="text-danger" style="display: none;">
              Passwords do not match
            </div>
          </div>

          <div class="mb-4">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="termsAgreement" required>
              <label class="form-check-label" for="termsAgreement">
                I agree to the <a href="#" style="color: #d46a6a;">Terms of Service</a> and <a href="#" style="color: #d46a6a;">Privacy Policy</a>
              </label>
            </div>
          </div>

          <!-- CSRF token pour Spring Security -->
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

          <div class="d-grid">
            <button type="submit" class="btn btn-candle btn-lg">Create Account</button>
          </div>

          <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Sign In</a>
          </div>
        </form>
      </div>
    </div>

    <!-- Security Notice -->
    <div class="mt-4 text-center">
      <div class="d-flex justify-content-center mb-2">
        <i class="fas fa-shield-alt text-success me-2"></i>
        <span>Your information is secure with us</span>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<jsp:include page="fragments/footer.jsp"/>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Password Strength & Confirmation Validation -->
<script>
  function checkPasswordStrength() {
    const password = document.getElementById('password').value;
    const strengthBar = document.getElementById('passwordStrength');

    // Reset the strength bar
    strengthBar.className = 'password-strength';

    // Check password strength
    if (password.length === 0) {
      // Empty password
      strengthBar.style.width = '0';
      strengthBar.classList.add('bg-light');
    } else if (password.length < 6) {
      // Weak password
      strengthBar.classList.add('strength-weak');
    } else if (password.length < 10 || !/[0-9]/.test(password) || !/[A-Z]/.test(password)) {
      // Medium password
      strengthBar.classList.add('strength-medium');
    } else {
      // Strong password
      strengthBar.classList.add('strength-strong');
    }
  }

  // Password toggle visibility
  document.getElementById('togglePassword').addEventListener('click', function() {
    const passwordInput = document.getElementById('password');
    const icon = this.querySelector('i');

    // Toggle the password visibility
    if (passwordInput.type === 'password') {
      passwordInput.type = 'text';
      icon.classList.remove('fa-eye');
      icon.classList.add('fa-eye-slash');
    } else {
      passwordInput.type = 'password';
      icon.classList.remove('fa-eye-slash');
      icon.classList.add('fa-eye');
    }
  });

  // Check if passwords match
  document.getElementById('confirmPassword').addEventListener('input', function() {
    const password = document.getElementById('password').value;
    const confirmPassword = this.value;
    const passwordMatch = document.getElementById('passwordMatch');

    if (password !== confirmPassword) {
      passwordMatch.style.display = 'block';
    } else {
      passwordMatch.style.display = 'none';
    }
  });

  // Form validation
  document.querySelector('form').addEventListener('submit', function(event) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
      event.preventDefault();
      document.getElementById('passwordMatch').style.display = 'block';
    }
  });
</script>
</body>
</html>