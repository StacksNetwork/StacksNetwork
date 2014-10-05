<table class="translations" cellspacing="0">
    <thead>
        <tr>
            <th style="width:20% ; min-width: 190px;">
                {$lang.Language}
            </th>
            <th>
                {$lang.Translation}
            </th>
		
        </tr>
    </thead>
    <tbody >
        {foreach from=$lines item=line}
            <tr id="trans_row_" >
                <td class="keybox">{$line.target|capitalize}: <b>{$line.name|capitalize}</b></td>
                    <td class="valuebox">
                        <textarea name="entrys[{$line.language_id}][{$line.keyword}]" style="overflow: hidden;">{$line.value}</textarea>
                    </td>
            </tr>
          {/foreach}

    </tbody>
</table>
{literal}
<script type="text/javascript">
    function bindBulkLang() {
        $('table.translations textarea').elastic();
    }
    appendLoader('bindBulkLang');
</script>
{/literal}