<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td ><h3>{$lang.systemstatistics}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">

			{include file='reports/sidebar.tpl'}
        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont" style="background:#F5F9FF">{if $action=='get'}
            {include file='reports/getreport.tpl'}
                {else}
                <div class="blu">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tbody><tr><td></td><td align="right">
                        <a class="editbtn" href="?cmd=reports&action=customize&id=0&security_token={$security_token}">创建新的自定义报告</a>
                    </td></tr>
            </tbody></table>
            </div>
                <div style="padding:15px;background:#F5F9FF;">
                    <div class="sectioncontent">
                        {if $reports}
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                            <tbody>

                               
	{foreach from=$reports key=type item=rep}

                                <tr >
                                    <th colspan="4" align="left">{$type}</th>
                                </tr>
                                    {foreach from=$rep item=report name=fr}
                                        <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">
                                            <td><a href="?cmd=reports&action=get&id={$report.id}" >{$report.name}</a></td>
                                            {if !($report.options & 1)}
                                            <td width="60"></td>
                                            <td width="20"><a href="?cmd=reports&action=delete&id={$report.id}&security_token={$security_token}" onclick="return confirm('您确定要移除该报告吗?');" class="delbtn">Delete</a></td>
                                            {else}
                                            <td width="60"><a href="?cmd=reports&action=customize&id={$report.id}&security_token={$security_token}" class="editbtn editgray">自定义</a></td>
                                            <td width="20"></td>
                                            {/if}
                                        </tr>


                                    {/foreach}
                                {/foreach}
                            </tbody>
                        </table>
                        {else}
                            <strong>{$lang.nothing}</strong>
                        {/if}

                    </div>
                </div>
           {/if} </div>
        </td>
    </tr>
</table>