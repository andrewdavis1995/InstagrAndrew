<%-- 
    Document   : SearchResults
    Created on : 03-Oct-2015, 11:48:20
    Author     : Andrew
--%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.UserDetails"%>
<%@page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="searchResults.css" />
        <title>JSP Page</title>
    </head>
    
    
    <body>
              
        <nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li style="margin-left: 20px" class="nav"><a href="/InstagrAndrew/upload.jsp">Upload</a></li>
                <li style="margin-left: 20px" class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
        
        <% 
            String searchedFor = (String)request.getAttribute("searchedText");
            ArrayList<UserDetails> profiles = (ArrayList<UserDetails>)request.getAttribute("matches");
            
            if(profiles != null && profiles.size() > 0){
                for(int i = 0; i < profiles.size(); i++){
                    
                    String path = "/InstagrAndrew/Images/" + profiles.get(i).getUsername()+ "?type=other&search=" + profiles.get(i).getUsername();
        %>
            <div>
                <a href = "<%=path%>"><img style="left: 0px; position: absolute; margin-left:40px; width: 70px; height: 70px;" src="/InstagrAndrew/Image/<%=profiles.get(i).getProfilePic()%>"></a>
                <div id ="profileInfo">
                    <li><a id="profileName" href = "<%=path%>" > <%=profiles.get(i).getName()%></a></li><br>
                    <p id="profileName"><%=profiles.get(i).getUsername()%></p>
                </div>
            </div>
        <%
                }
            }
        %>
        
        
    </body>
</html>
