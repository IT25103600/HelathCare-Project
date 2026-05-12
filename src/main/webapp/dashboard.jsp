<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="user" value="${sessionScope.currentUser}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Directory — MediSync</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<!-- NAV -->
<nav class="ms-nav">
    <a href="${pageContext.request.contextPath}/" class="ms-nav-logo">Medi<span>Sync</span></a>
    <div class="ms-nav-right">
        <span class="ms-nav-user">Welcome, <strong><c:out value="${user.name}"/></strong></span>
        <span class="ms-role-badge ms-role-${user.role}"><c:out value="${user.role}"/></span>
        <a href="${pageContext.request.contextPath}/" class="ms-btn-back">← Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" class="ms-btn-logout">Logout</a>
    </div>
</nav>

<div class="ms-page">
    <!-- Header -->
    <div class="ms-page-header">
        <div class="ms-page-header-left">
            <div class="ms-eyebrow">Component 01 · Member 1</div>
            <h1>Patient Directory</h1>
            <p>Manage patient registrations, profiles, and accounts.</p>
        </div>
        <c:if test="${user.isAdmin()}">
            <a href="${pageContext.request.contextPath}/patient/new" class="ms-btn ms-btn-primary">+ Register Patient</a>
        </c:if>
    </div>

    <!-- Error / success alerts -->
    <c:if test="${param.error == 'AccessDenied'}">
        <div class="ms-alert ms-alert-error">🔒 You do not have permission to perform that action.</div>
    </c:if>

    <!-- Search -->
    <div class="ms-search">
        <form action="${pageContext.request.contextPath}/patient/search" method="get" style="display:flex;flex:1;gap:.5rem;">
            <input type="text" name="keyword" placeholder="Search by name, ID or email…" value="<c:out value='${keyword}'/>">
            <button type="submit" class="ms-btn ms-btn-primary ms-btn-sm">Search</button>
            <a href="${pageContext.request.contextPath}/patient/list" class="ms-btn ms-btn-ghost ms-btn-sm">Clear</a>
        </form>
    </div>

    <!-- Table -->
    <div class="ms-table-wrap">
        <table class="ms-table">
            <thead>
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Type</th>
                    <c:if test="${user.isAdmin()}"><th>Actions</th></c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="patient" items="${listPatient}">
                <tr>
                    <td class="id-cell"><c:out value="${patient.patientId}"/></td>
                    <td><strong><c:out value="${patient.name}"/></strong></td>
                    <td style="color:var(--muted);"><c:out value="${patient.email}"/></td>
                    <td><c:out value="${patient.phone}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${patient.patientType == 'Premium'}">
                                <span class="ms-badge ms-badge-amber">⭐ Premium</span>
                            </c:when>
                            <c:otherwise>
                                <span class="ms-badge ms-badge-blue">Regular</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <c:if test="${user.isAdmin()}">
                    <td>
                        <div style="display:flex;gap:.5rem;">
                            <a href="${pageContext.request.contextPath}/patient/edit?id=<c:out value='${patient.patientId}'/>" class="ms-btn ms-btn-outline ms-btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/patient/delete?id=<c:out value='${patient.patientId}'/>" class="ms-btn ms-btn-danger ms-btn-sm" onclick="return confirm('Delete this patient permanently?')">Delete</a>
                        </div>
                    </td>
                    </c:if>
                </tr>
                </c:forEach>
                <c:if test="${empty listPatient}">
                    <tr class="empty-row"><td colspan="6">No patients found.</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="ms-table-footer">
            <span>Showing <strong>${listPatient.size()}</strong> record(s)</span>
            <span>Patient Management · Member 01</span>
        </div>
    </div>
</div>
</body>
</html>
