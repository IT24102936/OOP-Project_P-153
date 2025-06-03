package com.opp.project.servlets;

import com.opp.project.util.AdminFileUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UpdateAdminServlet")
public class EditAdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (id == null || id.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
            response.sendRedirect("Admin-management.jsp?errorMessage=All fields are required");
            return;
        }

        try {
            if (id.equals("1")) {
                response.sendRedirect("Admin-management.jsp?errorMessage=Admin with ID 1 cannot be edited");
                return;
            }

            // Check for duplicate username (excluding the current admin)
            for (String[] admin : AdminFileUtil.readAdmins()) {
                if (admin[2].equals(username) && !admin[0].equals(id)) {
                    response.sendRedirect("Admin-management.jsp?errorMessage=Username already exists");
                    return;
                }
            }

            AdminFileUtil.updateAdmin(id.trim(), name.trim(), username.trim(), email.trim(), password);
            response.sendRedirect("Admin-management.jsp?successMessage=Admin with ID " + id + " updated successfully");
        } catch (Exception e) {
            response.sendRedirect("Admin-management.jsp?errorMessage=Error updating admin: " + e.getMessage());
            e.printStackTrace();
        }
    }
}