//function go(){
//	this._a = new Array("浦东新闻,,","市民中心,,","信息公开,govOpen,/website/govOpen/index1.jsp","浦东诚信,,","域情专递,,","投资资讯,investInfo,/website/investInfo/index.jsp","服务导航,,","监督投诉,supervise,/website/supervise/apply.jsp","参政议政,,","经典栏目,,","返回首页,index,/website/index.jsp");
//	this._b = window.location.href;
//	this._c = document.getElementById("navi");
//	this._d = "";
//}

function nl(){
	var _a,_b,_c,_d,_e,_f;
	//var top_url=top.location.href;	
    //var top_url2=location.href;	
    //alert(top_url+"top");
    //alert(top_url2+"sub");
	try{
		_a = gn();
		_b = new go();
		_c = _b._a;
		_e = new ic();
		if(_c!=undefined){
			_b._d += "<table cellspacing=\"0\" cellpadding=\"0\"><tr><td width='6'></td>";
			for(i=0;i<_c.length;i++){
				_d = _c[i].split(",");
				_e._a = _d[0];
				_e._b = _d[2];
				if(_d[1]==_a) _e._c = "class='banner-checked'";
				else _e._c = "class='banner'";				
			
				
				if(_d[2].indexOf("http://")!=-1) _e._d = "target='_blank'";
				else _e._d = "";
				
				/*
				if (_d[2].indexOf("http://")!=-1)
				{
					if (top_url.indexOf(_d[2])!=-1)
					{
						_e._d = "target=''";
					}else{
						_e._d = "target='_blank'";
					}
				}else{
					if (top_url.indexOf("www.pudong.gov.cn")!=-1||top_url.indexOf("61.129.65.23")!=-1)
					{
						_e._d = "target=''";
					}else{
						_e._d = "target='_blank'";
					}

				}
				*/
				
				_b._d += ih(_e);
			}
			_b._d += "<td width='4'></td></tr></table>";
			_b._c.innerHTML = _b._d;
		}
	}
	catch(e){
		//nothing
	}
}

function gn(){
	var _a,_b,_c,_d;
	_a = new go();
	_b = _a._b;_b = _b.replace("http://","");_c = _b.split("/");
	for(i=0;i<_c.length;i++){
		if(_c[i]=="website") _d = _c[eval(i+1)];
	}
	return _d;
}

function ih(o){
	return "<td width='63' align=\"center\" "+o._c+"><a href=\""+o._b+"\" "+o._c+" "+o._d+"><strong>"+o._a+"</strong></a></td><td width=\"1\" align=\"center\"><img src=\"../images/sub_bannerAdd.gif\" width=\"1\" height=\"20\" /></td>";
}


function ic(){
	this._a = "";
	this._b = "";
	this._c = "";
	this._d= "";
}
//window.onload = function (){nl();}
nl();