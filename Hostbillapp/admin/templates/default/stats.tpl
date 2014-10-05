<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td ><h3>{$lang.systemstatistics}</h3></td>
        <td ></td>
    </tr>
    <tr>
        <td class="leftNav">
			{include file='reports/sidebar.tpl'}
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="background:#F5F9FF;">
			{include file='ajax.stats.tpl'}
            </div>
        </td>
    </tr>
</table>
