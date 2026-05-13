<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediSync — Create Patient Account</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { display:flex; align-items:center; justify-content:center; min-height:100vh; background:linear-gradient(135deg,#e8f5f0 0%,#f0edf8 100%); padding:2rem; }
        .wrap { width:100%; max-width:480px; }
        .back-link { display:inline-flex; align-items:center; gap:.4rem; font-size:.8rem; color:var(--muted); text-decoration:none; margin-bottom:1.5rem; }
        .back-link:hover { color:var(--ink); }
        .logo { font-size:1.2rem; font-weight:700; color:var(--green); margin-bottom:1.5rem; }
        .logo span { color:var(--green-light); }
        h1 { font-size:1.7rem; font-weight:700; margin-bottom:.3rem; }
        .sub { font-size:.875rem; color:var(--muted); margin-bottom:1.5rem; }
        .strength { height:4px; border-radius:2px; background:var(--border); margin-top:.4rem; overflow:hidden; }
        .strength-fill { height:100%; border-radius:2px; transition:width .3s,background .3s; width:0%; background:var(--danger); }
    </style>
</head>
<body>
<div class="wrap">
    <a href="${pageContext.request.contextPath}/login" class="back-link">← Back to Login</a>

    <div class="logo">Medi<span>Sync</span></div>
    <h1>Create Your Account</h1>
    <p class="sub">Register as a Patient to book appointments and view your records.</p>

    <c:if test="${not empty error}">
        <div class="ms-alert ms-alert-error">⚠ <c:out value="${error}"/></div>
    </c:if>

    <div class="ms-form-wrap" style="padding:1.75rem;">
        <form action="${pageContext.request.contextPath}/register" method="post" id="regForm">
            <div class="ms-form-grid-2">
                <div class="ms-field" style="grid-column:1/-1">
                    <label class="ms-label">Full Name</label>
                    <input class="ms-input" type="text" name="name" required placeholder="e.g. Kavishka Gunathilake"
                           value="<c:out value='${nameVal}'/>">
                </div>
                <div class="ms-field" style="grid-column:1/-1">
                    <label class="ms-label">Email Address</label>
                    <input class="ms-input" type="email" name="email" required placeholder="you@example.com"
                           value="<c:out value='${emailVal}'/>">
                </div>
                <div class="ms-field">
                    <label class="ms-label">Phone Number</label>
                    <input class="ms-input" type="tel" name="phone" required placeholder="+94 77 123 4567"
                           value="<c:out value='${phoneVal}'/>">
                </div>
                <div class="ms-field">
                    <label class="ms-label">Date of Birth</label>
                    <input class="ms-input" type="date" name="dob">
                </div>
                <div class="ms-field">
                    <label class="ms-label">Password</label>
                    <input class="ms-input" type="password" name="password" id="pwd" required placeholder="Min 6 characters" autocomplete="new-password">
                    <div class="strength"><div class="strength-fill" id="sbar"></div></div>
                </div>
                <div class="ms-field">
                    <label class="ms-label">Confirm Password</label>
                    <input class="ms-input" type="password" name="confirm" id="confirm" required placeholder="Re-enter password">
                </div>
            </div>

            <div class="ms-alert ms-alert-warn" style="margin-bottom:1.25rem;">
                🛡 You will be registered as a <strong>Regular Patient</strong>. After login, you can book appointments and view your records.
            </div>

            <button class="ms-btn ms-btn-primary" type="submit" style="width:100%;padding:.88rem;font-size:.9rem;">Create Account →</button>
            <p style="text-align:center;margin-top:1rem;font-size:.8rem;color:var(--muted);">
                Already have an account? <a href="${pageContext.request.contextPath}/login" style="color:var(--green-mid);font-weight:600;">Sign in here</a>
            </p>
        </form>
    </div>
</div>

<script>
const pwd = document.getElementById('pwd');
const sbar = document.getElementById('sbar');
pwd.addEventListener('input', () => {
    const v = pwd.value;
    let score = 0;
    if (v.length >= 6) score++;
    if (v.length >= 10) score++;
    if (/[A-Z]/.test(v)) score++;
    if (/[0-9]/.test(v)) score++;
    const colors = ['#c9613a','#f59e0b','#3b82f6','#2a5c45'];
    sbar.style.width = (score * 25) + '%';
    sbar.style.background = colors[score - 1] || '#c9613a';
});
</script>
</body>
</html>
