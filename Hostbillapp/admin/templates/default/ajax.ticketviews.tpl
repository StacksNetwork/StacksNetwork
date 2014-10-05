{if $display == 'theaders'}
    <th width="20"><input type="checkbox" id="checkall"/></th>
    {foreach from=$tview.columns item=col name=columns}
        <th {if $col==32}width="80"{elseif $col==1 || $col==16384 || $col==524288}width="50"{/if} class="tviews view{$col}"  style="white-space: nowrap; overflow: hidden; text-overflow:ellipsis ">
            {assign value=$columns[$col] var=colname}
            <a href="?cmd={$cmd}&tview={$tview.id}&orderby=column{$smarty.foreach.columns.index}|ASC"  class="sortorder" 
               title="{if $lang.$colname}{$lang.$colname}{else}{$colname}{/if}">
                {if $lang.$colname}{$lang.$colname}
                {else}{$colname}
                {/if}
            </a>
        </th>
    {/foreach}    
    <th class="border_0" style="width: 0"></th>
{elseif $display=='trow'}
    <td width="20"><input type="checkbox" class="check" value="{$ticket.id}" name="selected[]"/></td>
    {foreach from=$tview.columns item=col name=cols }
    {assign value="column`$smarty.foreach.cols.index`" var=columnx}
    {if $col == 131072}{* Tags*}
        <td class="tagnotes">
            {if $ticket[$columnx]}
                <div class="right inlineTags">
                    {foreach from=$ticket[$columnx] item=tag name=tagloop}
                        {if $smarty.foreach.tagloop.index < 3} 
                            <span>{$tag.tag}</span>
                        {/if}
                    {/foreach}
                </div>
            {/if}
        </td>
    {elseif $col == 65536}{* Assigned *}
        <td>
            {if $ticket[$columnx] > 0}
                <a href="?cmd=editadmins&action=administrator&id={$ticket[$columnx]}" >{foreach from=$staff_members item=staff}{if $staff.id == $ticket[$columnx]}{$staff.username}{break}{/if}{/foreach}</a>
            {else}
                -
            {/if}
        </td>
    {elseif $col == 16384}{* Notes*}
        <td class="tagnotes">
            {if $ticket[$columnx] > 0}
                <span class="hasnotes ticketflag-note" ></span>
            {/if}
        </td>
    {elseif $col == 4096}{* Status*}
        <td><span class="{$ticket[$columnx]}">{if $ticket[$columnx] == 'Open'}{$lang.Open}{elseif $ticket[$columnx] == 'Answered'}{$lang.Answered}{elseif $ticket[$columnx] == 'Closed'}{$lang.Closed}{elseif $ticket[$columnx] == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket[$columnx] == 'In-Progress'}{$lang.Inprogress}{else}{$ticket[$columnx]}{/if} </span></td>
    {elseif $col == 2048}{* SUBJECT *}
        <td class="subjectline">
            <div class="df1">
                <div class="df2">
                    <div class="df3">
                        <a href="?cmd=tickets&action=view&num={$ticket.ticket_number}{if $backredirect}&brc={$backredirect}{/if}" 
                           class="tload2 {if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">
                            {if $ticket[$columnx]}
                                {$ticket[$columnx]|wordwrap:80:"\n":true|escape}
                            {else}
                                #{$ticket.ticket_number}
                            {/if}
                            </a>
                    </div>
                </div>
            </div>
        </td>
    {elseif $col == 256}{* CLIENT NAME *}
        <td>{if $ticket.client_id!='0'}<a href="?cmd=clients&action=show&id={$ticket.client_id}">{/if}{$ticket[$columnx]}{if $ticket.client_id!='0'}</a>{/if}</td>
    {elseif $col == 64}{* Department*}
        <td><a href="?cmd=tickets&dept={$ticket[$columnx]}&list=all&showall=true" >{$ticket.department}</a></td>
    {elseif $col == 32 || $col == 1}{* Number  or ID*}
        <td><a href="?cmd=tickets&action=view&num={$ticket.ticket_number}{if $backredirect}&brc={$backredirect}{/if}" class="tload2 {if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">#{$ticket[$columnx]}</a></td>
    {elseif $col == 2 || $col == 4 }{* dates *}
        <td>{$ticket[$columnx]}</td>
    {else}
        <td class="fold-text" style="cursor:default">{$ticket[$columnx]}</td>
    {/if}
    {/foreach}
    <td class="border_{$ticket.priority}"></td>
{elseif $action=="default" || ($action=="menubutton" && $make=="poll")}
    {if $tview}
        
        {include file='ajax.tickets.tpl'}
        <script type="text/javascript">ticket.alignColumns();</script>
        
    {elseif $views}
        {if !$ajax}
        <form>
            <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <strong>Ticket Views</strong> 
                <div class="right"><div class="pagination"></div></div>
                <div class="clear"></div>
            </div>   
            <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
        </form>
        <table cellspacing="0" cellpadding="7" border="0" width="100%" class="glike hover">
            <thead>
                <tr>
                    <th>名称</th>
                    <th>所有人</th>
                    <th>类型</th>
                    <th width="50"></th>
                </tr>
            </thead>
            <tbody id="updater">
                {/if}
                {foreach from=$views item=view}
                    <tr>
                        <td><a href="?cmd=ticketviews&action=edit&id={$view.id}" title="edit">{$view.name}</a></td>
                        <td>{if $view.username}{$view.username}{else}--{/if}</td>
                        <td>{if $view.options & 1}公开{else}私人{/if}</td>
                        <td>
                            <a onclick="return confirm('您确定需要删除该视图吗?');" class="delbtn" href="?cmd=ticketviews&action=delete&id={$view.id}&security_token={$security_token}">删除</a>
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
        <div class="blu" style="line-height: 20px;" >
            <a href="?cmd={$cmd}&action=add" class="new_control">
                <span class="addsth">
                    <strong>新建视图</strong>
                </span>
            </a>
        </div>
                {/if}
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>自定义工单视图</h1>
                选择会被排列的工单类型与希望他们能怎么展示给您查阅!
                <div class="clear"></div>
                <a style="margin-top:10px" href="?cmd={$cmd}&action=add" class="new_add new_menu">
                    <span>新建视图</span>
                </a>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
{elseif $action=='add' || $action=='edit' || $action=='fromfilter'}
    <script type="text/javascript" src="{$template_dir}js/jqueryui/js/jquery-ui-1.8.23.custom.min.js?v={$hb_version}"></script>
    {literal}
        <style>
.view-option {
    clear: both;
    line-height: 30px;
}
.view-option b {
    display: block;
    float: left;
    width: 120px;
}

.view-columns, .view-filters{
    list-style: none outside none;
    margin: 0;
    padding: 0;
    clear:both
}
.view-columns li {
    background: none repeat scroll 0 0 #FFF0A5;
    border: 1px solid #FED22F;
    float: left;
    line-height: 26px;
    margin: 5px;
    width: 215px;
    cursor: move;
}
.view-columns li input{
    vertical-align: middle;
    cursor:pointer;
}
.view-filters > li {
    float: left;
    line-height: 26px;
    margin: 0.33%;
    width: 32%;
}
.view-filters > li > span{
    display:block;
    line-height: 25px;
}
.view-filters li .inp_{
    width: 95%;
    vertical-align: middle;
}
.view-filters li label{
    margin-right: 5px;
    white-space: nowrap;
}
.view-filters li .span-checkbox{
    float: left;
    line-height: 50px;
    margin-right: 5px;
}
.view-filters li .inp_checkbox{
    height: 46px;
}

#content_tb .view-sep{
    clear:both;
    padding-top: 10px;
    margin-top: 10px;
    border-top: solid 1px #ddd;
    box-shadow:0 1px white;
}
.ticketsTags .input ul{
    border-color: #7F9DB9
}

    </style>
    <script type="text/javascript">
        $(function() {
            $( ".view-columns" ).sortable().disableSelection();
        });
    </script>
        
    {/literal}
    <form action="" method="post">
        <div class="nicerblu" style="padding:10px;">
            <div class="view-option">
                <b>{$lang.Name}</b>
                <input name="name" value="{$view.name}" size="70" class="inp"/>
            </div>
            {if !($view.options & 4)}
            <div class="view-option">
                <b>读者</b>
                <input {if !($view.options & 1) }checked="checked"{/if} type="radio" name="audience" value="0"/> 私人
                <input {if ($view.options & 1) }checked="checked"{/if} type="radio" name="audience" value="1"/> 公开
            </div>
            {/if}
            <div class="view-option">
                <b>部门</b>
                {foreach from=$departments item=option key=value}
                    <label><input class="inp_m_checkbox" type="checkbox" value="{$option.id}"  name="view_filter[1048576][{$option.id}]" 
                                  {if !$option.my}disabled="disabled"{/if}
                                  {assign value=$view.filters[1048576] var=check}{if ($option.my && (!$view.filters || !$view.filters[1048576])) || isset($check[$option.id])}checked="checked"{/if} />
                        {$option.name}
                    </label>
                {/foreach}
            </div>
            <h3 class="view-sep">包含栏目</h3>
            <ul class="view-columns clearfix">
                {foreach from=$columns item=name key=field name=loop}
                    <li width="33%">
                        <input type="checkbox" name="columns[{$field}]" value="1" {if $view.columns.$field}checked="checked"{/if} /> 
                        {if $lan[$name]}{$lang[$name]}{else}{$name|capitalize}{/if}
                    </li>
                {/foreach}
            </ul>
            {if !($view.options & 4)}
            <h3 class="view-sep">过滤</h3>
            <ul class="view-filters clearfix">
                {foreach from=$filters item=filtr key=field name=loop}
                    {if $filtr}
                    <li>
                        <span {if $filtr.type}class="span-{if $filtr.options}m-{/if}{$filtr.type}"{/if}>{if $lan[$filtr.name]}{$lang[$filtr.name]}{else}{$filtr.name|ucfirst}{/if}
                        {if $filtr.type == 'tags'}
                            <a href="#" id="tagdescr" class="vtip_description" title="在过滤内容时您可以使用 &quot;and&quot;, &quot;or&quot;, &quot;not&quot; 等关键词, 默认是 &quot;and&quot;, 例如: <br> &bullet;&nbsp;tag1 tag2 or tag3 &raquo; (tag1 and tag2) or tag3"></a>
                        {/if}
                        </span>
                        
                        {if $filtr.type == 'select' }
                            <select class="inp inp_"  name="view_filter[{$field}]" {foreach from=$filtr item=attv key=attn}{if $attn!='type' && $attn!='name'}{$attn}="{$attv}"{/if}{/foreach}>
                            {foreach from=$filtr.options item=option key=value}
                                <option {if $view.filters.$field == $value}selected="selected"{/if} value="{$value}">{$option}</option>
                            {/foreach}
                            </select>
                        {elseif $filtr.type =='radio' || $filtr.type == 'checkbox'}
                            {if $filtr.options}
                                {foreach from=$filtr.options item=option key=value}
                                    <label><input class="inp_m_{$filtr.type}" type="{$filtr.type}"  {assign value=$view.filters[$field] var=check}{if (!$view.filters && $value!='Closed') || isset($check.$value)}checked="checked"{/if} value="{$value}"  name="view_filter[{$field}][{$value}]" />{$option}</label>
                                {/foreach}
                            {else}
                                <input class="inp_{$filtr.type}" type="{$filtr.type}" {if $view.filters.$field}checked="checked"{/if} value="1" name="view_filter[{$field}]" /> 
                            {/if}
                        {elseif $filtr.type == 'tags'}
                            {if is_array($view.filters.$field)}
                                <input class="inp inp_ inp_{$filtr.type}" type="text" value="{foreach from=$view.filters.$field item=t name=a key=g}{if is_numeric($g)}{$t|regex_replace:"!(.+)!":'&quot;\1&quot;'}{if !$smarty.foreach.a.last}{if $view.filters.$field.tag == 'any'} or {else} and {/if}{/if}{/if}{/foreach}" name="view_filter[{$field}]" /> 
                            {else}
                                <input class="inp inp_ inp_{$filtr.type}" type="text" value="{$view.filters.$field}" name="view_filter[{$field}]" /> 
                            {/if}
                            {*}
                            <div id="tagsInput_{$field}" class="left ticketsTags" style="position:relative; width:75% ;line-height: 14px; padding: 3px 0 0 5px; border: 1px solid #7F9DB9; background: #fff; margin-right: 3px; overflow: visible">
                                {foreach from=$view.filters.$field item=tag key=k}

                                    {if $k!=='tag'}
                                    <span class="tag"><a>{$tag}</a> |<a class="cls">x</a></span>
                                    {/if}
                                {/foreach}
                                <label style="position:relative" for="tagsin2" class="input">
                                    <em style="position:absolute">{$lang.tags}</em>
                                    <input id="tagsin2" autocomplete="off" style="width: 80px">
                                    <ul style="overflow-y:scroll; max-height: 100px; bottom: 23px; left: -7px"></ul>
                                </label>
                            </div>
                            <select class="inp" style="width: 19%" name="view_filter[{$field}][tag]">
                                <option {if $view.filters.$field.tag == 'any'}selected="selected"{/if} value="any" >任意</option>
                                <option {if $view.filters.$field.tag == 'all'}selected="selected"{/if} value="all" >全部</option>
                            </select>
                            <div id="tags_{$field}" style="display: none">
                                {foreach from=$view.filters.$field item=tag key=k}
                                    {if $k!=='tag'}
                                    <input type="hidden" name="view_filter[{$field}][]" value="{$tag}" />
                                    {/if}
                                {/foreach}
                            </div>
                            {literal}
                                <script type="text/javascript">
                                $(function(){
                                    ticket.bindTagsActions({/literal}'#tagsInput_{$field}'{literal}, 0, 
                                        function(tag){$({/literal}'#tags_{$field}').append('<input type="hidden" name="view_filter[{$field}][]" value="'+tag+'" />'); repozition('#tagsInput_{$field}'){literal};},
                                        function(tag){repozition({/literal}'#tagsInput_{$field}');$('#tags_{$field} {literal}input[value="'+tag+'"]').remove(); } 
                                    );
                                    function repozition(el){
                                        $(el+' ul').css({left: - $(el+' label').position().left - 2, bottom:$(el).height()+2});
                                    }
                                    repozition({/literal}'#tagsInput_{$field}'{literal}); 
                                });
                                </script>
                            {/literal}
                            {*}
                        {else}
                            <input class="inp inp_{$filtr.type}" {if $filtr.type} type="{$filtr.type}"{else}type="text"{/if} value="{$view.filters.$field}" name="view_filter[{$field}]" {foreach from=$filtr item=attv key=attn}{if $attn!='type' && $attn!='name'}{$attn}="{$attv}"{/if}{/foreach}/> 
                        {/if}
                    </li>
                    {/if}
                {/foreach}
            </ul>
            {/if}
            <div class="clear"></div>
        </div>
        <div class="blu">	
            <table border="0" cellpadding="2" cellspacing="0" >
                <tr>
                    <td><a href="?cmd={$cmd}"><strong>&laquo; {$lang.backto} 工单视图</strong></a>&nbsp;</td>
                    <td><input type="submit" name="save" value="{$lang.Save}" style="font-weight:bold;"/></td>                            
                </tr>
            </table>
        </div>
        {securitytoken}
    </form>
{elseif $action=='view'}
    
    {include file='ajax.tickets.tpl'}
    
{/if}