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
                            <li><a href="?cmd=configuration&picked_tab=3">{$lang.Billing}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=5">{$lang.Mail}</a></li>
                            <li class="active picked"><a href="?cmd=configuration&picked_tab=5">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=7">{$lang.Other}</a></li>
                        </ul>
                    </div>
                    <div class="list-2">
                        <div class="subm1 haveitems">
                            <ul >
                                <li><a href="?cmd=configuration&picked_tab=5&picked_subtab=0"><span>{$lang.maincurrency}</span></a></li>
                                <li><a href="?cmd=configuration&picked_tab=5&picked_subtab=1"><span>{$lang.addcurrencies}</span></a></li>
                                <li ><a href="?cmd=taxconfig"><span>{$lang.taxes}</span></a></li>
                                <li class="picked"><a href="?cmd=currencytocountry"><span>货币汇率对国家</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="nicerblu" id="ticketbody">
                    <div id="newtab">
                        <div class="tabb">


                            {if !$a_currencies}
                            <div class="blank_state blank_news">
                                <div class="blank_info">
                                    <h1>你需要有额外的货币定义的第一</h1>
                                    为了使用此功能, 请先定义额外的货币.
                                    <div class="clear"></div>
                                    <a class="new_add new_menu" href="?cmd=configuration&picked_tab=5&picked_subtab=1" style="margin-top:10px">
                                        <span>添加货币</span></a>
                                    <div class="clear"></div>
                                </div>
                            </div>

                             {elseif !$rules}
                                <div class="blank_state blank_news">
                                    <div class="blank_info">
                                        <h1>定义货币的国家规则</h1>
                                        如果你需要迫使某些国家使用一种货币使用此功能来设置规则. <br/>
                                        客户选择的货币就会自动变为一个定义在货币规则
                                        <div class="clear"></div>
                                        <a class="new_add new_menu" href="#" style="margin-top:10px" onclick="$('#addnewtax').toggle();return false">
                                            <span>添加新的规则</span></a>
                                        <div class="clear"></div>
                                    </div>
                                </div>
                            {/if}







                            <div class="rest" style="">
                                {if $rules}

                                    <h3>当前货币的国家规则</h3>
                                    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                                        <tbody>
                                        <tr>
                                            <th>{$lang.country}</th>
                                            <th>{$lang.currency}</th>
                                            <th width="20"></th>
                                        </tr>

                                        {foreach from=$rules item=tax}
                                            <tr>
                                                <td>{$countries[$tax.country]}</td>
                                                <td>{$all_currencies[$tax.currency_id].iso}</td>
                                                <td><a href="?cmd=currencytocountry&make=deleterule&country={$tax.country}&security_token={$security_token}" onclick="return confirm('{$lang.removetaxconfirm}')" class="delbtn">{$lang.Delete}</a></td></tr>
                                        {/foreach}



                                        <tr id="adtax_bt">
                                            <th colspan="6" align="left">
                                                <a href="#" class="editbtn" onclick="$('#adtax_bt').hide();$('#addnewtax').show();return false;">添加新的规则</a>&nbsp;
                                                <a href="?cmd=currencytocountry&make=addeur&security_token={$security_token}" class="editbtn" >欧元作为欧盟国家的默认设置</a>&nbsp;
                                                <a href="?cmd=currencytocountry&make=rmallrules&security_token={$security_token}" class="editbtn" onclick="return confirm('您确定吗?');" >删除所有的规则</a>&nbsp;
                                            </th>
                                        </tr>
                                        </tbody>

                                    </table>
                                {/if}
                                <div class="blu" id="addnewtax" style="display:none">
                                    <form action="" method="post">

                                        <table cellspacing="2" cellpadding="3" border="0">
                                            <tr>
                                                <td valign="middle"><strong>{$lang.country}:</strong></td>
                                                <td><select name="country" id="ct_"  class="inp" >
                                                        {foreach from=$countries key=k item=v}
                                                            <option value="{$k}">{$v}</option>
                                                        {/foreach}
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <table cellspacing="2" cellpadding="3" border="0">
                                            <tr>
                                                <td>{$lang.currency}:</td>
                                                <td> <select name="currency_id"  class="inp" >
                                                        {foreach from=$all_currencies key=k item=v}
                                                            <option value="{$v.id}">{$v.iso}</option>
                                                        {/foreach}
                                                    </select></td>
                                            </tr>
                                        </table>
                                        <input type="hidden" value="addrule" name="make"/>
                                        <center> <input type="submit" style="font-weight: bold;padding:10px;" value="添加新规则" class="submitme"/> <span class="orspace">{$lang.Or} <a href="#" charset=" editbtn" onclick="$('#adtax_bt').show();$('#addnewtax').hide();return false;">{$lang.Cancel}</a> </span>

                                             <span class="orspace">{$lang.Or} <a href="?cmd=currencytocountry&make=addeur&security_token={$security_token}" class="editbtn" >欧元作为欧盟国家的默认设置</a>&nbsp;</span>
                                        </center>
                                        {securitytoken}</form>
                                </div>


                            </div>

                        </div>


                    </div>

                </div>








            </div>
            </div>
 </td></tr></table>