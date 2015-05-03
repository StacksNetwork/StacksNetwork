<script type="text/javascript">loadelements.emails=true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td ><h3>{$lang.emailtemplates}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=emailtemplates&action=add"  class="tstyled {if $action=='add'}selected{/if}">{$lang.addnewtemplate}</a>
            <a href="?cmd=emailtemplates"  class="tstyled {if $action!='add'}selected{/if}">{$lang.emailtemplates}</a>


        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">


                {if $action=='add'}
                    <script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
                    {include file='ajax.emailtemplates.tpl'}

                {elseif $action=='preview'}
                <div class="blu"> <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;

                </div>
                <div class="lighterblue" style="padding:5px;">
                    <div style="padding:5px 0px">{$lang.thisisjustpreview}</div>
                    <div class="p5">
		{$body}
                    </div>
                </div>


                {elseif $action=='edit' }
                    {*}
                    <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
                    <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
                    {*}
                    <script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
                    {include file='ajax.emailtemplates.tpl'}

                {elseif $action=='default' || $action=='admins'}
                {literal}
                <script>
                    $(document).ready(function(){
                        $('#newshelfnav').TabbedMenu({
                             elem: '.sectioncontent',
                             picker: '.list-1 li',
                             aclass: 'active'
                        });
                    });
                </script>
                {/literal}

                <div class="blu">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr><td></td><td align="right">	<a href="?cmd=emailtemplates&action=add"  class="editbtn">{$lang.addnewtemplate}</a></td></tr>
                    </table>
                </div>

                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li class="active picked">
                                <a href="#"><span class="ico money">客户Emails</span></a>
                            </li>
                            <li class="last">
                                <a href="#"><span class="ico plug">管理员Emails</span></a>
                            </li>
                            
                        </ul>
                    </div></div>
<div style="padding:15px;background:#F5F9FF;">
                <div class="sectioncontent">
                    {if $emails}

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                        <tbody>

	{if $emails.Custom}
                            <tr >
                                <th colspan="4" align="left">{$lang.MyMessages}</th>
                            </tr>
                            {foreach from=$emails.Custom item=email  name=fr}
                            <tr class="havecontrols {if $email.system=='0'}man{/if} {if $smarty.foreach.fr.index%2==0}even{/if}">

                                <td style="padding-left:10px"><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                            </tr>
                            {/foreach}
                            {/if}
                            <tr >
                                <th colspan="4" align="left">{$lang.SystemMessages}</th>
                            </tr>
	{foreach from=$emails.All item=email  name=fr}{if $email.for!='Admin'}

                            <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">

                                <td style="padding-left:10px"><strong>{$lang.Client}: </strong><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                            </tr>
                           {/if} {/foreach}


                        </tbody></table>
                {else}
                <strong>{$lang.noemailstodisplay}</strong>

                {/if}




                </div>
                <div class="sectioncontent" style="display:none">
                    {if $emails}

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                        <tbody>

	
                            <tr >
                                <th colspan="4" align="left">{$lang.SystemMessages}</th>
                            </tr>
	{foreach from=$emails.All item=email  name=fr}{if $email.for=='Admin'}

                            <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">

                                <td style="padding-left:10px"><strong>{$lang.Admin}: </strong><a href="?cmd=emailtemplates&action=edit&id={$email.id}" >{$email.tplname}</a></td>
                                <td width="40"><a href="?cmd=emailtemplates&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" class="editbtn">{$lang.Edit}</a></td>
                                <td width="17" class="lastitm">{if $email.system=='0'}<a href="?cmd=emailtemplates&make=delete&id={$email.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletetemplateconfirm}')">{$lang.Delete}</a>{/if}</td>
                            </tr>
                           {/if} {/foreach}


                        </tbody></table>
                {else}
                <strong>{$lang.noemailstodisplay}</strong>

                {/if}



                </div>
    </div>
                {/if}

            </div></td>
    </tr>
</table>