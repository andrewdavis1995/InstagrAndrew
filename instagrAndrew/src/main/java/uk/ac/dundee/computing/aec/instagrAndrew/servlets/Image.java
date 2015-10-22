package uk.ac.dundee.computing.aec.instagrAndrew.servlets;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import javax.imageio.ImageIO;
import java.io.File;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import java.awt.image.BufferedImage;
import java.awt.Color;
import java.util.ArrayList;
import java.util.UUID;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrAndrew.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrAndrew.models.PicModel;
import uk.ac.dundee.computing.aec.instagrAndrew.models.User;
import uk.ac.dundee.computing.aec.instagrAndrew.models.UserDetails;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic;

/**
 * Servlet implementation class Image
 */
@WebServlet(urlPatterns = {
    "/Image",
    "/Image/*",
    "/Thumb/*",
    "/Images",
    "/Images/*"
})
@MultipartConfig

public class Image extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Cluster cluster;
    private HashMap CommandsMap = new HashMap();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Image() {
        super();
        
        // TODO Auto-generated constructor stub
        CommandsMap.put("Image", 1);
        CommandsMap.put("Images", 2);
        CommandsMap.put("Thumb", 3);

    }

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String args[] = Convertors.SplitRequestPath(request);
        
        int command;
        try {
            command = (Integer) CommandsMap.get(args[1]);
        } catch (Exception et) {
            error("Bad Operator", response);
            return;
        }
        switch (command) {
            case 1:
                DisplayImage(Convertors.DISPLAY_PROCESSED,args[2], response);
                break;
            case 2:
                DisplayImageList(args[2], request, response);
                break;
            case 3:
                DisplayImage(Convertors.DISPLAY_THUMB,args[2],  response);
                break;
            default:
                error("Bad Operator", response);
        }
    }

    private void DisplayImageList(String user, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(user);
        RequestDispatcher rd = request.getRequestDispatcher("/UsersPics.jsp");
        UUID profilePic = tm.getProfilePic(user);
        request.setAttribute("ProfilePic", profilePic);
        request.setAttribute("Pics", lsPics);
        User usr = new User();
        usr.setCluster(cluster);
        UserDetails deets = usr.getProfileInfo(user, false);
        //get email, first name and surname - function in the User file
        request.setAttribute("EmailAddress", deets.getEmail());
        request.setAttribute("Full_Name", deets.getName());
        rd.forward(request, response);
    }
    
    
    private void DisplayImage(int type,String Image, HttpServletResponse response) throws ServletException, IOException {
        
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
  
        
        Pic p = tm.getPic(type,java.util.UUID.fromString(Image));
        
        OutputStream out = response.getOutputStream();

        response.setContentType(p.getType());
        response.setContentLength(p.getLength());
        //out.write(Image);
        InputStream is = new ByteArrayInputStream(p.getBytes());
        BufferedInputStream input = new BufferedInputStream(is);
        byte[] buffer = new byte[8192];
        for (int length = 0; (length = input.read(buffer)) > 0;) {
            out.write(buffer, 0, length);
        }
        out.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        System.out.println("MADE IT TO DOPOST");
        
        for (Part part : request.getParts()) {
            
            String type = part.getContentType();
            if(type != null){
                
                String filename = part.getSubmittedFileName();

                String thing = request.getParameter("profilePic");
                System.out.println("PROFILE PIC is: " + thing);
                
                boolean profpic;
                profpic = thing != null;
                         
                InputStream is = request.getPart(part.getName()).getInputStream();
                int i = is.available();
                HttpSession session=request.getSession();
                LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
                String username="majed";

                if (lg != null && lg.getlogedin()){
                    username=lg.getUsername();
                }
                if (i > 0) {
                    byte[] b = new byte[i + 1];
                    is.read(b);

                    PicModel tm = new PicModel();
                    tm.setCluster(cluster);
                    
                    String hashtag = null;
                    String tint;
                    String grey;
                    String contrast;
                    
                    if(!profpic){

                        tint = (String)request.getParameter("Filter");
                        tm.setTint(tint);

                        grey = (String)request.getParameter("Greyscale");
                        tm.setGrey(grey);

                        //String vig = (String)request.getParameter("Vignette");
                        //tm.setVignette(vig);

                        contrast = (String)request.getParameter("Contrast");
                        tm.setContrast(contrast);
                        

                        String h1 = (String)request.getParameter("hiddenHT1");
                        String h2 = (String)request.getParameter("hiddenHT2");
                        String h3 = (String)request.getParameter("hiddenHT3");

                        if (!"".equals(h1)){
                            hashtag = h1;
                        }
                        if (!"".equals(h2)){
                            hashtag += "," + h2;

                        }
                        if (!"".equals(h3)){
                            if(hashtag == null){
                                hashtag = h3;
                            }else{
                                hashtag += "," + h3;
                            }
                        }

                    }
                    else{
                
                        tm.setContrast("3");
                        tm.setGrey("No");
                        tm.setTint("None");
                    }
                    
                    
                    tm.insertPic(b, type, filename, username, hashtag, profpic);

                    
                    is.close();
                }
                
                if(profpic){
                    response.sendRedirect("/InstagrAndrew/profile/" + username);
                }else{
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response);
                }
                
                break;
            }
        }

    }

    
    private void error(String mess, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = null;
        out = new PrintWriter(response.getOutputStream());
        out.println("<h1>You have a an error in your input</h1>");
        out.println("<h2>" + mess + "</h2>");
        out.close();
        return;
    }
}
