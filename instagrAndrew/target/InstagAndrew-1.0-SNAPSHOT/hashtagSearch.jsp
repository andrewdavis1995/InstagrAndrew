        <%-- 
            Document   : hashtagSearch
            Created on : 12-Oct-2015, 10:46:55
            Author     : Andrew
        --%>

        
        
        <%@page import="java.util.Iterator"%>
        <%@page import="java.util.ArrayList"%>
        <%@page import="java.util.ArrayList"%>
        <%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.Pic"%>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <link rel="stylesheet" type="text/css" href="myStyles.css" />
                <title>Search Results</title>
                
                
                <script>
                    function goToProfile(content){
            
                    var con = content.innerHTML;
                    var formElement = "username";
                    document.getElementById(formElement).value = con;
                    var path = "myform" + con;

                    document.getElementById(path).submit();
                }
                </script>
                
                
            </head>
            <body>
                <nav>
                    <ul>
                        <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                        <li class="nav"><a href="upload.jsp">Upload</a></li>
                        <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
                    </ul>
                </nav>



                <h1 style="color: white">Search Results</h1>
                <h3 style="color: white">You Searched For: #<%= (String)request.getAttribute("searchedText") %> </h3>

                <%  java.util.LinkedList<Pic> matches = (java.util.LinkedList<Pic>) request.getAttribute("matches");

                    if(matches != null && matches.size() > 0){
                        Iterator<Pic> iterator = matches.iterator();

                        while (iterator.hasNext()) {
                            Pic p = (Pic) iterator.next();
                            
                            String hashtagOutput = "";
                            
                            String tmp = p.getHashtag();
                            String[] splitHT = tmp.split(",");

                            for (int i = 0; i < 3; i++){
                                try{
                                    hashtagOutput += "#" + splitHT[i] + ", ";
                                }catch(Exception e){}
                            }

                            if (hashtagOutput.length() > 1){
                                hashtagOutput = hashtagOutput.substring(0, hashtagOutput.length() -2);
                            }

                    %>
                            <div  position="relative" style = "background-image: url('developmentImages/poleroid.png'); display: inline-block; width: 350px; height: 350px; margin-bottom: 50px; margin-left: 20px"> 
                                
                                <form method="POST" action="Profile/<%=p.getUser()%>" name="myform" id="myform<%=p.getUser()%>">
                                    <input type="hidden" value="<%=p.getUser()%>" name="username" id="username">
                                    <a style="margin-top: 30px; color: #39335B; float: left; margin-left: 48px; width: 100%" href="#" onclick="goToProfile(this)"><%=p.getUser()%></a>
                                </form>
                             
                                <form method="POST" action="Comments">
                                    <input type="hidden" name="imageSrc" id="imageSrc" value ="<%= p.getSUUID()%>">
                                    <input type="hidden" name="whatToDo" id="whatToDo" value ="read">
                                    <input type="hidden" name="username" id="username" value ="<%=p.getUser()%>">
                                    <input type="hidden" name="hashtags" id="hashtags" value="<%=hashtagOutput%> ">
                                    <input type="hidden" name="profPic" id="profPic" value ="<%=request.getAttribute("ProfilePic")%>">
                                    <a style ="display: block; margin-left: 48px; margin-top: 15px; float: left" >
                                    <input type="image" name="Submit" src="/InstagrAndrew/Thumb/<%=p.getSUUID()%>"></a>
                                    <!--<input type="submit" name="Submit" value="SUBMIT">-->
                                </form>
                        </div>       

                    <%
                        }
                    }else{
                %>
                <h3>No Pictures Found</h3>
                <%
                    }
                %>

            </body>
        </html>
