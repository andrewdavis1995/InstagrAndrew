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
    </head>
   
    
    
    <body background="developmentImages/4.JPG">
        <nav>
            <ul>
                <h1 style = "display: inline; font-size: 1.7em">InstagrAndrew</h1>
                <li><a href="upload.jsp">Upload</a></li>
                    <%
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                                                
                        if (lg != null) {
                            String UserName = lg.getUsername();                        
                            if (lg.getlogedin()) {
                    %>

                
                <li><a href="/InstagrAndrew/Images/<%=lg.getUsername()%>?type=user">Your Images</a></li>
                
                                      
                    <%}
                            }else{
                                %>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="login.jsp">Login</a></li>
                <%

                    }
                %>
            </ul>
        </nav>            
           
        <% 
            if (lg == null){ 
        %>
            <div style = "background-image: url('developmentImages/login background.png'); margin-left: 200px; width: 360px; height: 260px; margin-top: 100px; display: inline-block;">
                <form method="POST"  action="Register" autocomplete="off">
                    <ul>
                        <h2 style="color: white;">REGISTER</h2>
                        <br><li style="margin-left: 15px; margin-bottom: 15px; font-size: 18px">User Name <input type="text" name="username"></li><br><br>
                        <li style="margin-left: 26px; margin-top: 15px; font-size: 18px">Password <input type="password" name="password"></li>
                    </ul>
                    <input type="image" style="margin-left: 50px; margin-bottom: 15px; width: 260px; height: 40px; background: none; margin-top: 30px;" src="developmentImages/register button.png" onMouseOver="this.src='developmentImages/register button(hover).png'" onMouseOut="this.src='developmentImages/register button.png'"> 
                </form>
            </div>
            
            <div style = "background-image: url('developmentImages/login background.png'); margin-left: 50px; width: 360px; height: 260px; margin-top: 100px; display: inline-block;">
                <form method="POST" action="Login">
                    <ul>
                        <h2 style="color: white;">LOGIN</h2>
                        <br><li style="margin-left: 15px; margin-bottom: 15px; font-size: 18px">User Name <input type="text" name="username"></li><br><br>
                        <li style="margin-left: 26px; margin-top: 15px; font-size: 18px">Password <input type="password" name="password"></li>
                    </ul>
                    <input type="image" style="margin-left: 50px; margin-bottom: 15px; width: 260px; height: 40px; background: none; margin-top: 30px;" src="developmentImages/login button.png" onMouseOver="this.src='developmentImages/login button(hover).png'" onMouseOut="this.src='developmentImages/login button.png'"> 
                </form>
            </div>
            
        <%
        }else{
        %>
            
        <div class="container" style = "display: inline-block">
            <div id="content-slider">
                <div id="slider">
                    <div id="mask">
                        <ul>
                            <img class="firstanimation" style = "margin-left:0;" src="developmentImages/1.JPG" alt="1"/>
                            <img class="secondanimation" style = "margin-left:0;" src="developmentImages/2.JPG" alt="2"/>
                            <img class="thirdanimation" style = "margin-left:0;" src="developmentImages/3.JPG" alt="3"/>
                        </ul>
                    </div>  <!-- End Mask -->
                </div>  <!-- End Slider Container -->
            </div>
        </div>     
        
        
        
        <div style = "background-image: url('developmentImages/login background.png'); margin-left: 50px; width: 360px; height: 260px; margin-top: 100px; display: inline-block;">
            <form method="GET" action="Search">
                <div style = "float: left; margin-left: 15px;">
                    <h5>Search for User: </h5>                                        
                    <input type="text" name="searchText">
                    <input type="submit" value="Search" style="margin-left: 15px; margin-bottom: 15px;" src="developmentImages/button.png"> 
                </div>
            </form>
        </div>

        
        
            
       <% } %>
            
        <footer>
            <ul>
                <h5>&COPY; Andrew Davis</h5>
            </ul>
        </footer>
    </body>
</html>
