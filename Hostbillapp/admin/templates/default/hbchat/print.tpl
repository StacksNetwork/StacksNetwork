<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>{$hb}{if $pagetitle}{$pagetitle} -{/if} {$business_name} </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="text/javascript" src="{$template_dir}hbchat/media/jquery.js?v={$hb_version}"></script>
        <link href="{$template_dir}_style.css?v={$hb_version}" rel="stylesheet" media="all" />
        <link href="{$template_dir}hbchat/media/popup.css?v={$hb_version}" rel="stylesheet" media="all" />

    </head>
    <body class="hbprint" style="padding:10px;" {if $details}onload="window.print()"{/if}>
        {if !$details}
        <h3>Chat not found</h3>
        {else}
        <h3 class="left" style="margin-top:0px;">Chat transcript #{$details.id}</h3>
         <div class="right"><a class="printit" onclick="window.print()" href="javascript:void()">Print</a></div>
        <div class="clear"></div>
        <div class="cwrapper">
        <table cellspacing="0" cellpadding="0" border="0" width="100%">
            <tbody><tr>
                    <td width="50%" valign="top" >
                        <table cellspacing="0" cellpadding="0" width="100%" class="bluetable">
                            <tbody><tr>
                                    <td class="first">Subject</td>
                                    <td>{if $details.subject}{$details.subject}{else}<em>No subject</em>{/if}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">User name</td>
                                    <td>{$details.visitor_name} {if $details.client_id}<a href="?cmd=clients&action=show&id={$details.client_id}" target="_blank">Registered client</a>{/if}</td>
                                </tr>
                                <tr>
                                    <td class="first">User email</td>
                                    <td>{if $details.visitor_email}{$details.visitor_email}{else}<em>None provided</em>{/if}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">Date</td>
                                    <td>{$details.date_start|dateformat:$date_format}</td>
                                </tr>
                                <tr>
                                    <td class="first">Staff</td>
                                    <td>{$details.firstname} {$details.lastname}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">Chat type</td>
                                    <td>{if $details.type=='AC'}Staff invitation{else}User request{/if}</td>
                                </tr>
                            </tbody></table>
                    </td>
                    <td width="50%" valign="top" >
                        <table cellspacing="0" cellpadding="0" width="100%" class="bluetable">
                            <tbody>
                                <tr>
                                    <td class="first">Department</td>
                                    <td >{$details.deptname}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">Status</td>
                                    <td >{$details.status}</td>
                                </tr>
                                <tr>
                                    <td class="first">Duration</td>
                                    <td>{$details.duration}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">Round robin hits</td>
                                    <td>{$details.robin_count}</td>
                                </tr>
                                <tr>
                                    <td class="first">Chat ID</td>
                                    <td># {$details.id}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">Geodata</td>
                                    <td>{$details.countryname}, {$details.city}</td>
                                </tr>

                            </tbody></table>
                    </td>
                </tr>
            </tbody></table>
            </div>


        <div style="padding:10px;">
            {foreach from=$details.messages item=m}
             <div class="msg_wrapper msg_{$m.type}">
                    <span class="msg_who {$m.type}">{$m.submitter_name}:</span>
                    <span class="msg_date">{$m.date|dateformat:$date_format}</span>
                    <div class="clear"></div>
                    <span class="msg">{$m.message}</span>
                    <div class="clear"></div>
            </div>
            {/foreach}
        </div>
        {/if}
    </body>
</html>