<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule Appointment - Healthcare System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="glass-container glass-form-container">
        <div class="header">
            <h1>Schedule Appointment</h1>
            <a href="${pageContext.request.contextPath}/appointment/list" class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Back</a>
        </div>
        <c:if test="${param.error == 'DoctorNotFound'}">
            <div style="color: #da3633; background: #ffebe9; padding: 0.8rem; border-radius: 8px; margin-bottom: 1rem; text-align: center; font-size: 0.9rem;">
                Error: The Doctor ID you entered does not exist in the system!
            </div>
        </c:if>
        <c:if test="${param.error == 'PastDateNotAllowed'}">
            <div style="color: #da3633; background: #ffebe9; padding: 0.8rem; border-radius: 8px; margin-bottom: 1rem; text-align: center; font-size: 0.9rem;">
                Error: You cannot book an appointment for a date in the past!
            </div>
        </c:if>
        <c:if test="${param.error == 'DoctorNotAvailable'}">
            <div style="color: #da3633; background: #ffebe9; padding: 0.8rem; border-radius: 8px; margin-bottom: 1rem; text-align: center; font-size: 0.9rem;">
                Error: The Doctor is not available on this date (Sundays are off).
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/appointment/insert" method="post">
            <div class="form-group">
                <label>Patient ID</label>
                <input type="text" name="patientId" class="form-control" required placeholder="P001">
            </div>
            <div class="form-group">
                <label>Doctor ID</label>
                <input type="text" name="doctorId" class="form-control" required placeholder="D001">
            </div>
            <div class="form-group">
                <label>Date (YYYY-MM-DD)</label>
                <input type="date" name="date" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Time (HH:MM AM/PM)</label>
                <input type="text" name="time" class="form-control" required placeholder="10:30 AM">
            </div>
            <div class="form-group">
                <label>Reason</label>
                <input type="text" name="reason" class="form-control" required placeholder="General Checkup">
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="status" class="form-control" required>
                    <option value="Pending">Pending</option>
                    <option value="Confirmed">Confirmed</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
            </div>
            <div class="form-group">
                <label>Appointment Type</label>
                <select name="appointmentType" class="form-control" required>
                    <option value="Regular">Regular</option>
                    <option value="Emergency">Emergency</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 0.8rem;">Schedule</button>
        </form>
        <div style="text-align: center; margin-top: 1rem; color: var(--text-muted); font-size: 0.8rem;">
            Developed by Member 3
        </div>
    </div>
</body>
</html>
