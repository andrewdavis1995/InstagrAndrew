<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<!DOCTYPE html>
<html>
    
    <head>
        <link rel="stylesheet" type="text/css" href="myStyles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    
    <script>
        function submitLoginForm(){
             document.getElementById('loginForm').submit();
        }
    </script>
   
    
    <body background="developmentImages/4.JPG">
        
        <nav style="z-index: -1; background-image: url('developmentImages/newLogo.png')">
            <ul>
                    
                <h1 style = "display: inline; font-size: 1.7em; margin-left: 250px;">InstagrAndrew</h1>
                
                    <%
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                                                
                        if (lg != null ) {
                            String UserName = lg.getUsername();                        
                            if (lg.getlogedin()) {
                                User us = new User();
                        %>
                <form style="display: inline-block; margin-left: 60px" action="/InstagrAndrew/Upload" name="uploadForm" id="uploadForm" method="POST">
                    <input type="hidden" name="username" value="<%=UserName%>">
                    <input type="hidden" name="whatToDo" value="load">
                    <a href="#" onclick="document.getElementById('uploadForm').submit();">Upload</a>
                </form>
                    
                <div style="position: absolute; left: calc(100% - 200px); width: 200px; height: 85px; float: right; margin-top: 0; top: 0;"> 
                    <form action="Profile/<%=UserName%>" method="POST">
                        <input type="Image" name="Submit" src="developmentImages/yourProfile.png" style="width:220px; height: 65px; float: right; margin-top: 0; top: 0">
                        <input type="hidden" name = "username" id="username" value="<%=UserName%>">
                    </form>
                </div>  
                            <form action="LogOut" method="POST" style="display: inline-block;" id="LogoutForm">
                                <li><a onclick="document.getElementById('LogoutForm').submit();" href="#">Log Out</a></li>
                            </form>



                                <%}
                                        }else{
                                            %>
                            <form style="display: inline-block" action="Register" method="POST" name="registerForm" id="registerForm">
                                <li><a onclick="document.getElementById('registerForm').submit();" href="#">Register</a></li>
                            </form>
                            
                            <form style="display: inline-block" action="Login" method="POST" name="loginForm" id="loginForm">
                                <li><a onclick="submitLoginForm();" href="#">Login</a></li>
                            </form>
                            <%

                    }
                %>
            </ul>
        </nav>            
           
        <% 
            if (lg == null){ 
        %>
            <div style = "background-image: url('developmentImages/login background.png'); margin-left: 50px; width: 360px; height: 260px; margin-top: 100px; display: inline-block;">
                <form method="POST" action="Login">
                    <ul>
                        <h2 style="color: white;">LOGIN</h2>
                        <br><li style="margin-left: 15px; margin-bottom: 15px; font-size: 18px">User Name <input autocomplete="off" type="text" name="username"></li><br><br>
                        <li style="margin-left: 26px; margin-top: 15px; font-size: 18px">Password <input autocomplete="off" type="password" name="password"></li>
                    </ul>
                    <input type="image" style="margin-left: 50px; margin-bottom: 15px; width: 260px; height: 40px; background: none; margin-top: 30px;" src="developmentImages/login button.png" onMouseOver="this.src='developmentImages/login button(hover).png'" onMouseOut="this.src='developmentImages/login button.png'"> 
                </form>
            </div>
            
            
        <%
        }else{
        %>
            
        
        <div style = "background-size: cover; background-image: url('developmentImages/login background.png'); margin-left: 14%; width: 30%; height: 285px; margin-top: 100px; display: inline-block;">
           
            <form method="GET" action="Search">
            
                <div style = "float: left; margin-left: 15px; margin-top: 5px">
                    <h1>SEARCH:</h1>
                    <h5 style="margin-bottom: 10px;">Search for User: </h5>                                        
                    <input type="text" name="searchText" style="width: 270px; height: 20px">
                    <input type="submit" value="Search" style="margin-left: 10px; margin-bottom: 15px; height: 26px; width: 75px"> 
                </div>
            </form>
            
            <form method="GET" action="SearchHashtag">
                <div style = "float: left; margin-left: 15px;">
                    <h5 style="margin-bottom: 10px;">Search for Hashtags: </h5>                                        
                    <input type="text" name="searchText" style="width: 270px; height: 20px">
                    <input type="submit" value="Search" style="margin-left: 10px; margin-bottom: 15px; height: 26px; width: 75px"> 
                </div>
            </form>
        </div>
        
        
        <div style = "background-size: cover; background-image: url('developmentImages/login background.png'); width: 30%; height: 285px; margin-top: 100px; display: inline-block; margin-left: 6%">
            <form method="POST" action="Feed">
                <div style = "float: left; margin-left: 15px;">
                    <input type="hidden" name="username" value="<%=lg.getUsername()%>">
                    <input class='feedButton' type="Image" style="margin-left: 60px; margin-top: 20px; width: 65%" src="developmentImages/viewNewsfeed.png">
                </div>
            </form>        
        </div>
        
        
        <%         
            }
           
        %>
            
        <footer>
            <ul>
                <h5>&COPY; Andrew Davis</h5>
            </ul>
        </footer>
    </body>
</html>
