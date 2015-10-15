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
 
        <img id = "preview" src ="developmentImages/no preview.png" style = "float: right; margin-right: 50px; border-style: solid; border-width: 2px; border-color: black;" name = "preview" width = 500; height = 500;/>
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
            
            
            <!--
            CREATE TABLE comments (user_name varchar PRIMARY KEY, content varchar, image_id varchar);
            -->
            
            <!--<div style="display: inline-block; margin-left: 20px">
                <h3>Vignette:</h3>
                <input type="radio" value="No" name="Vignette" checked="true">No<br>
                <input type="radio" value="Yes" name="Vignette">Yes<br>
                <br><br><br>
            </div>-->
    
            <div style="display: inline-block;">
                <h3>Contrast:</h3>
                <input type="radio" value="0" name="Contrast">-45%<br>
                <input type="radio" value="1" name="Contrast">-30%<br>
                <input type="radio" value="2" name="Contrast">-15%<br>
                <input type="radio" value="4" name="Contrast" checked="true">No Change<br>
                <input type="radio" value="3" name="Contrast">+15%<br>
                <input type="radio" value="5" name="Contrast">+30%<br>
                <input type="radio" value="6" name="Contrast">+45%<br>
            </div>
            
            <br><br>
            
            <input maxlength="20" name="Hashtag" type="text" id="ht" onkeydown="doHashtag(event);" onkeyup="if(event.keyCode == 188){ document.getElementById('ht').value = ''; }" >
            
            <br><br><br>
            <h4>Click to Upload</h4>
            
            <input type="submit" value="Submit">
            
            
            <p name="HT1" id = "HT1" style="display: none; background-color: indianred;" onclick="removeHashtag(1);">#</p>
            <input type="hidden" name="hiddenHT1" id="hiddenHT1" value=""/>
            <p name="HT2" id = "HT2" style="display: none; background-color: indianred;" onclick="removeHashtag(2);">#</p>
            <input type="hidden" name="hiddenHT2" id="hiddenHT2" value=""/>
            <p name="HT3" id = "HT3" style="display: none; background-color: indianred;" onclick="removeHashtag(3);">#</p>
            <input type="hidden" name="hiddenHT3" id="hiddenHT3" value=""/>
            

            <script>

            var hashIndex = 1;
                
            function doHashtag(event) {
                
                var KC = event.keyCode;
                
                if (KC == 188) {
                    if(hashIndex < 4){
                        document.getElementById("HT" + hashIndex ).style.display = "inline-block";
                        document.getElementById("hiddenHT" + hashIndex).value = document.getElementById("ht").value;
                        document.getElementById("HT" + hashIndex).innerHTML = document.getElementById("ht").value;
                        hashIndex++;
                    }else{
                        alert("Cannot add another Hashtag. The maximum is 3");
                    }
                }
            }

            
            function removeHashtag(index){
                
                alert(index);
                
                if(index == 1){
                                        
                    alert("2 LEFT");
                    
                    var tmp = document.getElementById("hiddenHT2").value;
                    var tmp2 = document.getElementById("hiddenHT3").value;
                    
                    
                    alert(tmp);
                    alert(tmp2);
                    
                    document.getElementById("hiddenHT3").value = "";
                    document.getElementById("HT3").value = "";
                    document.getElementById("HT3").style.display = "none";
                    document.getElementById("hiddenHT2").value = tmp2;
                    document.getElementById("HT2").innerHTML = tmp2;
                    document.getElementById("hiddenHT1").value = tmp;
                    document.getElementById("HT1").innerHTML = tmp;
                    hashIndex = 1;
                    
                    
                }else if(index == 2){
                    
                    //alert("1 LEFT");
                    var tmp = document.getElementById("hiddenHT3").value;
                                        
                    document.getElementById("hiddenHT3").value = "";
                    document.getElementById("HT3").value = "";
                    document.getElementById("HT3").style.display = "none";
                    document.getElementById("hiddenHT2").value = tmp;
                    document.getElementById("HT2").innerHTML = tmp;
                    hashIndex = 2;
                    
                }else if(index  == 3){
                    
                    //alert("FULL");
                    
                    document.getElementById("hiddenHT3").value = "";
                    document.getElementById("HT3").innerHTML = "";
                    document.getElementById("HT3").style.display = "none";
                    hashIndex = 3;
                }
            }


            </script>
            
                       
            
        </form>
            

    </body>
</html>
