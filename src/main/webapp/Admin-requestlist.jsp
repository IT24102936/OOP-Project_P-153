<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Request List</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-requestlist.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>css/admin-navbar.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .toast {
      position: fixed;
      bottom: 20px;
      right: 20px;
      min-width: 250px;
      background-color: #333;
      color: white;
      padding: 16px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
      opacity: 0;
      transition: opacity 0.3s ease-in-out;
      z-index: 1000;
    }

    .toast.show {
      opacity: 1;
    }

    .toast.success {
      background-color: #28a745;
    }

    .toast.error {
      background-color: #dc3545;
    }

    .toast .close-btn {
      position: absolute;
      top: 8px;
      right: 8px;
      background: none;
      border: none;
      color: white;
      font-size: 16px;
      cursor: pointer;
    }
  </style>
</head>
<body>
<%@ include file="Admin-navbar.jsp"%>
<main>
  <div class="container">
    <h2>Request List</h2>
    <div class="search-container">
      <div class="search-bar">
        <i class="fas fa-search"></i>
        <input type="text" id="searchInput" placeholder="Search requests...">
        <i class="bi bi-search"></i>
      </div>
    </div>
    <div class="table-container">
      <table>
        <thead>
        <tr>
          <th>Request ID</th>
          <th>Student ID</th>
          <th>Course ID</th>
          <th>Date</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
        </thead>
        <tbody id="requestTableBody">
        <%@ page import="com.opp.project.service.QueueManager" %>
        <%
          java.util.List<String[]> requests = QueueManager.getQueueState();
          for (String[] requestData : requests) {
            String requestId = requestData[0];
            String studentId = requestData[1];
            String courseId = requestData[2];
            String timestamp = requestData[3];
            String status = requestData[4];
        %>
        <tr>
          <td><%= requestId %></td>
          <td><%= studentId %></td>
          <td><%= courseId %></td>
          <td><%= timestamp %></td>
          <td><%= status %></td>
          <td class="actions">
            <form action="ProcessRequestServlet" method="POST" style="display:inline;">
              <input type="hidden" name="requestId" value="<%= requestId %>">
              <input type="hidden" name="action" value="approve">
              <button type="submit" class="edit-btn">Approve</button>
            </form>
            <form action="ProcessRequestServlet" method="POST" style="display:inline;">
              <input type="hidden" name="requestId" value="<%= requestId %>">
              <input type="hidden" name="action" value="reject">
              <button type="submit" class="delete-btn">Reject</button>
            </form>
            <form action="ProcessRequestServlet" method="POST" style="display:inline;">
              <input type="hidden" name="requestId" value="<%= requestId %>">
              <input type="hidden" name="action" value="delete">
              <button type="submit" class="delete-btn">Delete</button>
            </form>
          </td>
        </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>
  </div>
</main>

<footer>
  <div class="footer-content">
    <p>© 2025 Admin Panel. All rights reserved.</p>
    <div class="footer-section">
      <a href="#">Privacy Policy</a>
      <a href="#">Terms of Service</a>
      <a href="#">Contact Us</a>
    </div>
  </div>
</footer>

<div class="toast">
  <% if (request.getParameter("successMessage") != null) { %>
  <script>
    const toast = document.querySelector('.toast');
    toast.textContent = '<%= request.getParameter("successMessage") %>';
    toast.classList.add('show', 'success');
  </script>
  <% } else if (request.getParameter("errorMessage") != null) { %>
  <script>
    const toast = document.querySelector('.toast');
    toast.textContent = '<%= request.getParameter("errorMessage") %>';
    toast.classList.add('show', 'error');
  </script>
  <% } %>
</div>

<script>
  function logout() {
    alert('Logout functionality to be implemented.');
  }

  const hamburger = document.querySelector('.hamburger');
  const navUl = document.querySelector('nav ul');

  if (hamburger && navUl) {
    hamburger.addEventListener('click', () => {
      navUl.classList.toggle('active');
    });
  }

  document.getElementById('searchInput').addEventListener('keyup', function(e) {
    const searchTerm = e.target.value.trim().toLowerCase();
    const tableBody = document.getElementById('requestTableBody');
    const rows = tableBody.getElementsByTagName('tr');

    Array.from(rows).forEach(row => {
      const requestId = row.cells[0].textContent.toLowerCase();
      const studentId = row.cells[1].textContent.toLowerCase();
      const courseId = row.cells[2].textContent.toLowerCase();
      const timestamp = row.cells[3].textContent.toLowerCase();
      const status = row.cells[4].textContent.toLowerCase();

      const isMatch = requestId.includes(searchTerm) ||
              studentId.includes(searchTerm) ||
              courseId.includes(searchTerm) ||
              timestamp.includes(searchTerm) ||
              status.includes(searchTerm);

      row.style.display = isMatch || searchTerm === '' ? '' : 'none';
    });
  });

  document.addEventListener('DOMContentLoaded', () => {
    const toast = document.querySelector('.toast');
    if (toast) {
      const closeBtn = document.createElement('button');
      closeBtn.className = 'close-btn';
      closeBtn.innerHTML = '×';
      closeBtn.addEventListener('click', () => {
        toast.classList.remove('show');
      });
      toast.appendChild(closeBtn);

      setTimeout(() => {
        if (toast.classList.contains('show')) {
          toast.classList.remove('show');
        }
      }, 3000);
    }
  });
</script>
</body>
</html>