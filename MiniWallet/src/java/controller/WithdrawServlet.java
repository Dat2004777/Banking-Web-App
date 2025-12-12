/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.TransactionDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import utils.Validate;

/**
 * withdraw servlet
 *
 * @author dat20
 */
public class WithdrawServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet WithdrawServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WithdrawServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        UserDAO userDAO = new UserDAO();
        
        User user = (User) session.getAttribute("user");
        User freshUser = userDAO.getUserByID(user.getId());
        session.setAttribute("user", freshUser);
        
        request.getRequestDispatcher("withdraw.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        Validate validate = new Validate();
        TransactionDAO transactionDAO = new TransactionDAO();
        
        User user = (User) session.getAttribute("user");
        String withDrawAmountStr = request.getParameter("withdrawAmount");

        try {
            double withDrawAmount = Double.parseDouble(withDrawAmountStr);

            if (validate.checkValidInputAmount(withDrawAmount) && validate.checkValidUserBalance(withDrawAmount, user)) {
                boolean isSuccess = transactionDAO.withdraw(user.getId(), withDrawAmount);

                if (isSuccess) {
                    double newBalance = user.getBalance() - withDrawAmount;
                    user.setBalance(newBalance);
                    session.setAttribute("user", user);

                    request.setAttribute("successMessage", "Rút tiền thành công");
                } else {
                    request.setAttribute("errorMessage", "Giao dịch thất bại, lỗi hệ thống");
                }
            } else {
                request.setAttribute("errorMessage", "Số tiền không hợp lệ hoặc số dư không đủ");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Vui lòng nhập số tiền hợp lệ");
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi");
        }

        request.getRequestDispatcher("withdraw.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
