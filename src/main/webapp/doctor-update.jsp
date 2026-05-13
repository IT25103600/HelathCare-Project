<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Doctor - Healthcare System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="glass-container glass-form-container">
        <div class="header">
            <h1>Update Doctor Profile</h1>
            <a href="${pageContext.request.contextPath}/doctor/list" class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Cancel</a>
        </div>

        <form action="${pageContext.request.contextPath}/doctor/update" method="post">
            <input type="hidden" name="doctorId" value="<c:out value='${doctor.doctorId}' />" />
            
            <div class="form-group">
                <label>Doctor ID</label>
                <input type="text" class="form-control" value="<c:out value='${doctor.doctorId}' />" disabled style="background: rgba(0,0,0,0.05); color: var(--text-muted);">
            </div>

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" required value="<c:out value='${doctor.name}' />">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required value="<c:out value='${doctor.email}' />">
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" class="form-control" required value="<c:out value='${doctor.phone}' />">
            </div>

            <div class="form-group">
                <label for="specialization">Specialization</label>
                <input type="text" id="specialization" name="specialization" class="form-control" required value="<c:out value='${doctor.specialization}' />">
            </div>

            <div class="form-group">
                <label for="doctorType">Doctor Type</label>
                <select id="doctorType" name="doctorType" class="form-control" required>
                    <option value="General" <c:if test="${doctor.doctorType == 'General'}">selected</c:if>>General Physician</option>
                    <option value="Specialist" <c:if test="${doctor.doctorType == 'Specialist'}">selected</c:if>>Specialist</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 0.8rem;">Save Changes</button>
        </form>
        <div style="text-align: center; margin-top: 1rem; color: var(--text-muted); font-size: 0.8rem;">
            Developed by Member 2
        </div>
    </div>
</body>
</html>
