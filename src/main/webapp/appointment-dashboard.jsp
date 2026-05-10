<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="user" value="${sessionScope.currentUser}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments — MediSync</title>
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
            <div class="ms-eyebrow">Component 03 · Member 3</div>
            <h1>Appointments</h1>
            <p>Schedule, track, and manage patient visits. Supports Regular &amp; Emergency types.</p>
        </div>
        <a href="${pageContext.request.contextPath}/appointment/new" class="ms-btn ms-btn-primary">+ Schedule Appointment</a>
    </div>

    <%-- Appointment validation errors --%>
    <c:if test="${param.error == 'DoctorNotFound'}">
        <div class="ms-alert ms-alert-error">🩺 Error: The Doctor ID you entered does not exist in the system.</div>
    </c:if>
    <c:if test="${param.error == 'PastDateNotAllowed'}">
        <div class="ms-alert ms-alert-error">📅 Error: You cannot book an appointment for a date in the past.</div>
    </c:if>
    <c:if test="${param.error == 'DoctorNotAvailable'}">
        <div class="ms-alert ms-alert-warn">⛔ Error: The doctor is unavailable on that date (Sundays are off).</div>
    </c:if>

    <div class="ms-search">
        <form action="${pageContext.request.contextPath}/appointment/search" method="get" style="display:flex;flex:1;gap:.5rem;">
            <input type="text" name="keyword" placeholder="Search by Patient ID or Doctor ID…" value="<c:out value='${keyword}'/>">
            <button type="submit" class="ms-btn ms-btn-primary ms-btn-sm">Search</button>
            <a href="${pageContext.request.contextPath}/appointment/list" class="ms-btn ms-btn-ghost ms-btn-sm">Clear</a>
        </form>
    </div>

    <div class="ms-table-wrap">
        <table class="ms-table">
            <thead>
                <tr><th>Apt ID</th><th>Patient ID</th><th>Doctor ID</th><th>Date &amp; Time</th><th>Type</th><th>Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
                <c:forEach var="appt" items="${listAppointment}">
                <tr>
                    <td class="id-cell"><c:out value="${appt.appointmentId}"/></td>
                    <td><c:out value="${appt.patientId}"/></td>
                    <td><c:out value="${appt.doctorId}"/></td>
                    <td>
                        <div style="font-weight:600;"><c:out value="${appt.date}"/></div>
                        <div style="font-size:.78rem;color:var(--muted);"><c:out value="${appt.time}"/></div>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${appt.appointmentType == 'Emergency'}">
                                <span class="ms-badge ms-badge-red">🚨 Emergency</span>
                            </c:when>
                            <c:otherwise>
                                <span class="ms-badge ms-badge-blue">Regular</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${appt.status == 'Confirmed'}"><span class="ms-badge ms-badge-green">Confirmed</span></c:when>
                            <c:when test="${appt.status == 'Cancelled'}"><span class="ms-badge ms-badge-red">Cancelled</span></c:when>
                            <c:otherwise><span class="ms-badge ms-badge-amber">Pending</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <div style="display:flex;gap:.5rem;">
                            <a href="${pageContext.request.contextPath}/appointment/edit?id=<c:out value='${appt.appointmentId}'/>" class="ms-btn ms-btn-outline ms-btn-sm">Edit</a>
                            <c:if test="${user.isAdmin()}">
                            <a href="${pageContext.request.contextPath}/appointment/delete?id=<c:out value='${appt.appointmentId}'/>" class="ms-btn ms-btn-danger ms-btn-sm" onclick="return confirm('Cancel this appointment?')">Delete</a>
                            </c:if>
                        </div>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty listAppointment}">
                    <tr class="empty-row"><td colspan="7">No appointments found.</td></tr>
                </c:if>
            </tbody>
        </table>
        <div class="ms-table-footer">
            <span>Showing <strong>${listAppointment.size()}</strong> appointment(s)</span>
            <span>Appointments · Member 03</span>
        </div>
    </div>
</div>
</body>
</html>
