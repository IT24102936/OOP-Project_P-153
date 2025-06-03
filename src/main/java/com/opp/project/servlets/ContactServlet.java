package com.opp.project.servlets;

import com.opp.project.util.ContactFileUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userIdentifier = (String) session.getAttribute("userIdentifier");

        // Check if the user is logged in
        if (userIdentifier == null) {
            request.setAttribute("errorMessage", "Please log in to submit a contact form.");
            response.sendRedirect("Login.jsp");
            return;
        }

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate inputs
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("contactform.jsp").forward(request, response);
            return;
        }

        // Format the current date (without time)
        LocalDateTime now = LocalDateTime.now();
        String date = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        // Prepare the contact data
        String[] contactData = new String[]{name, email, subject, message, date};

        // Save to contacts.txt using ContactFileUtil
        try {
            List<String[]> contacts = ContactFileUtil.readContacts();
            contacts.add(contactData);
            ContactFileUtil.writeContacts(contacts);
        } catch (Exception e) {
            System.err.println("Error saving to contacts.txt: " + e.getMessage());
            request.setAttribute("errorMessage", "Error saving your message. Please try again.");
            request.getRequestDispatcher("contactform.jsp").forward(request, response);
            return;
        }

        // Redirect with success message
        request.setAttribute("successMessage", "Your message has been sent successfully!");
        request.getRequestDispatcher("contactform.jsp").forward(request, response);
    }
}