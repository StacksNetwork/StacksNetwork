{*
 * NOC-PS Hostbill module
 * Power management template
 *
 * Copyright (C) Maxnet 2010-2012
 *
 * You are free to modify this module to fit your needs
 * However be aware that you need a NOC-PS license to actually provision servers
 *}

<div class="wbox"><div class="wbox_header">电源管理</div><div class="wbox_content">

{if $errormsg}
<p>
  <b>错误:</b> {$errormsg}
</p>
{elseif !$ip}
您的订单中未包含服务器!
{else}

<form name="ajaxform" method="post" action="" onsubmit="this.elements['performbutton'].disabled=true">
  <input type="hidden" name="nps_nonce" value="{$nonce}" />

  <table width="100%" cellpadding="10" cellspacing="10">
          <tr>
            <td width="150" class="fieldarea">主服务器IP地址</td>
            <td>{$ip}</td>
          </tr>

		  {if $result}
		  <tr>
			<td width="150" class="fieldarea"><b>最后一次操作内容</b></td>
		    <td><font color="green">{$result|escape}</font></td>
		  </tr>
		  {/if}

          <tr>
            <td width="150" class="fieldarea">电源状态</td>
            <td>{$status|escape}</td>
          </tr>
		  
{if $ask_ipmi_password}
          <tr>
            <td width="150" class="fieldarea">您服务器的IPMI密码</td>
            <td><input type="password" name="ipmipassword" style="width: 350px;"></td>
          </tr>
{/if}
          <tr>
            <td width="150" class="fieldarea">电源操作</td>
            <td>
{if $supportsOn}			  
			  <input type="radio" name="poweraction" value="on"> 打开电源<br>
{/if}{if $supportsOff}			  
			  <input type="radio" name="poweraction" value="off"> 关闭电源<br>
{/if}{if $supportsReset}			  
			  <input type="radio" name="poweraction" value="reset" checked="true"> 重启<br>
{/if}{if $supportsCycle}			  
			  <input type="radio" name="poweraction" value="cycle" {if !$supportsReset}checked="true"{/if}> 挂起<br>
{/if}{if $supportsCtrlAltDel}
			  <input type="radio" name="poweraction" value="ctrlaltdel"> 发送CTRL-ALT-DEL<br>
{/if}
			</td>
          </tr>

		  <tr>
			<td>&nbsp;
			<td><input type="submit" name="performbutton" value="执行操作">
		  </tr>
  </table>
</form>
{/if}

</div></div></div>