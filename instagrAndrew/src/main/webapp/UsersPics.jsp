<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrAndrew.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstagrAndrew</title>
        <link rel="stylesheet" type="text/css" href="/InstagrAndrew/myStyles.css" />
                
    </head>
    <body>
        
        <nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="/InstagrAndrew/upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <article>
            
            
        <%
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");

            String search = request.getParameter("search");
            String type = request.getParameter("type");
            
            if (lg != null) {
                
                if(type != "" && search != ""){
                
                    if(type.equals("other") && !search.equals(lg.getUsername())){

                    %> 
                        <h1> <%= search %>'s Pictures </h1>
                    <%
                    }else{
                        %>
                        <h1> Your Pictures </h1>
                        <%
                    }
                }
            }
        %>
            
            
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            if (lsPics == null) {
        %>
                <p>No Pictures found</p>
        <%
            } else {
                Iterator<Pic> iterator;
                iterator = lsPics.iterator();
                while (iterator.hasNext()) {
                    Pic p = (Pic) iterator.next();

        %>
        <a href="/InstagrAndrew/Image/<%=p.getSUUID()%>" ><img src="/InstagrAndrew/Thumb/<%=p.getSUUID()%>"></a><br/><%

                }
            }
        
        %>
        
        </article>
        
    </body>
</html>
