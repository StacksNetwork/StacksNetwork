{if $showth}
    <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
        <li style="background:#ffffff">
            <div style="border-bottom:solid 1px #ddd;">
                <table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                        <tr>
                            <td width="80" valign="top"><div style="padding:10px 0px;">
                                    <a onclick="return editlist('{$group.id}')" href="#" class="menuitm menuf" title="编辑" style="display:inline-block;width:14px;">
                                        <span class="editsth"></span>
                                    </a><!--
                                    --><a class="menuitm menul" title="delete" onclick="dellist();
                                            return false" href="#"><span class="delsth"></span></a>
                                </div>
                            </td>
                            <td width="300">
                                <h3>
                                    <a href="#" onclick="groupDetails({$group.id});
                                            return false;">列表: {$group.name}</a>
                                </h3>
                                {$group.description}
                            </td>
                            <td width="80" align="right" class="ipam-linebrs">
                                范围: <br/>
                                自动分配: <br/>
                                私有: <br/>

                            </td>
                            <td  width="180"class="ipam-linebrs">

                                <b>{$group.range_from} - {$group.range_to}</b><br/>
                                <b>{if $group.autoprovision}是{else}否{/if}</b><br/>
                                <b>{if $group.private}是{else}否{/if}</b><br/>

                            </td>
                            <td width="80" align="right" class="ipam-linebrs">
                                VLAN数量: <br/>
                                闲置: <br/>
                                使用率: <br/>

                            </td>
                            <td class="ipam-linebrs">

                                <b>{$group.count}</b><br/>
                                <b>{$group.count_unasigned}</b><br/>
                                <div class="usage {if $group.count_percent > 75}red{elseif $group.count_percent>50}yelow{elseif $group.count_percent>25}green{/if}">
                                    <div style="width: {$group.count_percent}%"><span class="inverted">{$group.count_percent}%</span></div>
                                    <span>{$group.count_percent}%</span>
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td >
                            </td>
                            <td colspan="3"> 
                                <div style="padding:10px 0px">
                                    <a class="new_control" onclick="return add();" href="#">
                                        <span class="addsth">添加新VLAN</span>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </li>
    </ul>
{/if}

{assign var="sortid" value=$group.id}
<a href="?cmd=module&module={$moduleid}&action=vlan_details&group={$sortid}" id="vlancurrentlist"></a>
{if $showth}
    <div class="right"><div class="pagination" style="margin-top:10px;"></div></div>
    <div class="clear"></div>
    <form action="" method="post" onsubmit="return submitForm(this)" id="vlanform" >
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="vlantotalpages"/>

        <table class="clear" width="100%" cellspacing="0" cellpadding="0" style="margin-top:10px">
            <tbody>
                <tr>
                    <th width="120px" >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=vlan_details&group={$sortid}&orderby=vlan|ASC" class="sortorder">{/if}VLAN{if $sortid}</a>{/if}</th>
                    <th >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=vlan_details&group={$sortid}&orderby=name|ASC" class="sortorder">{/if}名称{if $sortid}</a>{/if}</th>
                    <th style="min-width:100px">{if $sortid}<a href="?cmd=module&module={$moduleid}&action=vlan_details&group={$sortid}&orderby=descripton|ASC" class="sortorder">{/if}说明{if $sortid}</a>{/if}</th>
                    <th >子网</th>
                    <th width="115px" >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=vlan_details&group={$sortid}&orderby=lastupdate|ASC" class="sortorder">{/if}最后一次更新{if $sortid}</a>{/if}</th>
                    <th width="85px" >{if $sortid}<a href="?cmd=module&module={$moduleid}&action=vlan_details&group={$sortid}&orderby=changedby|ASC" class="sortorder">{/if}修改人{if $sortid}</a>{/if}</th>
                    <th ><input name="group" value="{$group.id}" type="hidden"/></th>
                </tr>
            </tbody>
            <tbody id="vlanupdater">
            {/if}
            {foreach from=$list item=line}
                <tr>
                    <td ><div>{$line.vlan}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">编辑</span></td>
                    <td ><div>{$line.name}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">编辑</span></td>
                    <td ><div>{$line.descripton}</div><span class="editbtn" onclick="edit(this,{$line.server_id})">编辑</span></td>
                    <td class="fs11">
                        {foreach from=$line.subnet item=sub name=sub}{*}
                            {*}{if !$smarty.foreach.sub.first}, {/if}{*}
                            {*}<a href="#" onclick="$('#bodycont h1:first').click(); groupDetails({$sub.id}); return false;">{$sub.name}</a>{*}
                        {*}{/foreach}
                    </td>
                    <td class="fs11"><div>{$line.lastupdate}</div></td>
                    <td class="fs11"><div>{$line.changedby}</div></td>
                    <td style="padding:5px 0 0 10px; width:20px"><a class ="delbtn" href="#" onClick="del(this,{$line.server_id})"></a></td>
                </tr>
            {/foreach}
            {if $showth}
            </tbody>
        </table>
    </form>
    {$lang.showing} <span id="vlansorterlow">{$sorterlow}</span> - <span id="vlansorterhigh">{$sorterhigh}</span> {$lang.of} <span id="vlansorterrecords">{$sorterrecords}</span>

    <div class="clear"></div>
    <div style="padding:20px 0px">

        <a class=" new_control greenbtn" href="#" onclick="$('#vlanform').submit();
                                            return false;"><span><strong>{$lang.savechanges}</strong></span></a>
                    {if count($list)>5}   
            <a class="new_control" onclick="return add();" href="#"  style="margin-left:10px;"><span class="addsth" >添加新VLAN</span></a>
        {/if}

        <div class="clear"></div>
    </div>
{/if}
