<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Invoice - Healthcare System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="glass-container glass-form-container">
        <div class="header">
            <h1>Update Invoice</h1>
            <a href="${pageContext.request.contextPath}/billing/list" class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Cancel</a>
        </div>
        <form action="${pageContext.request.contextPath}/billing/update" method="post">
            <input type="hidden" name="billId" value="<c:out value='${billing.billId}' />" />
            <div class="form-group">
                <label>Patient ID</label>
                <input type="text" name="patientId" class="form-control" required value="<c:out value='${billing.patientId}' />">
            </div>
            <div class="form-group">
                <label>Appointment ID</label>
                <input type="text" name="appointmentId" class="form-control" required value="<c:out value='${billing.appointmentId}' />">
            </div>
            <div class="form-group">
                <label>Amount ($)</label>
                <input type="number" step="0.01" name="amount" class="form-control" required value="<c:out value='${billing.amount}' />">
            </div>
            <div class="form-group">
                <label>Payment Status</label>
                <select name="paymentStatus" class="form-control" required>
                    <option value="Unpaid" <c:if test="${billing.paymentStatus == 'Unpaid'}">selected</c:if>>Unpaid</option>
                    <option value="Paid" <c:if test="${billing.paymentStatus == 'Paid'}">selected</c:if>>Paid</option>
                </select>
            </div>
            <div class="form-group">
                <label>Bill Date</label>
                <input type="text" name="billDate" class="form-control" required value="<c:out value='${billing.billDate}' />">
            </div>
            <div class="form-group">
                <label>Payment Method</label>
                <select name="paymentMethod" class="form-control" required>
                    <option value="DirectPayment" <c:if test="${billing.paymentMethod == 'DirectPayment'}">selected</c:if>>Direct Payment</option>
                    <option value="InsurancePayment" <c:if test="${billing.paymentMethod == 'InsurancePayment'}">selected</c:if>>Insurance Payment</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 0.8rem;">Save Changes</button>
        </form>
        <div style="text-align: center; margin-top: 1rem; color: var(--text-muted); font-size: 0.8rem;">
            Developed by Member 5
        </div>
    </div>
</body>
</html>
