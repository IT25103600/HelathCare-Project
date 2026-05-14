<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediSync — Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="ms-split-layout">
<div class="ms-split-left">
    <div class="logo">Medi<span>Sync</span></div>
    <h1 class="hero">Welcome back<br>to <em>MediSync.</em></h1>
    <p class="sub">Your appointments, doctors, and medical history — all in one place.</p>
    <div class="feat">Book and manage appointments instantly</div>
    <div class="feat">View your complete medical history</div>
    <div class="feat">Role-based secure access for all users</div>
    <div class="feat">File-based persistence, no database required</div>
</div>

<div class="ms-split-right">
    <div class="ms-login-card">
        <div class="ms-login-eyebrow">Secure Portal</div>
        <h2 class="ms-login-title">Sign in</h2>
        <p class="ms-login-sub">Use your registered email and password</p>

        <c:if test="${param.registered == 'true'}">
            <div class="ms-alert ms-alert-success">🎉 Account created! You can now sign in below.</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="ms-alert ms-alert-error">⚠ <span><c:out value="${error}"/></span></div>
        </c:if>

        <div class="ms-tabs">
            <button class="ms-tab active" type="button">Admin</button>
            <button class="ms-tab" type="button">Doctor</button>
            <button class="ms-tab" type="button">Patient</button>
        </div>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="hidden" name="role" id="selectedRole" value="ADMIN">
            <div class="ms-field">
                <label class="ms-label">Email Address</label>
                <input class="ms-input" type="email" name="email" required placeholder="you@example.com" value="<c:out value='${emailTyped}'/>">
            </div>
            <div class="ms-field">
                <label class="ms-label">Password</label>
                <input class="ms-input" type="password" name="password" required placeholder="Enter your password" autocomplete="current-password">
            </div>
            <div class="ms-hint-box">
                <strong>Admin / Doctor?</strong> Your account is in the system data files.<br>
                <strong>First-time Patient?</strong> Use the register button below.
            </div>
            <button class="ms-btn ms-btn-primary" type="submit" style="width:100%;padding:1rem;font-size:1rem;">Sign In →</button>
        </form>

        <div class="ms-divider">New patient?</div>
        <a href="${pageContext.request.contextPath}/register" class="ms-register-link">Create a Patient Account →</a>
    </div>
</div>

<script>
    const roleInput = document.getElementById('selectedRole');
    document.querySelectorAll('.ms-tab').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.ms-tab').forEach(t => t.classList.remove('active'));
            btn.classList.add('active');
            roleInput.value = btn.innerText.toUpperCase();
        });
    });
</script>
</body>
</html>
