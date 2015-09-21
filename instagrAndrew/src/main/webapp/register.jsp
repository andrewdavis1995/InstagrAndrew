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
    <body>
        <header>
            <h1>InstagrAndrew ! </h1>
            <h2>Your world in Black and White</h2>

            <script type="text/javascript"> 
            
                <%--javascript code adapted from:--%>
                <%--http://stackoverflow.com/questions/15231812/random-background-images-css3--%>

                function ChangeBackGround() 
                {
                var num = Math.ceil( Math.random() * 3 );
                document.body.background = 'developmentImages/'+num+'.JPG';
                }
            </script>
        </header>
        <nav>
            <ul>
                
                <li><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
       
        <article>
            <h3>Register as user</h3>
            <form method="POST"  action="Register">
                <ul>
                    <li>User Name <input type="text" name="username"></li>
                    <li>Password <input type="password" name="password"></li>
                </ul>
                <br/>
                <input type="submit" value="Register"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/InstagrAndrew">Home</a></li>
            </ul>
        </footer>
            
            <script type="text/javascript"> 
            ChangeBackGround();
        </script> 
            
    </body>
</html>
