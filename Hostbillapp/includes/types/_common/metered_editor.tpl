<table  cellspacing="0" cellpadding="5" border="0" width="100%">
<tbody><tr>
<td  valign="top"><div style="padding:10px 0px;"><a onclick="$(this).parents('tr:eq(0)').hide();$('#metered_var_editor').show();return false;"  class="prices menuitm " href="#"><span class="addsth">添加新的测量变量</span></a>
        </td>
</tr>
<tr id="metered_var_editor" style="display:none">
    <td>
        <table border="0" cellpadding="3" class="left" cellspacing="0" id="powerdnspanel_table">
<tbody><tr>
<td width="100" class="fs11"><span class="left">变量 *</span> <a class="vtip_description" title="必须, 使用API, 仅限字母"></a></td>
<td width="100" class="fs11"><span class="left">名称 *</span> <a class="vtip_description" title="名称, 前台GUI显示"></a></td>
<td width="60" class="fs11"><span class="left">单位</span> </td>
<td width="250" class="fs11">说明</td>
<td></td>
</tr>
<tr>
<td><input type="text" class="inp" value="" name="newmetered[variable]"></td>
<td><input type="text" class="inp" value="" name="newmetered[name]"></td>
<td><input type="text" class="inp" value=""  style="width:55px" name="newmetered[unit_name]"></td>
<td><input type="text" style="width:250px" class="inp" value="" name="newmetered[description]"></td>
<td>
    <a onclick="return saveProductFull();"  class="prices menuitm " href="#"><span class="addsth">添加</span></a>
</td>
</tr>
</tbody></table>
    </td>
</tr>
</tbody></table> <input type="hidden"  value="" name="newmetered[rm]" id="rmvar">
{literal}
    <script>
        function rmMeteredVar(vr) {
            
            if(confirm('您确定要删除这个变量? 它将从所有的产品与这种类型删除!')) {
                $('#rmvar').val(vr);
                saveProductFull();
            }
            
            return false;
        }
        </script>
        
        {/literal}