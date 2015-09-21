<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<!DOCTYPE html>
<html>
    
    <head>
        <link rel="stylesheet" type="text/css" href="myStyles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <script type="text/javascript"> 
            
            <%--javascript code adapted from:--%>
            <%--http://stackoverflow.com/questions/15231812/random-background-images-css3--%>
                
            function ChangeBackGround() 
            {
            var num = Math.ceil( Math.random() * 3 );
            document.body.background = 'developmentImages/'+num+'.JPG';
            }
        </script>
        
    </head>
    
    <nav>
        <ul>
            <h1 style = "display: inline;">InstagrAndrew</h1>
                <li><a href="upload.jsp">Upload</a></li>
                    <%
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                            
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>
            
            <li><a href="/InstagrAndrew/Images/<%=lg.getUsername()%>">Your Images</a></li>
                <%}
                        }else{
                            %>
            <li><a href="register.jsp">Register</a></li>
            <li><a href="login.jsp">Login</a></li>
            <%


                }%>
        </ul>
    </nav>
    
    
    <body>
        
        <header>
            <h1 style="display: inline; padding: 10px">InstagrAndrew!</h1>
            <h2>Your world in Black and White</h2>
        </header>
        
        <footer>
            <ul>
                <h5>&COPY; Andrew Davis</h5>
            </ul>
        </footer>
        
        <script type="text/javascript"> 
            ChangeBackGround();
        </script> 
        
    </body>
</html>
