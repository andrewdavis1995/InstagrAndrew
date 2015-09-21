<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstagrAndrew</title>
        <link rel="stylesheet" type="text/css" href="myStyles.css" />
        
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
        <h1>InstagrAndrew ! </h1>
        <h2>Your world in Black and White</h2>
        <nav>
            <ul>
                <li class="nav"><a href="upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <article>
            <h3>File Upload</h3>
            <form method="POST" enctype="multipart/form-data" action="Image">
                File to upload: <input type="file" name="upfile"><br/>

                <br/>
                <input type="submit" value="Press"> to upload the file!
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
