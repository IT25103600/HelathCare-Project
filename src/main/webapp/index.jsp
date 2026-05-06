<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Grab the current user from session --%>
<c:set var="user" value="${sessionScope.currentUser}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediSync — Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="ms-nav">
    <a href="${pageContext.request.contextPath}/" class="ms-nav-logo">Medi<span>Sync</span></a>
    <div class="ms-nav-right">
        <div class="ms-nav-user">
            Welcome, <strong><c:out value="${user.name}"/></strong>
        </div>
        <span class="ms-role-badge ms-role-${user.role}">
            <c:out value="${user.role}"/>
        </span>
        <a href="${pageContext.request.contextPath}/logout" class="ms-btn-logout">Logout →</a>
    </div>
</nav>

<!-- MAIN -->
<div class="ms-page">

    <!-- Header -->
    <div class="ms-page-header">
        <div class="ms-page-header-left">
            <div class="ms-eyebrow">Project Hub</div>
            <h1>Medical Scheduling System</h1>
            <p>
                <c:choose>
                    <c:when test="${user.isAdmin()}">You have full Admin access to all 6 modules below.</c:when>
                    <c:when test="${user.isDoctor()}">You have access to your Doctor, Appointments, and Records modules.</c:when>
                    <c:when test="${user.isPatient()}">You have access to your Patient profile, Appointments, and Records.</c:when>
                </c:choose>
            </p>
        </div>
    </div>

    <!-- Access Denied warning (shown if someone was redirected here) -->
    <c:if test="${param.error == 'AccessDenied'}">
        <div class="ms-alert ms-alert-error">
            🔒 You do not have permission to access that section.
        </div>
    </c:if>

    <!-- MODULE CARDS GRID -->
    <div class="ms-grid">

        <%-- ===== 1. PATIENT MANAGEMENT — visible to ADMIN and PATIENT ===== --%>
        <c:choose>
            <c:when test="${user.isAdmin() || user.isPatient()}">
                <a href="${pageContext.request.contextPath}/patient/list" class="ms-card">
                    <div class="card-icon">🧑‍⚕️</div>
                    <div class="card-title">Patient Management</div>
                    <div class="card-desc">Register, search, and manage patient profiles and health records.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 01</span></div>
                </a>
            </c:when>
            <c:otherwise>
                <div class="ms-card ms-locked">
                    <span class="ms-badge ms-badge-red" style="position: absolute; top: 1.5rem; right: 1.5rem;">🔒 No Access</span>
                    <div class="card-icon">🧑‍⚕️</div>
                    <div class="card-title">Patient Management</div>
                    <div class="card-desc">Restricted to Admin and Patient roles.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 01</span></div>
                </div>
            </c:otherwise>
        </c:choose>

        <%-- ===== 2. DOCTOR DIRECTORY — visible to ADMIN and DOCTOR ===== --%>
        <c:choose>
            <c:when test="${user.isAdmin() || user.isDoctor()}">
                <a href="${pageContext.request.contextPath}/doctor/list" class="ms-card">
                    <div class="card-icon">👨‍⚕️</div>
                    <div class="card-title">Doctor Directory</div>
                    <div class="card-desc">Add, update, and manage doctor profiles, specializations, and availability.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 02</span></div>
                </a>
            </c:when>
            <c:otherwise>
                <div class="ms-card ms-locked">
                    <span class="ms-badge ms-badge-red" style="position: absolute; top: 1.5rem; right: 1.5rem;">🔒 No Access</span>
                    <div class="card-icon">👨‍⚕️</div>
                    <div class="card-title">Doctor Directory</div>
                    <div class="card-desc">Restricted to Admin and Doctor roles.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 02</span></div>
                </div>
            </c:otherwise>
        </c:choose>

        <%-- ===== 3. APPOINTMENTS — visible to ALL roles ===== --%>
        <a href="${pageContext.request.contextPath}/appointment/list" class="ms-card">
            <div class="card-icon">📅</div>
            <div class="card-title">Appointments</div>
            <div class="card-desc">Book, reschedule, or cancel appointments. Supports Regular and Emergency types.</div>
            <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 03</span></div>
        </a>

        <%-- ===== 4. MEDICAL RECORDS — visible to ALL roles ===== --%>
        <a href="${pageContext.request.contextPath}/record/list" class="ms-card">
            <div class="card-icon">📋</div>
            <div class="card-title">Medical Records</div>
            <div class="card-desc">View prescriptions, diagnosis reports, and complete patient history.</div>
            <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 04</span></div>
        </a>

        <%-- ===== 5. BILLING — visible to ADMIN only ===== --%>
        <c:choose>
            <c:when test="${user.isAdmin()}">
                <a href="${pageContext.request.contextPath}/billing/list" class="ms-card">
                    <div class="card-icon">💳</div>
                    <div class="card-title">Billing &amp; Invoices</div>
                    <div class="card-desc">Generate invoices, track payments. Supports Insurance and Direct payment methods.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 05</span></div>
                </a>
            </c:when>
            <c:otherwise>
                <div class="ms-card ms-locked">
                    <span class="ms-badge ms-badge-red" style="position: absolute; top: 1.5rem; right: 1.5rem;">🔒 Admin Only</span>
                    <div class="card-icon">💳</div>
                    <div class="card-title">Billing &amp; Invoices</div>
                    <div class="card-desc">Restricted to Admin role only.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 05</span></div>
                </div>
            </c:otherwise>
        </c:choose>

        <%-- ===== 6. ADMIN PANEL — visible to ADMIN only ===== --%>
        <c:choose>
            <c:when test="${user.isAdmin()}">
                <a href="${pageContext.request.contextPath}/admin/list" class="ms-card">
                    <div class="card-icon">🛡️</div>
                    <div class="card-title">System Admin</div>
                    <div class="card-desc">Manage admin accounts, permissions, and system-wide access control.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 06</span></div>
                </a>
            </c:when>
            <c:otherwise>
                <div class="ms-card ms-locked">
                    <span class="ms-badge ms-badge-red" style="position: absolute; top: 1.5rem; right: 1.5rem;">🔒 Admin Only</span>
                    <div class="card-icon">🛡️</div>
                    <div class="card-title">System Admin</div>
                    <div class="card-desc">Restricted to Admin role only.</div>
                    <div style="margin-top: 1rem;"><span class="ms-badge ms-badge-green">Member 06</span></div>
                </div>
            </c:otherwise>
        </c:choose>

    </div><!-- /ms-grid -->
</div>

<footer style="text-align: center; padding: 2rem; color: var(--text-muted); font-size: 0.85rem;">
    MediSync Medical Scheduling System &mdash; Group Project &bull; All rights reserved
</footer>

</body>
</html>
