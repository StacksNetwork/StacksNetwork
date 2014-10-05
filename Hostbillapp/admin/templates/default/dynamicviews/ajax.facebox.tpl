<div id="formcontainer">
     <div id="formloader" >
<form method="post" action="{$formaction}" id="submitform" enctype="multipart/form-data">

	
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            {if count($tabsinfo)>1}
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    {foreach from=$tabsinfo item=tab key=tabname}
                        <a class="tchoice" href="#">{if $lang.$tabname}{$lang.$tabname}{else}{$tabname}{/if}</a>
                    {/foreach}
                 </div>
            </td>
            {/if}
            <td class="conv_content form"  valign="top">
                {foreach from=$tabsinfo item=tab key=tabname name=loopx}
               <div class="tabb" {if !$smarty.foreach.loopx.first}style="display:none"{/if}>
                   {if $parsedtabs.$tabname}{$tab}{else}{include file=$tab}{/if}
                   
               </div>
               {/foreach}
                  

		
            </td>
        </tr>
    </table>
   {securitytoken}</form> </div>
   <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            {if $formaction}<span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return saveFaceboxForm()"><span>{$lang.submit}</span></a></span>
            <span class="dhidden" >{$lang.Or}</span>{/if}
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


        </div>
        <div class="clear"></div>
    </div>
</div>
            {literal}
<script type="text/javascript">
    function saveFaceboxForm() {
            $('#formcontainer .spinner').show();
                if(typeof(onFaceboxSubmit)=='function') {
                  var ret =onFaceboxSubmit();
                      if(ret) {
                            $('#submitform').submit();
                       }
                } else {
                            $('#submitform').submit();
                }
                return false;
        }
      $('#formcontainer .haspicker').datePicker({
        startDate: startDate
    });
$('#lefthandmenu').TabbedMenu({elem:'.tabb'});
    </script>{/literal}
    