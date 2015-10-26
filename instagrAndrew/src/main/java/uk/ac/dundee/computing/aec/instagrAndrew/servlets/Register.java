/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrAndrew.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrAndrew.models.User;
import uk.ac.dundee.computing.aec.instagrAndrew.models.Validation;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
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
        
        String fName=request.getParameter("forename");
        String surname=request.getParameter("surname");
        String email=request.getParameter("email");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String confPass=request.getParameter("confirmPassword");
        
        if(username != null){
            User us=new User();
            us.setCluster(cluster);
            Validation isValid = us.checkDetails(fName, surname, email, username, password, confPass, false);

            if(isValid.getValidity()){
                us.RegisterUser(fName, surname, email, username, password);
                response.sendRedirect("/InstagrAndrew");
            }else{
                response.sendRedirect("/InstagrAndrew/register.jsp");
            }
        }else{
            HttpSession session=request.getSession();
            session.setAttribute("LoggedIn", null);
            RequestDispatcher rd=request.getRequestDispatcher("register.jsp");
            rd.forward(request,response);
        }
        
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
