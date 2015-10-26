<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>InstagrAndrew</title>
        <link rel="stylesheet" type="text/css" href="myStyles.css" />
        <script>
            function showSubmitButton(){
                document.getElementById("submitButton").style.display = 'inline-block';
                document.getElementById("submitLabel").style.display = 'inline-block';
            }
            function hideSubmitButton(){
                document.getElementById("submitButton").style.display = 'none';
                document.getElementById("submitLabel").style.display = 'none';
            }
        </script>
                
    </head>
    <body background="developmentImages/pegs.png" style = "background-color: red; background-size: cover; margin-bottom: 30px">
        <nav>
            <ul>
                <li><a style="font-size: 1.7em; text-decoration:none; " href="/InstagrAndrew"><b>InstagrAndrew</b></a></li>
                <li class="nav"><a href="upload.jsp">Upload</a></li>
                <li class="nav"><a href="/InstagrAndrew/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <div style="width: 40%; display: inline-block;float: left; margin-left: 2%;">
            <h1 style = "color: white; margin-left: 2%">SELECT FILE TO UPLOAD</h1>  
        
        
            <form method="POST" enctype="multipart/form-data" action="Image">
                <input type="file" id="files" name ="upfile" style = "color: white; margin-left: 3%; margin-bottom: 4%;"/>
                <img id = "preview" src ="developmentImages/no preview.png" style = "width: 500px; margin-left: 2%; border-style: solid; border-width: 2px; border-color: white;" name = "preview"height = 500;/>


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
                                   
                                if(theFile.type.match('image.*')){
                                   
                                    document.images["preview"].src = e.target.result;

                                    var w = document.images["preview"].width; 

                                    img.onload = function() {
                                        var width = img.width;
                                        var height = img.height;
                                        var ratio = height/width;
                                        var newHeight = w*ratio;
                                        document.images["preview"].height = newHeight;
                                    };

                                    img.src = reader.result; 

                                    showSubmitButton();
                                }else{
                                    alert("File was not an image. Only image files are accepted.");
                                    document.images["preview"].src = "developmentImages/no preview.png";
                                    document.images["preview"].height = "500";
                                    hideSubmitButton();
                                }

                               };
                            })(f);

                            reader.readAsDataURL(f);
                        }
                    }else{
                        document.images["preview"].src = "developmentImages/no preview.png";
                    }
                    document.getElementById('files').addEventListener('change', getImage, false);
                </script>
            
            <p style="display: inline; margin-left: 15px">Hashtags:</p>
            <p name="HT1" id = "HT1" style="display: none; background-color: white; color: red;" onclick="removeHashtag(1);">#</p>
            <p name="HT2" id = "HT2" style="display: none; background-color: white; color: red;" onclick="removeHashtag(2);">#</p>
            <p name="HT3" id = "HT3" style="display: none; background-color: white; color: red;" onclick="removeHashtag(3);">#</p>
            
        </div>
            
        <div style="float: right; margin-right: 2%; margin-top: 3%; width: 50%; display: inline-block;">
            
            <h2 style="color:white; width: 100%; text-align: center">FILTERS</h2>
            <h4 style="color:white; width: 100%; text-align: center">"Let's see what Develops"</h4>
                
            <div style="display: inline-block; margin-right: 5%;">
                <h3>Tint Color:</h3>
                <input type="radio" value="None" name="Filter" checked="true">None<br>
                <input type="radio" value="Red" name="Filter">Red<br>
                <input type="radio" value="Blue" name="Filter">Blue<br>
                <input type="radio" value="Yellow" name="Filter">Yellow<br>
                <input type="radio" value="Green" name="Filter">Green<br>
                <br><br><br>
            </div>
            
            <div style="display: inline-block; margin-right: 5%">
                <h3>Greyscale:</h3>
                <input type="radio" value="No" name="Greyscale" checked="true">No<br>
                <input type="radio" value="Yes" name="Greyscale">Yes<br>
                <br><br><br><br><br><br>
            </div>
                
                
            <div style="display: inline-block; margin-right: 5%">
                <h3>Rotation</h3>
                <input type="radio" value="None" name="Rotation" checked="true">No Rotation<br>
                <input type="radio" value="90CW" name="Rotation">Rotate 90&#176 Clockwise<br>
                <input type="radio" value="180" name="Rotation">Rotate 180&#176<br>
                <input type="radio" value="90ACW" name="Rotation">Rotate 90&#176 Anti-Clockwise<br><br>
                <input type="radio" value="None" name="Flip" checked="true">No Flip<br>
                <input type="radio" value="HorizontalFlip" name="Flip">Flip Horizontally<br>
                <input type="radio" value="VerticalFlip" name="Flip">Flip Vertically
                
            </div>
            
            
                
    
            <div style="display: inline-block;">
                <h3>Contrast:</h3>
                <input type="radio" value="0" name="Contrast">-45%<br>
                <input type="radio" value="1" name="Contrast">-30%<br>
                <input type="radio" value="2" name="Contrast">-15%<br>
                <input type="radio" value="4" name="Contrast" checked="true">No Change<br>
                <input type="radio" value="3" name="Contrast">+15%<br>
                <input type="radio" value="5" name="Contrast">+30%<br>
                <input type="radio" value="6" name="Contrast">+45%<br><br>
            </div>
            
            <br>
            <p>Hashtags (cannot be longer than 15 characters - max of 3 hashtags):</p>
            <p>(Separate By commas, Click to remove)</p>
            <input maxlength="20" name="Hashtag" type="text" id="ht" onkeydown="doHashtag(event);" onkeyup="if(event.keyCode == 188){ document.getElementById('ht').value = ''; }" maxlength="15" >
            
            <input type="hidden" name="hiddenHT1" id="hiddenHT1" value=""/>
            <input type="hidden" name="hiddenHT2" id="hiddenHT2" value=""/>
            <input type="hidden" name="hiddenHT3" id="hiddenHT3" value=""/>
            
            
            <br><br>
            <h5 id="submitLabel" style="display: none">Click to Upload:</h5>
            
            <input type="submit" value="Submit" id="submitButton" style="display: none; width: 300px; height: 60px">
            
            

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
                
                //alert(index);
                
                if(index == 1){
                                        
                    //alert("2 LEFT");
                    
                    var tmp = document.getElementById("hiddenHT2").value;
                    var tmp2 = document.getElementById("hiddenHT3").value;
                    
                    
                    //alert(tmp);
                    //alert(tmp2);
                    
                    document.getElementById("hiddenHT3").value = "";
                    document.getElementById("HT3").value = "";
                    document.getElementById("HT3").style.display = "none";
                    document.getElementById("hiddenHT2").value = tmp2;
                    document.getElementById("HT2").innerHTML = tmp2;
                    document.getElementById("hiddenHT1").value = tmp;
                    document.getElementById("HT1").innerHTML = tmp;
                    hashIndex--;
                    
                    
                }else if(index == 2){
                    
                    //alert("1 LEFT");
                    var tmp = document.getElementById("hiddenHT3").value;
                                        
                    document.getElementById("hiddenHT3").value = "";
                    document.getElementById("HT3").value = "";
                    document.getElementById("HT3").style.display = "none";
                    document.getElementById("hiddenHT2").value = tmp;
                    document.getElementById("HT2").innerHTML = tmp;
                    hashIndex--;
                    
                }else if(index  == 3){
                    
                    //alert("FULL");
                    
                    document.getElementById("hiddenHT3").value = "";
                    document.getElementById("HT3").innerHTML = "";
                    document.getElementById("HT3").style.display = "none";
                    hashIndex--;
                }
            }


            </script>
            
            </div>
            
        </form>
            

    </body>
</html>
