 
<script type="text/javascript" src="fckeditor.js"></script>
<form action="show.jsp" method="post" target="_blank">
<table border="0" width="700"><tr><td>
<textarea id="content" name="content" style="WIDTH: 100%; HEIGHT: 400px"></textarea>
<script type="text/javascript">
 var oFCKeditor = new FCKeditor('content') ;
 oFCKeditor.BasePath = "/system/app/infopublish/editor/" ;
 oFCKeditor.Height = 400;
 oFCKeditor.ToolbarSet = "Default" ; 
 oFCKeditor.ReplaceTextarea();
</script>
<input type="submit" value="Submit">
</td></tr></table>
</form>


