{*
 * NOC-PS Hostbill module
 * Console template
 *
 * Copyright (C) Maxnet 2013-2014
 *
 * May be distributed under the terms of the LGPL license.
 * In plain English: feel free to use and modify this file to fit your needs,
 * however do NOT ioncube encode it.
 * The source code must be available to anyone you distribute this module to.
 *}

<div class="wbox"><div class="wbox_header">控制台</div><div class="wbox_content">

{if $errormsg}
<b>{$errormsg}</b>
{else}

<form name="ajaxform" method="post" action="" onsubmit="this.elements['submit'].disabled=true"{if $consoletype == 'html5'} target="_blank"{/if}>
    <input type="hidden" name="nps_nonce" value="{$nonce}">
    <input type="hidden" name="action" value="getconsoleurl">
    
{if $powered_off}
        <input type="checkbox" name="powerup" checked> 启动服务器<br>
{/if}
{if $ask_ipmi_password}
        IPMI密码: <input type="password" name="ipmipassword"><br>
{/if}
    <input type="submit" name="submit" value="启动控制台">
</form>

{if $consoletype == 'html5'}

按下 '启动控制台' 按钮在新窗口中打开控制台.<br>
控制台的功能需要一个比较新的浏览器, 如Firefox或谷歌浏览器等, 需要支持HTML 5画布和WebSockets.<br>
另外SSL证书必须已安装在您的Noc-PS管理服务器提供商.

{else}

按下 '启动控制台' 按钮打开控制台.<br>
控制台功能使用Java WebStart技术需要在您的计算机上安装Java.<br>
如果您访问控制台有问题, 请尝试重置BMC.<br><br>

<form method="post" action="" onsubmit="this.elements['submit'].disabled=true">
    <input type="hidden" name="nps_nonce" value="{$nonce}">
    <input type="hidden" name="resetbmc" value="1">
    
{if $ask_ipmi_password}
    IPMI密码: <input type="password" name="ipmipassword"><br>
{/if}
    <input type="submit" name="submit" value="重启BMC">
</form>
{/if}
{/if}

</div>
</div>