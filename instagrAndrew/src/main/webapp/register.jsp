<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        
        <div style = "background-image: url('developmentImages/login background.png'); margin-left: 1%; width: 300px; height: 250px; margin-top: 4%">
            <form method="POST"  action="Register">
                <ul>
                    <br>
                    <h3 style="color: white;">REGISTER:</h3>
                    <br><li style="margin-left: 15px; padding-bottom: 15px;">User Name <input type="text" name="username"></li><br>
                    <li style="margin-left: 26px; padding-top: 15px;">Password <input type="password" name="password"></li>
                </ul>
                <br/>
                <input type="submit" value="Register" style="margin-left: 15px; margin-bottom: 15px;"> 
            </form>
        </div>
        
                        
    </body>
</html>
