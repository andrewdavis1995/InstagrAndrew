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
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <img id = "preview" src ="developmentImages/no preview.png" style = "float: right; margin-right: 50px; border-style: solid; border-width: 2px; border-color: black; -webkit-filter: grayscale(1); filter: gray; filter: grayscale(1);" name = "preview" width = 500; height = 500;/>
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
                        var img = new Image;

                        reader.onload = (function(theFile) {
                           return function(e) {
                               // help from here: http://www.onlinetools.org/articles/unobtrusivejavascript/chapter2.html
                               document.images["preview"].src = e.target.result;
                               
                               img.onload = function() {
                                   var width = img.width;
                                   var height = img.height;
                                   var ratio = height/width;
                                   var newHeight = 500*ratio;
                                   document.images["preview"].height = newHeight;
                               };
                               
                               img.src = reader.result; 
                               
                               
                           };
                        })(f);

                        reader.readAsDataURL(f);
                    }
                }else{
                    document.images["preview"].src = "developmentImages/no preview.png";
                }
                document.getElementById('files').addEventListener('change', getImage, false);
            </script>
            
            <br><br>
            <div style="display: inline-block;">
                <h3>Tint Color:</h3>
                <input type="radio" value="None" name="Filter" checked="true">None<br>
                <input type="radio" value="Red" name="Filter">Red<br>
                <input type="radio" value="Blue" name="Filter">Blue<br>
                <input type="radio" value="Yellow" name="Filter">Yellow<br>
                <input type="radio" value="Green" name="Filter">Green<br>
            </div>
            
            <div style="display: inline-block; margin-left: 20px">
                <h3>Greyscale:</h3>
                <input type="radio" value="No" name="Greyscale" checked="true">No<br>
                <input type="radio" value="Yes" name="Greyscale">Yes<br>
                <br><br><br>
            </div>
    
            <br>
            <h4>Click to Upload</h4>
            <input type="submit" value="Submit">
            
            
            
        </form>
                        
            
            <!--<script>
                //http://jsfiddle.net/Mpx4s/1/
              //  document.getElementById("inp").addEventListener('change', function() {
              //      document.getElementById("preview").setAttribute("style", "-webkit-filter:grayscale(" + this.value + "%); float: right; margin-right: 50px; border-style: solid; border-width: 2px; border-color: black;");
              //  }, false);
                
            //</script> -->
            

    </body>
</html>
