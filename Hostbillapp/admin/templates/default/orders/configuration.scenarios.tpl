<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='configuration/leftmenu.tpl'}
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                <div class="newhorizontalnav"  id="newshelfnav">
                    <div class="list-1">
                        <ul>
                            <li><a href="?cmd=configuration&picked_tab=0">{$lang.generalconfig}</a></li>
                            <li class="active picked"><a href="?cmd=configuration&picked_tab=1">{$lang.Ordering}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=2">{$lang.Support}</a></li>
                            <li ><a href="?cmd=configuration&picked_tab=3">{$lang.Billing}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=4">{$lang.Mail}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=5">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=6">{$lang.Other}</a></li>
                        </ul>
                    </div>
                    <div class="list-2">
                        <div class="subm1 haveitems">
                            <ul >
                                <li ><a href="?cmd=configuration&picked_tab=1"><span>{$lang.General}</span></a></li>
                                <li class="picked"><a href="?cmd=configuration&action=orderscenarios"><span>{$lang.orderscenarios}</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="nicerblu" id="ticketbody">
                    {include file='orders/configuration.scenarios.details.tpl'}
            </div>
            </div>
        </td></tr></table>