<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<%
//Update 20061231
CDataCn dCn = null;
CDataImpl dImpl = null;
try{
dCn = new CDataCn();
dImpl = new CDataImpl(dCn);

	String sql = "select sj_id,sj_dir from tb_subject where sj_parentid = (select sj_id from tb_subject where sj_dir='shpd')";
	Vector vect = dImpl.splitPage(sql,request,20);
	WebLeftNavigate barObj = null;

%>

<script language='javascript'>


	function expandGrid(gridId)
    {
      currentGrid=gridId;
	 
      var objTRs=document.getElementsByTagName("tr");
      for(var i=0;i<objTRs.length;i++)
      {
        var objTR=objTRs.item(i);
        
		if(objTR.id.search(/thd/ig)!=-1)
        {
		  
		   objTR.style.display="none";
      	}else{

			if(objTR.id.search(/sec/ig)!=-1)
			{
			   var gridIndex=objTR.id;
			   var Grid=currentGrid.substring(3);
			   if(gridIndex.indexOf(Grid)!=-1){
					objTR.style.display="";
			   }
			   else{
					var value = objTR.name;
					objTR.style.display="none";
			   }
			   
			}
		}
      }
		
		var classid = gridId.split("-");
		changeClass(classid[1]);
		document.all.oldClass.value="class" + gridId;
	    changeColor(gridId);
		document.all.oldBg.value=gridId;

    }
	
	function changeClass(id){
		var obj = document.getElementById("classfir-" + id + "-");
		var objName = document.all.oldClass.value;
		if(objName!="")
		{
		    var oldObj = document.getElementById(objName);
			oldObj.className="btOne-bg";
		}
		obj.className="btOneChecked-bg";
	}

	
	function changeColor(id){
		var obj = document.getElementById("bg-" + id);
		var objName = document.all.oldBg.value;
		if(objName!="")
		{
			
		var oldObj = document.getElementById("bg-" + document.all.oldBg.value);
			if(document.all.oldBg.value.indexOf("fir")!=-1)
				oldObj.bgColor="#999999"
			else
				oldObj.bgColor="#DDDDDD"
		}
		obj.bgColor = "#FF0000";
	}

	function expandSecGrid(gridId)
	{
		  currentGrid=gridId;
		  var objTRs=document.getElementsByTagName("tr");
		 
		  for(var i=0;i<objTRs.length;i++)
		  {
			var objTR=objTRs.item(i);

			
			
			if(objTR.id.search(/thd/ig)!=-1)
			{
			  var gridIndex=objTR.id;
			   var Grid=currentGrid.substring(3);
				//alert(Grid);
			   if(gridIndex.indexOf(Grid)!=-1){
					objTR.style.display="";
			   }
			   else{
					var value = objTR.name;
					objTR.style.display="none";
			   }
			}
		  }

		  changeColor(gridId);
	   document.all.oldBg.value=gridId;
	}

	
	function expandThdGrid(gridId)
	{
		  
	   changeColor(gridId);
	   document.all.oldBg.value=gridId;
	}
</script>
<input type="hidden" id="oldBg" value="">
<input type="hidden" id="oldClass" value="">
<%
	out.print("<"+"%	String sj_dir_col=\"govOpen\";	String domain=request.getRequestURL().toString().toLowerCase();	if(domain.indexOf(\"/website/\")!=-1)	{		sj_dir_col=domain.substring(domain.indexOf(\"/website/\")+9);		sj_dir_col=sj_dir_col.substring(0,sj_dir_col.indexOf(\"/\"));	}%"+">");
%>
<%out.println("<"+"%sj_dir_col=sj_dir_col.toLowerCase();%"+">");%>
<%
	if(vect!=null){
		for(int i=0;i<vect.size();i++){
			Hashtable content11 = (Hashtable)vect.get(i);
			String sj_dir_now=content11.get("sj_dir").toString();
			out.println("<"+"%if (\""+sj_dir_now+"\".toLowerCase().equals(sj_dir_col)){%"+"><div id='par" + sj_dir_now +"'>");
			barObj = new WebLeftNavigateBarDir(sj_dir_now,dCn,"index.jsp");
			barObj.setParDir(sj_dir_now);
			out.println(barObj.createFirstLeftBar());
			out.println("</div><"+"%}%"+">");
		}
	}
%>


<script language='javascript'>
/*
var href = window.location.search;

var arr = href.split("&");
var sjId;
var pardir;

for(var i=0;i<arr.length;i++){
	if(arr[i].indexOf("sj_dir=")!=-1){
		sjId = arr[i].substring(arr[i].indexOf("sj_dir=")+7);
		break;
	}
}
pardir = gn();
var divs=document.getElementsByTagName("div");
for(var iii=0;iii<divs.length;iii++)
{
	var objdiv=divs.item(iii);
	if(objdiv.id.search(/par/ig)!=-1)
	{
	   var griddivIndex=objdiv.id;		
	   if(griddivIndex.indexOf(pardir)!=-1){
			objdiv.style.display="";
	   }
	   else{			
			objdiv.style.display="none";
	   }
	   
	}
}

 var TRs=document.getElementsByTagName("tr");

for(var ii=0;ii<TRs.length;ii++)
{
	
	var TR=TRs.item(ii);
	var trIds = TR.id.split("-");
	
	if(sjId!=""){
		for(var j=0;j<trIds.length;j++)
		{
			if(trIds[j]==sjId) {
				if(j==1) {expandGrid("fir-"+ sjId + "-" );break;}
				if(j==2) {expandGrid("fir-"+ trIds[1] + "-" );expandSecGrid("sec-" + trIds[1] + "-" + sjId + "-");break;}
				if(j==3) {expandGrid("fir-"+ trIds[1] + "-" );expandSecGrid("sec-" + trIds[1] + "-" + trIds[2] + "-");expandThdGrid("thd-" + trIds[1] + "-" + trIds[2] + "-" + sjId + "-");break;}
			}

		}
	}

}*/
</script>
<%
}
catch(Exception e){
out.print(e.toString());
}
finally{
dImpl.closeStmt();
dCn.closeCn(); 
}
%>