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
            function setImageCount(name, count, email){
                document.getElementById('profileName').innerHTML = name + "<br> (Total Images: " + count + ")";   
                document.getElementById('emailAddress').innerHTML = email;
            }
            
            function showChangeButton(){
                document.getElementById("changeImageBtn").style.display = 'block';
            }
                        
            function hideChangeButton(){
                document.getElementById("changeImageBtn").style.display = 'none';
            }
            
        </script>
        
    </head>
        
    <body background="../developmentImages/cork.jpg" style="margin-top: 175px;">
        
        <nav style="top: 0">
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="/InstagrAndrew/upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <nav style="background-color: #3D3B46; top: 65px; height: 90px; color: white;">
            <ul>
                
                <% 
                
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");

                String search = request.getParameter("search");
                String type = request.getParameter("type");

                if (lg != null) {

                    if( type != null && type != "" && search != ""){

                        if(type.equals("other") && !search.equals(lg.getUsername())){

                        %> 
                        <h4 onmouseover="showChangeButton()" id="profileName" style="position: absolute; top: 0px; margin-top: 0px; display: inline-block; position: absolute; left: 120px; margin-left: 20px; top: 20px"> <%= search %>'s Profile </h4>
                        
                        <%    if ( request.getAttribute("ProfilePic") == null){ %>
                                <img id="ProfPic" src = "../developmentImages/question.png" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                            <%
                            }else{ %>
                                <img id="ProfPic" src = "/InstagrAndrew/Image/<%= request.getAttribute("ProfilePic") %>" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                            <% 
                            }
                        
                        }else{
                            %>
                            
                             
                            <form style ="float: right; color: white; width: 100%;" method="POST" enctype="multipart/form-data" action="Image">
                                
                                <div onmouseover="showChangeButton()" onmouseout="hideChangeButton()" class="image-upload" >
                                    
                                    <% if ( request.getAttribute("ProfilePic") == null){ %>
                                        <img id="ProfPic" src = "developmentImages/question.png" style="width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                                    <%
                                    }else{ %>
                                        <img id="ProfPic" src = "/InstagrAndrew/Image/<%= request.getAttribute("ProfilePic") %>" style="border-style: solid; border-width: 2px; width: 90px; height: 90px; display: inline-block; position: absolute; top: 0px; left: 20px;">
                                    <% 
                                    }
                                    %>
                                    
                                    <label for="files">
                                        <img id="changeImageBtn" style="position: absolute; float: left; top: 72px; left: 20px; display: none" src="../developmentImages/change.png"/>
                                    </label>

                                    <input id="files" type="file" name="upfile"/>
                                </div>
                                
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

                                            reader.onload = (function(theFile) {
                                               return function(e) {
                                                   // help from here: http://www.onlinetools.org/articles/unobtrusivejavascript/chapter2.html
                                                   document.images["ProfPic"].src = e.target.result;

                                                   img.src = reader.result; 


                                               };
                                            })(f);

                                            reader.readAsDataURL(f);
                                        }
                                    }else{
                                        document.images["ProfPic"].src = "developmentImages/question.png";
                                    }
                                    document.getElementById('files').addEventListener('change', getImage, false);
                                </script>

                                <input type="submit" value="Submit" style="float: right;">
                            </form>
                            
                            
                            <h4 id="profileName" style="position: absolute; margin-top: 0px; display: inline-block; left: 120px; margin-left: 20px; top: 20px"> Your Profile </h4>
                            <h5 id="emailAddress" style="position: absolute; top: 40px; margin-top: 0px; display: inline-block; left: 120px; margin-left: 20px;"></h5>
                            <%
                                    
                        }
                    }
                }
                %>
            </ul>
        </nav>
        
            
            
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            Set<String> email = (Set<String>)request.getAttribute("EmailAddress");
            String name = (String)request.getAttribute("Full_Name");
            
            if (email == null){
                email = new TreeSet<String>();
            }
            if (name == null){
                name = "";
            }
            
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
                            <li><a style="margin-top: 5px; color: #39335B; float: left; margin-left: 48px; width: 100%" href="../SearchHashtag?searchText=<%=splitHT[i]%>">#<%= splitHT[i] %> </a></li> 
                            <% 
                            } 
                        }else{
                            %>
                                <li><a style="margin-top: 5px; color: crimson; float: left; margin-left: 48px; width: 100%">No Hashtags</a></li> 
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
            if(<%= search %> != null){
                setImageCount(<%= search %> + "'s Profile", <%= count %>, <%= email %>, <%= name %>);
            }else{
                setImageCount("Your Profile", <%= count %>, <%= email %>, <%= name %> );
            }
        </script>
        
    </body>
</html>
