<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<%@ page import="uk.ac.dundee.computing.aec.instagrAndrew.servlets.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstagrAndrew</title>
        <link rel="stylesheet" type="text/css" href="/InstagrAndrew/myStyles.css" />


        <% String type;
            String search = "";
            String name;
            String emailString;
        %>
    
        <script>
            function showSaveButton() {
                document.getElementById("saveButton").style.display = 'inline-block';
            }
            function showChangeButton() {
                document.getElementById("changeImageBtn").style.display = 'block';
            }
            function hideChangeButton() {
                document.getElementById("changeImageBtn").style.display = 'none';
            }
            
            function getHashtagName(link, imageName){
                var hashtag = link.innerHTML;
                var cut = hashtag.substring(1);
                document.getElementById("searchText" + imageName).value = cut;
                var path = "HTSearchForm" + imageName;
                
                
                document.getElementById(path).submit();
            }
            
            function changeDeleteValue(){
                document.getElementById("delete").value = "true";
            }
        </script>

    </head>

    <body background="/InstagrAndrew/developmentImages/cork.jpg" style="margin-top: 175px;">
      
        <%
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            String currentUser = lg.getUsername(); 
            search = (String)request.getAttribute("search");
            
            
            ArrayList<String> followers = new ArrayList();
            ArrayList<String> followees = new ArrayList();
            
            try{
                followers = (ArrayList<String>)request.getAttribute("followers");
                followees = (ArrayList<String>)request.getAttribute("followees");
            }catch(Exception ee){}
            
        %>

        <nav style="top: 0">
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
               
                <form style="display: inline-block; margin-left: 60px" action="/InstagrAndrew/Upload" name="uploadForm" id="uploadForm" method="POST">
                    <input type="hidden" name="username" value="<%=currentUser%>">
                    <a href="#" onclick="document.getElementById('uploadForm').submit();">Upload</a>
                </form>
                
                <!--<li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>-->
                <%
                    if (lg != null) {
                        if(currentUser.equals(search)){%>
                            <form style="display: inline-block; margin-left: 60px" action="/InstagrAndrew/UpdateProfile" name="updateDetails" id="updateDetails" method="POST">
                                <input type="hidden" name="username" value="<%=currentUser%>">
                                <input type="hidden" name="whatToDo" value="load">
                                <a href="#" onclick="document.getElementById('updateDetails').submit();">Update Details</a>
                            </form>
                                
                            <form action="../LogOut" method="POST" style = "display: inline-block; float: right; margin-right: 20px;">
                                <input type="submit" value="Log Out" style="margin-left: 30px; margin-bottom: 15px; width: 150px;"> 
                            </form>
                <%      }
                    }
                %>
            </ul>
        </nav>

        <nav style="background-color: #3D3B46; top: 65px; height: 90px; color: white;">
            <ul>

               
               

                <%
                    if (lg != null) {%>
                        <div style="height: 90px; width: 250px; float: right; margin-right: 20px; margin-top: 0; top: 0; position: absolute; left: 80%;">
                            <%
                            if(!currentUser.equals(search)){%>
                                <div style="width: 60px; float: right; height: 100%;">
                                    <br>
                                    <form action="/InstagrAndrew/Follow" method="POST" style="display: inline-block; float: right;">
                                        <input type="hidden" name="action" id="action" value="follow">
                                        <input type="hidden" name="userProfile" id="hashtag" value="<%=search%>">
                                        <input type="hidden" name="currentUser" id="hashtag" value="<%=currentUser%>">
                                        <input type="Image" id="likeStar" width="60" height="60" style="display: inline-block">
                                    </form>
                                </div>
                            <%}%>
                            <div style="width: 190px">
                                <br><br>
                                <a href="#" onclick="showFollowers()" id="numFollowers" style="float: right; display: inline-block; margin-top: 0; margin-bottom: 0">Number of Followers: 0</a>
                                <a href="#" onclick="showFollowees()" id="numFollowees" style="float: right; display: inline-block; margin-top: 0; margin-bottom: 0">Profiles Followed: 0</a>
                            </div>
                        </div>
                    <%
                        if (request.getAttribute("ProfilePic") == null) { %>
                            <img id="ProfPic" src = "/InstagrAndrew/developmentImages/question.png" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                             <%
                        } else { %>
                            <img id="ProfPic" src = "/InstagrAndrew/Image/<%= request.getAttribute("ProfilePic")%>" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                            <%
                        }
                        %>
                        
                        <h2 id="fullName" style="color: white; position: absolute; top: 0px; display: inline-block; left: 120px; margin-left: 20px; margin-top: 0;"> NAME </h2>
                        <p id="profileName" style="color: white; position: absolute; top: 15px; display: inline-block; left: 120px; margin-left: 20px;"> Your Profile </p>
                        <p id="imageCount" style="color: white; position: absolute; top: 30px; display: inline-block; left: 120px; margin-left: 20px;"> 0 IMAGES</p>
                        <p id="emailAddress" style="color: white; position: absolute; top: 45px; display: inline-block; left: 120px; margin-left: 20px;"> none </p>

                        <form style ="float: right; color: white; width: 100%;" method="POST" enctype="multipart/form-data" action="/InstagrAndrew/Image">
                            
                            <%
                            if(currentUser.equals(search)){%>
                                <div onmouseover="showChangeButton()" onmouseout="hideChangeButton()" class="image-upload" >

                                    <label for="files">
                                        <img id="changeImageBtn" style="position: absolute; float: left; top: 72px; left: 0; display: none" src="/InstagrAndrew/developmentImages/change.png"/>
                                    </label>

                                    <input id="files" type="file" name="upfile"/>
                                </div>

                            <% } %>

                            <!--<input type="file" id="files" name ="upfile" style = "color: black"/>-->
                            <input type="hidden" name="profilePic" value="true">

                            <%--script partly adapted from: http://www.onlywebpro.com/demo/file_reader/reader01.html--%>
                            <script>
                                if (window.FileReader) {
                                    function getImage(evt) {
                                        var files = evt.target.files;
                                        var f = files[0];
                                        var reader = new FileReader();
                                        var img = new Image;
                                        reader.onload = (function (theFile) {
                                            return function (e) {
                                                // help from here: http://www.onlinetools.org/articles/unobtrusivejavascript/chapter2.html
                                                document.images["ProfPic"].src = e.target.result;
                                                img.src = reader.result;
                                                showSaveButton();
                                            };
                                        })(f);
                                        reader.readAsDataURL(f);
                                    }
                                } else {
                                    document.images["ProfPic"].src = "InstagrAndrew/developmentImages/question.png";
                                }
                                document.getElementById('files').addEventListener('change', getImage, false);
                            </script>

                            <input type="hidden" value="<%=search%>" name="username">
                            <input type="submit" value="Save Changes" name="saveButton" id="saveButton" style="float: right; margin-right: 300px; margin-top: 15px; display: none; width: 200px; height: 45px">
                        </form>

                <%
                    } else {
                        String redirectURL = "login.jsp";
                        response.sendRedirect(redirectURL);
                    }
                %>
            </ul>
        </nav>



        <%
               
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            Set<String> email = (Set<String>) request.getAttribute("EmailAddress");
            name = (String) request.getAttribute("Full_Name");
            String[] sdfdsf = new String[3];
            email.toArray(sdfdsf);
            emailString = sdfdsf[0];
            if (name == null) {
                name = "";
            }
            int count = 0;
            if (lsPics == null) {
        %>
       
        <h2 style = "color: black; width: 100%; text-align: center; padding-top: 80px">No Pictures found</h2>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                count++;
                Pic p = (Pic) iterator.next();
        %>
        <div position="relative" style = "background-image: url('/InstagrAndrew/developmentImages/pinBG.png'); display: inline-block; width: 350px; height: 400px; margin-bottom: 50px; margin-left: 20px"> 
            <%
                String hts = p.getHashtag();
                String[] splitHT = new String[3];
                if (hts != null) {
                    splitHT = hts.split(",");
                    for (int i = 0; i < 3; i++) {
                        try {
                            if(i < splitHT.length){    %> 
                        
                                <form style="margin-top: 15px;" method="POST" action="/InstagrAndrew/SearchHashtag" id="HTSearchForm<%=p.getSUUID()%>">   
                                    <a href="#" onclick="getHashtagName(this, '<%=p.getSUUID()%>');" style="margin-top: 4px; color: #39335B; float: left; margin-left: 48px; width: 100%">#<%=splitHT[i]%></a>
                                    <input type="hidden" name="searchText" id="searchText<%=p.getSUUID()%>" value="">
                                </form>
                         
                            <% }
                        } catch (Exception e) {
                        }
                    }
                } else {
                %>
                    <form style="margin-top: 15px;" method="POST" action="/InstagrAndrew/SearchHashtag" id="HTSearchForm<%=p.getSUUID()%>">   
                        <a style="margin-top: 4px; color: crimson; float: left; margin-left: 48px; width: 100%">No Hashtags</a>
                    </form>
                <%
                    }
                    String hashtagOutput = "";
                    for (int i = 0; i < 3; i++) {
                        try {
                            hashtagOutput += "#" + splitHT[i] + ", ";
                        } catch (Exception e) {
                        }
                    }
                    if (hashtagOutput.length() > 1) {
                        hashtagOutput = hashtagOutput.substring(0, hashtagOutput.length() - 2);
                    }
                %>

            <form method="POST" action="/InstagrAndrew/Comments">
                <input type="hidden" name="imageSrc" id="imageSrc" value ="<%= p.getSUUID()%>">
                <input type="hidden" name="dateAdded" id="dateAdded" value="<%=p.getDate()%>">
                <input type="hidden" name="whatToDo" id="whatToDo" value ="read">
                <input type="hidden" name="username" id="username" value ="<%=search%>">
                <input type="hidden" name="hashtags" id="hashtags" value="<%=hashtagOutput%> ">
                <input type="hidden" name="profPic" id="profPic" value ="<%=request.getAttribute("ProfilePic")%>">
                <a style ="display: block; margin-left: 48px; margin-top: 12px; float: left" >
                <input type="image" name="Submit" src="/InstagrAndrew/Thumb/<%=p.getSUUID()%>"></a>
                <!--<input type="submit" name="Submit" value="SUBMIT">-->
            </form>
        </div>

        

        <%
                }
            }
        %>

        
            <div style="margin-left: 350px; top: 80px; width: 30%; height: 500px; background-color: blue;  background-image: url('/InstagrAndrew/developmentImages/blue.png'); background-size: cover; position: fixed; overflow: auto; display: none" id="followeesLabel" name="followeesLabel">
                <button style="margin-left: 20px; margin-top: 20px; margin-bottom: 20px; width: 160px; height: 25px" onclick="hideBoth(); ">Close</button>
                
                <div style="width:80%; margin-left: 10%">
                <%
                    for(int i = 0; i < followees.size(); i++){
                        %>
                        <form style="margin-top: 0; margin-bottom: 0" method="POST" action="Profile" id="UserSearch<%=followees.get(i)%>">   
                            <a onclick ="document.getElementById('UserSearch<%=followees.get(i)%>').submit();" href="#" style="margin-top: 0; margin-bottom: 0; color: white; float: left; width: 100%"><%=followees.get(i)%></a>
                            <input type="hidden" name="username" id="username" value="<%=followees.get(i)%>">
                        </form>
                        <%
                    }
                %>
                </div>
            </div>
        
            <div style="margin-left: 350px; top: 80px; width: 30%; height: 500px; background-color: blue; background-image: url('/InstagrAndrew/developmentImages/blue.png'); background-size: cover; position: fixed; overflow: auto; display: none" id="followersLabel" name="followersLabel">
                <button style="margin-left: 20px; margin-top: 20px; margin-bottom: 20px; width: 160px; height: 25px" onclick="hideFollowers()">Close</button>
                
                <div style="width:80%; margin-left: 10%">
                <%
                    for(int i = 0; i < followers.size(); i++){
                        %>
                        <form style="margin-top: 0; margin-bottom: 0" method="POST" action="Profile" id="UserSearch<%=followers.get(i)%>">   
                            <a onclick ="document.getElementById('UserSearch<%=followers.get(i)%>').submit();" href="#" style="margin-top: 0; margin-bottom: 0; color: white; float: left; width: 100%"><%=followers.get(i)%></a>
                            <input type="hidden" name="username" id="username" value="<%=followers.get(i)%>">
                        </form>
                        <%
                    }
                %>
                </div>
            </div>
        
         <script>
            
            
            var srch = "<%=search%>";
            var fullName = "<%=name%>";
            var em = "<%=emailString%>";
            var count = "<%=count%>";
            
            if(srch === "null"){
                document.getElementById('profileName').innerHTML = "Your Profile";   
                document.getElementById('imageCount').innerHTML = "(Total Images:" + count + ")";
                document.getElementById('fullName').innerHTML = fullName;
                document.getElementById('emailAddress').innerHTML = em;
            }else{
                document.getElementById('profileName').innerHTML = srch + "'s Profile";   
                document.getElementById('imageCount').innerHTML = "(Total Images:" + count + ")";
                document.getElementById('fullName').innerHTML = fullName;
                document.getElementById('emailAddress').innerHTML = em;
            }
            
            
           
           
            <%
                        
            if(followers != null){
                if(!currentUser.equals(search)){
                    if(followers.contains(currentUser)){
                        %>
                            document.getElementById("action").value = "unfollow";
                            document.getElementById("likeStar").src = "/InstagrAndrew/developmentImages/follow_yellow.png";
                        <%
                    }else{
                        %>
                            document.getElementById("action").value = "follow";
                            document.getElementById("likeStar").src = "/InstagrAndrew/developmentImages/follow_grey.png";
                        <%    
                    }
                }
                int numFollowers = followers.size();
                
                System.out.println("FOLLOWERS @ SET: " + numFollowers);
                %>
                    document.getElementById('numFollowers').innerHTML = "Number of Followers: <%=numFollowers%>";
                <%
                System.out.println("DONE @ SET: " + numFollowers);
            }
            
            
            if(followees != null){
                
                int numFollowees = followees.size();
                System.out.println("FOLLOWEES @ SET: " + numFollowees);
                
                %>
                    document.getElementById('numFollowees').innerHTML = "Profiles Followed: <%=numFollowees%>";
                <%
                System.out.println("DONE @ SET: " + numFollowees);
            }
            %>
                      
            function showFollowers(){
                document.getElementById("followersLabel").style.display = "block";
                hideFollowees();
            }         
            
            function showFollowees(){
                document.getElementById("followeesLabel").style.display = "block";
                hideFollowers();
            }         
            function hideFollowers(){
                document.getElementById("followersLabel").style.display = "none";
            }
            function hideFollowees(){
                document.getElementById("followeesLabel").style.display = "none";
            }
             function hideBoth(){
                document.getElementById("followersLabel").style.display = "none";
                document.getElementById("followeesLabel").style.display = "none";
            }
            
        </script>
        
        
    </body>
</html>










