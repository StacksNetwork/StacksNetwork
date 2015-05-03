<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HostBill - {$business_name} </title>
<link href="{$template_dir}_style.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js"></script>
<style>{literal}
a {
 	font-weight:bold;
	color:#699ccb;
	text-decoration:none;
}
a:hover {
	text-decoration:underline;
	color:#a1c4e1;
}
small {
	font-size:11px;
}

.foc2 {
	border: solid 1px #dddddd;
	padding:4px 4px;
	width:320px;
}
.foc2:hover, .foc2:focus {
	border: solid 1px #6694e3;
	color:#666666;
}
html, body {
	height:100%;
	min-height:100%;
	position:relative;
	line-height:20px;
	font-size:11px;
	font-family:Tahoma,Arial !important;
}{/literal}
</style>
</head>

<body style="" onload="$('#username').focus();">


<div style="width:370px;margin:0px auto;position:relative;height:100%;padding:0px;min-height:100%">
<div style="width:370px;position:absolute;top:50%;margin-top:-230px;"><img src="{$template_dir}img/hb_logo.gif" style="margin-bottom:10px;" />
	<div style="border:3px solid #85a8c8; padding:2px;margin-bottom:4px;background:#ffffff;">

		<div>






		<div class="lighterblue" style="padding:15px;font-size:11px;">
		Provide your One Time Password:
                </div>
			<div style="padding:15px;">
	<form name="loginform" action="?cmd=onetimepasswords&action=verify" method="post">
<input name="make" value="login" type="hidden"/>
{securitytoken}
			<table border="0" width="100%" cellpadding="0" cellspacing="0">

				{if $error}
				<tr><td colspan="2" style="border:1px solid #DDDDDD;background:#FFFFDF;font-size:11px;padding:10px;">
				{foreach from=$error item=blad}
					<span class="error">{$blad}<br /></span>
				{/foreach}
				</td></tr>
				{/if}

				
				<tr>
				<td colspan="2">One Time Password:</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-bottom:10px;"><input name="otp"  class="foc2" id='username'/></td>
				</tr>
				

				<tr>
				<td width="50%"  align="left"></td>
				<td width="50%" align="right"><input type="submit" value="Login" style="padding:3px 6px;font-weight:bold"/></td>
				</tr>
			</table></form></div>

		</div>

	</div>
	<div style="text-align:right;"><small>Powered by <a href="http://hostbillapp.com" target="_blank" >HostBill</a></small></div>
</div>
</div>




</body>
</html>