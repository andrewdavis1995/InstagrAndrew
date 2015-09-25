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
    <body background="developmentImages/3.JPG" style = "color: black">
        <header>
        <h1>InstagrAndrew ! </h1>
        <h3>LOGIN</h3>
                
        </header>
        <nav>
            <ul>
                
                <li><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
       
        <article>
            <form method="POST"  action="Login">
                <ul>
                    <li style = "margin-left: 0; padding-left: 0;">User Name <input type="text" name="username"></li>
                    <li>Password <input type="password" name="password"></li>
                </ul>
                <br/>
                <input type="submit" value="Login"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/InstagrAndrew">Home</a></li>
            </ul>
        </footer>
        
        
    </body>
</html>
