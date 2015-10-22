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

        <script>

            function showSaveButton() {
                document.getElementById("saveButton").style.display = 'block';
            }

            function showChangeButton() {
                document.getElementById("changeImageBtn").style.display = 'block';
            }

            function hideChangeButton() {
                document.getElementById("changeImageBtn").style.display = 'none';
            }

        </script>

    </head>

    <% String type;
        String search;
        String name;
        String emailString;
    %>

    <body background="developmentImages/cork.jpg" style="margin-top: 175px;">
      
        <%
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");

            search = (String)request.getAttribute("search");

        %>

        <nav style="top: 0">
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="/InstagrAndrew/upload.jsp">Upload</a></li>
                <!--<li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>-->
                <%
                    if (lg != null) {
                        String currentUser = lg.getUsername(); 
                        if(currentUser.equals(search)){%>
                            <form style="display: inline-block; margin-left: 60px" action="UpdateProfile" name="updateDetails" id="updateDetails" method="type">
                                <input type="hidden" name="username" value="<%=currentUser%>">
                                <input type="hidden" name="whatToDo" value="load">
                                <a href="#" onclick="document.getElementById('updateDetails').submit();">Update Details</a>
                            </form>
                                
                <%      }
                    }
                %>
            </ul>
        </nav>

        <nav style="background-color: #3D3B46; top: 65px; height: 90px; color: white;">
            <ul>

               

                <%
                    if (lg != null) {
                        String currentUser = lg.getUsername();
                        if (request.getAttribute("ProfilePic") == null) { %>
                            <img id="ProfPic" src = "developmentImages/question.png" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                             <%
                        } else { %>
                            <img id="ProfPic" src = "/InstagrAndrew/Image/<%= request.getAttribute("ProfilePic")%>" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                            <%
                        }

                        %>
                        
                        <h2 id="fullName" style="color: white; position: absolute; top: 0px; display: inline-block; left: 120px; margin-left: 20px; margin-top: 0;"> NAME </h2>
                        <p id="profileName" style="color: white; position: absolute; top: 15px; display: inline-block; left: 120px; margin-left: 20px;"> Your Profile </p>
                        <p id="imageCount" style="color: white; position: absolute; top: 30px; display: inline-block; left: 120px; margin-left: 20px;"> 0 IMAGES</p>
                        <p id="emailAddress" style="color: white; position: absolute; top: 45px; display: inline-block; left: 120px; margin-left: 20px;"> THINGS </p>

                        <form style ="float: right; color: white; width: 100%;" method="POST" enctype="multipart/form-data" action="../Image">

                            
                            <%
                        
                            System.out.println("SEARCH: " + search);
                            System.out.println("CURRENT USER: " + currentUser);
                        
                            if(currentUser.equals(search)){%>
                                <div onmouseover="showChangeButton()" onmouseout="hideChangeButton()" class="image-upload" >

                                    <label for="files">
                                        <img id="changeImageBtn" style="position: absolute; float: left; top: 72px; left: 0; display: none" src="developmentImages/change.png"/>
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
                                    document.images["ProfPic"].src = "developmentImages/question.png";
                                }
                                document.getElementById('files').addEventListener('change', getImage, false);
                            </script>

                            <input type="submit" value="Submit" name="saveButton" id="saveButton" style="float: right; display: none">
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
        <h2 style = "color: black;">No Pictures found</h2>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                count++;
                Pic p = (Pic) iterator.next();
        %>
        <div position="relative" style = "background-image: url('developmentImages/pinBG.png'); display: inline-block; width: 350px; height: 400px; margin-bottom: 50px; margin-left: 20px"> 
            <%
                String hts = p.getHashtag();
                String[] splitHT = new String[3];
                if (hts != null) {
                    splitHT = hts.split(",");
                    for (int i = 0; i < splitHT.length; i++) {
                                    try {%> 
            <li><a style="margin-top: 5px; color: #39335B; float: left; margin-left: 48px; width: 100%" href="SearchHashtag?searchText=<%=splitHT[i]%>">#<%= splitHT[i]%> </a></li> 
                <%
                        } catch (Exception e) {
                        }
                    }
                } else {
                %>
            <li><a style="margin-top: 5px; color: crimson; float: left; margin-left: 48px; width: 100%">No Hashtags</a></li> 
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

            <form method="POST" action="Comments">
                <input type="hidden" name="imageSrc" id="imageSrc" value ="<%= p.getSUUID()%>">
                <input type="hidden" name="whatToDo" id="whatToDo" value ="read">
                <input type="hidden" name="username" id="username" value ="<%=name%>">
                <input type="hidden" name="hashtags" id="hashtags" value="<%=hashtagOutput%> ">
                <input type="hidden" name="profPic" id="profPic" value ="<%=request.getAttribute("ProfilePic")%>">
                <a style ="display: block; margin-left: 48px; margin-top: 15px; float: left" >
                    <input type="image" name="Submit" src="/InstagrAndrew/Thumb/<%=p.getSUUID()%>"></a>
                <!--<input type="submit" name="Submit" value="SUBMIT">-->
            </form>
        </div>

        

        <%
                }
            }
        %>

        
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
            
        </script>
        

    </body>
</html>
