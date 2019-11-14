/******************************************************************************
* Copyright 2000 by Mike Hall                                                 *
* Please see http://www.brainjar.com for terms of use.                        *
*                                                                             *
* Code for the site menu.                                                     *
******************************************************************************/

// Determine browser type (Netscape 6 or IE 5.5).

var isIE5 = (navigator.userAgent.indexOf("MSIE 4.0") > 0) ? 1 : 0;
var isNS6 = (navigator.userAgent.indexOf("Gecko")    > 0) ? 1 : 0;

// Global variable for tracking the currently active button.

var activeButton = null;
var activeButton2=null;
// Capture mouse clicks on the page so any active button can be deactivated.


  
if (isNS6)
  document.addEventListener("mousedown", pageMousedown, true);
else
document.onmousedown = pageMousedown;

function pageMousedown(event) {

  var className;

  // If the object clicked on was not a menu button or item, close any active
  // menu.

  
   
  if (isNS6)
    className = (event.target.className ?event.target.className : event.target.parentNode.className);
	  else
	   className = window.event.srcElement.className;

  if (className != "menuButton" && className != "menuItem" && activeButton)
   { resetButton(activeButton);

    if (activeButton2)
    resetButton2(activeButton2);
  // window.alert("test");
   }
}

function buttonClick(button, menuName) {

  // Blur focus from the link to remove that annoying outline.

  button.blur();

  // Associate the named menu to this button if not already done.
  if (!button.menu)
    button.menu = document.getElementById(menuName);

  // Reset the currently active button, if any.

  if (activeButton&& activeButton != button)
    resetButton(activeButton);
   if (activeButton2)
    resetButton2(activeButton2);
  // Toggle the button's state.

  if (button.isDepressed)
    resetButton(button);
  else
    depressButton(button);

  return false;
}

function buttonClick2(button, menuName) {

  // Blur focus from the link to remove that annoying outline.

  button.blur();

  // Associate the named menu to this button if not already done.

  if (!button.menu)
    button.menu = document.getElementById(menuName);

  // Reset the currently active button, if any.

  if (activeButton2&& activeButton2 != button)
    resetButton2(activeButton2);

  // Toggle the button's state.

  if (button.isDepressed)
    resetButton2(button);
  else
    depressButton2(button);

  return false;
}


function buttonMouseover(button, menuName) {

  // If any other button menu is active, deactivate it and activate this one.
 if (activeButton2)
    resetButton2(activeButton2);
  if (activeButton && activeButton != button) {
    resetButton(activeButton);
    if (menuName)
      buttonClick(button, menuName);
  }
}

function depressButton(button) {

  // Save current style values so they can be restored later. Only needs to be
  // done once.

  if (!button.oldBackgroundColor) {
    button.oldBackgroundColor = button.style.backgroundColor;
    button.oldBorderBottomColor = button.style.borderBottomColor;
    button.oldBorderRightColor = button.style.borderRightColor;
    button.oldBorderTopColor = button.style.borderTopColor;
    button.oldBorderLeftColor = button.style.borderLeftColor;
    button.oldColor = button.style.color;
    button.oldLeft = button.style.left;
    button.oldPosition = button.style.position;
    button.oldTop = button.style.top;
  }

  // Change style value to make the button looks like it's
  // depressed.

 // button.style.backgroundColor = "#0090b0";
  button.style.borderBottomColor = "#f0f0f0";
  button.style.borderRightColor = "#f0f0f0";
  button.style.borderTopColor = "#505050";
  button.style.borderLeftColor = "#505050";
  //button.style.color = button.menu.style.color;
  button.style.left = "1px";
  button.style.position = "relative";
  button.style.top = "1px";

  // For IE, force first menu item to the width of the parent menu, this
  // causes mouseovers work for all items even when cursor is not over the
  // link text.

  if (isIE5 && !button.menu.firstChild.style.width)
    button.menu.firstChild.style.width =
      button.menu.offsetWidth + "px";

  // Position the associated drop down menu under the button and show it. Note
  // that the position must be adjusted according to the brower type.
  menubar=document.all("menubar");
  x = getPageOffsetLeft(button);
  y = getPageOffsetTop(menubar) + menubar.offsetHeight+1;
  if (isIE5) {
    y += 2;
  }
  if (isNS6) {
    x--;
    y--;
  }
  button.menu.style.left = x + "px";
  button.menu.style.top  = y + "px";
  button.menu.style.visibility = "visible";
  hideElement2("SELECT",button.menu);
		hideElement2("OBJECT",button.menu);
  
  // Set button state and let the world know which button is active.

  button.isDepressed = true;
  activeButton = button;
}


function depressButton2(button) {

  // Save current style values so they can be restored later. Only needs to be
  // done once.

  if (!button.oldBackgroundColor) {
    button.oldBackgroundColor = button.style.backgroundColor;
    button.oldBorderBottomColor = button.style.borderBottomColor;
    button.oldBorderRightColor = button.style.borderRightColor;
    button.oldBorderTopColor = button.style.borderTopColor;
    button.oldBorderLeftColor = button.style.borderLeftColor;
    button.oldColor = button.style.color;
    button.oldLeft = button.style.left;
    button.oldPosition = button.style.position;
    button.oldTop = button.style.top;
  }

  // Change style value to make the button looks like it's
  // depressed.

 // button.style.backgroundColor = "#0090b0";
//  button.style.borderBottomColor = "#f0f0f0";
//  button.style.borderRightColor = "#f0f0f0";
//  button.style.borderTopColor = "#505050";
//  button.style.borderLeftColor = "#505050";
  //button.style.color = button.menu.style.color;
//  button.style.left = "1px";
//  button.style.position = "relative";
//  button.style.top = "1px";

  // For IE, force first menu item to the width of the parent menu, this
  // causes mouseovers work for all items even when cursor is not over the
  // link text.

  if (isIE5 && !button.menu.firstChild.style.width)
    button.menu.firstChild.style.width =
      button.menu.offsetWidth + "px";

  // Position the associated drop down menu under the button and show it. Note
  // that the position must be adjusted according to the brower type.
  menubar=document.all("menubar");
  x = getPageOffsetLeft(activeButton)+button.offsetWidth+2;
  //window.alert(button.tag);
  y = getPageOffsetTop(button) + 1;
  if (isIE5) {
    y += 2;
  }
  if (isNS6) {
    x--;
    y--;
  }
  button.menu.style.left = x + "px";
  button.menu.style.top  = y + "px";
  button.menu.style.visibility = "visible";
      // hideElement("SELECT");
	//	hideElement("OBJECT");
  
  // Set button state and let the world know which button is active.
  hideElement2("SELECT",button.menu);
		hideElement2("OBJECT",button.menu);
  button.isDepressed = true;
  activeButton2 = button;
}




function resetButton(button) {

  // Restore the button's style settings.

 // button.style.backgroundColor = button.oldBackgroundColor;
  button.style.borderBottomColor = button.oldBorderBottomColor;
  button.style.borderRightColor = button.oldBorderRightColor;
  button.style.borderTopColor = button.oldBorderTopColor;
  button.style.borderLeftColor = button.oldBorderLeftColor;
  button.style.color = button.oldColor;
  button.style.left = button.oldLeft
  button.style.position = button.oldPosition;
  button.style.top = button.oldTop;

  // Hide the button's menu.

  if (button.menu)
  {
    button.menu.style.visibility = "hidden";
	showElement("SELECT");
  showElement("OBJECT");
		}
  // Set button state and clear active menu global.

  button.isDepressed = false;
  activeButton = null;
}
function resetButton2(button) {

  // Restore the button's style settings.

 // button.style.backgroundColor = button.oldBackgroundColor;
  button.style.borderBottomColor = button.oldBorderBottomColor;
  button.style.borderRightColor = button.oldBorderRightColor;
  button.style.borderTopColor = button.oldBorderTopColor;
  button.style.borderLeftColor = button.oldBorderLeftColor;
  button.style.color = button.oldColor;
  button.style.left = button.oldLeft
  button.style.position = button.oldPosition;
  button.style.top = button.oldTop;

  // Hide the button's menu.

  if (button.menu)
  {
    button.menu.style.visibility = "hidden";
	//showElement("SELECT");
 // showElement("OBJECT");
		}
  // Set button state and clear active menu global.

  button.isDepressed = false;
  activeButton2 = null;
}
function getPageOffsetLeft(el) {

  // Return the true x coordinate of an element relative to the page.

  return el.offsetLeft +
    (el.offsetParent ? getPageOffsetLeft(el.offsetParent) : 0);
}

function getPageOffsetRight(el) {

  // Return the true x coordinate of an element relative to the page.

  return el.offsetRight;
}



function getPageOffsetTop(el) {

  return el.offsetTop +
    (el.offsetParent ? getPageOffsetTop(el.offsetParent) : 0);
}
function OutMenuItems(item)
{
	
	item.style.border="0 none black";
}

function OverMenuItems(item)
{
	if(this.sliding)
		return;		
	item.style.border="1 outset #ffffff";
}
function hideElement(elmID)
{
	for (i = 0; i < document.all.tags(elmID).length; i++)
	{
		obj = document.all.tags(elmID)[i];
		if (! obj || ! obj.offsetParent)
			continue;

		// Find the element's offsetTop and offsetLeft relative to the BODY tag.
		objLeft   = obj.offsetLeft;
		objTop    = obj.offsetTop;
		objParent = obj.offsetParent;
		while (objParent.tagName.toUpperCase() != "BODY")
		{
			objLeft  += objParent.offsetLeft;
			objTop   += objParent.offsetTop;
			objParent = objParent.offsetParent;
		}
		// Adjust the element's offsetTop relative to the dropdown menu
		// objTop = objTop - y;

		
			obj.style.visibility = "hidden";
	}
}

function showElement(elmID)
{
	for (i = 0; i < document.all.tags(elmID).length; i++)
	{
		obj = document.all.tags(elmID)[i];
		if (! obj || ! obj.offsetParent)
			continue;
		obj.style.visibility = "";
	}
}
function hideElement2(elmID,hideobj)
{
	hideLeft   = hideobj.offsetLeft;
		hideTop    = hideobj.offsetTop;
		hideParent = hideobj.offsetParent;
	while (hideParent.tagName.toUpperCase() != "BODY")
		{
			hideLeft    += hideParent.offsetLeft;
			hideTop   += hideParent.offsetTop;
			hideParent = hideParent.offsetParent;
		}
	hideRight=hideLeft+hideobj.offsetWidth;
    hideBottom=hideTop+hideobj.offsetHeight;
   // window.alert(hideLeft.toString()+"/"+hideRight.toString()+"/"+hideTop.toString()+"/"+hideBottom.toString());
	for (i = 0; i < document.all.tags(elmID).length; i++)
	{
		obj = document.all.tags(elmID)[i];
		if (! obj || ! obj.offsetParent)
			continue;

		// Find the element's offsetTop and offsetLeft relative to the BODY tag.
		objLeft   = obj.offsetLeft;
		objTop    = obj.offsetTop;
		objParent = obj.offsetParent;
		while (objParent.tagName.toUpperCase() != "BODY")
		{
			objLeft  += objParent.offsetLeft;
			objTop   += objParent.offsetTop;
			objParent = objParent.offsetParent;
		}
		// Adjust the element's offsetTop relative to the dropdown menu
		// objTop = objTop - y;

		 objRight=objLeft+obj.offsetWidth;
         objBottom=objTop+obj.offsetHeight;

		 if (hideLeft > objRight || objLeft >hideRight)
			;
		else if (objTop >hideBottom)
			;
		else if (hideTop>objBottom)
			;
		else
			obj.style.visibility = "hidden";
			
	}
}

