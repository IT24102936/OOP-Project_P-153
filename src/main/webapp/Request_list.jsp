<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Web - My Requests</title>
    <link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/img/logo.ico">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/navbarandfooter.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/requesttable.css">
</head>
<body>
<main>
    <%@ include file="navbar.jsp" %>

    <%
        // Check if the user is logged in
        String loginId = (String) session.getAttribute("username");
        if (loginId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
    %>
    <div class="card custom-card">
        <div class="card-body">
            <table class="custom-table">
                <thead>
                <tr>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Instructor Name</th>
                    <th>Requested Date</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>SE1120</td>
                    <td>Web Development</td>
                    <td>Prof.Namal</td>
                    <td>2025/05/10</td>
                    <td><span class="badge bg-success-subtle text-success">Active</span></td>
                </tr>
                <tr>
                    <td>SE1120</td>
                    <td>Web Development</td>
                    <td>Prof.Namal</td>
                    <td>2025/05/10</td>
                    <td><span class="badge bg-warning-subtle text-warning">Pending</span></td>
                </tr>
                <tr>
                    <td>SE1120</td>
                    <td>Web Development</td>
                    <td>Prof.Namal</td>
                    <td>2025/05/10</td>
                    <td><span class="badge bg-danger-subtle text-danger">Cancel</span></td>
                </tr>
                <tr>
                    <td>SE1120</td>
                    <td>Web Development</td>
                    <td>Prof.Namal</td>
                    <td>2025/05/10</td>
                    <td><span class="badge bg-success-subtle text-success">Active</span></td>
                </tr>
                <tr>
                    <td>SE1120</td>
                    <td>Web Development</td>
                    <td>Prof.Namal</td>
                    <td>2025/05/10</td>
                    <td><span class="badge bg-success-subtle text-success">Active</span></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</main>
<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/dropdown-position.js"></script>
</body>
</html>