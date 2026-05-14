<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Healthcare System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="glass-container">
        <div class="header">
            <h1>System Administrators</h1>
            <a href="${pageContext.request.contextPath}/admin/new" class="btn btn-primary">+ Add Admin</a>
        </div>

        <form action="${pageContext.request.contextPath}/admin/search" method="get" class="search-bar">
            <input type="text" name="keyword" class="form-control" placeholder="Search by name or email..." value="${keyword}">
            <button type="submit" class="btn btn-primary">Search</button>
            <a href="${pageContext.request.contextPath}/admin/list" class="btn btn-outline">Clear</a>
        </form>

        <table class="data-table">
            <thead>
                <tr>
                    <th>Admin ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="admin" items="${listAdmin}">
                    <tr>
                        <td><strong><c:out value="${admin.adminId}" /></strong></td>
                        <td><c:out value="${admin.name}" /></td>
                        <td><c:out value="${admin.email}" /></td>
                        <td class="actions">
                            <a href="${pageContext.request.contextPath}/admin/delete?id=<c:out value='${admin.adminId}' />" class="btn btn-danger" style="padding: 0.3rem 0.8rem; font-size: 0.8rem;" onclick="return confirm('Delete this admin?');">Revoke Access</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty listAdmin}">
                    <tr>
                        <td colspan="4" style="text-align:center; padding: 2rem;">No administrators found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        <div style="text-align: center; margin-top: 1rem; color: var(--text-muted); font-size: 0.8rem;">
            Developed by Member 6
        </div>
        <div style="margin-top: 1rem;">
            <a href="${pageContext.request.contextPath}/patient/list" class="btn btn-outline" style="font-size: 0.8rem;">Go to Patient Directory</a>
        </div>
    </div>
</body>
</html>
