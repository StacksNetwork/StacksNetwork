<script type="text/javascript">
loadelements.services=true;
</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.productsandservices}</h3></td>
    <td></td>
  </tr>
  <tr>
    <td class="leftNav">

	<a href="?cmd=services&action=addcategory"  class="tstyled {if $action=='addcategory'}selected{/if}"  >{$lang.addneworpage}</a> <br />


	
	<a href="?cmd=services"  class="tstyled {if $action=='default' || $action=='category'  || $action=='editcategory' || $action=='product'}selected{/if} defclass">{$lang.orpages}</a>

<a href="?cmd=productaddons"  class="tstyled">{$lang.manageaddons}</a>
	  </td>
    <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">
       	{include file='ajax.services.tpl'}
	   
	   </div></td>
  </tr>
</table>

