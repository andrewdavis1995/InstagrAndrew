<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.Validation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstagrAndrew</title>
        <link rel="stylesheet" type="text/css" href="myStyles.css" />       
                
    </head>
    
    <body background="developmentImages/2.JPG" style = "background-position: center;">
        <nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>

        
        <div style = "background-image: url('developmentImages/login background.png'); background-size: cover; margin-left: 1%; width: 300px; height: 450px; margin-top: 100px">
            <form method="POST"  action="Register">
                <ul>
                    <br>
                    <h3 style="color: white;">REGISTER:</h3><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">First Name<br><input type="text" name="forename" id = "FN"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Surname<br><input type="text" name="surname" id = "SN"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Email Address<br><input type="text" name="email" id = "email"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">User Name<br><input type="text" name="username" id = "username"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Password<br><input type="password" name="password" id = "pass"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Confirm Password<br><input type="password" name="confirmPassword" id = "confPass"></li><br>
                </ul>
                <br/>
                <input type="submit" value="Register" style="margin-left: 15px; margin-bottom: 15px;"> 
            </form>
        </div>
        
                        
    </body>
</html>