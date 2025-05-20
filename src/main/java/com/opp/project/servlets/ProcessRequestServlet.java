package com.opp.project.servlets;

import com.opp.project.service.QueueManager;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ProcessRequestServlet")
public class ProcessRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestIdStr = request.getParameter("requestId");
        String action = request.getParameter("action");

        if (requestIdStr == null || action == null) {
            response.sendRedirect("Admin-requestlist.jsp?errorMessage=Invalid request data");
            return;
        }

        try {
            int requestId = Integer.parseInt(requestIdStr);
            switch (action) {
                case "approve":
                    QueueManager.approveRequest(requestId);
                    response.sendRedirect("Admin-requestlist.jsp?successMessage=Request " + requestId + " approved successfully");
                    break;
                case "reject":
                    QueueManager.updateRequestStatus(requestId, "rejected");
                    QueueManager.removeRequest(requestId);
                    response.sendRedirect("Admin-requestlist.jsp?successMessage=Request " + requestId + " rejected successfully");
                    break;
                case "delete":
                    QueueManager.removeRequest(requestId);
                    response.sendRedirect("Admin-requestlist.jsp?successMessage=Request " + requestId + " deleted successfully");
                    break;
                default:
                    response.sendRedirect("Admin-requestlist.jsp?errorMessage=Invalid action");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("Admin-requestlist.jsp?errorMessage=Invalid request ID");
        } catch (Exception e) {
            response.sendRedirect("Admin-requestlist.jsp?errorMessage=Error processing request: " + e.getMessage());
        }
    }
}