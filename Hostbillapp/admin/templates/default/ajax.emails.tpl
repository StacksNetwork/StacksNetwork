

{if $action=='clientemails'}
    <div class="blu" style="text-align:right">
        <form action="?cmd=sendmessage" method="post">
            <input type="hidden" name="type" value="clients" />
            <input type="hidden" name="selected" value="{$client_id}" />
            <input type="submit" value="{$lang.SendEmail}" onclick="window.location='?cmd=sendmessage&type=clients&selected={$client_id}';return false;"/>{securitytoken}</form></div>


    {if $emails}<script type="text/javascript">
            {literal}
 function resent(mail_id) {
    $.post('?cmd=emails&action=resend',{
        selected:mail_id
    }, function(data){
        var resp = parse_response(data);

    });
}
            {/literal}
        </script>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
                <tr>

                    <th>{$lang.Subject}</th>
                    <th>{$lang.Date}</th>
                    <th width="20"></th>
                </tr>
            </tbody>
            <tbody >

                {foreach from=$emails item=email}
                    <tr  >

                        <td><a href="?cmd=emails&action=show&id={$email.id}">{$email.subject}</a></td>

                        <td>{$email.date}</td>         
                        <td><a href="javascript:void(0)" onclick="resent({$email.id})" class="editbtn">{$lang.resend}</a></td>

                    </tr>
                {/foreach}
            </tbody>

        </table>
        {if $totalpages}
            <center  class="blu"><strong>{$lang.Page} </strong>
                {section name=foo loop=$totalpages}
                {if $smarty.section.foo.iteration-1==$currentpage}<strong>{$smarty.section.foo.iteration}</strong>{else}
                    <a href='?cmd=emails&action=clientemails&id={$client_id}&page={$smarty.section.foo.iteration-1}' class="npaginer">{$smarty.section.foo.iteration}</a>
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

    <a href="?cmd=emails&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=emails" method="post" onsubmit="return filter(this)">  
        <table width="100%" cellspacing="2" cellpadding="3" border="0" >
            <tbody>
                <tr>

                    <td width="15%">{$lang.clientname}</td>
                    <td><input type="text" value="{$currentfilter.lastname}" size="40" name="filter[lastname]"/></td>
                    <td width="15%">{$lang.Subject}</td>
                    <td><input type="text" value="{$currentfilter.subject}" size="40" name="filter[subject]"/></td>
                </tr>
                <tr>
                    <td>{$lang.Message}</td>
                    <td colspan="3"><input type="text" value="{$currentfilter.message}" style="width:100%" name="filter[message]"/></td>

                </tr>          
                <tr><td colspan="4"><center><input type="submit" value="{$lang.Search}" />&nbsp;&nbsp;&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/></center></td></tr>
            </tbody>
        </table>{securitytoken}</form>

    <script type="text/javascript">bindFreseter();</script>

{elseif $action=='show'}
    <script type="text/javascript">
        {literal}
 function resent(mail_id) {
    $.post('?cmd=emails&action=resend',{
        selected:mail_id
    }, function(data){
        var resp = parse_response(data);

    });
}
        {/literal}
    </script>
    <div class="blu">
        <a href="?cmd=emails" data-pjax>
            <strong>&laquo; {$lang.backtoallemails}</strong>
        </a> 
        <input type="submit" name="resend" value="{$lang.Resend}" onclick="resent({$email.id})" style="font-weight: bold; margin-left: 5px" />
    </div>
    <table cellpadding="4" style="width: 100%; background: rgb(224, 236, 255);">
        <tr>
            <td><b>To</b></td>
            <td>
                {if $email.client_id}
                <a href="?cmd=clients&action=show&id={$email.client_id}">{$email.firstname} {$email.lastname}</a>
                {else}
                {$email.email}
                {/if}
            </td>
            <td><b>Date</b></td>
            <td>{$email.date|dateformat:$date_format}</td>
        </tr>
        <tr>
            <td><b>{$lang.Subject}</b></td>
            <td>{$email.subject}</td>
            <td><b>Status</b></td>
            <td>{if $email.status}<span class="Successfull">Sent</span>{else}<span class="Failure">Failed</span>{/if}</td>
        </tr>
    </table>
    <div class="lighterblue" style="padding:15px 10px 0">                 
        {$email.message}    
    </div>




{elseif $action=='default'}
    {if $emails}
        {if $showall}
            <script type="text/javascript">
                {literal}
 function resent(mail_id) {
    $.post('?cmd=emails&action=resend',{
        selected:mail_id
    }, function(data){
        var resp = parse_response(data);

    });
}
                {/literal}
            </script>
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="left">
                        {$lang.withselected}
                        <input type="submit" name="resend" value="{$lang.Resend}" class="submiter" />
                    </div>
                    <div class="right"><div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <a href="?cmd=emails" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" style="table-layout: fixed;">
                    <tbody>
                        <tr>      
                            <th width="20"><input type="checkbox" id="checkall"/></th>
                            <th><a href="?cmd=emails&orderby=subject|ASC"  class="sortorder">{$lang.Subject}</a></th>
                            <th width="170"><a href="?cmd=emails&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                            <th width="120"><a href="?cmd=emails&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th width="40">{$lang.Status}</th>
                            <th width="40">&nbsp;</th>
                        </tr>
                    </tbody> 
                    <tbody id="updater"> 
                    {/if}
                    {foreach from=$emails item=email}
                        <tr>
                            <td><input type="checkbox" class="check" value="{$email.id}" name="selected[]"/></td>
                            <td class="subjectline"><div class="df1"><div class="df2"><div class="df3"><a href="?cmd=emails&action=show&id={$email.id}"  data-pjax>{if $email.subject == ''}<em>(empty subject)</em>{else}{$email.subject}{/if}</a></div></div></div></td>
                            <td>
                                {if $email.client_id}
                                <a href="?cmd=clients&action=show&id={$email.client_id}">{$email.firstname} {$email.lastname}</a>
                                {else}
                                    <span title="{$email.email}">{$email.email|truncate:20:'..':true:true}</span>
                                {/if}
                            </td>
                            <td>{$email.date|dateformat:$date_format}</td>   
                            <td>{if $email.status}<span class="Successfull">Sent</span>{else}<span class="Failure">Failed</span>{/if}</td>
                            <td><a href="javascript:void(0)" onclick="resent({$email.id})" class="editbtn">{$lang.resend}</a></td>

                        </tr>
                    {/foreach}
                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th></th>
                            <th colspan="4">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">
                    <div class="left">
                        {$lang.withselected}
                        <input type="submit" name="resend" value="{$lang.Resend}" class="submiter" />
                    </div>
                    <div class="right"><div class="pagination"></div>
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


{/if}
