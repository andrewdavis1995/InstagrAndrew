/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrAndrew.models.User;
import uk.ac.dundee.computing.aec.instagrAndrew.models.UserDetails;
import uk.ac.dundee.computing.aec.instagrAndrew.models.Validation;

/**
 *
 * @author Andrew
 */
@WebServlet(name = "UpdateProfile", urlPatterns = {"/UpdateProfile"})
public class UpdateProfile extends HttpServlet {

    private Cluster cluster;
    
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    
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
        
        String action = request.getParameter("whatToDo");
        
        
        User us = new User();
        us.setCluster(cluster);
            
        if(action != null && !action.equals("")){
            String user = request.getParameter("username");
            UserDetails UD = us.getProfileInfo(user, true);
            request.setAttribute("UserDetails", UD);
            
        }else{
            
            String fn = request.getParameter("forename");
            String sn = request.getParameter("surname");
            String em = request.getParameter("email");
            String user = request.getParameter("username");
            String oldPass = request.getParameter("oldPassword");
            String pass = request.getParameter("password");
            String confPass = request.getParameter("confirmPassword");
            
            Validation val = us.checkDetails(fn, sn, em, null, pass, confPass, true);
            if(val.getValidity()){
                //check old password
                if (us.IsValidUser(user, oldPass)){
                    us.updateDetails(fn, sn, em, user, pass);
                    UserDetails UD = us.getProfileInfo(user, true);
                    request.setAttribute("UserDetails", UD);
                    val = new Validation("SUCCESS", true);
                }else{
                    val = new Validation("Old Password is incorrect", false);
                    UserDetails UD = us.getProfileInfo(user, true);
                    request.setAttribute("UserDetails", UD);
                }
                
            }else{
                UserDetails UD = us.getProfileInfo(user, true);
                request.setAttribute("UserDetails", UD);
            }
            
            request.setAttribute("Validation", val);
            
        }
        
        request.getRequestDispatcher("changeDetails.jsp").forward(request, response);  
        
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
        processRequest(request, response);
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
        processRequest(request, response);
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
