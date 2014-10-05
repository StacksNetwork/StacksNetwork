{if $action=="default"}
    {if !$ajax}
    <div {if !$rates}style="display: none"{/if} id="ratelist">
        
        <div id="newshelfnav" class="newhorizontalnav">
            <div class="list-1">
                <ul>
                    <li class="active last">
                        <a href="#"><span class="ico money">人工服务费率</span></a>
                    </li>{*}
                    <li class="last">
                        <a href="#"><span class="ico plug">职务-导入过滤器</span></a>
                    </li>{*}
                </ul>
            </div>
            <div class="list-2">
                <div class="navsubmenu haveitems" style="display: block;">
                    <ul>
                        {if !$forbidAccess.editSupportRates }
                            <li class="list-2elem"><a href="?cmd={$cmd}&action=add" onclick="track.newRate(); return false;"><span>新建人工服务费率</span></a></li>
                            <li class="list-2elem"><a onclick="return confirm('您确定需要删除选定的条目吗?');" class="submiter" name="delete" href="?cmd=ticketbans&amp;action=add&amp;type=pre"><span>Delete Selected</span></a></li>
                        {/if}
                    </ul>
                    <div class="right"><div class="pagination"></div></div>
                </div>
                <div style="display:none" class="navsubmenu haveitems">
                    <ul>
                        <li class="list-2elem"><a href="?cmd=ticketbans&amp;action=add"><span>添加职务导入过滤器</span></a></li>
                    </ul>
                </div>

                <div class="clear"></div>
            </div>
        </div>
        <input type="hidden" id="picked_tab" name="picked_tab" value="0">
        <form id="testform">
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <thead>
                    <tr>
                        <th width="20"><input id="checkall" type="checkbox" /></th>
                        <th><a class="sortorder" href="?cmd={$cmd}&orderby=id|ASC">ID</a></th>
                        <th><a class="sortorder" href="?cmd={$cmd}&orderby=name|ASC">姓名</a></th>
                        <th>Description</th>
                        <th width="160"><a class="sortorder" href="?cmd={$cmd}&orderby=price|ASC">每工时费用</a></th>
                        <th width="50"></th>
                    </tr>
                </thead>
                <tbody id="updater">
                {/if}
                {foreach from=$rates item=rate}
                    <tr>
                        <td><input class="check" type="checkbox" name="selected[]" value="{$rate.id}" /></td>
                        <td><a href="?cmd={$cmd}&action=edit&id={$rate.id}" title="edit" onclick="track.editRate({$rate.id}); return false;">#{$rate.id}</a></td>
                        <td><a href="?cmd={$cmd}&action=edit&id={$rate.id}" title="edit" onclick="track.editRate({$rate.id}); return false;">{$rate.name}</a></td>

                        <td>{$rate.description|escape}</td>
                        <td>{$rate.price|price:$currency}</td>
                        <td>
                            <a onclick="return confirm('您确定需要删除该条目吗?');" class="delbtn" href="?cmd={$cmd}&action=delete&id={$rate.id}&security_token={$security_token}">Delete</a>
                        </td>
                    </tr>
                {/foreach}
                {if !$ajax}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th colspan="92">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
        </form>
        <div class="newhorizontalnav">
            <div class="list-2">
                <div class="navsubmenu haveitems" style="display: block;">
                    <ul>
                        {if !$forbidAccess.editSupportRates }
                            <li class="list-2elem"><a href="?cmd={$cmd}&action=add" onclick="track.newRate(); return false;"><span>新建人工服务费率</span></a></li>
                        {/if}
                    </ul>
                    <div class="right"><div class="pagination"></div></div>
                </div>
            </div>
        </div>
     </div>
        <div class="blank_state blank_services" {if $rates}style="display: none"{/if} id="blanklist">
            <div class="blank_info">
                <h1>人工服务费率/实时跟踪</h1>
                您尚未定义任何服务费率, 您至少需要定义一条. 您才可以开具人工服务费账单.
                <div class="clear"></div>
                {if !$forbidAccess.editSupportRates }
                <a style="margin-top:10px" href="?cmd={$cmd}" class="new_add new_menu" onclick="track.newRate(); return false;">
                    <span>新建人工服务费率</span>
                </a>
                {/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='add' || $action=='edit'}
    <div class="content" style="display: block;">
        <form method="post" action="?cmd={$cmd}&action={$action}" method="post" onsubmit="track.saveRate(this); return false;" id="saveform">
            <input type="hidden" name="save" value="1" />
            {if $entry.id}
                <input type="hidden" name="id" value="{$entry.id}" />
            {/if}
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tbody>
                    <tr>
                        <td id="s_menu" style="width: 200px">
                            <div id="initial-desc"><strong>姓名</strong>
                                <br><small>姓名将被应用到账单的内容说明. </small>
                            </div><br>
                            <div id="initial-desc"><strong>价格</strong>
                                <br><small>将用于计算每个小时的服务价格.</small>
                            </div><br>
                            <div id="initial-desc"><strong>说明</strong>
                                <br><small>写几句在登录时可见的话, 仅显示于后台登陆时.</small>
                            </div>
                        </td>
                        <td class="conv_content faceform" style="vertical-align: top">
                            <h3 style="margin-bottom:0px;">添加新的人工服务费率</h3><br>
                            <fieldset>
                                <legend>姓名</legend>
                                <input type="text" name="name" value="{$entry.name}">
                            </fieldset>
                            <fieldset>
                                <legend>价格</legend>
                                <div class="clear"></div>
                                <label>
                                    {$currency.sign} <input type="text" name="price" value="{if $entry.price}{$entry.price|price:$currency:false}{else}{0|price:$currency:false}{/if}" size="4"/> {if $currency.code}{$currency.code}{else}{$currency.iso}{/if}
                                </label>
                                <div class="clear"></div>
                            </fieldset>
                            <fieldset>
                                <legend>说明</legend>
                                <div class="clear"></div>
                                <textarea name="description" style="width: 98%">{$entry.description|escape}</textarea>
                                <div class="clear"></div>
                            </fieldset>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="dark_shelf dbottom clear">
                <div class="left spinner">
                    <img src="ajax-loading2.gif">
                </div>
                <div class="right">
                    <span class="bcontainer ">
                        <a href="#" onclick="$('.spinner').show();$('#saveform').submit();return false;" class="new_control greenbtn">
                            <span>保存修改</span>
                        </a>
                    </span>
                    <span>&nbsp;</span>
                    <span class="bcontainer">
                        <a href="#" onclick="$(document).trigger('close.facebox');return false;" class="submiter menuitm">
                            <span>关闭</span>
                        </a>
                    </span>
                </div>
                <div class="clear"></div>
                {securitytoken}
            </div>
        </form>
    </div> 
{elseif $action=='ticket'}
    {if $rates}
        <form action="?cmd={$cmd}&action={$action}" method="POST">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align: left">
                <tbody>
                   <tr>
                       <th style=" width: 185px">开始时间</th>
                       <th style=" width: 185px">结束时间</th>
                       <th>费率</th>
                       <th>价格</th>
                       <th>备注</th>
                       <th>状态</th>
                       <th>添加人</th>
                       <th style=" width: 40px"></th>
                   </tr>
                   {foreach from=$items item=entry}
                       {if !$pendingitems && !$entry.status}
                           {assign value=true var=pendingitems}
                       {/if}
                       <tr>
                       <td>{$entry.start|dateformat:$date_format}</td>
                       <td>{$entry.end|dateformat:$date_format} <br /><small>({$entry.diff|convert:'second'})</small></td>
                       <td>{$entry.name} <small>({$entry.rate|price:$currency:true:2:false}/h)</small></td>
                       <td>{$entry.ratextime|price:$currency}</td>
                       <td>{if $entry.note}{$entry.note}{else}-{/if}</td>
                       <td>
                            {if !$entry.status}<span class="Draft">{$lang.Draft}</span>
                            {else}
                                {if $entry.invoice_id}<span class="Active">账单 <small><a href="?cmd=invoices&action=edit&id={$entry.invoice_id}&list=all" style="color: #4D89AB" >#{$entry.invoice_id}</a></small></span>
                                {elseif $entry.queue_id}<span class="Pending">排队</span>
                                {else}<span class="Cancelled">{$lang.Cancelled}</span>
                                {/if}
                            {/if}
                            </td>
                       <td>{$entry.admin}</td>
                       <td>{if !$entry.status}<a href="#{$entry.id}" class="delbtn" onclick="if(confirm('您确定需要删除该条目吗?')) ticket.delBilling('{$entry.id}'); return false;"></a>{/if}</td>
                   </tr>
                   {foreachelse}
                   <tr>
                        <td colspan="2">
                            {$lang.nothingtodisplay}
                        </td><td></td><td></td><td></td><td></td><td></td><td></td>
                   </tr>
                   {/foreach}
               </tbody>
               <tbody>
                   <tr>
                       <td>
                           <input type="text" name="startdate" value="{$submit.startdate}" class="inp haspicker" placeholder="eg. {"2014-05-15"|dateformat:$date_format}" style="width:90px">
                           <input type="text" name="startime" value="{$submit.startimet}" class="inp timepicker" placeholder="eg. 21:35" style="width:55px">  
                       </td>
                       <td>
                           <input type="text" name="enddate" value="{$submit.enddate}" class="inp haspicker" placeholder="eg. {"2014-05-16"|dateformat:$date_format}" style="width:90px">
                           <input type="text" name="endtime" value="{$submit.endtime}" class="inp timepicker" placeholder="eg. 01:35"  style="width:55px">
                       </td>
                       <td colspan="2">
                           <select name="rate_id" class="inp">
                               {foreach from=$rates item=rate}
                                <option {if $submit.rate == $rate.id}selected="selected"{/if} value="{$rate.id}">{$rate.name} ({$rate.price|price:$currency:true:2:false}/h) </option>
                               {/foreach}
                           </select>
                       </td>
                       <td colspan="3"><textarea name="note" class="inp" style="height: 1em"></textarea></td>
                       <td><button onclick="ticket.addBilling(); return false;">{$lang.Add}</button></td>
                   </tr>
               </tbody>
            </table>
            {if $pendingitems && !$forbidAccess.addInvoices && !$forbidAccess.editInvoices}
            <div>
                <br />
                <button onclick="ticket.startBilling($('#billtype').val(), $('#billingservices').val()); return false;" style="padding: 3px; line-height: 13px;">账单待定内容</button>
                <select id="billtype" name="type" class="inp" onchange="if($(this).val() == '1') $(this).next().show(); else  $(this).next().hide();">
                    <option value="0">立即</option>
                    <option value="1">添加到下一个客户账单</option>
                </select>
                <select id="billingservices" class="inp" style="display: none">
                    <option value="0">{$lang.Any}</option>
                    {foreach from=$services item=service}
                        <option value="{$service.id}">#{$service.id} {$service.name}{if $service.domain} {$service.domain}{/if}</option>
                    {/foreach}
                </select>
            </div>
           {/if}
        </form>
        {if $init}
            <script type="text/javascript" src="{$template_dir}js/timepicker/jquery.timepicker.min.js" ></script>
        {/if}
        <link media="all" rel="stylesheet" href="{$template_dir}js/timepicker/jquery.timepicker.css" />
        <script type="text/javascript" src="{$template_dir}js/tickettimetracking.js" ></script>
    {else}
        <div class="blank_services">
            <div class="blank_info" style="padding: 10px;">
                <h1>人工服务费率/实时跟踪</h1>
                您尚未定义任何服务费率, 您至少需要定义一条. 您才可以开具人工服务费账单.
                <div class="clear"></div>
                {if !$forbidAccess.editSupportRates }
                <a style="margin-top:10px" href="?cmd={$cmd}" class="new_add new_menu" onclick="track.newRate(); return false;">
                    <span>新建人工服务费率</span>
                </a>
                {/if}
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{/if}
{if ($action=='ticket' && !$rates && 'acl:editSupportRates'|checkcondition) || $action=='default'}
    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
    {literal}
        <script type="text/javascript">
            var track = {
                newRate: function(){
                    $.facebox({ ajax: "?cmd=tickettimetracking&action=add", width:900, nofooter:true, opacity:0.8, addclass:'modernfacebox' });
                },
                editRate: function(id){
                    $.facebox({ ajax: "?cmd=tickettimetracking&action=edit&id="+id, width:900, nofooter:true, opacity:0.8, addclass:'modernfacebox' });
                },
                saveRate: function(form){
                var that = $(form);
                    $.post(that.attr('action'), that.serializeObject(), function(data) {
                        data = parse_response(data);
                        $('#updater').html(data);
                        $(document).trigger('close.facebox');
                        if($('#updater tr').length){
                            $('#ratelist').show();
                            $('#blanklist').hide();
                        }
                    })
                }
            }
        </script>
    {/literal}
{/if}