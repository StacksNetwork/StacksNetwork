<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <link href="{$template_dir}css/appsheader.css?v={$hb_version}" rel="stylesheet" media="all" />
    </head>

    <body class="{$language} skin-blue">

    <div id="hbheader">
        <div id="topbar">
            <div class="left">



            </div>
            <div class="right">
                {$lang.loggedas}: <strong>{$admindata.username}</strong>  | <a href="{$system_url}">{$lang.clientarea}</a> | <a href="{$admin_url}?action=myaccount">{$lang.myaccount}</a> | <a href="{$admin_url}?cmd=configuration">{$lang.Configuration}</a> |  <a href="{$admin_url}?action=logout">{$lang.Logout}</a></div>
            <div class="clear"></div>
           
        </div>


        <div id="body-content">
            <table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:10px;" width="100%">
                <tr>
                    <td class="logoLeftNav"><a href="index.php"><img src="{$template_dir}img/hb_logo.gif" /></a></td>
                    <td valign="middle" style="background:#354a5f;">
                        <div class="menushelf" id="menushelf">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td style="width:832px;">
                                        <ul class="mainer" id="mmcontainer" style="height:34px;overflow:hidden">
                                            <li class="home"><a href="{$admin_url}" >
                                                    <span class="second home">{$lang.Home}</span>

                                                </a>
                                            </li>

                                            <li class="clients"><a class="mainmenu" href="{$admin_url}?cmd=clients">
                                                    <span class="second clients">{$lang.Clients}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="support"><a class="mainmenu" href="{$admin_url}?cmd=tickets">
                                                    <span class="second support">{$lang.Support}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="payments"><a class="mainmenu" href="{$admin_url}?cmd=invoices">
                                                    <span class="second payments">{$lang.Payments}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="orders"><a class="mainmenu" href="{$admin_url}?cmd=orders">
                                                    <span class="second orders">{$lang.ordersandaccounts}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>

                                            <li class="configuration"><a class="mainmenu" href="{$admin_url}?cmd=configuration">
                                                    <span class="second configuration">{$lang.Configuration}</span>
                                                    <span class="fourth"></span>
                                                </a> </li>


                                            <li class="configuration"><a class="mainmenu" href="{$admin_url}/apps">
                                                    <span class="second configuration" style="color:gold">Apps &raquo;</span>
                                                </a> </li>

                                            {if $appconfig.name}
                                            <li class="configuration"><a class="mainmenu" href="{$admin_url}/apps/{$appid}">
                                                    <span class="second configuration" style="color:gold">{$appconfig.name}</span>
                                                </a> </li>
                                            {/if}
                                        </ul>
                                                  
                                    </td>
                                    <td  valign="middle" align="right">

                                    </td>
                                </tr>
                            </table>


                        </div>
                    </td>
                </tr>
            </table>
</div>

</div>