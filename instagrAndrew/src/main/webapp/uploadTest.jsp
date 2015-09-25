
<!DOCTYPE html>
<head>
<title>BETA</title>
<style>
    .demo_page {
            background-color: slategray;
            color: white;
            font-size: 14px;
    }
    .demo_content {
            margin: 0 auto;
            text-align: center;
            width: 100%;
    }

    .info {
            margin: 15px 0;	
    }

</style>

</head>
<body class="demo_page">
<div class="demo_content"> 
  <div class="info">
    <input type="file" id="files" />
    <output id = "list"></output>
    
    <script>
	if (window.FileReader) {
            function handleFileSelect(evt) {
                var files = evt.target.files;
                var f = files[0];
                var reader = new FileReader();

                reader.onload = (function(theFile) {
                   return function(e) {
                                                                    
                      document.getElementById('list').innerHTML = ['<img src="', e.target.result,'" title="', theFile.name, '" style = "border-width: 1px; width: 200px; height: 200px;"/>'].join('');
                   };
                })(f);

                reader.readAsDataURL(f);
            }
        } else {
            document.getElementById('preview').innerHTML = ['<img alt = "PREVIEW COULD NOT BE LOADED"/>'].join('');
        }
        document.getElementById('files').addEventListener('change', handleFileSelect, false);
    </script>
    
  </div>
</div>
<!-- END demo_content -->
</body>
</html>