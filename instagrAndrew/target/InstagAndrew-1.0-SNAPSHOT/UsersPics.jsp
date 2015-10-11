<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstagrAndrew</title>
        <link rel="stylesheet" type="text/css" href="/InstagrAndrew/myStyles.css" />
        
        <script>
            function setImageCount(name, count){
              document.getElementById('profileName').innerHTML = name + " (Total Images: " + count + ")";   
            }
        </script>
        
    </head>
        
    <body background="../developmentImages/cork.jpg" style="margin-top: 90px;">
        
        <nav style="top: 0">
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="/InstagrAndrew/upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <nav style="background-color: #3D3B46; top: 65px; height: 25px; color: white;">
            <ul>
                
        
        <%
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");

            String search = request.getParameter("search");
            String type = request.getParameter("type");
            
            if (lg != null) {
                
                if(type != "" && search != ""){
                
                    if(type.equals("other") && !search.equals(lg.getUsername())){

                    %> 
                        <h4 id="profileName" style="position: absolute; top: 0px; margin-top: 0px"> <%= search %>'s Profile </h4>
                    <%
                    }else{
                        %>
                        <h4 id="profileName" style="position: absolute; top: 0px; margin-top: 0px"> Your Profile </h4>
                        <%
                    }
                }
            }
        %>
            </ul>
        </nav>
        
            
            
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
                int count = 0;
            if (lsPics == null) {
        %>
                <p>No Pictures found</p>
        <%
            } else {
                Iterator<Pic> iterator;
                iterator = lsPics.iterator();
                while (iterator.hasNext()) {
                    count++;
                    Pic p = (Pic) iterator.next();
        %>
                    <div  position="relative" style = "background-image: url('../developmentImages/pinBG.png'); display: inline-block; width: 350px; height: 400px; margin-bottom: 50px; margin-left: 20px"> 
                        <% 
                        String hts = p.getHashtag();
                        if(hts != null){
                            String[] splitHT = hts.split(",");
                            for (int i = 0; i < splitHT.length; i++){
                            %>
                                <li><a style="margin-top: 10px; color: #39335B; float: left; margin-left: 48px; width: 100%" href="#">#<%= splitHT[i] %> </a></li> 
                            <% 
                            } 
                        }else{
                            %>
                                <li><a style="margin-top: 10px; color: crimson; float: left; margin-left: 48px; width: 100%">No Hashtags</a></li> 
                            <%
                        }
                        %>
                        <a style ="display: block; margin-left: 48px; margin-top: 15px; float: left" href="/InstagrAndrew/Image/<%= p.getSUUID()%>" ><img src="/InstagrAndrew/Thumb/<%=p.getSUUID()%>"></a>  
                    </div>
        
                    <%            
                    }
                }
            
        %>
        
        <script>
            if(<%= search %> !== null){
                setImageCount(<%= search %> + "'s Profile", <%= count %>);
            }else{
                setImageCount("Your Profile", <%= count %>);
            }
        </script>
        
    </body>
</html>
