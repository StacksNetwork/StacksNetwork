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
        <h3>未发现聊天记录</h3>
        {else}
        <h3 class="left" style="margin-top:0px;">聊天记录 #{$details.id}</h3>
         <div class="right"><a class="printit" onclick="window.print()" href="javascript:void()">打印</a></div>
        <div class="clear"></div>
        <div class="cwrapper">
        <table cellspacing="0" cellpadding="0" border="0" width="100%">
            <tbody><tr>
                    <td width="50%" valign="top" >
                        <table cellspacing="0" cellpadding="0" width="100%" class="bluetable">
                            <tbody><tr>
                                    <td class="first">主题</td>
                                    <td>{if $details.subject}{$details.subject}{else}<em>无主题</em>{/if}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">用户名</td>
                                    <td>{$details.visitor_name} {if $details.client_id}<a href="?cmd=clients&action=show&id={$details.client_id}" target="_blank">注册用户</a>{/if}</td>
                                </tr>
                                <tr>
                                    <td class="first">用户邮箱</td>
                                    <td>{if $details.visitor_email}{$details.visitor_email}{else}<em>未提供</em>{/if}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">日期</td>
                                    <td>{$details.date_start|dateformat:$date_format}</td>
                                </tr>
                                <tr>
                                    <td class="first">员工</td>
                                    <td>{$details.lastname} {$details.firstname}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">聊天类型</td>
                                    <td>{if $details.type=='AC'}员工邀请{else}用户请求{/if}</td>
                                </tr>
                            </tbody></table>
                    </td>
                    <td width="50%" valign="top" >
                        <table cellspacing="0" cellpadding="0" width="100%" class="bluetable">
                            <tbody>
                                <tr>
                                    <td class="first">部门</td>
                                    <td >{$details.deptname}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">状态</td>
                                    <td >{$details.status}</td>
                                </tr>
                                <tr>
                                    <td class="first">时长</td>
                                    <td>{$details.duration}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">Round robin hits</td>
                                    <td>{$details.robin_count}</td>
                                </tr>
                                <tr>
                                    <td class="first">聊天ID</td>
                                    <td># {$details.id}</td>
                                </tr>
                                <tr class="odd">
                                    <td class="first">位置数据</td>
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