<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="user" value="${sessionScope.currentUser}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Records — MediSync</title>
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
            <div class="ms-eyebrow">Component 04 · Member 4</div>
            <h1>Medical Records</h1>
            <p>Prescriptions, diagnosis reports, and complete patient history.</p>
        </div>
        <c:if test="${user.isAdmin() || user.isDoctor()}">
            <a href="${pageContext.request.contextPath}/record/new" class="ms-btn ms-btn-primary">+ Add Record</a>
        </c:if>
    </div>
    <div class="ms-search">
        <form action="${pageContext.request.contextPath}/record/search" method="get" style="display:flex;flex:1;gap:.5rem;">
            <input type="text" name="keyword" placeholder="Search by Patient ID or Record ID…" value="<c:out value='${keyword}'/>">
            <button type="submit" class="ms-btn ms-btn-primary ms-btn-sm">Search</button>
            <a href="${pageContext.request.contextPath}/record/list" class="ms-btn ms-btn-ghost ms-btn-sm">Clear</a>
        </form>
    </div>
    <div class="ms-table-wrap">
        <table class="ms-table">
            <thead>
                <tr><th>Record ID</th><th>Patient ID</th><th>Doctor ID</th><th>Type</th><th>Diagnosis</th><th>Date</th>
                    <c:if test="${user.isAdmin() || user.isDoctor()}"><th>Actions</th></c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="record" items="${listRecord}">
                <tr>
                    <td class="id-cell"><c:out value="${record.recordId}"/></td>
                    <td><c:out value="${record.patientId}"/></td>
                    <td><c:out value="${record.doctorId}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${record.recordType == 'Prescription'}"><span class="ms-badge ms-badge-blue">💊 Prescription</span></c:when>
                            <c:otherwise><span class="ms-badge ms-badge-purple">📋 Diagnosis</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td style="max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><c:out value="${record.diagnosis}"/></td>
                    <td><c:out value="${record.visitDate}"/></td>
                    <c:if test="${user.isAdmin() || user.isDoctor()}">
                    <td><div style="display:flex;gap:.5rem;">
                        <a href="${pageContext.request.contextPath}/record/edit?id=<c:out value='${record.recordId}'/>" class="ms-btn ms-btn-outline ms-btn-sm">Edit</a>
                        <c:if test="${user.isAdmin()}"><a href="${pageContext.request.contextPath}/record/delete?id=<c:out value='${record.recordId}'/>" class="ms-btn ms-btn-danger ms-btn-sm" onclick="return confirm('Delete record?')">Delete</a></c:if>
                    </div></td>
                    </c:if>
                </tr>
                </c:forEach>
                <c:if test="${empty listRecord}"><tr class="empty-row"><td colspan="7">No medical records found.</td></tr></c:if>
            </tbody>
        </table>
        <div class="ms-table-footer">
            <span>Showing <strong>${listRecord.size()}</strong> record(s)</span>
            <span>Medical Records · Member 04</span>
        </div>
    </div>
</div>
</body>
</html>
