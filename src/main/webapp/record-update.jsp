<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Record - Healthcare System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="glass-container glass-form-container">
        <div class="header">
            <h1>Update Record</h1>
            <a href="${pageContext.request.contextPath}/record/list" class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Cancel</a>
        </div>
        <form action="${pageContext.request.contextPath}/record/update" method="post">
            <input type="hidden" name="recordId" value="<c:out value='${record.recordId}' />" />
            <div class="form-group">
                <label>Patient ID</label>
                <input type="text" name="patientId" class="form-control" required value="<c:out value='${record.patientId}' />">
            </div>
            <div class="form-group">
                <label>Doctor ID</label>
                <input type="text" name="doctorId" class="form-control" required value="<c:out value='${record.doctorId}' />">
            </div>
            <div class="form-group">
                <label>Diagnosis</label>
                <input type="text" name="diagnosis" class="form-control" required value="<c:out value='${record.diagnosis}' />">
            </div>
            <div class="form-group">
                <label>Prescription</label>
                <input type="text" name="prescription" class="form-control" required value="<c:out value='${record.prescription}' />">
            </div>
            <div class="form-group">
                <label>Visit Date</label>
                <input type="text" name="visitDate" class="form-control" required value="<c:out value='${record.visitDate}' />">
            </div>
            <div class="form-group">
                <label>Record Type</label>
                <select name="recordType" class="form-control" required>
                    <option value="Prescription" <c:if test="${record.recordType == 'Prescription'}">selected</c:if>>Prescription</option>
                    <option value="DiagnosisReport" <c:if test="${record.recordType == 'DiagnosisReport'}">selected</c:if>>Diagnosis Report</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 0.8rem;">Save Changes</button>
        </form>
        <div style="text-align: center; margin-top: 1rem; color: var(--text-muted); font-size: 0.8rem;">
            Developed by Member 4
        </div>
    </div>
</body>
</html>
