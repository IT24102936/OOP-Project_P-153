<%@ page import="com.opp.project.util.AdminFileUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add New Admin Profile</title>
  <!-- Custom css -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin-managment.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>css/admin-navbar.css">
  <!-- Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <!-- Bootstrap Icons CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="Admin-navbar.jsp"%>
<main>
  <div class="container">
    <!-- Add New Admin Section -->
    <div class="admin-profile-card animate-card">
      <h2>Add New Admin</h2>
      <form class="admin-profile-form fcss" id="addAdminForm" action="AddAdminServlet" method="POST">
        <div class="form-group">
          <label for="newAdminName">Name</label>
          <div class="input-wrapper">
            <i class="fas fa-user"></i>
            <input type="text" id="newAdminName" name="newAdminName" placeholder="Enter admin name" required>
          </div>
        </div>
        <div class="form-group">
          <label for="newAdminUsername">Username</label>
          <div class="input-wrapper">
            <i class="fas fa-user"></i>
            <input type="text" id="newAdminUsername" name="newAdminUsername" placeholder="Enter username" required>
          </div>
        </div>
        <div class="form-group">
          <label for="newAdminPassword">Password</label>
          <div class="input-wrapper">
            <i class="fas fa-lock"></i>
            <input type="password" id="newAdminPassword" name="newAdminPassword" placeholder="Enter password" required>
          </div>
        </div>
        <div class="form-group">
          <label for="newAdminEmail">Email</label>
          <div class="input-wrapper">
            <i class="fas fa-envelope"></i>
            <input type="email" id="newAdminEmail" name="newAdminEmail" placeholder="Enter admin email" required>
          </div>
        </div>
        <button type="submit" class="update-profile-btn">Add Admin</button>
      </form>
    </div>

    <!-- Admin List Section -->
    <div class="admin-profile-card animate-card">
      <h2>Admin List</h2>
      <div class="search-container">
        <div class="search-bar">
          <i class="fas fa-search"></i>
          <input type="text" id="adminSearchInput" placeholder="Search admins...">
        </div>
      </div>
      <div class="table-container">
        <table>
          <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Username</th>
            <th>Email</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody id="adminList">
          <%
            java.util.List<String[]> admins = AdminFileUtil.readAdmins();
            for (int i = 0; i < admins.size(); i++) {
              String[] admin = admins.get(i);
          %>
          <tr data-admin-id="<%= admin[0] %>" class="admin-row" data-original-position="<%= i %>">
            <td><span class="view-mode"><%= admin[0] %></span><label>
              <input type="text" class="edit-mode form-control" value="<%= admin[0] %>" style="display:none;" readonly>
            </label></td>
            <td><span class="view-mode"><%= admin[1] %></span></td>
            <td><%= admin[2] %><input type="text" class="edit-mode form-control" value="<%= admin[2] %>" style="display:none;"></td>
            <td><span class="view-mode"><%= admin[3] %></span></td>
            <td class="actions">
              <button class="edit-btn" onclick="toggleEdit(this)">Edit</button>
              <button class="save-btn" style="display:none;" onclick="function saveAdmin(param) {
              
              }
              saveAdmin(this)">Save</button>
              <% if (admin[0].equals("1")) { %>
              <button class="delete-btn" disabled>Delete</button>
              <% } else { %>
              <button class="delete-btn" onclick="deleteAdmin('<%= admin[0] %>')">Delete</button>
              <% } %>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</main>

<footer>
  <div class="footer-content">
    <p>© 2025 Admin Panel. All rights reserved.</p>
    <p><a href="#">Privacy Policy</a> | <a href="#">Terms of Service</a> | <a href="#">Contact Us</a></p>
  </div>
</footer>

<div class="toast">
  <% if (request.getParameter("successMessage") != null) { %>
  <script>
    const toast = document.querySelector('.toast');
    toast.textContent = '<%= request.getParameter("successMessage") %>';
    toast.classList.add('show');
  </script>
  <% } else if (request.getParameter("errorMessage") != null) { %>
  <script>
    const toast = document.querySelector('.toast');
    toast.textContent = '<%= request.getParameter("errorMessage") %>';
    toast.classList.add('show', 'error');
  </script>
  <% } %>
</div>

<script src="js/admin.js"></script>
<script>
  function logout() {
    if (confirm('Are you sure you want to logout?')) {
      alert('Logout functionality to be implemented.');
    }
  }

  const hamburger = document.querySelector('.hamburger');
  const navUl = document.querySelector('nav ul');

  hamburger.addEventListener('click', () => {
    navUl.classList.toggle('active');
  });

  function deleteAdmin(id) {
    if (confirm('Are you sure you want to delete this admin?')) {
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'DeleteAdminServlet';
      form.style.display = 'none';

      const idInput = document.createElement('input');
      idInput.type = 'hidden';
      idInput.name = 'id';
      idInput.value = id;
      form.appendChild(idInput);

      document.body.appendChild(form);
      form.submit();
    }
  }

  // Add close button to toast
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

      // Auto-hide after 3 seconds if shown
      setTimeout(() => {
        if (toast.classList.contains('show')) {
          toast.classList.remove('show');
        }
      }, 3000);
    }

    // Search functionality
    const searchInput = document.getElementById('adminSearchInput');
    const tableRows = document.querySelectorAll('#adminList tr');

    searchInput.addEventListener('input', function() {
      const searchTerm = this.value.toLowerCase().trim();
      tableRows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchTerm) ? '' : 'none';
      });
    });

    // Edit and Save functionality
    let editedRow = null;
    let originalIndex = null;

    function toggleEdit(button) {
      const row = button.closest('tr');
      const tbody = document.getElementById('adminList');
      const editModeElements = row.querySelectorAll('.edit-mode');
      const viewModeElements = row.querySelectorAll('.view-mode');
      const editBtn = row.querySelector('.edit-btn');
      const saveBtn = row.querySelector('.save-btn');
      const deleteBtn = row.querySelector('.delete-btn');

      if (editBtn.textContent === 'Edit') {
        if (editedRow) {
          cancelEdit(editedRow);
        }

        // Store the original index
        originalIndex = parseInt(row.getAttribute('data-original-position'));
        editedRow = row;

        // Move row to the top
        tbody.insertBefore(row, tbody.firstChild);
        row.classList.add('editing');

        // Switch to edit mode
        editModeElements.forEach(input => input.style.display = 'inline-block');
        viewModeElements.forEach(span => span.style.display = 'none');
        editBtn.textContent = 'Cancel';
        editBtn.classList.add('cancel-btn');
        editBtn.classList.remove('edit-btn');
        saveBtn.style.display = 'inline-block';
        deleteBtn.style.display = 'none';
      } else {
        cancelEdit(row);
      }
    }

    function cancelEdit(row) {
      const tbody = document.getElementById('adminList');
      const rows = Array.from(tbody.children);
      const editModeElements = row.querySelectorAll('.edit-mode');
      const viewModeElements = row.querySelectorAll('.view-mode');
      const editBtn = row.querySelector('.cancel-btn');
      const saveBtn = row.querySelector('.save-btn');
      const deleteBtn = row.querySelector('.delete-btn');

      // Exit edit mode
      editModeElements.forEach(input => input.style.display = 'none');
      viewModeElements.forEach(span => span.style.display = 'inline-block');
      row.classList.remove('editing');
      editBtn.textContent = 'Edit';
      editBtn.classList.add('edit-btn');
      editBtn.classList.remove('cancel-btn');
      saveBtn.style.display = 'none';
      deleteBtn.style.display = 'inline-block';

      // Restore original position
      const sortedRows = rows.sort((a, b) => parseInt(a.getAttribute('data-original-position')) - parseInt(b.getAttribute('data-original-position')));
      tbody.innerHTML = '';
      sortedRows.forEach(r => tbody.appendChild(r));

      editedRow = null;
      originalIndex = null;
    }

    function saveAdmin(button) {
      const row = button.closest('tr');
      const adminId = row.getAttribute('data-admin-id');
      const newValues = [];
      row.querySelectorAll('.edit-mode:not([readonly])').forEach(input => newValues.push(input.value));

      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'EditAdminServlet';
      form.style.display = 'none';

      const adminIdInput = document.createElement('input');
      adminIdInput.type = 'hidden';
      adminIdInput.name = 'adminId';
      adminIdInput.value = adminId;
      form.appendChild(adminIdInput);

      newValues.forEach((value, index) => {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'field' + index;
        input.value = value;
        form.appendChild(input);
      });

      document.body.appendChild(form);
      cancelEdit(row);
      form.submit();
    }
  });
</script>
</body>
</html>