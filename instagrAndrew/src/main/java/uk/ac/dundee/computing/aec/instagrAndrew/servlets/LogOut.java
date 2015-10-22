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
import uk.ac.dundee.computing.aec.instagrAndrew.stores.LoggedIn;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "LogOut", urlPatterns = {"/LogOut"})
public class LogOut extends HttpServlet {

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
                
        User us=new User();
        us.setCluster(cluster);
        HttpSession session=request.getSession();
      
        session.setAttribute("LoggedIn", null);
        RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
        rd.forward(request,response);
        
        //"SEE WHAT DEVELOPS"
        
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
//2.7 (PYTHON)