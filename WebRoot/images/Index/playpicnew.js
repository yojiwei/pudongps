function pictruePlayer(objId,textId)
{
	eval("window.picPlayer_"+ objId +"=this;");

	var isIE = document.all ? true : false;
	this.fashion = 23;
	this.timeOut = 3020;
	
	var outDiv = document.getElementById(objId);
	outDiv.innerHTML = '<p></p><div>'+ outDiv.innerHTML +'</div>';
	var plrDiv = outDiv.childNodes[1];
	
	var subDivs = plrDiv.childNodes;
	var picIndex = parseInt(subDivs.length/2) - 1;
	var setIndex = 0;

	for (var i=subDivs.length-1; i>=0; i--)
	{
		if (subDivs[i].nodeType == 3) plrDiv.removeChild(subDivs[i]);
	}
	
	for (var i=0; i<subDivs.length; i++)
	{
		var oA = document.createElement("A");
		oA.innerHTML = i + 1;
		oA.onclick = function()
		{
			setIndex = parseInt(this.innerHTML, 10) - 2;
		}
		outDiv.childNodes[0].appendChild(oA);
		oA = null;
	}
	var subLinks = outDiv.childNodes[0].childNodes;

	this.play = function()
	{
		if (subDivs.length == 0) return;
		if (this.fashion >= 1 && this.fashion <= 23)
			plrDiv.style.filter = "progid:DXImageTransform.Microsoft.RevealTrans(Transition="+ parseInt(this.fashion, 10) +")";
		else
			plrDiv.style.filter = "BlendTrans(duration=1)";

		if(isFirefox=navigator.userAgent.indexOf("Firefox")<=0) plrDiv.filters[0].apply();
		subDivs[picIndex].style.display = "none";
		subLinks[picIndex].className = "";
		setIndex++;
		if (setIndex >= subDivs.length) setIndex = 0;
		picIndex = setIndex;
		subDivs[picIndex].style.display = "block";
		subLinks[picIndex].className = "current";
		//alert(textId);
		document.getElementById(textId).innerHTML = "<a href="+subDivs[picIndex].childNodes[0].href+" class='B'>" + subDivs[picIndex].childNodes[0].title + "</a>";
		if(isFirefox=navigator.userAgent.indexOf("Firefox")<=0) plrDiv.filters[0].play();
		window.setTimeout("picPlayer_"+objId+".play()", eval("picPlayer_"+objId).timeOut); 
	}
}
