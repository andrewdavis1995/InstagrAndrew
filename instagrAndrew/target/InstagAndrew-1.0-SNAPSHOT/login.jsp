<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
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
    <body background="developmentImages/1.JPG" style = "color: black">
        
        <nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
            </ul>
        </nav>
       
        <div style = "background-image: url('developmentImages/login background.png'); margin-left: 50px; width: 360px; height: 260px; margin-top: 150px;">
            <form method="POST" action="Login">
                <ul>
                    <br>
                    <h2 style="color: white;">LOGIN</h2>
                    <br><li style="margin-left: 15px; padding-bottom: 15px;">User Name <input autocomplete="off" type="text" name="username"></li><br><br>
                    <li style="margin-left: 26px; padding-top: 15px;">Password <input autocomplete="off" type="password" name="password"></li>
                </ul>
                <br/><input type="image" style="margin-left: 50px; margin-bottom: 15px; width: 260px; height: 40px; background: none; margin-top: 0px;" src="developmentImages/login button.png" onMouseOver="this.src='developmentImages/login button(hover).png'" onMouseOut="this.src='developmentImages/login button.png'"> 
               
            </form>
        </div>
            
        </article>
        
    </body>
</html>