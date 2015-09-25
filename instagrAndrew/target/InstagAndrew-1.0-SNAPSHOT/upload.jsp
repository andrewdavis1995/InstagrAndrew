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
    </head>
    <body style = "background-color: darkslategray">
        <nav>
            <ul>
                <li class="nav"><a href="upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <img src ="developmentImages/no preview.png" style = "float: right; margin-right: 50px; border-style: solid; border-width: 2px; border-color: red; -webkit-filter: grayscale(1); filter: gray; filter: grayscale(1);" name = "preview" width = 500; height = 500;/>
        <h1 style = "color: black">SELECT FILE TO UPLOAD</h1>  
        
        
        <form method="POST" enctype="multipart/form-data" action="Image">
            <input type="file" id="files" name ="upfile" style = "color: black"/>
        
            <%--script partly adapted from: http://www.onlywebpro.com/demo/file_reader/reader01.html--%>
            <script>
                if (window.FileReader) {
                    function getImage(evt) {
                        var files = evt.target.files;
                        var f = files[0];
                        var reader = new FileReader();

                        reader.onload = (function(theFile) {
                           return function(e) {

                               // help from here: http://www.onlinetools.org/articles/unobtrusivejavascript/chapter2.html
                               document.images["preview"].src = e.target.result;

                           };
                        })(f);

                        reader.readAsDataURL(f);
                    }
                } else {
                    document.images["preview"].alt = "Preview Could not be loaded";
                }
                document.getElementById('files').addEventListener('change', getImage, false);
            </script>

            <input type="submit" value="Press"> to upload the file!
        </form>

        
        <footer>
            <ul>
                <li class="footer"><a href="/InstagrAndrew">Home</a></li>
            </ul>
        </footer>

    </body>
</html>
