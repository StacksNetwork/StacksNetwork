<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/pjax.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/ZeroClipboard.min.js?v={$hb_version}"></script>
        <script type="text/javascript">
            var lang=[];
            lang['edit']="{$lang.Edit}";
            {literal}  ZeroClipboard.config( { moviePath: 'templates/default/js/ZeroClipboard.swf' } ); {/literal}
        </script>
        <script type="text/javascript" src="{$template_dir}js/jquery.highlight.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/packed.js?v={$hb_version}"></script>
        <script type="text/javascript">Date.format = '{$js_date}';startDate='{$js_start}';</script>
        <script type="text/javascript">var ts=new Date();var ss=ts.getMinutes();if(ss<10)ss="0"+ss;var s=ts.getHours().toString()+':'+ss;</script>
        <link href="{$template_dir}_style.css?v={$hb_version}" rel="stylesheet" media="all" />
        {adminheader}

    </head>

    <body class="{$language}">

        <div id="topbar">
            <div class="left">


                <div id="taskMGR">

                    <div class="toper">
                        <span class="small-load" style="display:none;"></span>
                        <span class="progress" id="pb1" style="display:none;"></span>
                        <div id="numerrors"  style="display:none;">0</div>
                        <div id="numinfos"  style="display:none;">0</div>
                    </div>
                    <a class="showlog right" href="#">{$lang.showlog}</a>
                    <div id="outer">

                        <ul id="iner">
		{foreach from=$error item=blad}
                            <li class="error visible"><script type="text/javascript"> document.write(s);</script> {$blad}</li>
		{/foreach}
		{foreach from=$info item=infos}
                            <li class="info visible"><script type="text/javascript"> document.write(s);</script> {$infos}</li>
                            {/foreach}
                        </ul>
                    </div>

                </div>

            </div>
            <div class="right">
                 <span id="loadtwitter" class="shownice"></span>   |
                {$lang.loggedas}: <strong>{$admindata.username}</strong>  | <a href="{$system_url}">{$lang.clientarea}</a> | <a href="?action=myaccount">{$lang.myaccount}</a> | <a href="?cmd=configuration">{$lang.Configuration}</a> |  <a href="?action=logout">{$lang.Logout}</a></div>
            <div class="clear"></div>
           
        </div>


        <div id="body-content">
            <table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:10px;" width="100%">
                <tr>
                    <td class="logoLeftNav"><a href="index.php"><img src="{$template_dir}img/hb_logo.gif" /></a></td>
                    <td valign="middle" style="border: solid 1px #b5b5b5;background:#e5e5e5;">
                        <div class="menushelf" id="menushelf">
                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                <tr>


                                    <td>
                                        <ul class="mainer" id="mmcontainer">

                                            <li class="home"><a href="index.php" >
                                                    <span class="second home">{$lang.Home}</span>

                                                </a>
                                            </li>

                                            <li class="clients"><a class="mainmenu" href="?cmd=clients">
                                                    <span class="second clients">{$lang.Clients}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="support"><a class="mainmenu" href="?cmd=tickets">
                                                    <span class="second support">{$lang.Support}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="payments"><a class="mainmenu" href="?cmd=invoices">
                                                    <span class="second payments">{$lang.Payments}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="orders"><a class="mainmenu" href="?cmd=orders">
                                                    <span class="second orders">{$lang.ordersandaccounts}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="configuration"><a class="mainmenu" href="?cmd=configuration">
                                                    <span class="second configuration">{$lang.Configuration}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="extras"><a class="mainmenu" href="?cmd=managemodules">
                                                    <span class="second extras">{$lang.Extras}</span>
                                                    <span class="fourth"></span>
                                                </a></li>
                                        </ul>
                                    </td>
                                    <td {if $language=='arabic'}align="left"{else}align="right"{/if} valign="middle" >
                                        <div style="position:relative" id="search_form_container" class="search_form_container">
                                            <small title="You can use &quot; * &quot; in search query as a wildcard" style="cursor: help;">
                                                {$lang.smartsearch} 
                                                <img src="{$template_dir}img/question-small-white.png" style="vertical-align: middle"/>
                                            </small>
                                            <input name="query" class="foc"  style="padding:2px;width:250px;" id="smarts" autocomplete="off"/>
                                            <a href="#" id="search_submiter" class="search_submiter"></a>
                                        </div>

                                        <div id="smartres" class="smartres" style="display:none"><ul id="smartres-results" class="smartres-results" ></ul></div>
                                    </td>
                                </tr>
                            </table>



                            <ul class="submenu">
                                <li ><a href="?cmd=clients">{$lang.manageclients}</a></li>
                                <li ><a href="?cmd=newclient">{$lang.registernewclient}</a></li>
                                <li ><a href="?cmd=sendmessage">{$lang.SendMessage}</a></li>
                                <li ><a href="?cmd=affiliates">{$lang.Affiliates}</a></li>
                                <li ><a href="?cmd=clients&action=fields">{$lang.customerfields}</a></li>
                                {foreach from=$HBaddons.clients_menu item=ad}
                                <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                {/foreach}
                            </ul>

                            <ul class="submenu">
                                {if $enableFeatures.support}
                                    <li ><a href="?cmd=tickets">{$lang.supptickets}</a></li>
                                {/if}
                                {if $enableFeatures.chatmodule=='on'}
                                    <li ><a href="?cmd=hbchat">{$lang.LiveChat}</a></li>
                                {/if}
                                <li ><a href="?cmd=annoucements">{$lang.News}</a></li>
                                <li ><a href="?cmd=knowledgebase">{$lang.Knowledgebase}</a></li>
                                {if $enableFeatures.support}
                                    <li ><a href="?cmd=ticketdepts">{$lang.ticketdepts}</a></li>
                                    <li ><a href="?cmd=predefinied">{$lang.ticketmacros}</a></li>
                                {/if}
                                <li ><a href="?cmd=editadmins">{$lang.Administrators}</a></li>
                                {foreach from=$HBaddons.support_menu item=ad}
                                    <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                {/foreach}
                            </ul>
                            <ul class="submenu">
                                <li ><a href="?cmd=invoices">{$lang.Invoices}</a></li>
                                <li ><a href="?cmd=invoices&list=recurring">{$lang.Recurringinvoices}</a></li>

                                <li ><a href="?cmd=estimates">{$lang.Estimates}</a></li>
                                <li><a href="?cmd=transactions">{$lang.Transactions}</a></li>
                                <li><a href="?cmd=gtwlog">{$lang.Gatewaylog}</a></li>
                                {foreach from=$HBaddons.payment_menu item=ad}
                                <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                {/foreach}
                            </ul>
                            <ul class="submenu">
                                <li ><a href="?cmd=orders">{$lang.Orders}</a></li>
                                <li ><a href="?cmd=accounts">{$lang.Accounts}</a>
                                    {if $HBaddons.orders_accounts}
                                    <ul>
	{foreach from=$HBaddons.orders_accounts item=ad}
	{assign var="descr" value="_hosting"}
	{assign var="baz" value="$ad$descr"}
                                        <li><a href="?cmd=accounts&list={$ad}" >{if $lang.$baz}{$lang.$baz}{else}{$ad}{/if}</a></li>
	{/foreach}
                                    </ul>
                                    {/if}
                                </li>
                                <li ><a href="?cmd=domains">{$lang.Domains}</a></li>
                                {foreach from=$HBaddons.orders_menu item=ad}
                                <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                {/foreach}
                            </ul>
                            <ul class="submenu">
                                <li ><a href="?cmd=configuration">{$lang.generalconfig}</a></li>
                                <li ><a href="?cmd=managemodules">{$lang.Modules}</a></li>
                                <li ><a href="?cmd=services">{$lang.productsandservices}</a></li>
                                <li ><a href="?cmd=productaddons">{$lang.productaddons}</a></li>
                                <li ><a href="?cmd=emailtemplates">{$lang.emailtemplates}</a></li>
                                <li ><a href="?cmd=security">{$lang.securitysettings}</a></li>
                                <li ><a href="?cmd=servers">{$lang.manapps}</a></li>
                            </ul>
                            <ul class="submenu">

                                <li ><a href="?cmd=managemodules&action=other">{$lang.Plugins}</a></li>
                                <li ><a href="?cmd=stats">{$lang.systemstatistics}</a></li>
                                <li ><a href="?cmd=logs">{$lang.systemlogs}</a></li>
                                <li ><a href="?cmd=notifications">{$lang.Notifications}</a></li>
                                <li ><a href="?cmd=importaccounts">{$lang.impaccounts}</a></li>
                                <li ><a href="?cmd=infopages">{$lang.infopages}</a></li>
                                <li ><a href="?cmd=coupons">{$lang.promocodes}</a></li>
                                <li ><a href="?cmd=downloads">{$lang.Downloads}</a></li>
                                {foreach from=$HBaddons.extras_menu item=ad}
                                <li ><a href="?cmd=module&module={$ad.id}">{$ad.name}</a></li>
                                {/foreach}
                            </ul>
                            <script type="text/javascript"> {literal}setTimeout(function(){$('.mainmenu','#mmcontainer').HoverMenu();},2);{/literal}</script>
                        </div>
                    </td>
                </tr>
            </table>

 <script>{literal}
                    $(document).ready(function(){
                        $.getJSON('?cmd=root&action=latesttweets',function(data){
                           if(data[0]) {
                             $('#loadtwitter').html("Latest news: " + data[0]);  
                           }
                        });
                    });
            {/literal}
                
            </script>