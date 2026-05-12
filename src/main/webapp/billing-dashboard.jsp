<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="user" value="${sessionScope.currentUser}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Billing — MediSync</title>
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
            <div class="ms-eyebrow">Component 05 · Member 5</div>
            <h1>Billing &amp; Invoices</h1>
            <p>Track payments, generate invoices, and manage Insurance or Direct payments.</p>
        </div>
        <a href="${pageContext.request.contextPath}/billing/new" class="ms-btn ms-btn-primary">+ Generate Invoice</a>
    </div>
    <div class="ms-search">
        <form action="${pageContext.request.contextPath}/billing/search" method="get" style="display:flex;flex:1;gap:.5rem;">
            <input type="text" name="keyword" placeholder="Search by Patient ID or Bill ID…" value="<c:out value='${keyword}'/>">
            <button type="submit" class="ms-btn ms-btn-primary ms-btn-sm">Search</button>
            <a href="${pageContext.request.contextPath}/billing/list" class="ms-btn ms-btn-ghost ms-btn-sm">Clear</a>
        </form>
    </div>
    <div class="ms-table-wrap">
        <table class="ms-table">
            <thead>
                <tr><th>Bill ID</th><th>Patient ID</th><th>Appt ID</th><th>Amount</th><th>Method</th><th>Status</th><th>Date</th><th>Actions</th></tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${listBilling}">
                <tr>
                    <td class="id-cell"><c:out value="${bill.billId}"/></td>
                    <td><c:out value="${bill.patientId}"/></td>
                    <td><c:out value="${bill.appointmentId}"/></td>
                    <td><strong>$<c:out value="${bill.amount}"/></strong></td>
                    <td>
                        <c:choose>
                            <c:when test="${bill.paymentMethod == 'Insurance'}"><span class="ms-badge ms-badge-purple">🏥 Insurance</span></c:when>
                            <c:otherwise><span class="ms-badge ms-badge-blue">💳 Direct</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${bill.paymentStatus == 'Paid'}"><span class="ms-badge ms-badge-green">✔ Paid</span></c:when>
                            <c:otherwise><span class="ms-badge ms-badge-amber">Unpaid</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td><c:out value="${bill.billDate}"/></td>
                    <td><div style="display:flex;gap:.5rem;">
                        <a href="${pageContext.request.contextPath}/billing/edit?id=<c:out value='${bill.billId}'/>" class="ms-btn ms-btn-outline ms-btn-sm">Edit</a>
                        <a href="${pageContext.request.contextPath}/billing/delete?id=<c:out value='${bill.billId}'/>" class="ms-btn ms-btn-danger ms-btn-sm" onclick="return confirm('Delete invoice?')">Delete</a>
                    </div></td>
                </tr>
                </c:forEach>
                <c:if test="${empty listBilling}"><tr class="empty-row"><td colspan="8">No billing records found.</td></tr></c:if>
            </tbody>
        </table>
        <div class="ms-table-footer">
            <span>Showing <strong>${listBilling.size()}</strong> invoice(s)</span>
            <span>Billing &amp; Invoices · Member 05</span>
        </div>
    </div>
</div>
</body>
</html>

<!-- UI alignment adjustment 381 -->

<!-- UI alignment adjustment 749 -->

<!-- UI alignment adjustment 812 -->
