<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration"  class="tstyled selected">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled">{$lang.cronprofiles}</a>
            <a href="?cmd=security"  class="tstyled">{$lang.securitysettings}</a>
            <a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a>
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                <div class="newhorizontalnav"  id="newshelfnav">
                    <div class="list-1">
                        <ul>
                            <li><a href="?cmd=configuration&picked_tab=0">{$lang.generalconfig}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=1">{$lang.Ordering}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=2">{$lang.Support}</a></li>
                            <li class="active picked"><a href="?cmd=configuration&picked_tab=3">{$lang.Billing}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=4">{$lang.Mail}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=5">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=6">{$lang.Other}</a></li>
                        </ul>
                    </div>
                    <div class="list-2">
                        <div class="subm1 haveitems">
                            <ul >
                                <li><a href="?action=download&invoice=preview" ><span><b>{$lang.previewinvoice}</b></span></a></li>
                                <li class="list-2elem"><a href="?cmd=configuration&picked_tab=3&picked_subtab=0"><span>{$lang.invmethod}</span></a></li>
                                <li class="list-2elem" ><a href="?cmd=configuration&action=invoicetemplates"><span>{$lang.invcustomize}</span></a></li>
                                <li class="list-2elem picked" ><a href="?cmd=configuration&action=estimatetemplates"><span>预期定制</span></a></li>
                                <li class="list-2elem"><a href="?cmd=configuration&picked_tab=3&picked_subtab=1"><span>{$lang.creditcards}</span></a></li>
                                <li class="list-2elem"><a href="?cmd=configuration&picked_tab=3&picked_subtab=2"><span>{$lang.clbalance}</span></a></li>
                                <li class="list-2elem"><a href="?cmd=configuration&picked_tab=3&picked_subtab=3"><span>信用记录</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="nicerblu" id="ticketbody">
                    {include file='ajax.invoice.template.tpl'}
            </div>
            </div>
        </td></tr></table>