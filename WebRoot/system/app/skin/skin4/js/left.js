
// JavaScript Document
function bgChange(id)
{
    for(i=1;i<30;i++)
    {
    try{
        document.getElementById(i).className="";
       }catch(e){}
    }
    var menuId=id; 
    document.getElementById(menuId).className="current";
} 

function showsubmenu(sid)
{
    whichEl = eval("submenu" + sid);
    imgmenu = eval("imgmenu" + sid);
    img = eval("document.all.img" + sid);
    if (whichEl.style.display == "none")
    {
        eval("submenu" + sid + ".style.display=\"\";");
    }
    else
    {
        eval("submenu" + sid + ".style.display=\"none\";");
    }
    img.src=(img.src.indexOf("ico_up.jpg")!=-1)?"images/right/ico_down.jpg":"images/right/ico_up.jpg";
}


