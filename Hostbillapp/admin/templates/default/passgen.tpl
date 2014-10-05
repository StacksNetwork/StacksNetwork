<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
	<tr>
		<td>
			<h3>{$lang.securitysettings}</h3>
		</td>
		<td>

		</td>
	</tr>
	<tr>
		<td class="leftNav">
			<a href="?cmd=configuration"  class="tstyled">{$lang.generalsettings}</a>
			<a href="?cmd=configuration&action=cron"  class="tstyled">{$lang.cronprofiles}</a>
			<!--<a href="?cmd=configuration&action=currency"  class="tstyled">{$lang.currencysettings}</a>-->
			<a href="?cmd=tldprices"  class="tstyled">{$lang.domainpricingandsett}</a>
			<a href="?cmd=security"  class="tstyled  {if $action == 'default'}selected{/if}">{$lang.securitysettings}</a>
			<a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a> 
		</td>
		<td  valign="top"  class="bordered">
			<div id="bodycont" style="">
				<input type="text" id="pass_in" />
				<button onclick="genPassword()">Generate Password</button><br />
				<span>Advenced</span>
				Lenght:<input type="text" id="pass_len" maxlength="3" size="3"/>
				<div id="pass_adv">
					<div class="left">
						<span class="clear">Aplha Characters</span><br />
						<span>Lowercase (abc)</span><input type="checkbox" name="lower" value="1" checked="checked" /><br />
						<span>Uppercase (ABC)</span><input type="checkbox" name="upper" value="1" checked="checked" />
					</div>
					<div class="left">
						<span>Non-Aplha Characters</span><br />
						<span>Numbers ($%@)</span><input type="checkbox" name="numbers" value="1" checked="checked" /><br />
						<span>Symbols (123)</span><input type="checkbox" name="symbols" value="1" checked="checked" />
					</div>
					<div class="clear"></div>
					{literal}
					<style type="text/css">

					</style>
					<script type="text/javascript">
						$(document).ready(function(){
							$('#pass_adv input[type="checkbox"]').each(function(x){
								$(this).change(function(){
									if($('#pass_adv input[type="checkbox"]:checked').length < 1)
										$('#pass_adv input[type="checkbox"]').eq(0).attr('checked','checked');
								});
							});
						});
						function genPassword() {
							var length= $('#pass_len').val() != '' ? parseInt($('#pass_len').val()): 8;
							var rs = '';
							var sPassword = '';							
							if($('#pass_adv input[name="numbers"]').attr('checked')) rs = rs+'!@#$%^&*():;[]{}/`';
							if($('#pass_adv input[name="symbols"]').attr('checked')) rs = rs+'1234567890';
							if($('#pass_adv input[name="upper"]').attr('checked')) rs = rs+'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
							if($('#pass_adv input[name="lower"]').attr('checked') || rs.length == 0) rs = rs+'abcdefghijklmnopqrstuvwxyz';
							for (i=0; i < length; i++) {
								sPassword = sPassword + rs.charAt(Math.floor(Math.random()*rs.length));
							}
							$('#pass_in').val(sPassword);
						}
					</script> 
					{/literal}
				<div>
			</div>
		</td>
	</tr>
</table>