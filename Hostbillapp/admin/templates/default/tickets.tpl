<script type="text/javascript">loadelements.tickets=true;
    {foreach from=$statuses item=status}
        {assign value=$status|replace:'-':'a' var=purstatus}
        lang["{$status}"]="{if $lang[$purstatus]}{$lang[$purstatus]}{else}{$status}{/if}";
    {/foreach}
	lang["startedreplyat"]="{$lang.startedreplyat}";
	lang["draftsavedat"]="{$lang.draftsavedat}";
	lang["preview"]="{$lang.preview}";
        lang['unshare_confirm'] = "{$lang.unshare_confirm}";
        lang['none'] = "{$lang.none}";
        lang['nochange'] = "{$lang.nochange}";
</script>
<script type="text/javascript" src="{$template_dir}js/tickets.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.ticketsection}</h3></td>
        <td  class="searchbox">

            <div id="hider2" style="text-align:right">
                <div class="filter-actions">
                    <a class="left fTag" {if !$currentfilter.tag}style="display:none"{/if}>Tag: <em>{$currentfilter.tag}</em></a>
                    
                    {if $tview}
                        <a href="?cmd={$cmd}&tview={$tview.id}&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                        <a href="?cmd={$cmd}&tview={$tview.id}&resetfilter=1" {if $currentfilter}style="display:inline"{/if} class="freseter">{$lang.filterisactive}</a>
                    {else}
                        <a href="?cmd=tickets&action=getadvanced" class="fadvanced">{$lang.filterdata}</a>
                        <a href="?cmd=ticketviews&action=fromfilter"  {if $currentfilter}style="display:inline"{/if} ><b>Create View</b></a>
                        <a href="?cmd=tickets&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
                    {/if}
                </div>
            </div>
            <div id="hider" style="display:none"></div></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=tickets&action=new"  class="tstyled {if $cmd=='tickets'}tload {/if}{if $cmd=='tickets' && $action=='new'}selected{/if}" rel="new"><strong>{$lang.opensupticket}</strong></a>
            <br />
                {foreach from=$myDepartments item=dept}
                    {assign var=opendept value=false}
                    {assign var=assign_parm value=""}
                    {if $dept.name == 'total' && $dept.id == 0}
                        {if $currentdept=='all' && !$assigned}{assign var=opendept value=true}{/if}
                        {assign var=id_parm value="all"}
                        {assign var=name_parm value="All Tickets"}
                        {assign var=count_parm value=$mytickets.total}
                    {elseif $dept.name == 'assigned' && $dept.id == 0}
                        {if $currentdept=='all' && $assigned}{assign var=opendept value=true}{/if}
                        {assign var=assign_parm value="&assigned=true"}
                        {assign var=id_parm value="my"}
                        {assign var=name_parm value=$lang.mytickets}
                        {assign var=count_parm value=$mytickets.assigned}
                    {else}
                        {if $currentdept == $dept.id}{assign var=opendept value=true}{/if}
                        {assign var=id_parm value=$dept.id}
                        {assign var=name_parm value=$dept.name}
                        {assign var=count_parm value=$dept.total}
                    {/if}
                    {if $dept.view}
                        <a href="?cmd=ticketviews&tview={$dept.id}" class="tstyled {if $dept.id==$curentview}selected{/if}" >
                            <div>{$name_parm}
                                <span class="msg_counter" id="ticketsn_v{$id_parm}">{if $count_parm > 0}({$count_parm}){/if}</span>
                            </div>
                        </a>
                        {if ($tview.options & 4) }
                            <div {if $dept.id!=$curentview}style="display:none"{/if} id="listdept_v{$id_parm}">
                                {foreach from=$statuses item=status}
                                    <a href="?cmd=ticketviews&tview={$dept.id}&list={$status}"  class="tstyled tsubit {if $dept.id==$curentview && $currentlist==$status|lower}selected{/if}"  rel="{$status|lower}">
                                        {assign value=$status|replace:'-':'a' var=purstatus}
                                        {assign value="`$status`tickets" var=statustickets}
                                        {if $lang[$statustickets]}{$lang[$statustickets]}{else}{$status} {$lang.Tickets}{/if}
                                        <span class="msg_counter" id="ticketsn_{$status|regex_replace:"/[^\w]/":""}_v{$id_parm}">{if $dept.$status}({$dept.$status}){/if}</span>
                                    </a>
                                {/foreach}
                             </div>
                        {/if}
                    {else}
                        <a href="?cmd=tickets{if $dept.id}&dept={$dept.id}{/if}&list=all&showall=true{$assign_parm}" id="dept_{$id_parm}" class="tstyled {if $cmd=='tickets'}tload {/if}{if $opendept && $currentlist=='all'}selected{/if}" rel="all">
                            <div>{$name_parm}
                                <span class="msg_counter" id="ticketsn_{$id_parm}">{if $count_parm > 0}({$count_parm}){/if}</span>
                            </div>
                        </a>
                        {if $cmd=='tickets' && !$dept.view}
                            <div {if !$opendept}style="display:none"{/if} id="listdept_{$id_parm}">
                                {foreach from=$statuses item=status}
                                    <a href="?cmd=tickets{if $dept.id}&dept={$dept.id}{/if}&list={$status}&showall=true{$assign_parm}"  class="tstyled tsubit {if $cmd=='tickets'}tload {/if} {if $opendept && $currentlist==$status|lower}selected{/if}"  rel="{$status|lower}">
                                        {assign value=$status|replace:'-':'a' var=purstatus}
                                        {assign value="`$status`tickets" var=statustickets}
                                        {if $lang[$statustickets]}{$lang[$statustickets]}{else}{$status} {$lang.Tickets}{/if}
                                        <span class="msg_counter" id="ticketsn_{$status|regex_replace:"/[^\w]/":""}_{$id_parm}">{if $dept.$status}({$dept.$status}){/if}</span>
                                    </a>
                                {/foreach}
                             </div>
                        {/if}
                    {/if}
                {/foreach}
            <br /><br />
            {if $enableFeatures.support}
                <a href="?cmd=predefinied"  class="tstyled {if $cmd=='predefinied'}selected{/if}">{$lang.ticketmacros|capitalize}</a>
                <a href="?cmd=ticketdepts"  class="tstyled {if $cmd=='ticketdepts'}selected{/if}">{$lang.ticketdepts|capitalize}</a>

                <a href="?cmd=ticketbans"  class="tstyled {if $cmd=='ticketbans'}selected{/if}">{$lang.ticketfilters|capitalize}</a>
                <a href="?cmd=ticketshare"  class="tstyled {if $cmd=='ticketshare'}selected{/if}">{$lang.ticketshare|capitalize}</a>
                <a href="?cmd=supportrating"  class="tstyled {if $cmd=='supportrating'}selected{/if}">Ticket Ratings</a>
                <a href="?cmd=ticketviews"  class="tstyled {if $cmd=='ticketviews' && !$tview}selected{/if}">Ticket Views</a>
                {if $enableFeatures.supportext}
                    <a href="?cmd=tickettimetracking"  class="tstyled {if $cmd=='tickettimetracking'}selected{/if}">Support Rates</a>
                {/if}
            {/if}
            <br />
            <a href="?cmd=editadmins"  class="tstyled {if $cmd=='editadmins' || $cmd=='root'}selected{/if}">{$lang.Administrators|capitalize}</a>
            <br /><br />
            <div class="tagNav">
                <strong>{$lang.tags}</strong>
                <div class="ticketsTags">
                    <div id="tagsBox">
                        <em>Loading...</em>
                    </div>
                </div>
            </div>
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style=""> 
                {if $cmd=='tickets'}
                    {include file='ajax.tickets.tpl'}
                {elseif $cmd=='predefinied'}
                    {include file='ajax.predefinied.tpl'}
                {elseif $cmd=='ticketdepts'}
                    {include file='ajax.ticketdepts.tpl'}
                {elseif $cmd=='ticketbans'}	
                    {include file='ajax.ticketbans.tpl'}
                {elseif $cmd=='ticketshare' }	
                    {include file='ajax.ticketshare.tpl'}
                {elseif $cmd=='ticketviews' }	
                    {include file='ajax.ticketviews.tpl'}
                {elseif $cmd=='tickettimetracking' }	
                    {include file='ajax.tickettimetracking.tpl'}
                {elseif $cmd=='editadmins' || $cmd=='root'}	
                    {include file='ajax.editadmins.tpl'}
                {elseif $cmd=='supportrating'}	
                    {include file='ajax.supportrating.tpl'}
                {/if} 
            </div>
        </td>
    </tr>
</table>