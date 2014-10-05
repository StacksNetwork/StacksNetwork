<table border="0" cellpadding="2" cellspacing="0" >
 <tr>
     <td><a href="?cmd=accounts&list={$currentlist}"><strong>&laquo; {$lang.backto} {$lang.accounts}</strong></a>&nbsp;</td>
     <td class="menubar">
         <a class="menuitm"   href="#" onclick="$('#formsubmiter').click();return false" ><span ><strong>{$lang.savechanges}</strong></span></a>
         
         {if !$forbidAccess.deleteServices}
             <a class=" menuitm menuf" href="#" onclick="confirm1();return false;"><span style="color:#FF0000">{$lang.Delete}</span></a>{*
         *}{/if}{*
         *}<a class="setStatus menuitm menu{if !$forbidAccess.deleteServices}l{/if}" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
     </td>
     <td><input type="checkbox" name="manual" value="1" {if $details.manual == '1'}checked="checked" {/if}  class="changeMode" style="display:none;"/> </td>
 </tr>
</table><div id="confirm_ord_delete" style="display:none" class="confirm_container">

	<div class="confirm_box">
		<h3>{$lang.accdelheading}</h3>
		{$lang.accdeldescr}<br />
<br />


		<input type="radio" checked="checked" name="cc_" value="1" id="cc_hard"/> {$lang.deleteopt1}<br />
		<input type="radio"  name="cc_" value="0" id="cc_soft"/> {$lang.deleteopt2}<br />


		<br />
		<center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="return confirmsubmit2()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="return cancelsubmit2()"/></center>

	</div>

</div>
<script type="text/javascript">
 {literal}
 function autosus(el) {
 	if($(el).is(':checked')) {
		$('#autosuspend_date').show();
	} else {
		$('#autosuspend_date').hide();
	}
 }
 function confirm1() {
 $('#bodycont').css('position','relative');
             $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
			 return false;
}
function confirmsubmit2() {
var add='';
if($('#cc_hard').is(':checked'))
	add='&harddelete=true';
	window.location.href='?cmd=accounts&make=delete&action=edit&id='+$('#account_id').val()+add+'&security_token='+$('input[name=security_token]').val();
	return false;
}
function cancelsubmit2() {
	$('#confirm_ord_delete').hide().parent().css('position','inherit');
	return false;
}
 function new_gateway(elem) {
    if($(elem).val() == 'new') {
        window.location = "?cmd=managemodules&action=payment";
        $(elem).val(($("select[name='"+$(elem).attr('name')+"'] option:first").val()));
    }
 }
         function checkup() {
             if(!$('.changeMode').eq(0).is(':checked') && $('#product_id').eq(0).val()!={/literal}{$details.product_id}{literal} && $('select[name=status]').eq(0).val()!='Pending' && $('select[name=status]').eq(0).val()!='Terminated'  ) {
                 return confirm('{/literal}{$lang.upgrconf}{literal}');
             }
             return true;
         }
         function sh1xa(el,id) {
             if($(el).eq(0).val()==id) {
                 $('#upgrade_opt').hide();
             } else {
                 $('#upgrade_opt').show();
             }
         }

 {/literal}
 </script>