{if $showlog}
    <div class="right"><strong><a href="javascript:void(0)" onclick="$('#ticket_log').hide();">{$lang.Hide}</a></strong></div>
    <div class="clear"></div>
    <table border="0" width="100%" class="tlog">
        {foreach from=$showlog item=log}
            <tr>
                <td class="light" align="right" width="140">{$log.date|dateformat:$date_format}</td>
                <td>{$log.action}</td>
            </tr>
        {/foreach}
    </table>
{/if}

{if $quote}
    {$quote}
{elseif $draftdate}
    {$lang.draftsavedat}{$draftdate|dateformat:$date_format}
{/if}
{if $action=='menubutton' && $make=='poll'}
    {foreach from=$tickets item=ticket}
        <tr {if $ticket.escalated == 1}class="sla_level_one"{elseif $ticket.escalated > 1}class="sla_level_two"{/if}>
            {if $tview}
                {include file="ajax.ticketviews.tpl" display=trow}
            {else}
                <td width="20"><input type="checkbox" class="check" value="{$ticket.id}" name="selected[]"/></td>
                <td>{if $ticket.client_id!='0'}<a href="?cmd=clients&action=show&id={$ticket.client_id}">{/if}{$ticket.name}{if $ticket.client_id!='0'}</a>{/if}</td>
                <td class="subjectline">
                    <div class="df1">
                        <div class="df2">
                            <div class="df3">
                                <a href="?cmd=tickets&action=view{if $backredirect}&brc={$backredirect}{/if}{if $currentdept && $currentdept!='all'}&dept={$currentdept}{/if}{if $currentlist && $currentlist!='all'}&list={$currentlist}{/if}&num={$ticket.ticket_number}" class="tload2 {if $ticket.admin_read=='0'}unread{/if}" rel="{$ticket.ticket_number}">{$ticket.tsubject|wordwrap:80:"\n":true|escape}</a>
                            </div>
                        </div>
                    </div>
                </td>
                <td class="tagnotes">
                    {if $ticket.flags & 1}
                        <div class="right hasnotes ticketflag-note" title="包含管理员备注的工单"></div>
                    {/if}
                    {if $ticket.flags & 2}
                        <div class="right ticketflag-bill" title="额外付费的工单"></div>
                    {/if}
                    {if $ticket.flags & 4}
                        <div class="right ticketflag-writing" title="另一名员工开始写这分工单的回复"></div>
                    {/if}
                    {if $ticket.tags}
                        <div class="right inlineTags">
                            {foreach from=$ticket.tags item=tag name=tagloop}
                                {if $smarty.foreach.tagloop.index < 3} 
                                    <span>{$tag.tag}</span>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}
                </td>
                <td><span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if} class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if} </span></td>
                <td class="subjectline">{$ticket.rpname}</td>
                <td class="border_{$ticket.priority}">{$ticket.lastreply}</td>
            {/if}
        </tr>
    {/foreach}
{elseif $action=='menubutton' && $make=='getrecent'}
    {if $reply}
        <div class="ticketmsg{if $reply.type!='Admin'} ticketmain{/if}" id="reply_{$reply.id}"><input type="hidden" name="viewtime" class="viewtime" value="{$reply.viewtime}"/>
            <div class="left">
                {if $reply.type!='Admin' && $ticket.client_id}
                    <a href="?cmd=clients&action=show&id={$ticket.client_id}" target="_blank">
                    {/if}
                    <strong {if $reply.type=='Admin'}class="adminmsg"{else}class="clientmsg reply_{$reply.type}"{/if}>
                        {$reply.name}</strong> 
                        {if $reply.type!='Admin' && $ticket.client_id}
                    </a>
                {/if}
                {if $reply.type=='Admin'}
                    {$lang.staff}
                {elseif $reply.replier_id!='0'}
                    {$lang.client}
                {/if}, {$lang.wrote}
            </div>

            <div class="right">{$lang.replied} {$reply.date|dateformat:$date_format}&nbsp;&nbsp;&nbsp;</div>
            <div class="clear"></div>
            <p> {$reply.body|httptohref|nl2br} </p>
        </div>
    {/if}
{elseif $action=='menubutton' && $make=='editreply'}
	<p id="msgbody{$reply.id}">{$reply.newbody|httptohref|regex_replace:"/[^\S\n]+\n/":"<br>"|nl2br}</p>
	<div class="editbytext fs11" style="color:#555; font-style: italic">{$lang.lastedited} {$reply.editby} at {$reply.lastedit|dateformat:$date_format}</div>
{elseif $action=='menubutton' && $make=='loadnotes'}
    {if $adminnotes}
        {foreach from=$adminnotes item=entry name=adminnt}
            <tr class="admin-note {if $smarty.foreach.adminnt.index%2!=0}odd{/if}">
                <td class="first">{$entry.date|dateformat:$date_format}</td>
                {assign var='admincolor' value=$entry.color%17}
                <td>
                    <small class="right" ><a href="#{$entry.id}" class="ticketnotesremove">[{$lang.Remove}]</a></small>
                    <strong class="admincolor{$admincolor}" style="color:#{if $ucolors.$admincolor}{$ucolors.$admincolor}{else}000{/if}">{$entry.name}</strong>  
                    <div class="admin-note-body">{$entry.note|escape:'html':'UTF-8'|httptohref:'html'}</div>
                    {if !empty($entry.attachments[0])}
                        <div class="admin-note-attach">
                        {foreach from=$entry.attachments item=attachment}
                            <div class="attachment"><a href="?cmd=root&action=download&type=downloads&id={$attachment.id}">{$attachment.name}</a></div>
                        {/foreach}
                        </div>
                    {/if}
                </td>  
            </tr>
        {/foreach}
    {/if}   
{elseif $action=='getclients'}
    {foreach from=$clients item=cl}
        <option {if $cl.id == $client_id}selected="selected"{/if} value="{$cl.id}">#{$cl.id} {if $cl.companyname!=''}{$lang.Company}: {$cl.companyname}{else}{$cl.lastname} {$cl.firstname}{/if}</option>
    {/foreach}
{elseif $action=='default'}
	{if $tickets}
		{if $showall}
                    
                    <form action="" method="post" id="testform" >
                        <div class="bottom-fixed" style="display:none">
                            <div style="position: relative">
                                <a href="#" class="menuitm hasMenu" id="bulk_macro">{$lang.applymacro}: <span class="morbtn">{$lang.none}</span><input type="hidden" name="bulk_macro"/></a>
                                <a href="#" class="menuitm hasMenu" id="bulk_dept">{$lang.department}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_dept"/></a>
                                <a href="#" class="menuitm hasMenu" id="bulk_priority">{$lang.setpriority}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_prio"/></a>
                                <a href="#" class="menuitm hasMenu" id="bulk_status">{$lang.status}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_status"/></a>
                                <a href="#" class="menuitm hasMenu" id="bulk_owner">{$lang.assignto}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_owner"/></a>

                                {if $agreements}
                                    <a href="#" class="menuitm hasMenu" id="bulk_share">{$lang.sharewith}: <span class="morbtn">{$lang.nochange}</span><input type="hidden" name="bulk_share"/></a>
                                    {/if}
                                <br />
                                <div class="left ticketsTags" style="position:relative; width:400px;line-height: 14px; padding: 1px 0 0 5px; border: 1px solid #ddd; background: #fff; margin-right: 3px; overflow: visible">
                                    <label style="position:relative" for="tagsin" class="input">
                                        <em style="position:absolute">{$lang.tags}</em>
                                        <input id="tagsin" autocomplete="off" style="width: 80px">
                                        <ul style="overflow-y:scroll; max-height: 100px; bottom: 21px; left: -7px"></ul>
                                    </label>
                                </div>
                                <div id="bulk_tags" style="display: none"></div>


                                <input type="checkbox" onchange="$(this).next().slideToggle(); if(!$('#bulk_status input').val().length) dropdown_handler('Answered', $('#bulk_status'), null, $('#bulk_status_m').find('a[href=Answered]').html());" name="bulk_reply"/> {$lang.addreply} 
                                <textarea style="width: 99%; display: none" name="bulk_message"></textarea>
                                <a name="bulk_actions" rel=".bottom-fixed form" href="#" class="submiter menuitm greenbtn" onclick="$(this).parents('.bottom-fixed').slideUp('fast');">应用选定</a>

                                <ul id="bulk_macro_m" class="ddmenu" load="?cmd=predefinied&action=getmacros">
                                    <li><a href="0">{$lang.none}</a></li>
                                        {foreach from=$macros item=macro}
                                        <li><a href="{$macro.id}">{$macro.name}</a></li>
                                        {/foreach}
                                </ul>
                                <ul id="bulk_dept_m" class="ddmenu">
                                    <li><a href="0">{$lang.nochange}</a></li>
                                        {foreach from=$myDepartments item=dept}
                                            {if $dept.id}
                                            <li><a href="{$dept.id}">{$dept.name}</a></li>
                                            {/if}
                                        {/foreach}
                                </ul>
                                <ul id="bulk_priority_m" class="ddmenu">
                                    <li><a href="">{$lang.nochange}</a></li>
                                    <li class="opt_low" ><a href="0">{$lang.Low}</a></li>
                                    <li class="opt_medium" ><a href="1">{$lang.Medium}</a></li>
                                    <li class="opt_high"><a href="2">{$lang.High}</a></li>
                                </ul>
                                <ul id="bulk_status_m" class="ddmenu">
                                    <li><a href="">{$lang.nochange}</a></li>
                                        {foreach from=$statuses item=status}
                                        <li><a href="{$status}">{$lang.$status}</a></li>
                                        {/foreach}
                                </ul>
                                <ul id="bulk_owner_m" class="ddmenu" >
                                    <li><a href="0">{$lang.nochange}</a></li>
                                        {foreach from=$staff_members item=stfmbr}
                                        <li><a href="{$stfmbr.id}">{$stfmbr.lastname} {$stfmbr.firstname}</a></li>
                                        {/foreach}
                                </ul>
                                <ul id="bulk_share_m" class="ddmenu">
                                    <li><a href="0">{$lang.nochange}</a></li>
                                        {foreach from=$agreements item=agreement}
                                        <li><a href="{$agreement.uuid}">{$lang.sharewith} #{$agreement.tag}</a></li>
                                        {/foreach}
                                </ul>
                            </div>
                {literal}
                    <script type="text/javascript">
                    $(function () {
                        $('.bottom-fixed .hasMenu').dropdownMenu({}, function (a, o, p, h) {
                            dropdown_handler(a, o, p, h)
                        });
                    });
                    ticket.bindTagsActions('.bottom-fixed .ticketsTags', 0,
                        function (tag) {
                            $('#bulk_tags').append('<input type="hidden" name="bulk_tags[]" value="' + tag.replace(/"/g,'&quote;') + '" />');
                            repozition();
                        },
                        function (tag) {
                            repozition();
                            $('#bulk_tags input[value="' + tag + '"]').remove();
                        }
                    );

                    $('#testform').undelegate('input.check, #checkall', 'change').delegate('input.check, #checkall', 'change', showhide_bulk);
                    if(!$('.bottom-fixed').data('check')){
                        $(document).ajaxStop(showhide_bulk);
                        $('.bottom-fixed').data('check', true);
                    }
                    </script>
                {/literal}
                </div>
                <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="left menubar">
                        {$lang.withselected}
                        <a   class="submiter menuitm menuf confirm" name="markmerged"   href="#" ><span >{$lang.Merge}</span></a><a   class="submiter menuitm menuc" name="markasread"  href="#" ><span >{$lang.markasread}</span></a><a   class="submiter menuitm menuc" name="markclosed"  href="#" ><span >{$lang.Close}</span></a><a   class="submiter menuitm confirm menul" name="markdeleted" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>
                    </div>
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {if $tview}
                    <a href="?cmd={$cmd}&tview={$tview.id}" id="currentlist" style="display:none" updater="#updater"></a>
                {else}
                    <a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}" id="currentlist" style="display:none" updater="#updater"></a>
                {/if}
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            {if $tview}
                                {include file="ajax.ticketviews.tpl" display=theaders}
                            {else}
                                <th width="20"><input type="checkbox" id="checkall"/></th>
                                <th width="190"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=name|ASC"  class="sortorder">{$lang.Client}</a></th>
                                <th><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                                <th class="tagnotes"></th>
                                <th width="100"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                                <th width="120"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=rp_name|ASC"  class="sortorder">{$lang.lastreplier}</a></th>
                                <th  width="110" class="lastelb"><a href="?cmd=tickets&list={$currentlist}{if $currentdept}&dept={$currentdept}{/if}{$assigned}&orderby=priority DESC,t.lastreply|ASC"  class="sortorder">{$lang.Lastreply}</a></th>
                                {/if}
                        </tr>
                    </tbody>
                    <tbody id="updater">
                    {/if}
                    {include file="ajax.tickets.tpl" action=menubutton make=poll}
                    {literal}
                    <script type="text/javascript"> 
                            var tdwidth=notew=0;$(".hasnotes").length&&(notew=$(".hasnotes").outerWidth(!0)),$(".tagnotes").each(function(){var a=0;$(this).children().each(function(){a+=$(this).outerWidth(!0)}),a>tdwidth&&(tdwidth=a)}),$(".tagnotes").width(tdwidth+notew)
                    </script> 
                {/literal}
                {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th></th>
                            <th {if $tview}colspan="{$columns_count+1}"{else}colspan="6"{/if}>
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
				<div class="blu">
					<div class="right">
						<div class="pagination"></div>
					</div>
					<div class="left menubar">

						{$lang.withselected}
						<a   class="submiter menuitm menuf" name="markmerged"   href="#" ><span >{$lang.Merge}</span></a><a   class="submiter menuitm menuc" name="markasread"  href="#" ><span >{$lang.markasread}</span></a><a   class="submiter menuitm menuc" name="markclosed"  href="#" ><span >{$lang.Close}</span></a><a   class="submiter menuitm confirm menul" name="markdeleted" href="#" ><span style="color:#FF0000">{$lang.Delete}</span></a>

					</div>
					<div class="clear"></div>
				</div>
				{securitytoken}
			</form>
			{if $ajax}
				<script type="text/javascript">bindEvents();</script>
			{/if}
		{/if}
                
		{if $ajax}
			<script type="text/javascript">bindTicketEvents();</script>
		{/if}
	{else}
            {if $showall}
                <div id="blank_state" class="blank_state blank_news" style="padding:0 15px ">
                    <div class="blank_info">
                        {if !$enableFeatures.support}
                            <h1>在您的系统里功能未启用</h1>
                        {elseif $assigned}
                            <h1>{$lang.nothingtodisplay}</h1>
                            {$lang.nothing_assigned}
                        {elseif $currentdept=='all'}
                            <h1>{$lang.nothingtodisplay}</h1>
                            {$lang.nothing_here}  
                            <div class="clear"></div>
                            <a style="margin-top:10px" href="?cmd=tickets&action=new" class="new_add new_menu"><span>{$lang.opensupticket}</span></a>
                                {else}
                            <h1>{$lang.nothingtodisplay}</h1>
                            {$lang.nothing_indept}
                        {/if}
                    </div>
                    <script type="text/javascript">var he = $('#blank_state').height()/ 2; $('#blank_state').css('padding-top', ($('#blank_state').parent().parent().height()/2) - he).css('padding-bottom', ($('#blank_state').parent().parent().height()/2) - he)</script>
                </div>
            {else}
                <tr>
                    <td colspan="7"><p align="center" >{$lang.nothingtodisplay}</p></td>
                </tr>
            {/if}
        {/if}
{elseif $action=='clienttickets'}
    <div class="blu" style="text-align:right">
        <form action="?cmd=tickets&action=new" method="post">
            <input type="hidden" name="client_id" value="{$client_id}" />
            <input type="submit" value="{$lang.opennewticket}" onclick="window.location='?cmd=tickets&action=new&client_id={$client_id}';return false;"/>{securitytoken}
        </form>
    </div>
    {if $tickets}
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
                <tr>

                    <th>{$lang.datesubmitted}</th>
                    <th>{$lang.department}</th>
                    <th>{$lang.Subject}</th>

                    <th>{$lang.Status}</th>
                    <th class="lastelb">{$lang.Lastreply}</th>

                </tr>
            </tbody>
            <tbody >
                {foreach from=$tickets item=ticket}
                    <tr>
                        <td>{$ticket.date|dateformat:$date_format}</td>
                        <td>{$ticket.deptname}</td>
                        <td>
                            <a {if $ticket.admin_read=='0'}style="font-wight:bold"{/if} href="?cmd=tickets&action=view&list={$currentlist}&num={$ticket.ticket_number}" class="tload2" rel="{$ticket.ticket_number}">{$ticket.tsubject|wordwrap:80:"\n":true|escape}</a>
                        </td>
                        <td>
                            <span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if} class="{$ticket.status}">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if}</span>
                        </td>
                        <td class="border_{$ticket.priority}">{$ticket.lastreply}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        {if $totalpages}
            <center class="blu">
                <strong>{$lang.Page} </strong>
                {section name=foo loop=$totalpages}
                    {if $smarty.section.foo.iteration-1==$currentpage}
                        <strong>{$smarty.section.foo.iteration}</strong>
                    {else}
                        <a href='?cmd=tickets&action=clienttickets&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
                    {/if}
                {/section}
            </center>
            <script type="text/javascript">
                {literal}
			 $('a.npaginer').click(function(){
				 ajax_update($(this).attr('href'), {}, 'div.slide:visible');
				 return false;
			 });
                {/literal}
            </script>
        {/if}
    {else}
        <strong>{$lang.nothingtodisplay}</strong>
    {/if}
{elseif $action=='getadvanced'}
    <div class="filter-actions">
        {if $tview}
            <a href="?cmd={$cmd}&tview={$tview.id}&resetfilter=1" {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
        {else}
            <a href="?cmd=ticketviews&action=fromfilter"  {if $currentfilter}style="display:inline"{/if} ><b>创建视图</b></a>
            <a href="?cmd=tickets&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        {/if}
    </div>
    <form class="searchform filterform" action="?cmd=tickets" method="post" onsubmit="return filter(this)">
        <table width="100%" cellspacing="2" cellpadding="3" border="0" class="">
            <tbody>
                <tr>
                    <td width="15%">{$lang.Searchin}</td>
                    <td><select name="filter[status]">
                            <option value="">{$lang.Anystatus}</option>
                            {foreach from=$statuses item=st}
                                <option {if $currentfilter.status==$st}selected="selected"{/if} value="{$st}">{if $lang.$st}{$lang.$st}{else}{$st}{/if}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td width="15%">{$lang.submitername}</td>
                    <td><input type="text" value="{$currentfilter.name}" size="40" name="filter[name]"/></td>
                </tr>
                <tr>
                    <td>{$lang.department}</td>
                    <td>
                        <select name="filter[dept_id]">
                            <option value="">{$lang.Anydepartment}</option>
                            {foreach from=$departments item=dept}
                                <option value="{$dept.id}"  {if $currentfilter.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                            {/foreach}
                        </select></td>
                    <td>{$lang.ticketnum}</td>
                    <td><input maxlength="6" size="10" name="filter[ticket_number]"/></td>
                </tr>
                <tr>
                    <td>{$lang.Message}</td>
                    {assign value='body|rp_body' var=rpbody}
                    <td><input type="text" value="{$currentfilter.$body}" size="40" name="filter[body]" /></td>
                    <td>{$lang.email}</td>
                    <td><input type="text" value="{$currentfilter.email}" size="40" name="filter[email]"/></td>
                </tr>
                <tr>
                    <td>{$lang.tags}</td>
                    <td >
                        <input type="text" value="{$currentfilter.tag|escape}" size="40" name="filter[tag]" style="width:200px;" /> 
                        <a href="#" id="tagdescr" class="vtip_description" title="您可以使用 &quot;和&quot;, &quot;或&quot;, &quot;不是&quot; 关键词当过滤标签时, 默认为 &quot;和&quot;, 例如: <br> &bullet;&nbsp;tag1 tag2 或 tag3 &raquo; (tag1 和 tag2) 或 tag3"></a>
                        <script type="text/javascript">$("#tagdescr").vTip();</script>
                        {*}<select name="filter[_tag]"  style="width:56px;">
                            <option {if $currentfilter._tag=='any'}selected="selected"{/if} value="any">任意</option>
                            <option {if $currentfilter._tag=='all'}selected="selected"{/if} value="all">所有</option>
                        </select>{*}
                    </td>
                    <td>仅限未读</td>
                    <td ><input type="checkbox" name="filter[admin_read]" {if $currentfilter.body=="0"}checked="checked"{/if} value="0" /></td>

                </tr>
                <tr>
                    <td>分配给</td>
                    <td >
                        <select name="filter[owner_id]" >
                            <option value=""> - </option>
                            {foreach from=$staff_members item=stfmbr}
                                <option value="{$stfmbr.id}" {if $currentfilter.body==$stfmbr.id}selected="selected"{/if}>
                                    {$stfmbr.lastname} {$stfmbr.firstname}
                                </option>
                            {/foreach}
                        </select>
                    </td>
                    <td></td>
                    <td ></td>
                </tr>
                <tr><td colspan="4"><center><input type="submit" value="{$lang.Search}" />&nbsp;&nbsp;&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/></center></td></tr>
            </tbody>
        </table>
        {securitytoken}
    </form>

    <script type="text/javascript">bindFreseter();</script>

{elseif $action=='view' && $ticket}
	<input type="hidden" id="ticket_number" name="ticket_number" value="{$ticket.ticket_number}" />
	<input type="hidden" id="ticket_id" name="ticket_id" value="{$ticket.id}" />
        <div class="blu">
            <div class="menubar">
                <a href="{if $backlink}{$backlink}{else}?cmd=tickets&list={$currentlist}{/if}&showall=true"  class="tload2"  id="backto">
                    <strong>&laquo; {$lang.backto} {if $currentlist == 'open'}{$lang.Open}{elseif $currentlist == 'answered'}{$lang.Answered}{elseif $currentlist == 'closed'}{$lang.Closed}{elseif $currentlist == 'client-reply'}{$lang.Clientreply}{elseif $currentlist == 'in-progress'}{$lang.Inprogress}{elseif $currentlist == 'all'}{$lang.all}{else}{$currentlist}{/if} {$lang.tickets}</strong>
                </a>
                <a class="setStatus menuitm menuf" href="#" id="hd1" onclick="return false;" >
                    <span class="morbtn">{$lang.Setstatus}</span>
                </a>
                <a class="setStatus menuitm menuc" id="hd4" onclick="return false;" >
                    <span class="morbtn">{$lang.setpriority}</span>
                </a>
                <a   class="setStatus menuitm  menul"   href="#" id="hd3" onclick="return false;" >
                    <span class="morbtn">{$lang.blocktickets}</span>
                </a>

                <a class="menuitm menuf deleteTicket" href="#" >
                    <span style="color:red">{$lang.Delete}</span>
                </a>
                {if count($staff_members) > 1}
                    <a class="menuitm setStatus menuc" id="hd6" onclick="return false;" href="#" >
                        <span class="morbtn">{if $ticket.owner_id}{foreach from=$staff_members item=stfmbr}{if $stfmbr.id==$ticket.owner_id}分配给 {$stfmbr.lastname} {$stfmbr.firstname}{break}{/if}{/foreach}{else}分配给{/if}</span>
                    </a>
                    <a class="menuitm setStatus menuc" id="hd7" onclick="return false;" href="#" >
                        <span class="morbtn">订阅</span>
                    </a>
                {/if}
                <a class="menuitm setStatus menul" id="hd2" onclick="return false;" href="#" >
                    <span class="morbtn">{$lang.moreactions}</span>
                </a>

                <ul id="hd4_m"  class="ddmenu">
                    <li class="opt_low {if $ticket.priority=='0'}disabled{/if}"><a href="Low">{$lang.Low}</a></li>
                    <li  class="opt_medium {if $ticket.priority=='1'}disabled{/if}"><a href="Medium">{$lang.Medium}</a></li>
                    <li  class="opt_high {if $ticket.priority=='2'}disabled{/if}"><a href="High">{$lang.High}</a></li>
                </ul>

                <ul id="hd1_m"  class="ddmenu">
                    {foreach from=$statuses item=status}
                        <li class="act_{$status|lower} {if $ticket.status==$status}disabled{/if}"><a href="status|{$status}">{$lang.$status}</a></li>
                    {/foreach}
                </ul>
                {if count($staff_members) > 1}
                    <ul class="ddmenu" id="hd6_m">
                        {if $ticket.owner_id}
                            <li><a href="assign:0">移除分配</a></li>
                        {/if}
                    {foreach from=$staff_members item=stfmbr}
                        <li><a href="assign:{$stfmbr.id}">{$stfmbr.lastname} {$stfmbr.firstname}</a></li>
                    {/foreach}
                    </ul>
                    <ul class="ddmenu" id="hd7_m">
                        {if $ticket.subscriptions}
                            <li><a href="assign:0:1">移除所有</a></li>
                            {/if}
                            {foreach from=$staff_members item=stfmbr}
                                {if $stfmbr.id != $ticket.owner_id}
                                    <li><a href="assign:{$stfmbr.id}:1{if in_array($stfmbr.id,$ticket.subscriptions)}:1{/if}">{if in_array($stfmbr.id,$ticket.subscriptions)}移除{else}添加{/if} {$stfmbr.firstname} {$stfmbr.lastname}</a></li>
                                {/if}
                            {/foreach}
                    </ul>
                {/if}
                <ul id="hd2_m" class="ddmenu">
                    <li><a href="Unread">{$lang.markunread}</a></li>
                    <li><a href="ShowLog">{$lang.viewticketlog}</a></li>
                    {if $ticket.share}
                        <li><a href="unshare">{$lang.unshare}</a></li>
                    {else}
                        {foreach from=$agreements item=agreement}
                        <li><a href="share:{$agreement.uuid}">{$lang.sharewith} #{$agreement.tag}</a></li>
                        {/foreach}
                    {/if}
                </ul>
                <ul id="hd3_m" class="ddmenu">
                    <li><a href="blockEmail">{$lang.From} {$ticket.email}</a></li>
                    <li><a href="blockSubject" onclick="return false;">{$lang.withsamesubj}</a></li>
                    <li class="disabled highlighter"><a href="blockBody" onclick="return false;">{$lang.containinghightext}</a></li>
                </ul>
            </div>
        </div>
	<div id="ticket_log"></div>
	<div class="lighterblue" id="ticket_editdetails" style="display:none">
		<form action="?cmd={$cmd}&action={$action}&num={$ticket.ticket_number}" method="post" id="ticket_editform"></form>
	</div>
	<div id="ticketbody">
		<h1 {if $ticket.priority=='1'}class="prior_Medium"{elseif $ticket.priority=='2'}class="prior_High"{/if}>#{$ticket.ticket_number} - {$ticket.subject|wordwrap:100:"\n":true|escape}
			<span {if $ticket.status_color && $ticket.status_color != '000000'}style="color:#{$ticket.status_color}"{/if} class="{$ticket.status}" id="ticket_status">{if $ticket.status == 'Open'}{$lang.Open}{elseif $ticket.status == 'Answered'}{$lang.Answered}{elseif $ticket.status == 'Closed'}{$lang.Closed}{elseif $ticket.status == 'Client-Reply'}{$lang.Clientreply}{elseif $ticket.status == 'In-Progress'}{$lang.Inprogress}{else}{$ticket.status}{/if}</span>
		</h1>
		{literal}
			<script type="text/javascript">
				$(function(){
					
					ticket.bindTagsActions('#tagsCont', 10, 
                        function(tag){$.post('?cmd=tickets&action=addtag', {tag:tag, id:$('#ticket_number').val()}, function(data){ticket.updateTags(data.tags)});}, 
                        function(tag){$.post('?cmd=tickets&action=removetag', { tag: tag, id:$('#ticket_number').val()}, function(data){if(typeof data != 'undefined' && typeof data.reloadwhole != 'undefined' && data.reloadwhole == true){ ajax_update('?cmd=tickets&action=view&list=all&num='+$('#ticket_number').val(),{},'#bodycont');}else if(typeof data != 'undefined'){ticket.updateTags(data.tags);if(data.tickettags !== undefined){insertTags(data.tickettags);}}});});

					$(document).off('click','#tagsCont span a:first-child').on('click','#tagsCont span a:first-child', function(){
						window.open('?cmd=tickets&filter[tag]='+$(this).text());
					});
				});

			</script>
		{/literal}
		<div id="tagsCont">
			{foreach from=$tags item=tag}
				<span class="tag"> <a{if $specialtags.$tag} class="{$specialtags.$tag}"{/if} >{$tag}</a> |<a class="cls">x</a></span>
			{/foreach}
			<label style="position:relative" for="tagsin">
				<em style="position:absolute">{$lang.tags}</em>
				<input id="tagsin">
				<ul></ul>
			</label>
			<div class="clear"></div>
		</div>
		
                {if $ticket.client_id!='0'}
                    <div id="client_nav">
                        <!--navigation-->
                        <a class="nav_el nav_sel left" href="#">{$lang.ticketmessage}</a>
                        {include file="_common/quicklists.tpl"}
                        <div class="clear"></div>
                    </div>
                {else}
                    <div id="client_nav">
                        <!--navigation-->
                        <a class="nav_el nav_sel left" href="#">{$lang.ticketmessage}</a>
                        <div>
                            <span class="left" style="padding-top:5px;padding-left:5px;">
                                <form action="?cmd=newclient" method="post" target="_blank">
                                    <a href="#" onclick="$(this).parent().submit(); return false;">注册未新用户</a>
                                    <input type="hidden" name="email" value="{$ticket.email}" />
                                    <input type="hidden" name="lastname" value="{$ticket.name|regex_replace:"/^[^ ]+\s?/":'$1'|escape}" />
                                    <input type="hidden" name="firstname" value="{$ticket.name|regex_replace:"/^([^ ]+)\s.+$/":'$1'|escape}" />
                                    <input type="hidden" name="ticket_id" value="{$ticket.id}" />
                                </form>
                            </span>
                        </div>
                        <div class="clear"></div>
                    </div>
                {/if}
		<div class="ticketmsg {if $ticket.type!='Admin'}ticketmain{/if}"  id="client_tab">
                    <div class="slide" style="display:block">
                        <div class="left">
                            {if $ticket.client_id!='0'  && $ticket.type!='Admin'}
                                <a href="?cmd=clients&action=show&id={$ticket.client_id}" target="_blank">
                            {/if}
                                <strong {if $ticket.type=='Admin'}class="adminmsg"{else}class="clientmsg reply_{$ticket.type}"{/if}>{$ticket.name}</strong>
                            {if $ticket.client_id!='0'  && $ticket.type!='Admin'}
                                </a>
                            {/if}
                            {if $ticket.client_id!='0' && $ticket.type=='Client'}{$lang.client}
                            {elseif $ticket.type=='Admin'}{$lang.staff}
                            {/if}, {$lang.wrote}
                            {if $ticket.type!='Admin' && $ticket.email}
                                <div style="color: rgb(153, 153, 153); font-size: 11px; width: 200px; line-height: 12px;">{$ticket.email}</div>
                            {/if}
                        </div>
                        
                        <div class="tdetails auto-height" style="float: right; border-left: 1px solid #bbb; background: #f7f7f7; padding: 5px; margin: -5px -5px -5px 15px; width: 230px;">
                            <a href="#" class="editTicket fs11 right" onclick="$(this).toggle().next().toggle()">编辑详情</a>
                            <a href="#" class="editTicket editbtn none right" onclick="$(this).toggle().prev().toggle()">保存详情</a>
                            <table border="0" width="100%">
                                <tr>
                                    <td align="right" class="light" style="min-width: 90px">{$lang.department}:</td>
                                    <td align="left">
                                        <strong>{$ticket.deptname}</strong>
                                        <select class="inp" name="deptid" style="display: none; width: 221px">
                                            {foreach from=$departments item=dept}
                                                <option value="{$dept.id}" {if $ticket.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="light">{$lang.submitter}</td>
                                    <td align="left">
                                        <span>{$ticket.name|escape}</span>
                                        <input name="name" value="{$ticket.name|escape}" style="display: none; width: 250px" class="inp"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="light">{$lang.asignedclient}</td>
                                    <td align="left">
                                        <span>
                                            {if $ticket.client_id}#{$ticket.client_id} {$client.lastname} {$client.firstname}
                                            {else}{$lang.notreg}
                                            {/if}
                                        </span>
                                        <div style="display: none;">
                                            <select class="inp" style="width: 255px;" name="owner_id"  load="clients" default="{$ticket.client_id}">
                                                <option value="0">{$lang.notreg}</option>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                {if !$ticket.share || $ticket.share=='master'}
                                    <tr>
                                        <td align="right"  class="light">{$lang.emaill|capitalize}</td>
                                        <td align="left">
                                            <div class="fold-text"><a href="mailto:{$ticket.email}">{$ticket.email}</a></div>
                                            <input name="email" value="{$ticket.email}" style="display: none; width: 250px" class="inp"/>
                                        </td>
                                    </tr>
                                {else}
                                    <tr>
                                        <td align="right"  class="light">{$lang.author_uuid}</td>
                                        <td align="left">
                                            <div class="fold-text">{$ticket.email}</div>
                                            <input name="email" value="{$ticket.email}" style="display: none; width: 250px" class="inp"/>
                                        </td>
                                    </tr>
                                {/if}
                                <tr style="display:none" class="sh_row force">
                                    <td align="right" class="light">{$lang.subject|capitalize}</td>
                                    <td align="left">
                                        <div class="fold-text">{$ticket.subject|escape}</div>
                                        <input name="subject" value="{$ticket.subject|escape}"  style="display: none; width: 250px" class="inp"/>
                                    </td>
                                </tr>
                                <tr {if !$ticket.cc}style="display:none"{/if} class="sh_row">
                                    <td align="right" class="light">抄送CC</td>
                                    <td align="left">
                                        <div class="fold-text">{if $ticket.cc}{$ticket.cc}{else}{$lang.none}{/if}</div>
                                        <input name="cc" value="{$ticket.cc}"  style="display: none; width: 250px" class="inp"/>
                                    </td>
                                </tr>
                                <tr {if !$ticket.owner_id}style="display:none"{/if} class="sh_row">
                                    <td align="right" class="light">分配给</td>
                                    <td align="left">
                                        <span>
                                            {if $ticket.owner_id}
                                                {foreach from=$staff_members item=stfmbr}
                                                    {if $stfmbr.id==$ticket.owner_id}
                                                        {$stfmbr.lastname} {$stfmbr.firstname}{break}
                                                    {/if}
                                                {/foreach}
                                            {else}
                                                {$lang.none}
                                            {/if}
                                        </span>
                                        <select name="owner" class="inp" style="display: none ; width: 221px">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$staff_members item=stfmbr}
                                                <option {if $stfmbr.id==$ticket.owner_id}selected="selected"{/if} value="{$stfmbr.id}">{$stfmbr.lastname} {$stfmbr.firstname}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" class="light">{$lang.IPaddress}</td>
                                    <td align="left">
                                        {if $ticket.senderip}{$ticket.senderip}
                                        {else}{$lang.none}
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"  class="light">{$lang.lastreply|capitalize}</td>
                                    <td align="left">
                                        {$ticket.lastreply|dateformat:$date_format}
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <script type="text/javascript">{literal}$(function(){if($('.auto-height').height() < $('#client_tab').height())$('.auto-height').css('min-height',$('#client_tab').height()+'px'); });$('.fold-text').click(function(){$(this).toggleClass('show')}){/literal}</script>
                        <div class="right">
                            <strong><a href="#reply" class="scroller">{$lang.Reply}</a></strong>
                        </div>
                        <div class="right">
                            <a href="#" class="editor">{$lang.Edit}</a>&nbsp;&nbsp;&nbsp;
                        </div>
                        <div class="right">
                            <a href="{$ticket.id}" class="quoter">{$lang.Quote}</a>&nbsp;&nbsp;&nbsp;
                        </div>
                        <div class="right" style="margin:0px 5px;">
                            <a href="#" class="quoter2">{$lang.Quoteselected}</a>
                        </div>
                        <div class="right">
                            {$lang.opened} {$ticket.date|dateformat:$date_format}
 
                            {if $ticket.type == 'Client'} using client area, logged in
                            {elseif $ticket.type == 'Unregistered'} from client area, not logged in
                            {elseif $ticket.type != 'Admin'} via Email
                            {/if}
                            &nbsp;&nbsp;&nbsp;
                        </div>
                        <div style="clear:left"></div>
                        <p id="msgbody"> {$ticket.body|httptohref|regex_replace:"/^\S\n]+\n/":"<br>"|nl2br} </p>
                    {if $ticket.editby != ''}<div class="editbytext fs11" style="color:#555; font-style: italic">{$lang.lastedited} {$ticket.editby} at {$ticket.lastedit|dateformat:$date_format}</div>{/if}
                    <div id="editbody{$reply.id}" style="overflow:hidden; display:none; margin: 9px 0 0">
                        <textarea style="width:100%"></textarea>
                        <div style="padding:5px 0">
                            <a href="{$reply.id}" class="menuitm editorsubmit"><span>{$lang.savechanges}</span></a> {$lang.Or} 
                            <a onclick="$('#msgbody{$reply.id}').show().siblings('.editbytext:first').show(); $('#editbody{$reply.id}').hide();return false" href="#" class="menuitm"><span>{$lang.Cancel}</span></a>
                        </div>
                    </div>
                    {if !empty($attachments[0])}
                        <hr />
                        {foreach from=$attachments[0] item=attachment}
                            <div class="attachment"><a href="?action=download&id={$attachment.id}">{$attachment.org_filename}</a></div>
                            {/foreach}

                    {/if}
                    <div style="clear:both"></div>
                </div>
                {include file="_common/quicklists.tpl" _placeholder=true}
        </div>
            {if $replies && !empty($replies) }

                {foreach from=$replies item=reply}

                    {if $reply.status!='Draft'}
                        <div class="ticketmsg{if $reply.type!='Admin'} ticketmain{/if}" id="reply_{$reply.id}">
                            <div class="left">
                                {if $reply.type!='Admin' && $reply.replier_id}
                                    <a href="?cmd=clients&action=show&id={$reply.replier_id}" target="_blank">
                                    {/if}
                                    <strong {if $reply.type=='Admin'}class="adminmsg"{else}class="clientmsg"{/if}>
                                        {$reply.name}
                                    </strong> 
                                    {if $reply.type!='Admin' && $reply.replier_id}
                                    </a>
                                {/if}
                                {if $reply.type=='Admin'}{$lang.staff}
                                {elseif $reply.replier_id!='0'}{$lang.client}
                                {/if}, {$lang.wrote}
                                {if $reply.type!='Admin' && $reply.email}
                                    <div style="color: rgb(153, 153, 153); font-size: 11px; width: 200px; line-height: 12px;">{$reply.email}</div>
                                {/if}
                            </div>
                            <div class="right replybtn"><strong><a href="{$reply.id}" class="deletereply">{$lang.Delete}</a> <a href="{$reply.id}" class="deletereply"><img src="{$template_dir}img/trash.gif" alt="{$lang.Delete}"/></a></strong></div>
                            <div class="right"><a href="{$reply.id}" class="editor" type="reply">{$lang.Edit}</a></div>
                            <div class="right"><a href="{$reply.id}" class="quoter" type="reply">{$lang.Quote}</a>&nbsp;&nbsp;&nbsp;</div>
                            <div class="right" style="margin:0px 5px;"><a href="#" class="quoter2">{$lang.Quoteselected}</a></div>
                            <div class="right">
                                {$lang.replied} {$reply.date|dateformat:$date_format} <span style="color:#555">id: {$reply.id}</span>
                                <span style="display: none;">
                                    {if $reply.type == 'Client'} 使用客户中心, 需要登录
                                    {elseif $reply.type == 'Unregistered'} 来自客户中心, 无需登录
                                    {elseif $reply.type != 'Admin'} 通过 Email
                                    {/if}
                                </span>
                                &nbsp;&nbsp;&nbsp;
                            </div>
                            <div class="clear"></div>
                            <p id="msgbody{$reply.id}"> {$reply.body|httptohref|regex_replace:"/[^\S\n]+\n/":"<br>"|nl2br}</p>
                            {if $reply.editby != ''}<div class="editbytext fs11" style="color:#555; font-style: italic">{$lang.lastedited} {$reply.editby} at {$reply.lastedit|dateformat:$date_format}</div>
                            {/if}
                            <div id="editbody{$reply.id}" style="overflow:hidden; display:none; margin: 9px 0 0">
                                <textarea style="width:100%"></textarea>
                                <div style="padding:5px 0">
                                    <a href="{$reply.id}" class="menuitm editorsubmit"><span>{$lang.savechanges}</span></a> {$lang.Or} 
                                    <a onclick="$('#msgbody{$reply.id}').show().siblings('.editbytext').show(); $('#editbody{$reply.id}').hide();return false" href="#" class="menuitm"><span>{$lang.Cancel}</span></a>
                                </div>
                            </div>
                            {if !empty($attachments[$reply.id])}
                                <hr />
                                {foreach from=$attachments[$reply.id] item=attachment}
                                    <div class="attachment"><a href="?action=download&id={$attachment.id}">{$attachment.org_filename}</a>
                                    </div>
                                {/foreach}
                            {/if} 
                        </div>
                    {/if}
                {/foreach}
            {/if}

            <div id="recentreplies"></div>
            <div style="{if !($ticket.flags & 1)}display:none;{/if}" id="ticketnotebox" >
                <div class="hr-info">
                    <span>
                        备注 <a title="备注是管理者和被分配该工单的员工给可见的. 客户无法看到您在这里所写的内容." class="vtip_description" style="padding-left:16px">&nbsp;</a>
                    </span>
                </div>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                    <tbody id="ticketnotes">

                        <tr class="odd">
                            <td></td>
                            <td> 加载中... <img src="{$template_dir}img/ajax-loading2.gif"> </td>
                        </tr>

                    </tbody>
                    <tbody>
                        <tr class="odd">
                            <td style="vertical-align: baseline; white-space: nowrap; padding: 5px">
                                <script src="{$template_dir}js/fileupload/init.fileupload.js?v={$hb_version}"></script>
                                <strong style="">{if $admindata.lastname!='' && $admindata.firstname!=''}{$admindata.lastname} {$admindata.firstname}{else}{$admindata.username}{/if}</strong>
                            </td>
                            <td width="100%">
                                <div class="admin-note-new">
                                <div class="admin-note-input">
                                    <textarea rows="4" id="ticketnotesarea" name="notes" class="notes_field notes_changed"></textarea>
                                    <div class="admin-note-attach"></div>
                                </div>
                                <div id="notes_submit" class="notes_submit admin-note-submit">
                                    <input value="{$lang.LeaveNotes}" type="button" id="ticketnotessave">
                                </div>
                                <a href="#" class="editbtn" id="ticketnotesfile">添加文件</a>
                            </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
           {if $enableFeatures.supportext}
           <div style="{if !($ticket.flags & 2)}display:none;{/if}" id="ticketbils" >
               <div class="hr-info">
                    <span>
                        实时跟踪 & 账单 <a title="您可以在这里添加收费服务工单. 添加了对应项目作为草稿, 以便于执行该工单的人员可以以此生成账单." class="vtip_description" style="padding-left:16px">&nbsp;</a>
                    </span>
                </div>
               <div class="ticket-msgbox">
                   加载中... <img src="{$template_dir}img/ajax-loading2.gif">
                   {if $ticket.flags & 2}<script type="text/javascript">{literal}$(function(){ticket.getBilling();}){/literal}</script>{/if}
               </div>
           </div>
           {/if}
	</div>

        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="replytable" {if $ticket.status=='Closed'}style="display:none"{/if}>
            <tr>
                <td valign="top" style="background:#E0ECFF" >
                    <div class="gbar">
                        <a href="#reply" name="reply" class="active bgo" onclick="return false;"><strong>{$lang.Reply}</strong></a>
                        <a href="#reply" name="notes" class="badd"  onclick="$(this).hide();$('#ticketnotebox').slideDown('fast');$('#ticketnotesarea').focus();return false;" style="{if $ticket.flags & 1}display:none;{/if}">{$lang.LeaveNotes}</a>
                        {if $enableFeatures.supportext}
                            <a href="#reply" name="notes" class="badd"  onclick="$(this).hide();ticket.getBilling();$('#ticketbils').slideDown('fast'); return false;" style="{if $ticket.flags & 2}display:none;{/if}">实时跟踪 & 账单</a>
                        {/if}
                        <div class="clear"></div>
                    </div>
                    <div class="blu" >
                        <div id="alreadyreply">
                            {foreach from=$replies item=reply}
                                {if $reply.status=='Draft' && $reply.replier_id!=$admindata.id}
                                    <span class="numinfos adminr_{$reply.replier_id}">
                                        <strong>{$reply.name}</strong> 
                                        {$lang.startedreplyat} {$reply.date|dateformat:$date_format} 
                                        <a href="#" onclick="ticket.loadReply('{$reply.id}');return false">{$lang.preview}</a>
                                    </span>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="imp_msg" id="justadded" style="display:none">
                            {$lang.newreplyjust}  &nbsp;&nbsp;&nbsp;&nbsp;
                            <a href="#" rel="{$ticket.viewtime}" id="showlatestreply"><strong>{$lang.updateticket}</strong></a>&nbsp;&nbsp;
                            <a href="#" onclick="$('#justadded').hide();return false;">{$lang.Hide}</a>
                        </div>

                        <form action="?cmd=tickets&action=view&num={$ticket.ticket_number}&list={$currentlist}" method="post" enctype="multipart/form-data" >
                            <input type="hidden" name="make" value="addreply" />
                            <div id="previewinfo" style="display:none">
                                <span class="right"><a href="#" onclick="$('#previewinfo').hide();return false">{$lang.hide}</a></span>
                                <span class="left"></span><span class="clear"></span>
                            </div>
                            <textarea style="width:99%" rows="14" id="replyarea" name="body">{*}
                                {*}{foreach from=$replies item=reply}{*}
                                    {*}{if $reply.status=='Draft' && $reply.replier_id==$admindata.id}{$reply.body}{*}
                                    {*}{/if}{*}
                                {*}{/foreach}{*}
                            {*}</textarea>
                            <div id="draftinfo">
                                <span class="draftdate" {foreach from=$replies item=reply}{if $reply.status=='Draft' && $reply.replier_id==$admindata.id}style="display:inline"{/if}{/foreach}>
                                    {foreach from=$replies item=reply}
                                        {if $reply.status=='Draft' && $reply.replier_id==$admindata.id}{$lang.draftsavedat}{$reply.date|dateformat:$date_format}
                                        {/if}
                                    {/foreach}
                                </span> 
                                <span class="controls" {foreach from=$replies item=reply}{if $reply.status=='Draft' && $reply.replier_id==$admindata.id}style="display:inline"{/if}{/foreach}>
                                    <a href="#" onclick="return ticket.savedraft()">{$lang.savedraft|capitalize}</a> 
                                    <a href="#" onclick="return ticket.removedraft()">{$lang.removedraft|capitalize}</a></span>
                            </div>
                            <a  class="attach" href="#" >{$lang.addattachment}</a> &nbsp;&nbsp;({$lang.allowedextensions} {$extensions})<br />
                            <div id="attachments"> </div>
                            <br />



                            <table border="0" cellspacing="0" cellpadding="3" width="100%">
                                <tr><td width="300">


                            <table border="0" cellspacing="0" cellpadding="3">
                                <tr>
                                    <td><strong>{$lang.Setstatus}: </strong></td>
                                    <td>
                                        <select name="status_change" class="inp" >
                                            {foreach from=$statuses item=status}
                                                <option value="{$status}" {if $status=='Answered'}selected="selected"{/if}>{$lang.$status}</option>
                                            {/foreach}
                                        </select> 
                                        <strong>&amp;</strong>
                                        <button name="justsend" value="{$lang.Send}" style="font-weight: bold;width: 94px;padding: 10px 20px;font-size: 12px;" id="ticketsubmitter" class=" new_control greenbtn">{$lang.Send}</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right"><input type="checkbox" name="send_save" onclick="$('label[for=\'replyaddid\']').next().toggle();" id="replyaddid"/> </td>
                                    <td colspan="2">
                                        <label style="float: left; min-width: 180px;line-height: 23px;" for="replyaddid">{$lang.asmacro}</label>
                                        <label style="display: none"><input class="inp" type="text" name="send_save_name" value=""/></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right"><input type="checkbox" name="send_save2" onclick="$('label[for=\'addasarticle\']').next().toggle();" id="addasarticle"/> </td>
                                    <td colspan="2">
                                        <label style="float: left; min-width: 180px;line-height: 23px;" for="addasarticle">{$lang.askbarticle}</label>
                                        <label style="display: none"><input class="inp" type="text" name="send_save_name2" value=""/></label>
                                    </td>
                                </tr>
                            </table>
                                    </td>
                                <td id="ticketwidgetarea" valign="top" style="padding:10px;background:#f5f9ff">
                                    {foreach from=$ticketwidgets item=ticketwidget}
                                        <a  class="new_control" href="?cmd={$ticketwidget.module}&ticket_id={$ticket.id}" style="margin:10px 10px 10px 0px;"><span>{$ticketwidget.modname}</span></a>
                                    {/foreach}
                                </td>
                                </tr>

                            </table>


                            <input type="hidden" id="backredirect" name="brc" value="{$backredirect}" />
                            {securitytoken}
                        </form>
                    </div>
                </td>
                <td valign="top" class="blu" style="padding: 0; width: 10px;">
                    <div style="height: 25px; width: 100%; background: rgb(247, 247, 247);"></div>
                    <div class="blu" style="width:237px;" id="ticketwidget">



                    </div>
                </td>
            </tr>
        </table>
	<div class="blu"> 
            <div class="menubar">
                <a href="?cmd=tickets&list={$currentlist}&showall=true"  class="tload2"  id="backto"><strong>&laquo; {$lang.backto} {if $currentlist == 'open'}{$lang.Open}{elseif $currentlist == 'answered'}{$lang.Answered}{elseif $currentlist == 'closed'}{$lang.Closed}{elseif $currentlist == 'client-reply'}{$lang.Clientreply}{elseif $currentlist == 'in-progress'}{$lang.Inprogress}{elseif $currentlist == 'all'}{$lang.all}{else}{$currentlist}{/if} {$lang.tickets}</strong></a>{*
                *}<a class="setStatus menuitm menuf"  href="#" id="hd1" onclick="return false;" ><span class="morbtn">{$lang.Setstatus}</span></a><a   class="setStatus menuitm menuc" id="hd4" onclick="return false;" ><span class="morbtn">{$lang.setpriority}</span></a>{*
                *}<a class="setStatus menuitm  menul"   href="#" id="hd3" onclick="return false;" ><span class="morbtn">{$lang.blocktickets}</span></a>
                <a class="menuitm menuf deleteTicket"    href="#" ><span style="color:red">{$lang.Delete}</span></a>{*
                *}{if $staff_members}{*
                *}<a class="menuitm setStatus menuc" id="hd6" onclick="return false;" href="#" >
                <span class="morbtn">{if $ticket.owner_id}{foreach from=$staff_members item=stfmbr}{if $stfmbr.id==$ticket.owner_id}分配给 {$stfmbr.lastname} {$stfmbr.firstname}{break}{/if}{/foreach}{else}分配给{/if}</span>
                </a>{*
                *}{/if}{*
                *}<a class="menuitm setStatus menul" id="hd2" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
            </div>
	</div>
	{if $ajax}
            <script type="text/javascript">bindEvents();bindTicketEvents();</script>
	{/if}

{elseif $action=='new'}
    <form action="?cmd=tickets&action=new" method="post" id="newticketform" enctype="multipart/form-data">
        <input type="hidden" name="make" value="createticket" />
        <input type="hidden" value="new" id="ticket_number" />
        <input type="hidden" name="useclientname" value="1" />
        <div class="lighterblue" style="padding:5px">
            <table width="100%" cellspacing="2" cellpadding="3" border="0" class="">
                <tbody>
                    <tr>
                        <td width="120px">{$lang.Client}</td>
                        <td>
                            <select name="client" id="client_picker" class="inp" load="clients" default="{if $submit.client}{$submit.client}{elseif $client_id}{$client_id}{else}0{/if}" style="width:340px">
                                <option value="-1"  {if $submit.client=='-1' && !$client_id}selected="selected"{/if}>{$lang.nonregistered}</option>
                                <option value="0" {if ($submit.client=='0' && !$client_id) || !isset($submit.client)}selected="selected"{/if}>{$lang.chooseone}</option>
                                {foreach from=$clients item=client}
                                    {if $submit.client==$client.id || $client_id==$client.id}
                                        <option value="{$client.id}" selected="selected">#{$client.id} {if $client.companyname!=''}{$client.companyname}{else}{$client.lastname} {$client.firstname}{/if}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </td>
                        <td></td>
                    </tr>
                    <tr id="emailrow2" {if !isset($submit.client) || $submit.client>'0'  || $client_id }style="display:none"{/if}>
                        <td>{$lang.Name}</td>
                        <td colspan="2"><input type="text" value="{$submit.name}" size="50" name="name"  class="inp"/></td>
                    </tr>

                    <tr id="emailrow" {if !isset($submit.client) || $submit.client>'0' || $client_id }style="display:none"{/if}>
                        <td>{$lang.email}</td>
                        <td colspan="2"><input type="text" value="{$submit.email}" size="50" name="email"  class="inp"/></td>
                    </tr>

                    <tr>
                        <td>{$lang.Subject}</td>
                        <td colspan="2">
                            <input type="text" value="{$submit.subject|escape}" size="75" name="subject" required="required"  class="inp"/>
                        </td>
                    </tr>
                    
                    <tr>
                        <td>{$lang.department}</td>
                        <td colspan="2">
                            <select name="dept_id" class="inp">
                                {foreach from=$departments item=dept}
                                    <option value="{$dept.id}" {if $submit.dept_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>{$lang.status}</td>
                        <td colspan="2">
                            <select name="status" class="inp">
                                {foreach from=$statuses item=status}
                                    <option value="{$status}" {if $submit.status==$status}selected="selected"{/if}>{$status}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>分配给</td>
                        <td>
                            <select name="owner_id" class="inp">
                                <option value="0">{$lang.none}</option>
                                {foreach from=$staff_members item=stfmbr}
                                    <option {if $stfmbr.id==$submit.owner_id}selected="selected"{/if} value="{$stfmbr.id}">{$stfmbr.lastname} {$stfmbr.firstname}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>抄送CC</td>
                        <td colspan="2">
                            <a href="#" onclick="$(this).hide();$('#addcc').show();return false;" {if $submit.cc}style="display:none"{/if} class="editbtn">{$lang.addcc}</a>
                            <div {if !$submit.cc}style="display:none"{/if} id="addcc">
                                 <input type="text" value="{$submit.cc}" size="75" name="cc" class="inp"/> <small>{$lang.addmanycoma}</small>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="top"><textarea rows="14" id="replyarea" name="body">{$submit.body}</textarea>
                            <div id="draftinfo"><span class="draftdate" {if $submit.date}style="display:inline"{/if}>{$lang.draftsavedat}{$submit.date|dateformat:$date_format}</span> <span class="controls" style="display:inline"><a href="#" onclick="return savedraft()">{$lang.savedraft}</a> <a href="#" onclick="return removedraft()">{$lang.removedraft}</a></span></div>
                            <script type="text/javascript">
                                {literal}
                                    function savedraft() {
                                      ajax_update('?cmd=tickets',{make:'savedraft',action:'menubutton',id:$('#ticket_number').val(),body:$('#replyarea').val()},'#draftinfo .draftdate');
                                      $('#draftinfo .draftdate').show();
                                      return false;
                                    }
                                    function removedraft() {
                                      ajax_update('?cmd=tickets',{make:'removedraft',action:'menubutton',id:'new'});
                                      $('#draftinfo .draftdate').html('').hide();
                                      $('#draftinfo .controls').hide();
                                      $('#replyarea').val("");
                                      return false;
                                    }
                                {/literal}
                            </script>
                        </td>
                        <td valign="top" style="padding-right:4px; background: #FFF" width="230">

                            <div class="gbar" id="rswitcher">
                                <a href="?cmd=predefinied&action=gettop" class="active d1">{$lang.myreplies}</a>
                                <a href="?cmd=predefinied&action=browser" class="d2">{$lang.replybrowse}</a>
                                <a href="?cmd=knowledgebase&action=browser" class="d3">{$lang.kbarticles}</a>
                                <div class="clear"></div>
                            </div>
                            <div id="suggestion">
                                <div class="d1">加载中...</div>
                                <div class="d2">加载中...</div>
                                <div class="d3">加载中...</div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <a href="#" onclick="$(this).hide().next().show();return false;" {if $submit.notes}style="display:none"{/if} class="editbtn">添加备注</a>
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" {if !$submit.notes}style="display:none"{/if} >
                                <tbody>
                                    <tr class="odd">
                                        <td style="vertical-align: baseline; white-space: nowrap; padding: 5px; ">
                                            <strong style="">备注</strong><br>
                                            ({if $admindata.lastname!='' && $admindata.firstname!=''}{$admindata.lastname} {$admindata.firstname}{else}{$admindata.username}{/if})
                                        </td>
                                        <td style="padding-top:5px" width="100%" >
                                            <textarea class="notes_field notes_changed" id="ticketnotesarea"  style="width:40%; height:auto" name="notes" >{$submit.notes}</textarea>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <a  class="attach editbtn" href="#" >{$lang.addattachment}</a> &nbsp;&nbsp;({$lang.allowedextensions} {$extensions})<br />
                            <div id="attachments"> </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="blu">
            <input type="submit" value="{$lang.createticket}" style="font-weight:bold" id="ticketsubmitter"/>
        </div>
        {securitytoken}
    </form>
    {if $ajax}
        {literal}
            <script type="text/javascript">bindEvents();bindTicketEvents();</script>
            {/literal}
    {/if}
            <script type="text/javascript">
                    $(document).trigger('HostBill.newticketform');

            </script>
{/if}
