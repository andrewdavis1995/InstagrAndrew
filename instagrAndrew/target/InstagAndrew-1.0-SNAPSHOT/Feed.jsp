<%-- 
    Document   : Feed
    Created on : 27-Oct-2015, 18:33:09
    Author     : Andrew
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.User"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.LoggedIn"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="myStyles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feed</title>
        
        <script>
            function getHashtagName(link, imageName){
               var hashtag = link.innerHTML;
               var cut = hashtag.substring(1);
               document.getElementById("searchText" + imageName).value = cut;
               var path = "HTSearchForm" + imageName;

               document.getElementById(path).submit();
            }
        </script>
        
    </head>
    
    <body style="margin-top: 80px;">
        <%
            ArrayList<Pic> pictures = (ArrayList<Pic>)request.getAttribute("pictures");
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            String currentUser = lg.getUsername(); 
        %>
        
        
    
        <nav style="z-index: 2;">
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <div style="position: absolute; left: calc(100% - 200px); width: 200px; height: 85px; float: right; margin-top: 0; top: 0;"> 
                    <form action="Profile/<%=currentUser%>" method="POST">
                        <input type="Image" name="Submit" src="developmentImages/yourProfile.png" style="width:220px; height: 65px; float: right; margin-top: 0; top: 0">
                        <input type="hidden" name = "username" id="username" value="<%=currentUser%>">
                    </form>
                </div>  
            </ul>
        </nav>    
        
        <h1 style="margin-left: 40px;" >Recent Activity from people you Follow:</h1>
                    
        <%
            for(int i =0; i < pictures.size(); i++){
                
                String h = pictures.get(i).getHashtag();
                String[] hashtags = h.split(",");
                String hashtagOutput = "";
                
                for(int j = 0; j < hashtags.length; j++){
                    hashtagOutput += "#" + hashtags[j] + ", ";
                }
                
                if(hashtagOutput.length() > 0){
                    hashtagOutput = hashtagOutput.substring(0, hashtagOutput.length() - 2);
                }
                
                //getUsername
                
                %>
                <div style="width: 90%; margin-left: 3%; margin-bottom: 20px; margin-right: 0; background-color: lightblue;">
                    
                    <div style="width: 59%; display: inline-block; ">
                        <form method="POST" action="/InstagrAndrew/Comments">
                            <input type="hidden" name="imageSrc" id="imageSrc" value ="<%= pictures.get(i).getSUUID()%>">
                            <input type="hidden" name="whatToDo" id="whatToDo" value ="read">
                            <input type="hidden" name="username" id="username" value ="<%=pictures.get(i).getUser()%>">
                            <input type="hidden" name="hashtags" id="hashtags" value="<%=hashtagOutput%> ">
                            <input type="hidden" name="profPic" id="profPic" value ="<%=request.getAttribute("ProfilePic")%>">
                            <a style ="display: block; margin-left: 48px; margin-top: 12px; float: left" >
                            <input style="width: 93%; margin-left: 15px; margin-bottom: 15px; margin-top: 15px;  margin-right: 15px" type="image" name="Submit" src="/InstagrAndrew/Image/<%=pictures.get(i).getSUUID()%>"></a>
                            <!--<input type="submit" name="Submit" value="SUBMIT">-->
                        </form>
                    </div>
                    
                    
                    <div style="display: inline-block; width: 37%; vertical-align: top; height: 350px; background-color: #0b0f42; margin-left: 0; margin-bottom: 15px; margin-top: 15px;">
                        
                        <form style="margin-left: 20px; margin-top: 15px;" method="POST" action="Profile/<%=pictures.get(i).getUser()%>" id="usernameForm<%=pictures.get(i).getUser()%>"> 
                            <input type="hidden" name="username" value="<%=pictures.get(i).getUser()%>">
                            <h2><a href="#" onclick="document.getElementById('usernameForm<%=pictures.get(i).getUser()%>').submit()"><%=pictures.get(i).getUser()%></a></h2>
                        </form>
                        
                        <%
                            for(int j = 0; j < hashtags.length; j++){%>
                                <form style="margin-top: 15px; margin-left: 30px" method="POST" action="/InstagrAndrew/SearchHashtag" id="HTSearchForm<%=pictures.get(i).getSUUID()%>">   
                                    <a href="#" onclick="getHashtagName(this, '<%=pictures.get(i).getSUUID()%>');" style="margin-top: 4px; color: white; float: left; margin-left: 10px; width: 100%">#<%=hashtags[j]%></a>
                                    <input type="hidden" name="searchText" id="searchText<%=pictures.get(i).getSUUID()%>" value="">
                                </form>
                                
                            <%}
                        %>
                        
                    </div>
                </div>
        <%
            }
        %>
        
    </body>
</html>
