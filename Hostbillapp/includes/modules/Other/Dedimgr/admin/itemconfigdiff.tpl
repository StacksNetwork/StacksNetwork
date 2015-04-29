<h1> 
    <strong><a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$rack.colo_id}">数据中心: {$rack.coloname}</a></strong>
    &raquo; <strong><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$rack.floor_id}">楼层: {$rack.floorname}</a> <em>{if $rack.room} 机房: {$rack.room}{/if}</em></strong>
    &raquo; <strong><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">机柜: {$rack.name}</a> </strong> 
    {foreach from=$stack item=sti}
        &raquo; {$sti.category_name} - {$sti.name} {if $sti.label}&raquo; {$sti.label}{/if}  #{$sti.id}
    {/foreach}

</h1>
<link rel="stylesheet" type="text/css" href="{$moduledir}../jsdifflib/diffview.css"/>
<script type="text/javascript" src="{$moduledir}../jsdifflib/diffview.js"></script>
<script type="text/javascript" src="{$moduledir}../jsdifflib/difflib.js"></script>
<form action="?cmd=module&module={$moduleid}&action=itemconfigedit&item_id={$item.id}&id={if $entry.id}{$entry.id}{else}new{/if}" method="POST">
    <table style="width: 100%" cellpadding="6" cellspacing="0">
        <tr>
            <td>
                <select id="left" class="inp" style="width: 100%">
                    {foreach from=$configs item=conf}
                        <option value="">----</option>
                        <optgroup label="{$conf.active.description|escape}">
                            {if $conf.active}
                                <option value="{$conf.active.id}">{$conf.active.description|escape} ({$conf.active.date|dateformat:$date_format}, {$conf.active.author})</option> 
                            {/if}
                            {foreach from=$conf.archived item=entry}
                                <option value="{$entry.id}">{$entry.description|escape} {$entry.date|dateformat:$date_format}, {$entry.author})</option>  
                            {/foreach}
                        </optgroup>
                    {/foreach}
                </select>
                <textarea id="lefttarget" style="display: none"></textarea>
            </td>
            <td>
                <select id="right" class="inp" style="width: 100%">
                    <option value="">----</option>
                    {foreach from=$configs item=conf}
                        <optgroup label="{$conf.active.description|escape}">
                            {if $conf.active}
                                <option value="{$conf.active.id}">{$conf.active.description|escape} ({$conf.active.date|dateformat:$date_format}, {$conf.active.author})</option> 
                            {/if}
                            {foreach from=$conf.archived item=entry}
                                <option value="{$entry.id}">{$entry.description|escape} ({$entry.date|dateformat:$date_format}, {$entry.author})</option>  
                            {/foreach}
                        </optgroup>
                    {/foreach}
                </select>
                <textarea id="righttarget" style="display: none"></textarea>
            </td>
        </tr>
    </table>
    <div id="diffoutput">
        <table class="diff inlinediff">
            <thead>
                <tr>
                    <th></th><th></th>
                    <th class="texttitle">---- vs. ----</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>1</th>
                    <td class="equal" colspan="2" style="text-align: center; color:grey">选择配置对比</td>
                </tr>
                <tr>
                    <th class="author" colspan="3">立体视觉效果技术由 <a href="http://github.com/cemerick/jsdifflib">jsdifflib</a> 所生成.</th>
                <tr>
            </tbody>
        </table>
    </div>
</form>

{literal}
    <script type="text/javascript">

        function diffUsingJS() {
            var left = difflib.stringAsLines($('#lefttarget').val()),
                    right = difflib.stringAsLines($('#righttarget').val()),
                    sm = new difflib.SequenceMatcher(right, left),
                    opcodes = sm.get_opcodes(),
                    diffoutputdiv = $("#diffoutput"),
                    contextSize = null;
            console.log(right, left)
            diffoutputdiv.html('').append(diffview.buildView({
                baseTextLines: right,
                newTextLines: left,
                opcodes: opcodes,
                baseTextName: $('#left option:selected').text(),
                newTextName: $('#right option:selected').text(),
                contextSize: contextSize,
                viewType: 1
            }));

        }
        $('#left, #right').change(function() {
            var that = $(this);
            $.post('?cmd=module&module={/literal}{$moduleid}{literal}&action=itemconfigdiff', {item_id: 32, id: that.val()}, function(data) {
                if (data && data.config) {
                    $('#' + that.attr('id') + 'target').val(data.config);
                }
                diffUsingJS();
            })
        });
    </script>
{/literal}