<%-- 
    Document   : displayImage
    Created on : 16-Oct-2015, 17:11:18
    Author     : Andrew
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.servlets.Image"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.LoggedIn"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.CommentModel"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.PicModel"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="/InstagrAndrew/myStyles.css" />
        <title>Image</title>
        
    </head>
    
    <script>
        
        
         function getHashtagName(link, imageName){
            var hashtag = link.innerHTML;
            var cut = hashtag.substring(1);
            document.getElementById("searchText" + imageName).value = cut;
            var path = "HTSearchForm" + imageName;

            document.getElementById(path).submit();
        }
        
        function calcImage(){
            var img = document.getElementById("likeStar").src.toString();
            var path = img.substring(54);
            
            if(path == "star_blank.png"){
                document.getElementById("type").value = "like";
            }else{
                document.getElementById("type").value = "unlike";
            }
        }
        
        
        function getProfileName(content, name){
            
            var con = content.innerHTML;
            
            var formElement = "username";
            document.getElementById(formElement).value = con;
            var path = "UserSearchForm" + con + name;
            
            document.getElementById(path).submit();
        }
        
        
        function getProfileNameLikes(link){
            var profile = link.innerHTML;
            var formElement = "username" + profile;
            document.getElementById(formElement).value = profile;
            var path = "LikeForm" + profile;

            document.getElementById(path).submit();
        }
        
    </script>
    
    
    <body style="background-color: #3D3B46; margin-top: 20px">
        
        <%
                
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            String currentUser = lg.getUsername();
            
            String path = (String)request.getAttribute("imageSource");
            ArrayList<String> likes;
            int numLikes;
            try{
                System.out.println("SUCCESS");
                likes = (ArrayList<String>)request.getAttribute("likes");
                System.out.println("SUCCESS");
                numLikes = likes.size();
            }catch(Exception ex){
                likes = new ArrayList<String>();
                numLikes = 0;
            }
            
            String output = "";
            
            

            if(numLikes < 1){
                output = "No likes so far";
            }else if(numLikes < 3){
                for (int i = 0; i < 3; i++){
                    try{
                        output += likes.get(i) + ", ";
                    }catch(Exception e){}
                }


                output = "Likes: " + output.substring(0, output.length()-2);


            }else{
                output = "Likes: " + numLikes;
            }

            
           
                    
                
           %>
            
        <img src ="/InstagrAndrew/Image/<%=path%>" style="width:73%; margin-left: 0; display: inline-block;">
               
        
        <div style="display: inline-block; background-color: lightblue; margin-left: 1%; width: 25%; vertical-align: top;">
        
            <div id="likers" name="likers" style="overflow: auto; position: absolute; width: 25%; height: 500px; background-color: blue; background-image: url('/InstagrAndrew/developmentImages/blue.png'); z-index: 10; display: none">
                <div>   <!-- title div -->  
                    <h3><a href="#" style="color: white; display: inline-block" onclick="hideLikes();">Hide Likes</a></h3>
                    
                </div>
                <br>
                <div id="likerContainer">   <!-- div for storing likers -->
                    <%
                        for (int i = 0; i < numLikes; i++){
                            %>
                            <div id="<%=likes.get(i)%>">
                                
                                <form style="margin-top: 15px;" method="POST" action="Profile" id="LikeForm<%=likes.get(i)%>">
                                    <a href="#" onclick="getProfileNameLikes(this);" style="margin-top: 10px; color: white; float: left; margin-left: 1%; width: 99%"><%=likes.get(i)%></a>
                                    <input type="hidden" name="username" id="username<%=likes.get(i)%>" value="">
                                </form>
                                
                            </div>
                            <%
                        }
                    %>
                </div>
                
            </div>
                        
            <div style="display: inline-block; background-color: blue; background-image: url('/InstagrAndrew/developmentImages/blue.png'); background-size: cover; margin-left: 1%; margin-top: 1%; margin-right: 1%; width: 98%; vertical-align: top; height: 120px;">
                
                <%
                    String profilePicPath = "";
                        
                    try{
                        UUID profilePicture = (UUID)request.getAttribute("ProfPic");
                        
                        if(profilePicture != null){
                            profilePicPath = "/InstagrAndrew/Image/" + profilePicture;
                        }else{
                            profilePicPath = "developmentImages/question.png";
                        }
                    }catch(Exception exc){
                        profilePicPath = "developmentImages/question.png";
                    }
                %>
                
                <img style="width:60px; height:60px; display: inline-block;" src = "<%=profilePicPath%>">
                <div style="margin-left: 15px; margin-top: 0; height: 100%; vertical-align: top; display: inline-block; width: calc(100%-105px); width: -webkit-calc(100% - 105px); width: -moz-calc(100% - 105px);">
                    
                    
                    <form method="POST" action="Profile/<%=request.getAttribute("username")%>" id="usernameForm"> 
                        <input type="hidden" name="username" value="<%=request.getAttribute("username")%>">
                        <h2 style="display: inline-block; color: white; height: 20px; width: 100%; vertical-align: top; margin-top: 0; margin-bottom: 0;"><a href="#" onclick="document.getElementById('usernameForm').submit()"><%=request.getAttribute("username")%></a></h2>
                    </form>
                    
                    
                    <h6 style="display: inline-block; color: white; height: 20px; width: 100%; vertical-align: top; margin-top: 15px; margin-bottom: 0;"><%=request.getAttribute("hashtags")%></h6>
                    <form action="Comments" method="POST">
                        <input type="hidden" value ="<%=path%>" name="imageSrc">
                        <input type="hidden" value="" id="type" name="type">
                        <input type="hidden" value="<%=request.getAttribute("username")%>" name="username">
                        <input type="hidden" value="POST" name="whatToDo">
                        <input type="hidden" name="hashtags" id="hashtag" value="<%=request.getAttribute("hashtags")%>">
                        <input type="hidden" value="<%=request.getAttribute("ProfPic")%>" name="profPic">
                        <input onclick="calcImage()" type="Image" id="likeStar" width="30" height="30" style="display: inline-block">
                    </form>
                    <a id="numLikesLabel" href="#" style="color: white; display: inline-block; font-size: 0.8em" onclick="showLikes();"><%=output%></a>
                </div>
            </div>
                
                <h3 style="margin-left: 15px; margin-bottom: 0; margin-top: 0">Comments:</h3>
                
                
            <%
                if(request.getAttribute("comments") != null){
                    ArrayList<CommentModel> comments = (ArrayList<CommentModel>)request.getAttribute("comments");

                    for(int i = 0; i < comments.size(); i++){
                    %>
                    <div style="background-image: url('/InstagrAndrew/developmentImages/blue.png'); background-size: cover; height: 70px; margin-left: 1%; margin-top: 1%; margin-right: 1%; width: 98%;">
                        
                        <form style="margin-top: 15px;" method="POST" action="Profile" id="UserSearch<%=comments.get(i).getUsername()%>">   
                            <a onclick ="document.getElementById('UserSearch<%=comments.get(i).getUsername()%>').submit();" href="#" style="margin-top: 5px; color: lightblue; float: left; margin-left: 10px; width: 100%"><%=comments.get(i).getUsername()%></a>
                            <input type="hidden" name="username" id="username" value="<%=comments.get(i).getUsername()%>">
                        </form>
                            
                             
                        <h5 style="margin-top: 0; margin-left: 10px;"><b><%=comments.get(i).getContent()%></b></h5>
                    </div>
                    <%  
                    }
                }else{
                    %>
                    <div style="background-image: url('/InstagrAndrew/developmentImages/blue.png'); background-size: cover; height: 60px; margin-left: 1%; margin-top: 1%; margin-right: 1%; width: 98%;">
                        <h4 style="margin-top: 0;">"NO COMMENTS YET"</h4>
                    </div>
                    <%
                }
            %>
                <div style="height: 200px; background-color: blue; background-image: url('/InstagrAndrew/developmentImages/blue.png'); background-size: cover; margin-left: 1%; margin-top: 1%; margin-right: 1%; width: 98%;">
                    <form id="commentForm" action="Comments" type="POST">
                        
                        <input type="hidden" value="comment" name="type">
                        <input type="hidden" name="hashtags" id="hashtag" value="<%=request.getAttribute("hashtags")%>">
                        <input type="hidden" name="profPic" id="profPic" value ="<%=request.getAttribute("ProfPic")%>">
                        <input type="hidden" name="username" id="username" value ="<%=request.getAttribute("username")%>">
                        <input type="hidden" name="imageSrc" value="<%=(String)request.getAttribute("imageSource")%>"><br>
                        <h5 style="margin-left: 10px;">Leave a Comment (Max. 100 characters):</h5>
                        <textarea style="margin-left: 10px; overflow: no-content; resize: none; width: 92%; height: 45px;" name="comment" id="comment" form="commentForm" maxlength="100"></textarea>
                        <input type="hidden" name="whatToDo" id="whatToDo" value ="POST">
                        <input style="margin-left: 10px; margin-top: 10px" type="Submit" name="submit">                
                    </form>

                </div>
                        
                <button style="margin-left: 15px; margin-top: 15px; margin-bottom: 15px" onclick="goHome()">GO HOME</button>
                
                <% 
                    if (lg.getUsername().equals((String)request.getAttribute("username"))){
                        %>
                        <form style="margin-left: 15px; margin-bottom: 15px;" action="DeleteImage" method="POST">
                            <input type="submit" value="DELETE IMAGE">
                            <input type="hidden" name="username" id="username" value ="<%=request.getAttribute("username")%>">
                            <input type="hidden" name="imageID" id="username" value ="<%=request.getParameter("imageSrc")%>">
                            <input type="hidden" value="<%=request.getParameter("dateAdded")%>" name="dateAdded">
                        </form>
                <%
                    }
                %>
                <form action="DeleteImage" method="POST">
                    
                </form>
                
        </div>

                        
        <script>
            <%
            lg = (LoggedIn) session.getAttribute("LoggedIn");
            currentUser = lg.getUsername();
            
            if(likes.contains(currentUser)){
                %>
                    document.getElementById("likeStar").src = "/InstagrAndrew/developmentImages/star_filled.png";
                <%
            }else{
                %>
                    document.getElementById("likeStar").src = "/InstagrAndrew/developmentImages/star_blank.png";
                <%    
            }
            %>
                
        </script>
                        
                    
        <script type="text/javascript">
            function goHome(){
                window.location = "index.jsp";
            }
            
            function showLikes(){
                document.getElementById("likers").style.display = "block";
            }
            function hideLikes(){
                document.getElementById("likers").style.display = "none";
            }
            
        </script>
        
        
    </body>
</html>
