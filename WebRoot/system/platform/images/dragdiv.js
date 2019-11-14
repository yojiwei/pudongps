   var connid=-1;
   var id=-1;
   var lineid=-1,editid=-1,editline=-1;
var dragapproved=false;
var zcor,xcor,ycor;
var nudex=90;nudey=42;
var linex,liney;
var linex1,liney1;
var minx,miny,maxy;
function iniArray() {
      this.length = 100;
      
   }

  function isvalidxy(x,y,a,b)
  {
 // window.alert(x.toString()+y.toString()+a.toString()+minx.toString()+miny.toString());
  if (x-a<minx)
  {//window.alert("test1")
  return false;}
  if (y-a<miny)
 {//window.alert("test2")
  return false;}
  if (y+b>maxy)
 {//window.alert("test3")
  return false;}
 return true;
  }

function showdiv(s)
  {
 // window.alert(x.toString()+y.toString()+a.toString()+minx.toString()+miny.toString());
 document.all(s).style.display="inline";
document.all("lineinput").style.display="none";
document.all("nudeinput").style.display="none";

  }

  function editnode(pid)
   {editid=pid;
    document.all("nudename").value=nudes[editid].name;
    document.all("nudebindunit").value=nudes[editid].bindunit;
	document.all("nudeins").value=nudes[editid].insname;
	document.all("nudetype").value=nudes[editid].nudetype;
	document.all("nudestate").value=nudes[editid].state;
	document.all("folder").value=nudes[editid].folder;
    document.all("nudeinput").style.display="inline";
	 document.all("lineinput").style.display="none";
	 document.all("workflowdiv").style.display="none";
    //document.all("nudeinput").style.left=nudes[editid].x;
    //document.all("nudeinput").style.top=nudes[editid].y+12;
   }

    function editline1()
   {editline=lineid;
   // window.alert(editline.toString()+lines[editline].name);
    document.all("linename").value=lines[editline].name;
    document.all("linetype").value=lines[editline].linetype;
	 document.all("lineifstat").value=lines[editline].lineifstat;
    document.all("lineinput").style.display="inline";
	document.all("nudeinput").style.display="none";
	document.all("workflowdiv").style.display="none";
   // document.all("lineinput").style.left=lines[editline].x+4;
   // document.all("lineinput").style.top=lines[editline].y+4;
   }

  

  function inpnude()
   {// document.all("nudeinput").style.display="none";
     nudes[editid].name=document.all("nudename").value;
     nudes[editid].bindunit=document.all("nudebindunit").value;
	 nudes[editid].insname=document.all("nudeins").value;
	 nudes[editid].nudetype=document.all("nudetype").value;
	  nudes[editid].state=document.all("nudestate").value;
	   nudes[editid].folder=document.all("folder").value;
     document.all("scontentsub"+editid.toString()).innerHTML=nudes[editid].name;
    
   }


   function inpline()
   { 
     lines[editline].name=document.all("linename").value;
     lines[editline].linetype=document.all("linetype").value;
	 lines[editline].lineifstat=document.all("lineifstat").value;
	// document.all("lineinput").style.display="none";
    
     outline(editline,lines[editline].x,lines[editline].y);
	
   }




function fullfill(formid)
{
var strnude="",strline="",i,temp="";
for (i=0;i<countnude;i++ )
{nude=nudes[i];
if (nude.isvalid)
{ if(nude.bindunit=="")
  nude.bindunit=="n";
  if(nude.isname=="")
  nude.isname=="n";
  if(nude.state=="")
  nude.state=="n";
temp=nude.id+"?"+nude.name+"?"+(nude.x-minx).toString()+"?"+(nude.y-miny).toString()+"?"+nude.bindunit+"?"+nude.insname+"?"+nude.state+"?"+nude.nudetype+"?"+nude.folder;
 if (strnude=="")
 strnude=temp;
 else
 strnude=strnude+"~~"+temp;
}

} 
for (i=0;i<countline;i++)
{line=lines[i];
if (line.isvalid)
{  
  if(line.name=="")
  line.name=="n";
 temp=line.sid+"?"+line.tid+"?"+(line.x-minx).toString()+"?"+(line.y-miny).toString()+"?"+line.name+"?"+line.linetype+"?"+line.lineifstat;
 if (strline=="")
 strline=temp;
 else
 strline=strline+"~"+temp;
 }
} 
document.all("wfnudes").value=strnude;
document.all("wflines").value=strline;
document.all(formid).submit();}

function getcon(pid)
{var x,y,sx,sy,tx,ty;
 var i,j,curline=-1;
if(connid==-1)
connid=pid;
else
{ nude=nudes[connid];
 for (i=0;i<nude.nextcount;i++)
 if (nudes[pid].id==nude.nextnudes[i].nextid&&nude.nextnudes[i].nexttype==1)
 {
 curline=nude.nextnudes[i].linekey;
 lines[curline].isvalid=true;
 nude.nextnudes[i].isvalid=true;
 for (j=0;j<nudes[pid].nextcount;j++)
 if (nudes[connid].id==nudes[pid].nextnudes[j].nextid&&nudes[pid].nextnudes[j].nexttype==2)
 nudes[pid].nextnudes[j].isvalid=true;
}
//window.alert( curline.toString());
 if(curline<0)
 {//window.alert(pid.toString()+"/"+connid.toString());
 line=new iniline();
 line.skey=connid;
 line.tkey=pid;
 line.sid=nudes[connid].id;
 line.tid=nudes[pid].id;
 sx=nudes[connid].x;
 sy=nudes[connid].y;
 tx=nudes[pid].x;
 ty=nudes[pid].y;
 if (sx+nudex<tx)
 {x=sx+nudex+10;
  y=sy+nudey/2;
  }
 else
 {if (sx>tx+nudex)
 {x=sx-10;
  y=sy+nudey/2;}
  else
  {if(sy>ty+nudey)
  {x=sx+nudex/2;
   y=sy-10;
  }
   else
  {if(sy+nudey<ty)
  {x=sx+nudex/2;
   y=sy+nudey+10;
  }
  
  }
  }
  }

  if(connid==pid)
  {x=sx+nudex/2;
   y=sy+nudey+15;
  }

  line.x=x;
  line.y=y;
  lines[countline]=line;
  nextnude=new ininextnude();
  nextnude.nextid=nudes[pid].id;
  nextnude.nexttype=1;
  nextnude.linekey=countline;
  nudes[connid].nextnudes[nudes[connid].nextcount]=nextnude;
  nudes[connid].nextcount=nudes[connid].nextcount+1;
  nextnude=new ininextnude();
  nextnude.nextid=nudes[connid].id;
  nextnude.nexttype=2;
  nextnude.linekey=countline;
  nudes[pid].nextnudes[nudes[pid].nextcount]=nextnude;
  nudes[pid].nextcount=nudes[pid].nextcount+1;

  var outhtml="";
  outhtml=outhtml+"<div id='line"+countline.toString()+"1' z-index='4' onmousedown='dragsline("+countline.toString()+")'  class='divline'></div>";
  outhtml=outhtml+"<div id='line"+countline.toString()+"2' z-index='4' onmousedown='dragsline("+countline.toString()+")'  class='divline'></div>";
  outhtml=outhtml+"<div id='line"+countline.toString()+"3' z-index='4' onmousedown='dragsline("+countline.toString()+")'  class='divline'></div>";
  outhtml=outhtml+"<div id='imgarrow"+countline.toString()+"' z-index='4'  class='divarrow'></div>";
//  window.alert(outhtml);
  document.body.innerHTML= document.body.innerHTML+outhtml;
 //window.alert(x.toString()+"/"+y.toString()+nudes[connid].x.toString()+nudes[connid].y.toString());
  outline(countline,x,y);
  line2=new iniline2();
  line2.x=x;
  line2.y=y;
  lines2[countline]=line2;
  countline=countline+1;
}
else
 outline(curline,lines[curline].x,lines[curline].y);

  //window.alert(x.toString()+y.toString());
connid=-1;
}



}

function delline()
{ 
  dellineid(lineid);
  dragapproved=false;
  lineid=-1;
  document.all("nodeshow").style.display="none";
 }

 function dellineid(linekey)
 {var skey,tkey,i;
  skey=lines[linekey].skey;
  tkey=lines[linekey].tkey;
  lines[linekey].isvalid=false;
  for (i=0;i<nudes[skey].nextcount;i++)
  if (nudes[skey].nextnudes[i].nexttype==1&&nudes[skey].nextnudes[i].linekey==linekey)
  nudes[skey].nextnudes[i].isvalid=false;
  for (i=0;i<nudes[tkey].nextcount;i++)
  if (nudes[tkey].nextnudes[i].nexttype==2&&nudes[tkey].nextnudes[i].linekey==linekey)
  nudes[tkey].nextnudes[i].isvalid=false;

   document.all("line"+linekey.toString()+"1").innerHTML="";
   document.all("line"+linekey.toString()+"2").innerHTML="";
   document.all("line"+linekey.toString()+"3").innerHTML="";
   document.all("imgarrow"+linekey.toString()).innerHTML="";
 
 }

function delnude(pid)
{ var linekey,i,j;
  for (i=0;i<nudes[pid].nextcount;i++)  
  if (nudes[pid].nextnudes[i].isvalid)
 { linekey=nudes[pid].nextnudes[i].linekey;
   dellineid(linekey);
   if (linekey==lineid)
   {
     dragapproved=false;
     lineid=-1;
     document.all("nodeshow").style.display="none";
   }
  }
  nudes[pid].isvalid=false;  
 document.all("scontentmain"+pid.toString()).style.display="none";
  if (connid==pid)
  connid=-1;
  if (id==pid)
  id=-1;

}

function addnewnude()
{
var addx,addy,tempid;
addy=event.clientY;
addx=event.clientX;
if(isvalidxy(addx,addy,30,30+nudey))
{
if (confirm("add a new nude?"))
{

nude=new ininude;
if (countnude>0)
tempid=nudes[countnude-1].id;
else
tempid="1000";
tempid=(parseInt(tempid)+1).toString();
nude.id=tempid;
nude.x=addx;
nude.y=addy;
nude.name=document.all("defaultname").value;
nudes[countnude]=nude;

var outhtml="";
outhtml="<input type='hidden' name='nude"+tempid+"' value='"+countnude.toString()+"'>";
outhtml=outhtml+"<div id='scontentmain"+countnude.toString()+"' class='scontentmain' z-index='2' ><div id='scontentbar"+countnude.toString()+"' class='scontentbar' align='right' onmousedown='dragscontentmain("+countnude.toString()+")' onmouseup='relmouse()'  ><img src='../images/line_1.gif' border=1 onclick='getcon("+countnude.toString()+")'><img src='../images/edit.gif' border=1 onclick='editnode("+countnude.toString()+")'><img src='../images/close.gif' border=1 onclick='delnude("+countnude.toString()+")'></div>";
outhtml=outhtml+"<div id='scontentsub"+countnude.toString()+"' class='scontentsub' >"+document.all("defaultname").value+"</div></div>";

  document.body.innerHTML= document.body.innerHTML+outhtml;
 
  document.all("scontentmain"+countnude.toString()).style.left=addx;
  document.all("scontentmain"+countnude.toString()).style.top=addy;




countnude=countnude+1;
}

}
return false;
}
function iniArray2()
{    this.length = 10;}


function ininextnude()
{this.nextid="";
 this.nexttype=1;
 this.isvalid=true;
 this.linekey=0;
}

function ininude()
{this.id="";
 this.name="";
 this.x=0;
 this.y=0;
 this.bindunit="n";
 this.insname="n";
 this.state="n";
 this.nudetype="n";
  this.folder="n";
 this.nextcount=0;
 this.nextnudes=new iniArray2();
 this.isvalid=true;
}

function iniline()
{this.sid="";
 this.tid="";
 this.skey=0;
 this.tkey=0;
 this.name="n";
 this.linetype="1";
 this.lineifstat="n";
 this.x=0;
 this.y=0;
 this.isvalid=true;
}

function iniline2()
{this.x=0;
 this.y=0;
}

var nudes=new iniArray();
var nude;
var lines=new iniArray();
var lines2=new iniArray();
var line,nextnude,line2;
var countline=0;
var countnude=0;

function movescontentmain(){
var i,count,tempx,tempy;
if (event.button==1&&dragapproved){
addx=tempvar1+event.clientX-xcor;
addy=tempvar2+event.clientY-ycor;
if(isvalidxy(addx,addy,30,30+nudey))
{
zcor.style.pixelLeft=tempvar1+event.clientX-xcor;
zcor.style.pixelTop=tempvar2+event.clientY-ycor;

tempx=event.clientX-xcor;
tempy=event.clientY-ycor;
setnude2(id,tempx,tempy);
if (lineid>-1)
{document.all("nodeshow").style.left=lines2[lineid].x-4;
document.all("nodeshow").style.top=lines2[lineid].y-4;
}

}//leftpos=document.all.scontentmain.style.pixelLeft-document.body.scrollLeft;
//toppos=document.all.scontentmain.style.pixelTop-document.body.scrollTop;
return false;
}
}
function movescontentmain2(){
if (event.button==1&&dragapproved){
addx=tempvar1+event.clientX-xcor;
addy=tempvar2+event.clientY-ycor;
if(isvalidxy(addx,addy,4,4))
{
zcor.style.pixelLeft=tempvar1+event.clientX-xcor;
zcor.style.pixelTop=tempvar2+event.clientY-ycor;

lines2[lineid].x=zcor.style.pixelLeft+4;

lines2[lineid].y=zcor.style.pixelTop+4;
//window.alert(lines2[lineid].y.toString());
// window.alert((event.clientY-ycor).toString());
var ret= outline(lineid,lines2[lineid].x,lines2[lineid].y);
if (!ret)
{

zcor.style.pixelLeft=tempvar1;
zcor.style.pixelTop=tempvar2;

lines2[lineid].x=lines[lineid].x;
lines2[lineid].y=lines[lineid].y;
outline(lineid,lines2[lineid].x,lines2[lineid].y);
}
}




//leftpos=document.all.scontentmain.style.pixelLeft-document.body.scrollLeft;
//toppos=document.all.scontentmain.style.pixelTop-document.body.scrollTop;
return false;
}
}
function dragscontentmain(pid){
if (!document.all)
return;
id=parseInt(pid);
//document.all("scontentbar"+id.toString()).bgcolor="yellow";
dragapproved=true;
zcor=document.all("scontentmain"+id);
tempvar1=zcor.style.pixelLeft;
tempvar2=zcor.style.pixelTop;
setnude(id);
//linex=linex1;
//liney=liney1;
xcor=event.clientX;
ycor=event.clientY;
document.onmousemove=movescontentmain;

}

function setnude(nudeid)
{var i,count,linekey;
 //window.alert(nudeid);
 //window.alert(nudes[0].name);
 nude=nudes[nudeid];
 nudes[nudeid].x=document.all("scontentmain"+nudeid.toString()).style.pixelLeft;
 nudes[nudeid].y=document.all("scontentmain"+nudeid.toString()).style.pixelTop;
 count=nude.nextcount;
 for (i=0;i<count;i++)
 {nextnude=nude.nextnudes[i];
 if(nextnude.isvalid&&nextnude.nexttype==1)
 {linekey=nextnude.linekey;
  lines[linekey].x=lines2[linekey].x;
  lines[linekey].y=lines2[linekey].y;
  }
 }
}





function setnude2(nudeid,tempx,tempy)
{var i,count,linekey;
 nude=nudes[nudeid];
 count=nude.nextcount;
 for (i=0;i<count;i++)
 {nextnude=nude.nextnudes[i];
  linekey=nextnude.linekey;
 // window.alert(nextnude.linekey.toString());
 if(nextnude.isvalid)
 {
 if(nextnude.nexttype==1)
 {// window.alert("test");
  lines2[linekey].x=lines[linekey].x+tempx;
  lines2[linekey].y=lines[linekey].y+tempy;
  //window.alert("test");
  }

  var ret= outline(linekey,lines2[linekey].x,lines2[linekey].y);
  }

 }
}



function relmouse()
{
setnude(id);

dragapproved=false;

//linex=linex1;
//liney=liney1;
if (lineid!=-1)
{//window.alert(lineid.toString());
document.all("nodeshow").style.left=lines[lineid].x-4;
document.all("nodeshow").style.top=lines[lineid].y-4;
}

}
function dragsline(pid){

if (!document.all)
return;
lineid=parseInt(pid);

document.all("nodeshow").style.left=lines[lineid].x-4;
document.all("nodeshow").style.top=lines[lineid].y-4;
document.all("nodeshow").style.display="inline";

}
function dragsline2(){
if (!document.all)
return;
dragapproved=true;
zcor=document.all("nodeshow");
zcor.style.left=lines[lineid].x-4;
zcor.style.top=lines[lineid].y-4;
tempvar1=zcor.style.pixelLeft;
tempvar2=zcor.style.pixelTop;
xcor=event.clientX;
ycor=event.clientY;
document.onmousemove=movescontentmain2;

}
function relmouse2()
{
 dragapproved=false;
 lines[lineid].x=lines2[lineid].x;
 lines[lineid].y=lines2[lineid].y;
 //document.all("nodeshow").style.left=lines2[lineid].x-4;
 //document.all("nodeshow").style.top=lines2[lineid].y-4;

//document.all("nodeshow").style.display="none";
}

function onoffdisplay(){
if (scontentsub.style.display=='') 
scontentsub.style.display='none';
else
scontentsub.style.display='';
}

function staticize(){
w2=document.body.scrollLeft+leftpos;
h2=document.body.scrollTop+toppos;
scontentmain.style.left=w2;
scontentmain.style.top=h2;
}




function loaddrag()
{var strnuds=document.all("wfnudes").value;
 var arrnuds=strnuds.split("~");
 var strnud="";
 var arrnud;
 var x;
 var y;
 var id="";
 var name="";
 var outhtml="";
 var i;
 minx=document.all("drawpanel").offsetLeft;
 miny=document.all("drawpanel").offsetTop+77;
 maxy=miny+400;
 //window.alert(minx.toString()+"/"+miny.toString());

 for (i=0;i<arrnuds.length;i++)
 {strnud=arrnuds[i];
  
  arrnud=strnud.split("?");
  if(arrnud.length>2)
  {
  id=arrnud[0];
  name=arrnud[1];
  x=parseInt(arrnud[2])+minx;
  y=parseInt(arrnud[3])+miny;
  nude=new ininude();
  nude.id=id;
  nude.name=name;
  nude.x=x;
  nude.y=y; 
  nude.bindunit=arrnud[4];
  nude.insname=arrnud[5];
  nude.state=arrnud[6];
  nude.nudetype=arrnud[7];
  nude.folder=arrnud[8];
  nudes[countnude]=nude;
  drawnude(countnude,x,y,id,name);
countnude=countnude+1;
  }
 }
  var strlines=document.all("wflines").value;
  var arrlines=strlines.split("~");
  var strline="";
  var arrline;
  var sid="";
  var tid="";
  for (i=0;i<arrlines.length;i++)
 {strline=arrlines[i];
  arrline=strline.split("?");
  if( arrline.length>2)
  {
  sid=arrline[0];  
  tid=arrline[1];
  x=parseInt(arrline[2])+minx;
  y=parseInt(arrline[3])+miny;
 

  line=new iniline();
  line.sid=sid;
  line.tid=tid;
  line.name=arrline[4];
  line.linetype=arrline[5];
  line.lineifstat=arrline[6];
 // window.alert("nude"+sid);
  line.skey=parseInt(document.all("nude"+sid).value);
  line.tkey=parseInt(document.all("nude"+tid).value);
  
  line.x=x;
  line.y=y; 
  line2=new iniline2();
  line2.x=x;
  line2.y=y;
  lines2[countline]=line2;
  lines[countline]=line;
  nextnude=new ininextnude();
  nextnude.nextid=tid;
  nextnude.nexttype=1;
  nextnude.linekey=countline;
  nudes[line.skey].nextnudes[nudes[line.skey].nextcount]=nextnude;
  nudes[line.skey].nextcount=nudes[line.skey].nextcount+1;
  nextnude=new ininextnude();
  nextnude.nextid=sid;
  nextnude.nexttype=2;
  nextnude.linekey=countline;
  nudes[line.tkey].nextnudes[nudes[line.tkey].nextcount]=nextnude;
  nudes[line.tkey].nextcount=nudes[line.tkey].nextcount+1;
 linex=x;
  liney=y;
  linex1=x;
  liney1=y;
  

 drawline(countline,x,y);

 
    //document.write("<div id='line' z-index='4'><table border=0 cellSpacing=0 cellPadding=0   width=100 height=2 border=0 bgcolor='red'><tr><td></td></tr></table></div>");
   countline=countline+1;

}
//outline(1,x,y);




 }
  
 
//var w=document.body.clientWidth-195;
//var h=50;

//w+=document.body.scrollLeft;
//h+=document.body.scrollTop;

//var leftpos=w;
//var toppos=h;
//document.write("<div id='line' z-index='4'><table border=0 cellSpacing=0 cellPadding=0   width=100 height=2 border=0 bgcolor='red'><tr><td></td></tr></table></div>");
//window.onscroll=staticize;
for (i=0;i<countline;i++)
outline(i,lines[i].x,lines[i].y);
//window.alert(nudes[0].nextcount.toString());
document.oncontextmenu=addnewnude;


}

function fromtype(ltype)
{  var opt=document.all("linetype").options;
   return(opt[parseInt(ltype)-1].text);
  
}

function drawline(countline,x,y)
{ var outhtml="";
  var alttext="";

  alttext=lines[countline].name+"("+fromtype(lines[countline].linetype)+")";
  document.write("<div id='line"+countline.toString()+"1' z-index='4' title='"+alttext+"' onmousedown='dragsline("+countline.toString()+")'  class='divline'></div>");
  document.write("<div id='line"+countline.toString()+"2' z-index='4' title='"+alttext+"' onmousedown='dragsline("+countline.toString()+")'  class='divline'></div>");
  document.write("<div id='line"+countline.toString()+"3' z-index='4' title='"+alttext+"'  onmousedown='dragsline("+countline.toString()+")'  class='divline'></div>");
  document.write("<div id='imgarrow"+countline.toString()+"' z-index='4' title='"+alttext+"'  class='divarrow'></div>");

}

function getcolor(linetype)
{

switch(linetype)
{case "1":
 return("#0006FF");
 case "2":
 return("#ff0000");
 case "3":
 return("#00D90A");
 case "4":
 return("#000000");
 case "5":
 return("#FF9C00");
 }

}
function drawnude(countnude,x,y,id,name)
{ var outhtml="";
  
document.write("<input type='hidden' name='nude"+id+"' value='"+countnude.toString()+"'>");
 outhtml="<div id='scontentmain"+countnude.toString()+"' class='scontentmain'><div id='scontentbar"+countnude.toString()+"' class='scontentbar' align='right' onmousedown='dragscontentmain("+countnude.toString()+")' onmouseup='relmouse()'  ><img src='../images/line_1.gif' border=0 onclick='getcon("+countnude.toString()+")'><img src='../images/edit.gif' border=0 onclick='editnode("+countnude.toString()+")'><img src='../images/close.gif' border=0 onclick='delnude("+countnude.toString()+")'></div>";
  outhtml=outhtml+"<div id='scontentsub"+countnude.toString()+"' class='scontentsub' >"+name+"</div></div>";

  document.write(outhtml);
 
  document.all("scontentmain"+countnude.toString()).style.left=x;
  document.all("scontentmain"+countnude.toString()).style.top=y;

}
function outline(linekey,x,y)
{
 var skey=lines[linekey].skey;
 var tkey=lines[linekey].tkey;
 var linetype=lines[linekey].linetype;
 var color=getcolor(linetype);
 var ret=false;
 var sx;
 var sy;
 var tx;
 var ty;
 var ttx;
 var tty;
 var ttx1;
 var tty1;
 var lx;
 var ly;
 var j;
 var lw=0;
 var lh=0;
 var temp=0;
 
  
  // window.alert(skey.toString()+tkey.toString());
  //document.write("<div id='line' z-index='4'><table border=0 cellSpacing=0 cellPadding=0   width=100 height=2 border=0 bgcolor='red'><tr><td></td></tr></table></div>");
  sx=document.all("scontentmain"+skey.toString()).style.pixelLeft;
  sy=document.all("scontentmain"+skey.toString()).style.pixelTop;
  tx=document.all("scontentmain"+tkey.toString()).style.pixelLeft;
  ty=document.all("scontentmain"+tkey.toString()).style.pixelTop;
  ttx=x-sx;
  tty=y-sy;
  ttx1=x-sx-nudex;
  tty1=y-sy-nudey;

  
  //  window.alert(ttx.toString()+tty.toString()+tty1.toString());
 //window.alert(sx.toString()+sy.toString()+tty1.toString());
  if (ttx<0&&tty>0&&tty1<0)
  {lx=sx;
   ly=sy+nudey/2;
   lw=lx-x;
  // window.alert(ttx.toString()+tty.toString()+tty1.toString());
  document.all("line"+linekey.toString()+"1").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
  document.all("line"+linekey.toString()+"1").style.left=x;
   document.all("line"+linekey.toString()+"1").style.top=y-1;
   ret=true;
  }
   
  if (tty>0&&ttx>0&&ttx1<0)
  {lx=sx+nudex/2;
   ly=sy+nudey;
   lh=y-ly;
  // window.alert(ttx.toString()+tty.toString()+tty1.toString());
  document.all("line"+linekey.toString()+"1").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
  document.all("line"+linekey.toString()+"1").style.left=x;
   document.all("line"+linekey.toString()+"1").style.top=ly-1;
    ret=true;
  } 

   if (ttx>0&&tty>0&&tty1<0)
  {lx=sx+nudex;
   ly=sy+nudey;
   lw=x-lx;
  // window.alert(ttx.toString()+tty.toString()+tty1.toString());
  document.all("line"+linekey.toString()+"1").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
  document.all("line"+linekey.toString()+"1").style.left=lx;
   document.all("line"+linekey.toString()+"1").style.top=y-1;
    ret=true;
  } 

 
 if (tty<0&&ttx>0&&ttx1<0)
  {
   ly=sy;
   lh=ly-y;
  
  document.all("line"+linekey.toString()+"1").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
  document.all("line"+linekey.toString()+"1").style.left=x;
   document.all("line"+linekey.toString()+"1").style.top=y-1;
    ret=true;
  } 
 if (ret)
 {
   ttx=x-tx;
   tty=y-ty;
   ttx1=x-tx-nudex;
   tty1=y-ty-nudey;

   if (ttx<0&&tty<0)
   {
    if(y>sy)
	{
   ly=ty+nudey/2;
    lh=ly-y;
	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
    lw=tx-x;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=x;
    document.all("line"+linekey.toString()+"3").style.top=ly-1;
	document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/you_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=tx-5;
    document.all("imgarrow"+linekey.toString()).style.top=ly-5;
   }
   else
   {lx=tx+nudex/2;
    lw=lx-x;
	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
    lh=ty-y;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2  height="+lh.toString()+"  border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=lx-2;
    document.all("line"+linekey.toString()+"3").style.top=y;
	document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/xia_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx-6;
    document.all("imgarrow"+linekey.toString()).style.top=ty-5;
   }
   
   }





if (ttx1>0&&tty<0)
   {
    if(y>sy)
	{
   ly=ty+nudey/2;
    lh=ly-y;
	lx=tx+nudex;
	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
    lw=x-lx+2;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=lx;
    document.all("line"+linekey.toString()+"3").style.top=ly-1;
	document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/zuo_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx;
    document.all("imgarrow"+linekey.toString()).style.top=ly-5;
   }
   else
   {
   lx=tx+nudex/2;
   if(lx-x<0)
    {temp=lx;
	 lx=x;
	 x=temp;
	}
    lw=lx-x;
	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
    lh=ty-y;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2  height="+lh.toString()+"  border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=x-2;
    document.all("line"+linekey.toString()+"3").style.top=y;
	
	document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/xia_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=x-6;
    document.all("imgarrow"+linekey.toString()).style.top=ty-5;
   }
   
   }









   if (ttx<0&&tty>0&&tty1<0)
   {
     if (x>sx)
   {
    lx=tx;
     lw=tx-x;
	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
    document.all("line"+linekey.toString()+"3").innerHTML="";
    document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/you_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx-5;
    document.all("imgarrow"+linekey.toString()).style.top=y-5;
   }
  
   
   
   }






 if (ttx1>0&&tty>0&&tty1<0)
   {
     if (x<sx+nudex)
   {
    lx=tx+nudex;
     lw=x-tx-nudex;
	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=lx;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
    document.all("line"+linekey.toString()+"3").innerHTML="";
   document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/zuo_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx;
    document.all("imgarrow"+linekey.toString()).style.top=y-5;
   }
  
   
   
   }








if (tty<0&&ttx>0&&ttx1<0)
   {
  
    
   ly=ty;
  // lx=tx+nudex/2;
   lh=ly-y;
  	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=y-1;
	document.all("line"+linekey.toString()+"3").innerHTML=""
   document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/xia_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=x-4;
    document.all("imgarrow"+linekey.toString()).style.top=ly-5;
    
   }


if (ttx1>0&&tty1>0)
   {
   if (x<sx+nudex)
   {
    
   ly=ty+nudey;
   lx=tx+nudex/2;
   lh=y-ly;
  	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=lx-1;
    document.all("line"+linekey.toString()+"2").style.top=ly;
	document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/shang_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx-5;
    document.all("imgarrow"+linekey.toString()).style.top=ly;
	if(lx-x<0)
    {temp=lx;
	 lx=x;
	 x=temp;
	}
    lw=lx-x;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=x;
    document.all("line"+linekey.toString()+"3").style.top=y-1;
 
   }
   else
   {ly=ty+nudey/2;
    lx=tx+nudex;
	lh=y-ly;
	document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x;
    document.all("line"+linekey.toString()+"2").style.top=ly;
    lw=x-lx;
    document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=lx;
    document.all("line"+linekey.toString()+"3").style.top=ly-1;
    document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/zuo_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx;
    document.all("imgarrow"+linekey.toString()).style.top=ly-5;
   }
   
   }




if (ttx<0&&tty1>0)
   {
   if (x>sx)
   {
    
   ly=ty+nudey;
   lx=tx+nudex/2;
   lh=y-ly;
  	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=lx-1;
    document.all("line"+linekey.toString()+"2").style.top=ly;
	 document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/shang_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx-5;
    document.all("imgarrow"+linekey.toString()).style.top=ly;
	if(lx-x<0)
    {temp=lx;
	 lx=x;
	 x=temp;
	}
    lw=lx-x;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=x;
    document.all("line"+linekey.toString()+"3").style.top=y-1;
  
   }
   else
 {//window.alert(ttx.toString()+tty1.toString());
    
   ly=ty+nudey/2;
   lx=tx;
   lh=y-ly;
  	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=x-1;
    document.all("line"+linekey.toString()+"2").style.top=ly;
	if(lx-x<0)
    {temp=lx;
	 lx=x;
	 x=temp;
	}
    lw=lx-x;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=x;
    document.all("line"+linekey.toString()+"3").style.top=ly-1;
    document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/you_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=tx-5;
    document.all("imgarrow"+linekey.toString()).style.top=ly-5;
   }
   }






if (ttx>0&&ttx1<0&&tty1>0)
   {
    
   ly=ty+nudey;
   lx=x;
   lh=y-ly;
  	//window.alert(ttx.toString()+tty.toString());
    document.all("line"+linekey.toString()+"2").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width=2 height="+lh.toString()+" border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"2").style.left=lx-2;
    document.all("line"+linekey.toString()+"2").style.top=ly;
  document.all("imgarrow"+linekey.toString()).innerHTML="<img src='../images/shang_"+linetype+".gif'>";
	document.all("imgarrow"+linekey.toString()).style.left=lx-6;
    document.all("imgarrow"+linekey.toString()).style.top=ly;
 if(lx-x<0)
    {temp=lx;
	 lx=x;
	 x=temp;
	}
    lw=lx-x;
	document.all("line"+linekey.toString()+"3").innerHTML="<table  border=0 cellSpacing=0 cellPadding=0   width="+lw.toString()+" height=2 border=0 bgcolor='"+color+"'><tr><td></td></tr></table>";
    document.all("line"+linekey.toString()+"3").style.left=x;
    document.all("line"+linekey.toString()+"3").style.top=y-1;
   
   
   
   }


}

if(skey==tkey)
{document.all("line"+linekey.toString()+"1").innerHTML="";


}

return ret;



}