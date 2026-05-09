<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Doctor - Healthcare System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-v3.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="glass-container glass-form-container">
        <div class="header">
            <h1>Register Doctor</h1>
            <a href="${pageContext.request.contextPath}/doctor/list" class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Back to Directory</a>
        </div>

        <form action="${pageContext.request.contextPath}/doctor/insert" method="post">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" required placeholder="Jane Smith">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required placeholder="dr.jane@example.com">
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" class="form-control" required placeholder="+1 234 567 8900">
            </div>

            <div class="form-group">
                <label for="specialization">Specialization</label>
                <input type="text" id="specialization" name="specialization" class="form-control" required placeholder="e.g. Cardiology">
            </div>

            <div class="form-group">
                <label for="doctorType">Doctor Type</label>
                <select id="doctorType" name="doctorType" class="form-control" required>
                    <option value="General">General Physician</option>
                    <option value="Specialist">Specialist</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 0.8rem;">Register Doctor</button>
        </form>
        <div style="text-align: center; margin-top: 1rem; color: var(--text-muted); font-size: 0.8rem;">
            Developed by Member 2
        </div>
    </div>
</body>
</html>

<!-- UI alignment adjustment 791 -->

<!-- UI alignment adjustment 609 -->

<!-- UI alignment adjustment 441 -->
