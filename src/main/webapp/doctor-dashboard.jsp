<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="user" value="${sessionScope.currentUser}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Directory — MediSync</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
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
    <div class="ms-page-header">
        <div class="ms-page-header-left">
            <div class="ms-eyebrow">Component 02 · Member 2</div>
            <h1>Doctor Directory</h1>
            <p>Browse and manage medical staff, specializations, and availability.</p>
        </div>
        <c:if test="${user.isAdmin()}">
            <a href="${pageContext.request.contextPath}/doctor/new" class="ms-btn ms-btn-primary">+ Add Doctor</a>
        </c:if>
    </div>

    <div class="ms-search">
        <form action="${pageContext.request.contextPath}/doctor/search" method="get" style="display:flex;flex:1;gap:.5rem;">
            <input type="text" name="keyword" placeholder="Search by name or specialization…" value="<c:out value='${keyword}'/>">
            <button type="submit" class="ms-btn ms-btn-primary ms-btn-sm">Search</button>
            <a href="${pageContext.request.contextPath}/doctor/list" class="ms-btn ms-btn-ghost ms-btn-sm">Clear</a>
        </form>
    </div>

    <div class="ms-table-wrap">
        <table class="ms-table">
            <thead>
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th><th>Specialization</th><th>Type</th>
                    <c:if test="${user.isAdmin()}"><th>Actions</th></c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="doctor" items="${listDoctor}">
                <tr>
                    <td class="id-cell"><c:out value="${doctor.doctorId}"/></td>
                    <td><strong>Dr. <c:out value="${doctor.name}"/></strong></td>
                    <td style="color:var(--muted);"><c:out value="${doctor.email}"/></td>
                    <td><c:out value="${doctor.specialization}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${doctor.doctorType == 'Specialist'}">
                                <span class="ms-badge ms-badge-purple">Specialist</span>
                            </c:when>
                            <c:otherwise>
                                <span class="ms-badge ms-badge-green">General</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <c:if test="${user.isAdmin()}">
                    <td>
                        <div style="display:flex;gap:.5rem;">
                            <a href="${pageContext.request.contextPath}/doctor/edit?id=<c:out value='${doctor.doctorId}'/>" class="ms-btn ms-btn-outline ms-btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/doctor/delete?id=<c:out value='${doctor.doctorId}'/>" class="ms-btn ms-btn-danger ms-btn-sm" onclick="return confirm('Remove this doctor?')">Delete</a>
                        </div>
                    </td>
                    </c:if>
                </tr>
                </c:forEach>
                <c:if test="${empty listDoctor}">
                    <tr class="empty-row"><td colspan="6">No doctors found.</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="ms-table-footer">
            <span>Showing <strong>${listDoctor.size()}</strong> doctor(s)</span>
            <span>Doctor Directory · Member 02</span>
        </div>
    </div>
</div>
</body>
</html>
