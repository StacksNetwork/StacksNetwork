
                {if $action=='add'}
                <form method="post" action="">
                    <div class="blu"> <a href="?cmd=annoucements" class="tload2" data-pjax><strong>&laquo; {$lang.backtonews}</strong></a>

                    </div>
                    <div class="lighterblue" style="padding:5px">

                        <table  width="100%" cellspacing="0" cellpadding="6">
                            <tr>
                                <td width="160" align="right"><b>{$lang.Title}</b></td>
                                <td>
                                    {hbinput value=$annoucement.tag_title style="" class="inp" size="50" name="title"}
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><b>{$lang.Date}:</b></td>
                                <td><input name="date" size="10" value="{if $annoucement.date}{$annoucement.date|dateformat:$date_format}{else}{$currentdate|dateformat:$date_format}{/if}" class="inp haspicker" /></td>
                                </tr>
                             <tr>
                                 <td align="right"><b>{$lang.onlyforregistered}:</b></td>
                                 <td> <input type="checkbox" name="enable" value="1" {if $annoucement.enable == 1}checked="checked" {/if} /></td>
                             </tr>
                             <tr>
                                <td width="160" valign="top" align="right"><b>{$lang.Content}</b></td>
                                <td>
                                    {hbwysiwyg value=$annoucement.tag_content style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="prod_content" name="content" featureset="full"}
                                </td>
                            </tr>
                        </table>


                    </div>
                    <div class="blu"> <a href="?cmd=annoucements" class="tload2" data-pjax><strong>&laquo; {$lang.backtonews}</strong></a>
                        <input type="submit" name="submit" style="font-weight:bold" value="{$lang.addnews}" />
                        <input type="button" onclick="window.location='?cmd=annoucements'" value="{$lang.Cancel}"/>
                    </div>
                    {securitytoken}</form>
                {elseif $action=='edit' && $annoucement}
                <form method="post" action="">
                    <div class="blu"> <a href="?cmd=annoucements" class="tload2" data-pjax><strong>&laquo; {$lang.backtonews}</strong></a>

                    </div>
                    <div class="lighterblue" style="padding:5px">


                         <table  width="100%" cellspacing="0" cellpadding="6">
                            <tr>
                                <td width="160" align="right"><b>{$lang.Title}</b></td>
                                <td>
                                    {hbinput value=$annoucement.tag_title style="" class="inp" size="50" name="title"}
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><b>{$lang.Date}:</b></td>
                                <td><input name="date" size="10" value="{if $annoucement.date}{$annoucement.date|dateformat:$date_format}{else}{$currentdate|dateformat:$date_format}{/if}" class="inp haspicker" /></td>
                                </tr>
                             <tr>
                                 <td align="right"><b>{$lang.onlyforregistered}:</b></td>
                                 <td> <input type="checkbox" name="enable" value="1" {if $annoucement.enable == 1}checked="checked" {/if} /></td>
                             </tr>
                             <tr>
                                <td width="160" valign="top" align="right"><b>{$lang.Content}</b></td>
                                <td>
                                    {hbwysiwyg value=$annoucement.tag_content style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="prod_content" name="content" featureset="full"}
                                </td>
                            </tr>
                        </table>

                    </div>
                    <div class="blu"> <a href="?cmd=annoucements" class="tload2" data-pjax><strong>&laquo; {$lang.backtonews}</strong></a>
                        <input type="submit" name="submit" style="font-weight:bold" value="{$lang.savechanges}" />
                        <input type="button" onclick="window.location='?cmd=annoucements'" value="{$lang.Cancel}"/>
                    </div>
                    {securitytoken}</form>

                {else}
                {if $annoucements}
                {if $showall}<div class="blu">
					<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                    <input type="button" value="{$lang.createnewnews}" class="linkDirectly" href="?cmd=annoucements&action=add"/>
					<div class="right"><div class="pagination"></div></div>
                </div>
				<a href="?cmd=annoucements" id="currentlist" style="display:none" updater="#updater"></a>
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                    <tbody>
                        <tr>
                            <th width="10%"><a href="?cmd=annoucements&orderby=id|ASC" class="sortorder">ID</a></th>
                            <th width="20%"><a href="?cmd=annoucements&orderby=title|ASC" class="sortorder">{$lang.Title}</a></th>
                            <th><a href="?cmd=annoucements&orderby=date|ASC" class="sortorder">{$lang.Date}</a></th>
                            <th width="50%"><a href="?cmd=annoucements&orderby=content|ASC" class="sortorder">{$lang.Content}</a></th>
                            <th></th>
                        </tr>
						<tbody id="updater">
                                                    {/if}
                                                    {foreach from=$annoucements item=ann}
	<tr>
		<td><a href="?cmd=annoucements&action=edit&id={$ann.id}" data-pjax >{$ann.id}</a></td>
		<td><a href="?cmd=annoucements&action=edit&id={$ann.id}" data-pjax >{$ann.title}</a></td>
		<td>{$ann.date|dateformat:$date_format}</td>
		<td>{$ann.content}</td>
		<td><a href="?cmd=annoucements&make=delete&id={$ann.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletenewsconfirm}');" class="delbtn">Delete</a></td>
	</tr>
{/foreach}{if $showall}
						</tbody>
						<tbody id="psummary">
							<tr>
								<th></th>
								<th colspan="9">
									{$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
								</th>
							</tr>
						</tbody>
					</table>
				<div class="blu">
                    <input type="button" value="{$lang.createnewnews}" class="linkDirectly" href="?cmd=annoucements&action=add"/>
					<div class="right"><div class="pagination"></div></div>
                </div>
                {/if}
                {else}
                <div class="blank_state blank_news">
                    <div class="blank_info">
                        <h1>{$lang.blank_kb}</h1>
				{$lang.blank_kb_desc}
                        <div class="clear"></div>

                        <a class="new_add new_menu" href="?cmd=annoucements&action=add" data-pjax style="margin-top:10px">
                            <span>{$lang.createnewnews}</span></a>
                        <div class="clear"></div>

                    </div>
                </div>
                {/if}
                {/if}