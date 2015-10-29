<%-- 
    Document   : changeDetails
    Created on : 20-Oct-2015, 09:25:39
    Author     : Andrew
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.Validation"%>
<%@page import="java.util.Set"%>
<%@page import="uk.ac.dundee.computing.aec.instagrAndrew.models.UserDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="myStyles.css" />      
        <title>Change Details</title>
        
        
        
        
        
    </head>
    <body background="developmentImages/5.JPG" style = "background-position: center;">
        
        <%
            
            
            String firstName;
            String surname;
            Set<String> email;
            String password;
            String username;
            String emailString = "";
            
            UserDetails UD = (UserDetails)request.getAttribute("UserDetails");
            
            firstName = UD.getForename();
            surname = UD.getSurname();
            email = UD.getEmail();
            password = UD.getPassword();
            username = UD.getUsername();
            String[] tmp = new String[4];
            email.toArray(tmp);
            try{
                emailString = tmp[0];
            }catch(Exception ex){}
            
            Object val = request.getAttribute("Validation");
            if(val!=null){
                Validation v = (Validation)val;
                %>
                <script>
                    alert("<%=v.getErrorMessage()%>");
                </script>
                <%
            }
            
            
        %>
        
        <nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
        
        <div style = "margin-left: 1%; width: 300px; height: 450px; margin-top: 5%; background-image: url('developmentImages/login background.png'); background-size: cover; ">
            <form method="POST" action="UpdateProfile">
                
                <h2 style="float:right; margin-right: 20px; margin-top: 30px;"><%=username%>'s Profile:</h2>
                <ul>
                    <br>
                    <h3 style="color: white;">Change Details</h3><br>
                    <input type="hidden" value="<%=username%>" name="username">
                    <li style="margin-left: 15px; padding-bottom: 15px;">First Name<br><input autocomplete="off" type="text" name="forename" id = "FN" value="<%=firstName%>" style="width: 90%;"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Surname<br><input autocomplete="off" type="text" name="surname" id = "SN" value="<%=surname%>" style="width: 90%"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Email Address<br><input autocomplete="off" type="text" name="email" id = "email" value="<%=emailString%>" style="width: 90%"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Old Password<br><input autocomplete="off" type="password" name="oldPassword" id = "oldPassword" style="width: 90%"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Password<br><input autocomplete="off" type="password" name="password" id = "password" style="width: 90%"></li><br>
                    <li style="margin-left: 15px; padding-bottom: 15px;">Confirm Password<br><input autocomplete="off" type="password" name="confirmPassword" id = "confirmPassword" style="width: 90%"></li><br>
                </ul>
                <br/>
                <input type="submit" value="Update" style="margin-left: 15px; margin-bottom: 15px;"> 
            </form>
        </div>
        
        
    </body>
</html>
