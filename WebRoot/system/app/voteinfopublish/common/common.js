


function fnSelectSJ(sjchk)
{
/*
        dW = 300;
        dH = 350;
        //pageUrl = "PublishSJ.jsp";//选择栏目
        pageUrl = "PublishSJFrame.jsp";//选择栏目
        var args = new Object();
        args["AuthorityCheck"] = document.formData.authoIds.value;	//权限的参数
        args["AuthorityName"] = document.formData.authoNames.value;		//有权限的栏目名称
        args["NowSelectId"] = document.formData.sjId.value; //现在被选中的id

    args["NowSelectValue"] = ","+document.formData.sjName.value; //现在被选中的id
        returnSet = showModalDialog(pageUrl, args ,"dialogWidth: "+dW+"px; dialogHeight: "+dH+"px; help=no; status=no; scroll=yes; resizable=no; ") ;
        if (typeof(returnSet) == "undefined" || returnSet == "")
        {
                return ;
        }else{
                sValue = returnSet.split(";");
                if(sjchk)
        {

                        var trueor02 = 0
                        sj_idvalue02=sValue[0].split(",")
                        sj_idvalue03=(sValue[1].substring(1,sValue[1].length)).split(",")
                        var sj_id=document.formData.sj_id.value;
                        sj_idvalue=sj_id.split(",")
                        var trueor=1
                        for(i=0;i<sj_idvalue02.length;i++)
                        {

                                for(j=0;j<sj_idvalue.length;j++)
                                {
                                        if(sj_idvalue02[i]==sj_idvalue[j])
                                        {
                                                trueor =0;
                                        }
                                }
                                if(trueor!=0)
                                {
                  var div_obj02=document.createElement("DIV")
                                        div_obj02.id="div"+sj_idvalue02[i]
                                        document.all.TdInfo02.appendChild(div_obj02);
                  div_obj02.innerHTML="<input type='checkbox' value='1' name='ch" + sj_idvalue02[i] + "' id='ch" + sj_idvalue02[i] + "' onclick='javascript:clickall()'>"+sj_idvalue03[i];
                                }
                                trueor =1
        }
                for(i=0;i<sj_idvalue.length;i++)
                                {
                                        var div_obj=document.getElementById("div"+sj_idvalue[i]);
                                        trueor02=0;
                                        for(j=0;j<sj_idvalue02.length;j++)
                                        {
                                                if(sj_idvalue[i]==sj_idvalue02[j])
                                                {
                                                      trueor02=1;
                                                }
                                        }
                                        if(trueor02!=1)
                                        {
                                                if(div_obj!=null)
                                                {
                                                        div_obj.removeNode(true);
                                                }
                                        }
                }
     }
        document.formData.sjName.value = sValue[1].substring(1,sValue[1].length);
        document.formData.sjId.value = sValue[0];

    }*/
}




function fnSelectSJ2(sjchk,bootid)
{

        dW = 300;
        dH = 350;
        //pageUrl = "PublishSJ.jsp";//选择栏目
        pageUrl = "PublishSJFrame11.jsp?bootid=" + bootid;//选择栏目
        var args = new Object();
        args["AuthorityCheck"] = document.formData.autho_Ids.value;	//权限的参数
        args["AuthorityName"] = document.formData.autho_Names.value;		//有权限的栏目名称
        args["NowSelectId"] = document.formData.sj_id.value; //现在被选中的id

    args["NowSelectValue"] = ","+document.formData.sjName1.value; //现在被选中的id
        returnSet = showModalDialog(pageUrl, args ,"dialogWidth: "+dW+"px; dialogHeight: "+dH+"px; help=no; status=no; scroll=yes; resizable=no; ") ;
        //alert(returnSet);
        if (typeof(returnSet) == "undefined" || returnSet == "")
        {
                return ;
        }else{
                sValue = returnSet.split(";");
                if(sjchk)
        {

                        var trueor02 = 0
                        sj_idvalue02=sValue[0].split(",")
                        sj_idvalue03=(sValue[1].substring(1,sValue[1].length)).split(",")
                        var sj_id=document.formData.sj_id.value;
                        sj_idvalue=sj_id.split(",")
                        var trueor=1
                        for(i=0;i<sj_idvalue02.length;i++)
                        {

                                for(j=0;j<sj_idvalue.length;j++)
                                {
                                        if(sj_idvalue02[i]==sj_idvalue[j])
                                        {
                                                trueor =0;
                                        }
                                }
                                if(trueor!=0)
                                {
                  var div_obj02=document.createElement("DIV")
                                        div_obj02.id="div"+sj_idvalue02[i]
                                        document.all.TdInfo02.appendChild(div_obj02);
                  div_obj02.innerHTML="<input type='checkbox' value='1' name='ch" + sj_idvalue02[i] + "' id='ch" + sj_idvalue02[i] + "' onclick='javascript:clickall()'>"+sj_idvalue03[i];
                                }
                                trueor =1
        }
                for(i=0;i<sj_idvalue.length;i++)
                                {
                                        var div_obj=document.getElementById("div"+sj_idvalue[i]);
                                        trueor02=0;
                                        for(j=0;j<sj_idvalue02.length;j++)
                                        {
                                                if(sj_idvalue[i]==sj_idvalue02[j])
                                                {
                                                        trueor02=1;
                                                }
                                        }
                                        if(trueor02!=1)
                                        {
                                                if(div_obj!=null)
                                                {
                                                        div_obj.removeNode(true);
                                                }
                                        }
                }
     }

        document.formData.sjName1.value = sValue[1];
        document.formData.sj_id.value = sValue[0];
        document.formData.submit();

    }
}

function fnSelectSJ1(sjchk,bootid)
{

        dW = 300;
        dH = 350;
        //pageUrl = "PublishSJ.jsp";//选择栏目
        pageUrl = "PublishSJFrame11.jsp?bootid=" + bootid;//选择栏目
        var args = new Object();
        args["AuthorityCheck"] = document.formData.autho_Ids.value;	//权限的参数
        args["AuthorityName"] = document.formData.autho_Names.value;		//有权限的栏目名称
        args["NowSelectId"] = document.formData.sj_id.value; //现在被选中的id

    args["NowSelectValue"] = ","+document.formData.sjName1.value; //现在被选中的id
        returnSet = showModalDialog(pageUrl, args ,"dialogWidth: "+dW+"px; dialogHeight: "+dH+"px; help=no; status=no; scroll=yes; resizable=no; ") ;
        //alert(returnSet);
        if (typeof(returnSet) == "undefined" || returnSet == "")
        {
                return ;
        }else{
                sValue = returnSet.split(";");
                if(sjchk)
        {

                        var trueor02 = 0
                        sj_idvalue02=sValue[0].split(",")
                        sj_idvalue03=(sValue[1].substring(1,sValue[1].length)).split(",")
                        var sj_id=document.formData.sj_id.value;
                        sj_idvalue=sj_id.split(",")
                        var trueor=1
                        for(i=0;i<sj_idvalue02.length;i++)
                        {

                                for(j=0;j<sj_idvalue.length;j++)
                                {
                                        if(sj_idvalue02[i]==sj_idvalue[j])
                                        {
                                                trueor =0;
                                        }
                                }
                                if(trueor!=0)
                                {
                  var div_obj02=document.createElement("DIV")
                                        div_obj02.id="div"+sj_idvalue02[i]
                                        document.all.TdInfo02.appendChild(div_obj02);
                  div_obj02.innerHTML="<input type='checkbox' value='1' name='ch" + sj_idvalue02[i] + "' id='ch" + sj_idvalue02[i] + "' onclick='javascript:clickall()'>"+sj_idvalue03[i];
                                }
                                trueor =1
        }
                for(i=0;i<sj_idvalue.length;i++)
                                {
                                        var div_obj=document.getElementById("div"+sj_idvalue[i]);
                                        trueor02=0;
                                        for(j=0;j<sj_idvalue02.length;j++)
                                        {
                                                if(sj_idvalue[i]==sj_idvalue02[j])
                                                {
                                                        trueor02=1;
                                                }
                                        }
                                        if(trueor02!=1)
                                        {
                                                if(div_obj!=null)
                                                {
                                                        div_obj.removeNode(true);
                                                }
                                        }
                }
     }

        document.formData.sjName1.value = sValue[1];
        document.formData.sj_id.value = sValue[0];
        //document.formData.submit();

    }
}







function checkform()
{
        /**
        status:

        1 -- 新增

        */
        var form = document.formData ;
        form.CT_content.value=eWebEditor1.getHTML();


        if(form.ct_title.value =="")
        {
                alert("请填写主题!");
                form.ctTitle.focus();
                return false;
        }

        //GetDatademo();
  //form.action = "publishResult.jsp";
  //form.target = "_self";
  form.submit();
}

function showCal(obj)
{
        if (!obj) var obj = event.srcElement;
        var obDate;
        if ( obj.value == "" ) {
                obDate = new Date();
        } else {
                var obList = obj.value.split( "-" );
                obDate = new Date( obList[0], obList[1]-1, obList[2] );
        }

        var retVal = showModalDialog( "/system/common/calendar/calendar.htm", obDate,
                "dialogWidth=206px; dialogHeight=206px; help=no; scroll=no; status=no; " );

        if ( typeof(retVal) != "undefined" ) {
                var year = retVal.getFullYear();
                var month = retVal.getMonth()+1;
                var day = retVal.getDate();
                obj.value =year + "-" + month + "-" + day;
        }
}