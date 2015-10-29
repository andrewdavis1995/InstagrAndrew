
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrAndrew.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.HttpURLConnection;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.CassandraHosts;
import javax.servlet.ServletConfig;
import com.datastax.driver.core.Cluster;
import uk.ac.dundee.computing.aec.instagrAndrew.models.PicModel;
import uk.ac.dundee.computing.aec.instagrAndrew.models.User;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic;

/**
 *
 * @author Andrew
 */
@WebServlet(name = "SearchHashtag", urlPatterns = {"/SearchHashtag"})
public class SearchHashtag extends HttpServlet {

    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        
            String name = request.getParameter("searchText");
            
            if(name != null){
                PicModel pm=new PicModel();
                pm.setCluster(cluster);

                java.util.LinkedList<Pic> matches = pm.getMatchingPics(name);
                
                request.setAttribute("matches", matches);
                request.setAttribute("searchedText", name);

                request.getRequestDispatcher("hashtagSearch.jsp").forward(request, response);            
            }else{
                String hashtag = request.getParameter("Hashtag");
                
                //search for images with matching hashtag
                System.out.println("Cannot perform Search");
                request.getRequestDispatcher("index.jsp");
                
            }
    }
              
              

    public static int getResponseCode(String urlString) throws MalformedURLException, IOException {
        URL u = new URL(urlString); 
        HttpURLConnection huc =  (HttpURLConnection)  u.openConnection(); 
        huc.setRequestMethod("GET"); 
        huc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 (.NET CLR 3.5.30729)");
        huc.connect(); 
        return huc.getResponseCode();
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