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
        <link rel="stylesheet" type="text/css" href="newcss.css" />
        <title>Search Results</title>
    </head>
    <body background="developmentImages/cork.jpg">
        <!--<nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>-->
        
        <ul>
            <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
            <li class="nav"><a href="upload.jsp">Upload</a></li>
            <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
        </ul>
        
        
        <h1 style="color: black">Search Results</h1>
        <h3 style="color: black">You Searched For: <%= (String)request.getAttribute("searchedText") %> </h3>
        
        <%  java.util.LinkedList<Pic> matches = (java.util.LinkedList<Pic>) request.getAttribute("matches");
            Iterator<Pic> iterator = matches.iterator();
           
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();
                
        %>
                <div  position="relative" style = "background-image: url('developmentImages/pinBG.png'); display: inline-block; width: 350px; height: 400px; margin-bottom: 50px; margin-left: 20px"> 
                    <li><a style="margin-top: 10px; color: #39335B; float: left; margin-left: 48px; width: 100%" href="http://localhost:8080/InstagrAndrew/Images/<%=p.getUser() %>?type=other&search=<%=p.getUser() %> "> <%= p.getUser() %> </a></li>
                    <a style ="display: block; margin-left: 48px; margin-top: 15px; float: left" href="/InstagrAndrew/Image/<%= p.getSUUID()%>" ><img src="/InstagrAndrew/Thumb/<%=p.getSUUID()%>"></a>  
                </div>
                
        <%
            }
        %>
        
    </body>
</html>
