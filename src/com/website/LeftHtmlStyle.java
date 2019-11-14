package com.website;

public class LeftHtmlStyle {
	
	/* <td> has onclick event
	 
	public static final String layerFirst = "<table width=\"173\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">" +
			"<tr id=\"$spanid\"><td width=\"15\" bgcolor=\"#666666\" id=\"bg-$spanid\"></td><td class=\"btOne-bg\" onclick=\"expandGrid('$spanid',this)\" id=\"class$spanid\"  style='cursor:hand'>" +
			"<a href=\"$href\" class=\"one\"  >$title</a></td> </tr>$secondlayer</table>";
	
	public static final String [] originFirstTag = {"$title" ,"$href","$spanid","$secondlayer"};
		

	public static final String layerSecond = "<tr id=\"$secondid\" name=\"$secondid\" style='display:none'>" +
						"<td bgcolor=\"#DDDDDD\" id=\"bg-$secondid\" ></td>" +
						"<td valign=\"top\" class=\"btTwo-bg\" onclick=\"expandSecGrid('$secondid')\" style='cursor:hand'> <a href=\"$href\" class=\"two\">$title</a></td></tr>$thirdLayer";
	
	public static final String [] originSecondTag = {"$title" ,"$href","$secondid","$thirdLayer","$firstid"};
	
	
	public static final String layerThirdParent = "$sontag";
	
	public static final String [] thirdParentTag = {"$thirdid","$sontag"};
	
	public static final String layerThirdSon = "<tr id=\"$thirdid\" style='display:none' onclick=\"expandThdGrid('$thirdid')\"><td bgcolor=\"#DDDDDD\" id=\"bg-$thirdid\"></td><td class=\"btThree-bg\">" +
			"· <a href=\"$href\" class=\"three\">$title</a></td></tr>";
	
	public static final String [] thirdSonTag = {"$title" ,"$href","$thirdid"};
	
	public static final String layerZXFirst = "<table width=\"173\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">" +
	"<tr id=\"$spanid\"><td width=\"15\" bgcolor=\"#666666\" id=\"bg-$spanid\"></td><td class=\"btOne-bg\" onclick=\"expandGrid('$spanid',this)\" id=\"class$spanid\"  style='cursor:hand'>" +
	"<a href=\"$href\" class=\"one\"  >$title</a></td> </tr>$secondlayer</table>";

	public static final String [] originZXFirstTag = {"$title" ,"$href","$spanid","$secondlayer"};
	
	
	public static final String layerZXSecond = "<tr id=\"$secondid\" name=\"$secondid\" >" +
					"<td bgcolor=\"#DDDDDD\" id=\"bg-$secondid\" ></td>" +
					"<td valign=\"top\" class=\"btTwo-bg\" onclick=\"expandSecGrid('$secondid')\" style='cursor:hand'> <a href=\"$href\" class=\"two\">$title</a></td></tr>$thirdLayer";
	
	public static final String [] originZXSecondTag = {"$title" ,"$href","$secondid","$thirdLayer","$firstid"};
	
	
	public static final String layerZXThirdParent = "$sontag";
	
	public static final String [] thirdZXParentTag = {"$thirdid","$sontag"};
	
	public static final String layerZXThirdSon = "<tr id=\"$thirdid\" onclick=\"expandThdGrid('$thirdid')\"><td bgcolor=\"#DDDDDD\" id=\"bg-$thirdid\"></td><td class=\"btThree-bg\">" +
		"· <a href=\"$href\" class=\"three\">$title</a></td></tr>";
	
	public static final String [] thirdZXSonTag = {"$title" ,"$href","$thirdid"};
	
	*/
	
	/* 第一层栏目树 */
	public static final String layerFirst = "<table width=\"173\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">" +
	"<tr id=\"$spanid\"><td width=\"15\" bgcolor=\"#999999\" id=\"bg-$spanid\"></td><td class=\"btOne-bg\" id=\"class$spanid\"  >" +
	"<a href=\"$href\" class=\"one\"  $target >$title</a></td> </tr>$secondlayer</table>";  

	public static final String [] originFirstTag = {"$title" ,"$href","$spanid","$secondlayer","$target"};
	
	/* 第二层栏目树 */
	public static final String layerSecond = "<tr id=\"$secondid\" name=\"$secondid\" style='display:none'>" +
					"<td bgcolor=\"#DDDDDD\" id=\"bg-$secondid\" ></td>" +
					"<td valign=\"top\" class=\"btTwo-bg\" > <a href=\"$href\" class=\"two\" $target>$title</a></td></tr>$thirdLayer";
	
	public static final String [] originSecondTag = {"$title" ,"$href","$secondid","$thirdLayer","$firstid","$target"};
		
	public static final String layerThirdParent = "$sontag";
	
	public static final String [] thirdParentTag = {"$thirdid","$sontag"};
	
	/* 第三层栏目树 */
	public static final String layerThirdSon = "<tr id=\"$thirdid\" style='display:none' ><td bgcolor=\"#DDDDDD\" id=\"bg-$thirdid\"></td><td class=\"btThree-bg\">" +
		"· <a href=\"$href\" class=\"three\" $target>$title</a></td></tr>";
	
	public static final String [] thirdSonTag = {"$title" ,"$href","$thirdid","$target"};
	
	/* 第一层二级页面首页栏目树 */
	public static final String layerOrgFirst = "<table width=\"173\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">" +
	"<tr id=\"$spanid\"><td width=\"15\" bgcolor=\"#999999\" id=\"bg-$spanid\"></td><td class=\"btOne-bg\" id=\"class$spanid\"  >" +
	"<a href=\"$href\" class=\"one\"  $target >$title</a></td> </tr>$secondlayer</table>";
	
	public static final String [] originOrgFirstTag = {"$title" ,"$href","$spanid","$secondlayer","$target"};
	
	/* 第二层二级页面首页栏目树 */
	public static final String layerOrgSecond = "<tr id=\"$secondid\" name=\"$secondid\" style='$displagflag'>" +
	"<td bgcolor=\"#DDDDDD\" id=\"bg-$secondid\" ></td>" +
	"<td valign=\"top\" class=\"btTwo-bg\" > <a href=\"$href\" class=\"two\" $target>$title</a></td></tr>$thirdLayer";

	public static final String [] originOrgSecondTag = {"$title" ,"$href","$secondid","$thirdLayer","$firstid","$target","$displagflag"};
	
	/* 第三层二级页面首页栏目树 */
	public static final String layerOrgThirdSon = "<tr id=\"$thirdid\" style='$displagflag'><td bgcolor=\"#DDDDDD\" id=\"bg-$thirdid\"></td><td class=\"btThree-bg\">" +
	"· <a href=\"$href\" class=\"three\" $target>$title</a></td></tr>";

	public static final String [] thirdOrgSonTag = {"$title" ,"$href","$thirdid","$target","$displagflag"};
	
	
	/* 第一层展开栏目树 */
	public static final String layerZXFirst = "<table width=\"173\" border=\"0\" cellspacing=\"1\" cellpadding=\"0\">" +
	"<tr id=\"$spanid\"><td width=\"15\" bgcolor=\"#999999\" id=\"bg-$spanid\"></td><td class=\"btOne-bg\" id=\"class$spanid\">" +
	"<a href=\"$href\" class=\"one\"  $target>$title</a></td> </tr>$secondlayer</table>";
	
	public static final String [] originZXFirstTag = {"$title" ,"$href","$spanid","$secondlayer","$target"};
	
	/* 第二层展开栏目树 */
	public static final String layerZXSecond = "<tr id=\"$secondid\" name=\"$secondid\" >" +
				"<td bgcolor=\"#DDDDDD\" id=\"bg-$secondid\" ></td>" +
				"<td valign=\"top\" class=\"btTwo-bg\" > <a href=\"$href\" class=\"two\" $target>$title</a></td></tr>$thirdLayer";
	
	public static final String [] originZXSecondTag = {"$title" ,"$href","$secondid","$thirdLayer","$firstid","$target"};
	
	public static final String layerZXThirdParent = "$sontag";  
	
	public static final String [] thirdZXParentTag = {"$thirdid","$sontag"};
	
	/* 第三层展开栏目树 */
	public static final String layerZXThirdSon = "<tr id=\"$thirdid\" ><td bgcolor=\"#DDDDDD\" id=\"bg-$thirdid\"></td><td class=\"btThree-bg\">" +
	"· <a href=\"$href\" class=\"three\" $target>$title</a></td></tr>";
	
	public static final String [] thirdZXSonTag = {"$title" ,"$href","$thirdid","$target"};


}
