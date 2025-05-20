package com.opp.project.servlets;

import com.opp.project.util.FileUtil;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login ID and password from the form
        String loginId = request.getParameter("loginId");
        String password = request.getParameter("password");

        // First, check if the credentials match an admin
        boolean isAdmin = validateAdminCredentials(loginId, password);

        if (isAdmin) {
            // If admin login is successful, store admin identifier and username
            HttpSession session = request.getSession();
            String adminUsername = getAdminUsernameFromLoginId(loginId); // Retrieve the actual username
            session.setAttribute("userIdentifier", loginId);
            session.setAttribute("username", adminUsername); // Store the actual username
            session.setAttribute("isAdmin", true); // Mark as admin
            // Redirect to Admin Dashboard
            response.sendRedirect("/Admin-dashboard.jsp");
        } else {
            // If not an admin, validate student credentials
            boolean isValidStudent = validateCredentials(loginId, password);

            if (isValidStudent) {
                // If student login is successful, store the login ID and retrieve username
                HttpSession session = request.getSession();
                String username = getUsernameFromLoginId(loginId); // Retrieve the actual username
                String studentId = getStudetId(loginId);
                session.setAttribute("userIdentifier", loginId);  // Store the login ID (email or username)
                session.setAttribute("username", username);       // Store the actual username
                session.setAttribute("studentId", studentId);
                session.setAttribute("isAdmin", false);          // Mark as non-admin

                // Redirect to the student dashboard
                response.sendRedirect("/Dashboard.jsp");
            } else {
                // If login fails, send back to login page with an error message
                request.setAttribute("errorMessage", "Incorrect Username/Email or Password.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        }
    }

    // Method to validate admin username or email and password
    private boolean validateAdminCredentials(String loginId, String password) {
        try (BufferedReader br = new BufferedReader(new FileReader(FileUtil.ADMIN_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 5) { // Expecting id,name,username,email,password
                    String storedUsername = parts[2];  // Username is the third field
                    String storedEmail = parts[3];     // Email is the fourth field
                    String storedPassword = parts[4];  // Password is the fifth field
                    // Check if loginId matches username or email
                    if (storedUsername.equals(loginId) || storedEmail.equals(loginId)) {
                        // Compare the entered password with the stored hashed password
                        if (BCrypt.checkpw(password, storedPassword)) {
                            return true; // Password matches
                        }
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading admin.txt: " + e.getMessage());
        }
        return false; // Credentials don't match
    }

    // Method to retrieve the admin username based on loginId (email or username)
    private String getAdminUsernameFromLoginId(String loginId) {
        try (BufferedReader br = new BufferedReader(new FileReader(FileUtil.ADMIN_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 5) {
                    String storedUsername = parts[2];  // Username is the third field
                    String storedEmail = parts[3];     // Email is the fourth field
                    if (storedUsername.equals(loginId) || storedEmail.equals(loginId)) {
                        return storedUsername; // Return the actual username
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading admin.txt: " + e.getMessage());
        }
        return loginId; // Fallback to loginId if username not found
    }

    // Method to validate student username or email and password
    private boolean validateCredentials(String loginId, String password) {
        try (BufferedReader br = new BufferedReader(new FileReader(FileUtil.DATA_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 9) { // Ensure the line has enough fields (studentId added)
                    String storedUsername = parts[2];  // Username is the third field
                    String storedEmail = parts[4];     // Email is the fifth field
                    String storedPassword = parts[7];  // Password is the eighth field
                    // Check if loginId matches username or email
                    if (storedUsername.equals(loginId) || storedEmail.equals(loginId)) {
                        // Compare the entered password with the stored hashed password
                        if (BCrypt.checkpw(password, storedPassword)) {
                            return true; // Password matches
                        }
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students.txt: " + e.getMessage());
        }
        return false; // Credentials don't match
    }

    // Method to retrieve the student username based on loginId (email or username)
    private String getUsernameFromLoginId(String loginId) {
        try (BufferedReader br = new BufferedReader(new FileReader(FileUtil.DATA_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 9) {
                    String storedUsername = parts[2];  // Username is the third field
                    String storedEmail = parts[4];     // Email is the fifth field
                    if (storedUsername.equals(loginId) || storedEmail.equals(loginId)) {
                        return storedUsername; // Return the actual username
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students.txt: " + e.getMessage());
        }
        return loginId; // Fallback to loginId if username not found (should not happen after validation)
    }
    private String getStudetId(String loginId) {
        try (BufferedReader br = new BufferedReader(new FileReader(FileUtil.DATA_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 9) {
                    String storedUsername = parts[2];  // Username is the third field
                    String storedEmail = parts[4];     // Email is the fifth field
                    String studentID = parts[0];
                    if (storedUsername.equals(loginId) || storedEmail.equals(loginId)) {
                        return studentID; // Return the actual username
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading students.txt: " + e.getMessage());
        }
        return loginId; // Fallback to loginId if username not found (should not happen after validation)
    }
}