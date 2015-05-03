{if $action=='manage'}
<div class="blu">{$lang.clearloginfo}</div>
<div class="lighterblue" style="padding:5px">
    <form method="post" action="">
        <input type="hidden" name="make" value="delete" />

        <table border="0" cellpadding="3" width="500" cellspacing="0">
            <tr><td colspan="3"><strong>{$lang.choosedeltype}:</strong></td></tr>

            <tr>
                <td width="20"><input type="radio" name="from_date" checked="checked" value="0"/></td>
                <td colspan="2">{$lang.deleteallent}</td>
            </tr>
            <tr>
                <td width="20"><input type="radio" name="from_date"  value="1"/></td>
                <td>{$lang.deleteolderthan}: </td>
                <td><input class="haspicker" name="date" /></td>
            </tr>

            <tr><td colspan="3"><strong>{$lang.deletefrom}:</strong></td></tr>

            <tr>
                <td width="20"><input type="checkbox" name="tickets_emails" value="1"/></td>
                <td colspan="2">{$lang.ticketimplog}</td>
            </tr>
            <tr>
                <td width="20"><input type="checkbox" name="gateway_log" value="1"/></td>
                <td colspan="2">{$lang.Gatewaylog}</td>
            </tr>


            <tr>
                <td width="20"><input type="checkbox" name="client_activity_log" value="1"/></td>
                <td colspan="2">{$lang.clactivitylog}</td>
            </tr>
            <tr>
                <td width="20"><input type="checkbox" name="client_credit_log" value="1"/></td>
                <td colspan="2">{$lang.clientcreditlog}</td>
            </tr>
            <tr>
                <td width="20"><input type="checkbox" name="admin_log" value="1"/></td>
                <td colspan="2">{$lang.adactivitylog}</td>
            </tr>
            <tr>
                <td width="20"><input type="checkbox" name="system_log" value="1"/></td>
                <td colspan="2">{$lang.systemlog}</td>
            </tr>

            <tr>
                <td width="20"><input type="checkbox" name="email_log" value="1"/></td>
                <td colspan="2">{$lang.sentemailslog}</td>
            </tr>

            <tr>
                <td width="20"><input type="checkbox" name="domain_log" value="1"/></td>
                <td colspan="2">{$lang.domactivitylog}</td>
            </tr>

            <tr>
                <td width="20"><input type="checkbox" name="account_log" value="1"/></td>
                <td colspan="2">{$lang.accactivitylog}</td>
            </tr>

            <tr>
                <td width="20"><input type="checkbox" name="coupons_log" value="1"/></td>
                <td colspan="2">{$lang.discountcouponslog}</td>
            </tr>

            <tr>
                <td width="20"><input type="checkbox" name="chat_log" value="1"/></td>
                <td colspan="2">{$lang.chatlog}</td>
            </tr>
            <tr>
                <td width="20"><input type="checkbox" name="error_log" value="1"/></td>
                <td colspan="2">{$lang.errorlog}</td>
            </tr>

            <tr>
                <td width="20"><input type="checkbox" name="api_log" value="1"/></td>
                <td colspan="2">{$lang.apilog}</td>
            </tr>
            <tr>
                <td width="20"><input type="checkbox" name="client_changes_log" value="1"/></td>
                <td colspan="2">{$lang.clientchangeslog}</td>
            </tr>


            <tr><td colspan="3" align="left"><input type="submit" value="{$lang.clearselectedlogs}" style="font-weight:bold"/></td></tr>
        </table>{securitytoken}</form>
</div>


{elseif $action=='clientactivity'}
{if $logs}

{if $showall}
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    <a href="?cmd=logs&action=clientactivity" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="150"><a href="?cmd=logs&action=clientactivity&orderby=lastname|ASC"  class="sortorder">{$lang.Client}</a></th>
                <th width="150"><a href="?cmd=logs&action=clientactivity&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th ><a href="?cmd=logs&action=clientactivity&orderby=description|ASC"  class="sortorder">{$lang.Action}</a></th>



            </tr>
        </tbody>
        <tbody id="updater">

            {/if}

            {foreach from=$logs item=email}
            <tr>

                <td><a href="?cmd=clients&action=show&id={$email.client_id}">{$email.lastname} {$email.firstname}</a></td>
                <td>{$email.date|dateformat:$date_format}</td>
                <td>{$email.description}</td>


            </tr>
            {/foreach}

            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="3">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
        </tbody>

    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    {securitytoken}</form>

{/if}

{else} 
{if $showall}
<p class="blu"> {$lang.nothingtodisplay} </p>
{else}
<tr>
    <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
{/if}

{elseif $action=='adminactivity'}

{if $logs}

{if $showall}
<form action="" method="post" id="testform" >
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">




        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    <a href="?cmd=logs&action=adminactivity" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="22%"><a href="?cmd=logs&action=adminactivity&orderby=lastname|ASC"  class="sortorder">{$lang.logintime}</a></th>
                <th width="21%"><a href="?cmd=logs&action=adminactivity&orderby=lastvisit|ASC"  class="sortorder">{$lang.lastaccess}</a></th>
                <th width="21%"><a href="?cmd=logs&action=adminactivity&orderby=logout|ASC"  class="sortorder">{$lang.logouttime}</a></th>
                <th width="21%"><a href="?cmd=logs&action=adminactivity&orderby=username|ASC"  class="sortorder">{$lang.Username}</a></th>
                <th width="15%"><a href="?cmd=logs&action=adminactivity&orderby=ip|ASC"  class="sortorder">{$lang.IPaddress}</a></th>




            </tr>
        </tbody>
        <tbody id="updater">

            {/if}

            {foreach from=$logs item=email}
            <tr>

                <td>{$email.login|dateformat:$date_format}</td>
                <td>{$email.lastvisit|dateformat:$date_format}</td>
                <td>{if $email.logout=='0000-00-00 00:00:00'}-{else}{$email.logout|dateformat:$date_format}{/if}</td>
                <td><a href="?cmd=editadmins&action=administrator&id={$email.admin_id}">{$email.username|capitalize}</a></td>
                <td>{$email.ip}</td>

            </tr>
            {/foreach}

            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="5">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    {securitytoken}</form>

{/if}

{else} 
{if $showall}
<p class="blu"> {$lang.nothingtodisplay} </p>
{else}
<tr>
    <td colspan="5"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
{/if}



{elseif $action=='importlog'}

{if $logs}

{if $showall}
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    <a href="?cmd=logs&action=importlog" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th><a href="?cmd=logs&action=importlog&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=to|ASC"  class="sortorder">{$lang.To}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
            </tr>
        </tbody>
        <tbody id="updater">

            {/if}

            {foreach from=$logs item=email}
            <tr>

                <td>{$email.date|dateformat:$date_format}</td>
                <td>{$email.to}</td>
                <td><a href="?cmd=logs&action=getimportlog&id={$email.id}">{$email.subject}</a></td>
                <td>
                    {if $email.status == 0}<a class="vtip_description" title="电子邮件与您导入的一个过滤器相匹配"></a>&nbsp;过滤&nbsp;出了
                    {elseif $email.status == 1}<a class="vtip_description" title="部门不允许未注册客户"></a>&nbsp;未注册 
                    {elseif $email.status == 2}成功 
                    {elseif $email.status == 3}<a class="vtip_description" title="接收邮件不匹配任何您的支持部门"></a>&nbsp;未&nbsp;找到 
                    {elseif $email.status == 4}<a class="vtip_description" title="发件人的电子邮件与部门电子邮件相同"></a>&nbsp;跳过
                    {elseif $email.status == 5}<a class="vtip_description" title="错误,无法创建该工单"></a>&nbsp;错误
                    {elseif $email.status == 6}<a class="vtip_description" title="消息指的是不同的部门不相关的工单"></a>&nbsp;不匹配
                    {elseif $email.status == 7}<a class="vtip_description" title="发件人的邮箱在电子邮件系统中存在"></a>&nbsp;系统
                    {elseif $email.status == 8}<a class="vtip_description" title="邮件被认定为自动提交"></a>&nbsp;自动提交
                    {elseif $email.status == 9}<a class="vtip_description" title="时间已经达到该任务极限"></a>&nbsp;时间限制
                    {elseif $email.status == 10}<a class="vtip_description" title="工单已关闭回复无法接受"></a>&nbsp;工单已关闭
                    {elseif $email.status == 11}<a class="vtip_description" title="该工单与数分钟前导入的相同"></a>&nbsp;重复
                    {else}<a class="vtip_description" title="意外错误,无法创建工单"></a>&nbsp;未知
                    {/if}
                </td>

            </tr>
            {/foreach}

            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="4">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}</form>

{/if}

{else} 
{if $showall}
<p class="blu"> {$lang.nothingtodisplay} </p>
{else}
<tr>
    <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
{/if}

{elseif $action=='default'}

{if $logs}

{if $showall}
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    <a href="?cmd=logs" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th width="15%"><a href="?cmd=logs&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th ><a href="?cmd=logs&orderby=what|ASC"  class="sortorder">{$lang.Description}</a></th>
                <th width="10%"><a href="?cmd=logs&orderby=who|ASC"  class="sortorder">{$lang.Username}</a></th>



            </tr>
        </tbody>
        <tbody id="updater">

            {/if}

            {foreach from=$logs item=email}
            <tr>

                <td>{$email.date|dateformat:$date_format}</td>
                <td>{$email.what}
                    {if $email.type && $email.item_id}
                    {if $email.type=='client'}<a href="?cmd=clients&action=show&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='account'}<a href="?cmd=accounts&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='order'}<a href="?cmd=orders&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='domain'}<a href="?cmd=domains&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='invoice'}<a href="?cmd=invoices&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='transaction'}<a href="?cmd=transactions&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='cron_prof'}<a href="?cmd=configuration&action=profile&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='admin'}<a href="?cmd=editadmins&action=administrator&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='admin_group'}<a href="?cmd=configuration&action=group&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='product'}<a href="?cmd=services&action=product&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='product_cat'}<a href="?cmd=services&action=category&cat_id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='product_add'}<a href="?cmd=productaddons&action=addon&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='server'}<a href="?cmd=servers&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {elseif $email.type=='email_tpl'}<a href="?cmd=emailtemplates&action=edit&id={$email.item_id}">(ID: {$email.item_id})</a>
                    {/if}
                    {/if}
                </td>
                <td>{$email.who|capitalize}</a></td>


            </tr>
            {/foreach}

            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="3">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    {securitytoken}</form>

{/if}

{else} 
{if $showall}
<p class="blu"> {$lang.nothingtodisplay} </p>
{else}
<tr>
    <td colspan="3"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
{/if}


{elseif $action=='getimportlog'}

<div class="blu">
    <a href="?cmd=logs&action=importlog"><strong>&laquo; 返回所有导入邮件</strong></a></div>
<div class="lighterblue" style="padding:5px">
    <strong>{$lang.From}</strong> {$email.from}<br />
    <strong>{$lang.To}</strong> {$email.to}<br />
    <strong>{$lang.Subject}</strong> {$email.subject}<br />
    <strong>{$lang.Status}</strong> {$email.status}<br />
    <strong>{$lang.Received}</strong> {$email.date|dateformat:$date_format}<br /><br />
    {if $email.headers}
    <a href="#" class="editbtn" onclick="$(this).hide().next().show(); return false;">显示邮件标题</a>
    <table class="whitetable" width="99%" cellspacing="0" cellpading="0" style="table-layout:fixed; word-wrap: break-word; display:none">
        {foreach from=$email.headers item=header key=name name=headers}
        <tr {if $smarty.foreach.headers.index%2==0}class="even"{/if}>
            <td style="width:10%; vertical-align: top; text-align: right">{$name}:</td>
            <td>{$header|escape}</td>
        </tr>
        {/foreach}
    </table>
    {/if}
    <pre style="font-family: monospace,Lucida Console; padding: 0px 0px 0px 15px; white-space: pre-wrap;">
    {$email.message}
    </pre>
</div>




{elseif $action=='coupons'}

{if $logs}

{if $showall}
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>

    <a href="?cmd=logs&action=coupons" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
                <th><a href="?cmd=logs&action=importlog&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=lastname|ASC"  class="sortorder">{$lang.Client}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=order_id|ASC"  class="sortorder">{$lang.Order}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=coupon_id|ASC"  class="sortorder">{$lang.couponhash}</a></th>
                <th><a href="?cmd=logs&action=importlog&orderby=discount|ASC"  class="sortorder">{$lang.Discount}</a></th>


            </tr>
        </tbody>
        <tbody id="updater">

            {/if}

            {foreach from=$logs item=email}
            <tr>

                <td>{$email.date|dateformat:$date_format}</td>
                <td><a href="?cmd=clients&action=show&id={$email.client_id}">{$email.lastname} {$email.firstname}</a></td>
                <td><a href="?cmd=orders&action=edit&id={$email.order_id}&list=all">#{$email.order_id}</a></td>
                <td><a href="?cmd=coupons&action=edit&id={$email.coupon_id}">#{$email.coupon_id}</a></td>
                <td>{$email.discount|price:$currency}</td>

            </tr>
            {/foreach}

            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="5">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}</form>

{/if}

{else} 
{if $showall}
<p class="blu"> {$lang.nothingtodisplay} </p>
{else}
<tr>
    <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
{/if}

{elseif $action=='apilog'}

    {if $logs}

    {if $showall}
    <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <div class="blu">

            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>

        <a href="?cmd=logs&action=apilog" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
                <tr>
                    <th width="200">日期</th>
                    <th width="150">IP地址</th>
                    <th width="150">API ID</th>
                    <th width="150">调用函数</th>
                    <th >结果</th>
                </tr>
            </tbody>
            <tbody id="updater">

                {/if}

                {foreach from=$logs item=request}
                <tr>
                    <td>{$request.date|dateformat:$date_format}</td>
                    <td>{$request.ip}</td>
                    <td>{$request.api_id}</td>
                    <td>{$request.action}</td>
                    <td>{$request.result}</td>
                </tr>
                {/foreach}

                {if $showall}
            </tbody>
            <tbody id="psummary">
                <tr>
                    <th colspan="5">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                    </th>
                </tr>
            </tbody>
        </table>
        <div class="blu">

            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        {securitytoken}</form>

    {/if}

    {else}
    {if $showall}
    <p class="blu"> {$lang.nothingtodisplay} </p>
    {else}
    <tr>
        <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
    </tr>
    {/if}
    {/if}
{elseif $action=='errorlog'}

    {if $logs}

    {if $showall}
    <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
        <div class="blu">

            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>

        <a href="?cmd=logs&action=errorlog" id="currentlist" style="display:none" updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
                <tr>
                    <th width="200">Date</th>
                    <th width="150">Type</th>
                    <th >Error</th>
                </tr>
            </tbody>
            <tbody id="updater">
                {/if}

                {foreach from=$logs item=request}
                <tr>
                    <td>{$request.date|dateformat:$date_format}</td>
                    <td>{$request.type}</td>
                    <td><div class="errorless fs11">{$request.entry|nl2br}</div></td>
                </tr>
                {/foreach}

                {if $showall}
            </tbody>
            <tbody id="psummary">
                <tr>
                    <th colspan="5">
                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                    </th>
                </tr>
            </tbody>
        </table>
        <div class="blu">

            <div class="right">
                <div class="pagination"></div>
            </div>
            <div class="clear"></div>
        </div>
        {securitytoken}</form>

    {/if}

    {else}
    {if $showall}
    <p class="blu"> {$lang.nothingtodisplay} </p>
    {else}
    <tr>
        <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
    </tr>
    {/if}
    {/if}

{elseif $action=='cancelations'}


{if $logs}

{if $showall}
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">
        <div class="right">
            <div class="pagination"></div>
        </div>
		<div class="left menubar">
			{$lang.withselected}
			<a class="submiter menuitm menuf" name="cancellacc" queue="push" href="#">
				<span>{$lang.CancelAccount}</span>
			</a>
			<a class="submiter menuitm menul" name="delreq" queue="push" href="#">
				<span>{$lang.DeleteRequest}</span>
			</a>
		</div>
        <div class="clear"></div>
    </div>

    <a href="?cmd=logs&action=cancelations" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
        <tbody>
            <tr>
				<th style="width:20px"><input type="checkbox" id="checkall"/></th>
				<th style="width:120px">{$lang.Date}</th>
				<th>{$lang.Client}</th>
				<th>{$lang.Domain}</th>
                <th>{$lang.Account}</th>
                <th style="width: 40%;">{$lang.Reason}</th>
                <th>{$lang.Type}</th>
                <th>Billing period ends</th>
                <th>{$lang.Status}</th>
            </tr>
        </tbody>
        <tbody id="updater">

            {/if}

            {foreach from=$logs item=request}
            <tr>
                <td><input type="checkbox" name="selected[]" {if $request.status == 'Cancelled' || $request.status == 'Terminated' || $request.status == 'Fraud'}disabled="disabled"{else} class="check"{/if} value="{$request.account_id}" /></td>
				<td>{$request.date|dateformat:$date_format}</td>
				<td>{if $request.client_id}<a href="?cmd=clients&action=show&id={$request.client_id}">{$request.lastname} {$request.firstname}</a>{else}-{/if}</td>
				<td>{if $request.domain}<a href="?cmd=accounts&action=edit&id={$request.account_id}">{$request.domain}</a>{else}-{/if}</td>
                <td>
                    <a href="?cmd=accounts&action=edit&id={$request.account_id}">{if $request.name}{$request.category} - {$request.name}{else}账户 #{$request.account_id}{/if}</a>
                </td>
                <td><div class="fs11" style="max-height: 40px; overflow: auto;">{$request.reason}</div></td>
                <td>{$request.type}</td>
                <td>{$request.next_invoice}</td>
                <td>{if $request.status == 'Cancelled' || $request.status == 'Terminated' || $request.status == 'Fraud'}<span class="Active">{$lang.Cancelled}</span>{else}<span class="Pending">{$lang.Pending}</span>{/if}</td>
            </tr>
            {/foreach}

            {if $showall}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="10">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>

                </th>
            </tr>
        </tbody>
    </table>
    <div class="blu">

        <div class="right">
            <div class="pagination"></div>
        </div>
        <div class="clear"></div>
    </div>
    {securitytoken}</form>

{/if}

{else}
{if $showall}
<p class="blu"> {$lang.nothingtodisplay} </p>
{else}
<tr>
    <td colspan="15"><p align="center" > {$lang.nothingtodisplay} </p></td>
</tr>
{/if}
{/if}


{/if}