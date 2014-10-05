{if $changes}
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
 <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
<b>客户配置文件修改</b>
<ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:10px" id="grab-sorter" class="fs11">
    {foreach from=$changes item=f name=fl}
<li style="background:#ffffff; {if $smarty.foreach.fl.iteration>4}display:none;{/if}"><div style="border-bottom:solid 1px #ddd;">
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tr>
                
                <td width="120">{$f.date|dateformat:$date_format}</td>
                <td>by: {$f.who}</td>
                <td width="60" align="right"><a href="?cmd=clients&action=historydetails&id={$f.id}" class="editbtn" onclick="return showHistoryDetails(this)">详情</a></td>

            </tr>
        </table>
    </div>
</li>
    {/foreach}
    {if count($changes)>4}
        <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;" id="finalli">
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tr>
                
                <td align="center"><a href="#" onclick="return LoadMoreResults()">加载更多</a></td>

            </tr>
        </table>
    </div>
</li>
    {/if}
</ul>
       
    
    {literal}
        <script> 
    function LoadMoreResults() {
        $('#finalli').hide();
           $('#grab-sorter li').show(); 
return false;
    }
function showHistoryDetails(el) {
            $.facebox({ ajax: $(el).attr('href'),width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
            return false;
                }</script>
    {/literal}
{/if}