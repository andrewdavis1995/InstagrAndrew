/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrAndrew.models.CommentModel;
import uk.ac.dundee.computing.aec.instagrAndrew.models.User;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.LoggedIn;

/**
 *
 * @author Andrew
 */
@WebServlet(name = "Comments", urlPatterns = {"/Comments"})
public class Comments extends HttpServlet {

    private Cluster cluster;
    
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
        Boolean reload = false;
        try{
            reload = (Boolean)request.getAttribute("reload");
        }catch(Exception e){}
        
        System.out.println("ACTION: " + action);
        System.out.println("RELOAD: " + reload);
        
        if(action.equals("post") && reload == null){
            postComment(request, response);
        }else{
            getComments(request, response);
        }
    }
    
    public void postComment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        
        Enumeration<String> e = request.getParameterNames();
        
        while (e.hasMoreElements()){
            System.out.println(e.nextElement());
        }
        
        
        CommentModel cm = new CommentModel();
        cm.setCluster(cluster);
        
        
        HttpSession session=request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");

        String username = "";
        
        if (lg != null) {
            
            String imageID = request.getParameter("imageSrc");
            System.out.println("IMAGE ID: " + imageID);
            username = lg.getUsername();   
        
            UUID id = UUID.fromString(imageID);
            String content = request.getParameter("comment");
        
            cm.insertComment(id, username, content);
            
           
            String hashtag = request.getParameter("hashtags");
            request.setAttribute("hashtags", hashtag);

            String PP = request.getParameter("profPic");
            if(PP!= null){
                UUID profpic = UUID.fromString(PP);
                request.setAttribute("ProfPic", profpic);
            }
            String path = request.getParameter("imageSrc");
            request.setAttribute("imageSource", path);

            String user = request.getParameter("username");
            request.setAttribute("username", user);

            cm.setCluster(cluster);
            UUID image;
            image = UUID.fromString(path);
            ArrayList<CommentModel> comments = cm.getComments(image);
            request.setAttribute("comments", comments);

            
            
            Enumeration<String> things = request.getAttributeNames();
            System.out.println("SECOND RUN");
            
            while(things.hasMoreElements()){
                System.out.println(things.nextElement());
            }
            
            request.setAttribute("reload", true);
            RequestDispatcher rd=request.getRequestDispatcher("displayImage.jsp");
            rd.forward(request,response);
            //response.sendRedirect("displayImage.jsp");
        }
        
       
    }
    

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
        
    protected void getComments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        Enumeration<String> e = request.getParameterNames();
        
        while(e.hasMoreElements()){
            System.out.println(e.nextElement());
        }
        
        String user = request.getParameter("username");
        request.setAttribute("username", user);
        
        String hashtag = request.getParameter("hashtags");
        request.setAttribute("hashtags", hashtag);

        String PP = request.getParameter("profPic");
        try{
            UUID profpic = UUID.fromString(PP);
            request.setAttribute("ProfPic", profpic);
        }catch(Exception ex){
            //call method to find profilePic
            User us = new User();
            us.setCluster(cluster);
            UUID profpic = us.getProfilePicture(user);
            request.setAttribute("ProfPic", profpic);            
        }
        
        String path = request.getParameter("imageSrc");
        request.setAttribute("imageSource", path);
        
        
        CommentModel cm = new CommentModel();
        cm.setCluster(cluster);
        UUID image;
        image = UUID.fromString(path);
        ArrayList<CommentModel> comments = cm.getComments(image);
        request.setAttribute("comments", comments);
        
        RequestDispatcher rd=request.getRequestDispatcher("displayImage.jsp");
        rd.forward(request,response);
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
        String path = request.getParameter("imageSrc");
        System.out.println(path);
        System.out.println("THIS IS RUNNING!");
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
