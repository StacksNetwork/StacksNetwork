<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.Administrators}</h3></td>
    <td></td>
  </tr>
  <tr>
    <td class="leftNav">
	<a href="?cmd=editadmins&action=addadministrator"  class="tstyled {if $action=='addadministrator'}selected{/if}"><strong>{$lang.addadmin}</strong></a><br />
	

	<a href="?cmd=editadmins"  class="tstyled {if $action=='default' || $action=='administrator'}selected{/if}">{$lang.Administrators}</a>
	<a href="?action=myaccount"  class="tstyled {if $action=='myaccount'}selected{/if}">{$lang.myaccount}</a> 
	
	<br />

	
	

	



	  </td>
    <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">
       	{include file='ajax.editadmins.tpl'}
	   
	   </div></td>
  </tr>
</table>

