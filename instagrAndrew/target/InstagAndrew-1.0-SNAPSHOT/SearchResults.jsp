<%-- 
    Document   : SearchResults
    Created on : 03-Oct-2015, 11:48:20
    Author     : Andrew
--%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.LoggedIn"%>
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
                    
                    String username = profiles.get(i).getUsername();
                    String path = "/InstagrAndrew/profile/" + username;
                    LoggedIn lg = (LoggedIn)session.getAttribute("LoggedIn");
                    String currentUser = "";
                    if(lg!= null){
                        currentUser = lg.getUsername();
                    }
        %>
                    <div style="background-image: url('developmentImages/userprofileBG.png');">
                        
                        <form method="POST" action="Profile/<%=username%>"> 
                            <%if(profiles.get(i).getProfilePic() != null){ %>
                                <input type="image" style="left: 40px; width:70px; height: 70px; position: absolute;" src="/InstagrAndrew/Image/<%=profiles.get(i).getProfilePic()%>" value="" alt="">
                            <% }else{ %>
                                <input type="image" style="left: 40px; width:70px; height: 70px; position: absolute;" src="developmentImages/question.png" value="" alt="">
                            <% } %>
                            <input type="hidden" name="username" id="username" value="<%=profiles.get(i).getUsername()%>">
                        </form>
                       
                        <div id ="profileInfo">
                          <%if (username.equals(currentUser)) {
                                %>
                                    <h3 style="color: red;">YOUR PROFILE</h3>
                                <%
                            }else{
                                %>
                                    <h3 style="color: black;"><%=profiles.get(i).getUsername()%></h3>
                                <%
                            }
                            %>
                            <p id="profileName"><%=username%></p>
                        </div>
                    </div>  
        <%
                }
            }else{
            %>
                <h3>No Profiles found</h3>
            <%
            }
        %>
        
        
    </body>
</html>
