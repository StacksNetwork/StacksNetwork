<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HostBill - {$business_name} </title>
<link href="{$template_dir}_style.css" rel="stylesheet" media="all" />
<script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js?v={$hb_version}"></script>
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
		
		
{if $banned}

<span class="error">{$lang.youripbanned} ({$banned}). {$lang.trylater}</span>
{elseif $action=="passforgotten"}
<div class="lighterblue" style="padding:15px;font-size:11px;">
    {if $reminder_sent}
        <strong>{$lang.resetpass_sent}</strong>
    {elseif $already_reset}
        <strong>{$lang.resetpass_alreadysent}</strong> <br /> {$lang.resetpass_alreadysent2}
	
    {else}

    {if $wrong_email}<div  style="border:1px solid #DDDDDD;background:#FFFFDF;font-size:11px;padding:10px;"><span class="error">{$lang.resetpass_wrongemail}</span></div>{/if}
    <form action="" method="post">
        <table border="0" width="100%" cellpadding="2" cellspacing="2">
        <tr><td>{$lang.resetpass_enteremail}:</td></tr>
        <tr><td><input name="emailaddr"  class="foc2"/></td></tr>
        <tr><td align="center"><input type="submit" style="font-weight: bold" value="{$lang.ResetPassword}" /></td></tr>
        </table>
    </form>
    {/if}
</div>
    <div class="blu"><a href="index.php">&laquo; {$lang.LoginReturn}</a></div>
{else}



		
		
		<div class="lighterblue" style="padding:15px;font-size:11px;">
		{if $licenseerror}
		{if $licenseproblem=='1'}
						{$lang.licenseproblem1}
                                               
					{elseif $licenseproblem=='2'}
						{$lang.licenseproblem2}
						
					{elseif $licenseproblem=='3'}
						{$lang.licenseproblem3}
						
					
					
					{/if}
                    {if $licenselog}{$licenselog}{/if}
		{else}
		{$lang.welcomelog}
		{if $reset_ok}
        <br/><strong>{$lang.reset_ok}</strong> {/if}
		{/if}</div>
			<div style="padding:15px;">
	{if !$licenseerror}	<form name="loginform" action="" method="post">
<input name="action" value="login" type="hidden"/>
{/if}
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
			
				{if $error}
				<tr><td colspan="2" style="border:1px solid #DDDDDD;background:#FFFFDF;font-size:11px;padding:10px;">
				{foreach from=$error item=blad}
					<span class="error">{$blad}<br /></span>
				{/foreach}
				</td></tr>
				{/if}
				
				{if $licenseerror}
				
				
				<tr><td colspan="2">
					{if $licenseproblem=='1'}
						
                                                {$lang.enteractivationcode}
						<form  action="" method="post">
					<input name="action" value="activate" type="hidden"/>
						<textarea style="width:98%;margin:5px 0px;height:60px;" name="activate"></textarea>
						<center><input type="submit" value="Activate"/></center>
						</form>
										
					{/if}

				
				</td></tr>
				
				
				{else}
				<tr>
				<td colspan="2">{$lang.Username}:</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-bottom:10px;"><input name="username" value="{$submit.login_email}" class="foc2" id='username'/></td>
				</tr>
				<tr>
					<td colspan="2">{$lang.Password}:</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-bottom:10px;"><input name="password"  class="foc2" type="password"/> </td>
				</tr>
				
				<tr>
					<td colspan="2">{$lang.Language}:</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-bottom:10px;">
						<select name="language" class="foc2" style="width:330px">
						{foreach from=$languages item=langx}{if $langx=='english'}<option value="{$langx}">{$langx|capitalize}</option>{/if}{/foreach}
						{foreach from=$languages item=langx}{if $langx!='english'}<option value="{$langx}">{$langx|capitalize}</option>{/if}{/foreach}
						
						</select>
					</td>
				</tr>
				
				<tr>
				<td width="50%"  align="left"><input name="rememberme" value="1" type="checkbox"/>{$lang.rememberme}</td>
				<td width="50%" align="right"><input type="submit" value="{$lang.Login}" style="padding:3px 6px;font-weight:bold"/></td>
				</tr>
				{/if}
			</table>
			{if !$licenseerror}</form>{/if}</div>
			<div class="lighterblue" style="padding:15px;font-size:11px;">
			{if !$licenseerror}
			<a href="?action=passforgotten">{$lang.passforgotten}</a><br />
			{$lang.currip} <strong>{$ip}</strong>
			{else}
				<a href="index.php?licenseerror">{$lang.clicktocheck}</a>
				{/if}
			</div>
		
{/if}	
			
		</div>
		
	</div>
	<div style="text-align:right;"><small>Powered by <a href="http://hostbillapp.com" target="_blank" >HostBill</a></small></div>
</div>
</div>




</body>
</html>