<%-- 
    Document   : test
    Created on : Sep 29, 2014, 9:16:48 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
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
    <body>
        <h1>Hello World!</h1>
        <%
            Pic ps = new Pic();
            LoggedIn lg = new LoggedIn();
            %>
            
            <script type="text/javascript"> 
            ChangeBackGround();
        </script> 
    </body>
</html>
