<%-- 
    Document   : displayImage
    Created on : 16-Oct-2015, 17:11:18
    Author     : Andrew
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.CommentModel"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.PicModel"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Image</title>
    </head>
    <body>
        
        <%
            String path = (String)request.getAttribute("imageSource");
        %>
        <img src ="/InstagrAndrew/Image/<%=path%>" style="width:73%; margin-left: 0; display: inline-block">
        
        
        <div style="display: inline-block; background-color: red; margin-left: 1%; width: 25%; vertical-align: top;">
        
            <div style="display: inline-block; background-color: blue; margin-left: 0; width: 100%; vertical-align: top; height: 60px;">
                <img style="width:60px; height:60px; display: inline;" src = "/InstagrAndrew/Image/<%= request.getAttribute("ProfPic") %>">
                <div style="margin-left: 15px; margin-top: 0; height: 100%; vertical-align: top; display: inline-block; width: calc(100%-105px); width: -webkit-calc(100% - 105px); width: -moz-calc(100% - 105px);">
                    <h1 style="display: inline-block; color: white; height: 20px; width: 100%; vertical-align: top; margin-top: 0; margin-bottom: 0;"><%=request.getAttribute("username")%></h1>
                    <h4 style="display: inline-block; color: white; height: 20px; width: 100%; vertical-align: top; margin-top: 15px; margin-bottom: 0;"><%=request.getAttribute("hashtags")%></h4>
                </div>
                
            </div>
            <%
                if(request.getAttribute("comments") != null){
                    ArrayList<CommentModel> comments = (ArrayList<CommentModel>)request.getAttribute("comments");

                    for(int i = 0; i < comments.size(); i++){
                    %>
                    <p>"<b><%=comments.get(i).getUsername()%>- </b><%=comments.get(i).getContent()%>"</p>
                    <%  
                    }
                }else{
                    %>
                    <p>NO COMMENTS</p>
                    <%
                }
            %>
            <div style="height: 200px; background-color: yellow;">
                <form id="commentForm">
                    <input type="hidden" name="hashtags" id="hashtag" value="<%=request.getAttribute("hashtags")%>">
                    <input type="hidden" name="profPic" id="profPic" value ="<%=request.getAttribute("ProfPic")%>">
                    <input type="hidden" name="username" id="username" value ="<%=request.getAttribute("username")%>">
                    <input type="hidden" name="imageSrc" value="<%=(String)request.getAttribute("imageSource")%>"><br>
                    <h5 style="margin-left: 10px;">Leave a Comment (Max. 100 characters):</h5>
                    <textarea style="margin-left: 10px; overflow: no-content; resize: none; width: 92%; height: 45px;" name="comment" id="comment" form="commentForm" maxlength="100"></textarea>
                    <input type="hidden" name="whatToDo" id="whatToDo" value ="post">
                    <input style="margin-left: 10px; margin-top: 10px" type="Submit" name="submit">                
                </form>

            </div>
        </div>
        
        
    </body>
</html>
