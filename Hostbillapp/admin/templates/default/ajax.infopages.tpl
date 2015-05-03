{if $action=='default'}

                {if $pages}

                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="" class="glike">
                    <tbody>
                        <tr>

                            <th>{$lang.Title}</th>
                            <th>URL</th>
                            <th></th>


                        </tr>
		  {foreach from=$pages item=page}

                        <tr>

                            <td><a data-pjax href="?cmd=infopages&action=edit&id={$page.id}">{$page.title}</a></td>
                            <td><a target="blank" href="{$system_url}?/page/{$page.url}/">{$system_url}?/page/{$page.url}/</a></td>
                            <td width="16"><a data-pjax href="?cmd=infopages&delete={$page.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletepageconfirm}')" class="delbtn">删除</a></td>


                        </tr>
		{/foreach}

                    </tbody>
                </table>
                {else}
                <div class="blank_state blank_news">
                    <div class="blank_info">
                        <h1>{$lang.blank_kb}</h1>
				{$lang.blank_kb_desc}
                        <div class="clear"></div>

                        <a class="new_add new_menu" href="?cmd=infopages&action=new" data-pjax style="margin-top:10px">
                            <span>{$lang.addnewpage}</span></a>
                        <div class="clear"></div>

                    </div>
                </div>

                {/if}



                {elseif $action=='new'}
                <form method="post">
                    <div style="padding: 10px;" class="lighterblue">
                        <table cellpadding="6" cellspacing="0" width="100%">

                            <tr>
                                <td width="160" align="right"><b>{$lang.pagetitle}</b></td>
                                <td>
                                    {hbinput value=$submit.title style="" class="inp" size="50" name="title"}
                                </td>
                            </tr>

                            <tr>
                                <td width="160" align="right"><b>{$lang.Visible}?</b></td>
                                <td><input type="checkbox" name="visible" value="1" checked="checked"/></td>
                            </tr>

                            <tr>

                                <td width="160" valign="top" align="right"><b>{$lang.Content}</b></td>
                                <td>
                                    {hbwysiwyg value=$page.tag_content style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="prod_content" name="content" featureset="full"}
                                </td>
                            </tr>


                        </table>
                    </div>
                    <div class="blu">
                        <input type="submit" style="font-weight: bold;" value="{$lang.addnewpage}" name="save"/>
                    </div>{securitytoken}</form>
                {elseif $action=='edit'}
                <form method="post">
                    <div style="padding: 10px;" class="lighterblue">
                        <table cellpadding="6" cellspacing="0" width="100%">
                             <tr>
                                <td width="160" align="right"><b>{$lang.pagetitle}</b></td>
                                <td>
                                    {hbinput value=$page.tag_title style="" class="inp" size="50" name="title"}
                                </td>
                            </tr>
                             <tr>
                                <td width="160" align="right"><b>{$lang.Visible}?</b></td>
                                <td><input type="checkbox" name="visible" value="1" {if $page.visible}checked="checked"{/if}/></td>
                            </tr>
                            <tr>
                                <td width="160" valign="top" align="right"><b>{$lang.Content}</b></td>
                                <td>
                                    {hbwysiwyg value=$page.tag_content style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="prod_content" name="content" featureset="full"}
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="blu">
                        <input type="submit" style="font-weight: bold;" value="{$lang.savechanges}" name="save"/>
                    </div>{securitytoken}</form>

                {/if}