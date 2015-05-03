<table class="glike" id="preset-table" cellpadding="6" style="width: 100%">
    <tbody>
        <tr>
            <th>Name</th>
            <th>Source CIDR</th>
            <th>Protocol</th>
            <th>Ports / ICMP Settings</th>
            <th></th>
        </tr>
    </tbody>
    <tbody id="widget-presets">
        {foreach from=$widget.config.presets item=preset key=index}
            {foreach from=$preset.data item=data name=presetloop key=subindex}
                <tr class="preset-row">
                    <td>
                        {if $smarty.foreach.presetloop.first}
                            <input type="hidden" name="config[presets][{$index}][name]" value="{$preset.name}" />
                            <a href="#" onclick="return setPresetWidget(this)">{$preset.name}</a>
                        {/if}
                    </td>
                    <td>
                        <input type="hidden" name="config[presets][{$index}][data][{$subindex}][cidr]" value="{$data.cidr}" />
                        {$data.cidr}
                    </td>
                    <td>
                        <input type="hidden" name="config[presets][{$index}][data][{$subindex}][proto]" value="{$data.proto}" />
                        {$data.proto}
                    </td>
                    <td>
                        <input type="hidden" name="config[presets][{$index}][data][{$subindex}][val1]" value="{$data.val1}" />
                        <input type="hidden" name="config[presets][{$index}][data][{$subindex}][val2]" value="{$data.val2}" />
                        {$data.val1} - {$data.val2}
                    </td>
                    <td><a href="#" onclick="return delWidgetPreset(this)" class="delbtn"></a></td>
                </tr>
            {/foreach}
        {/foreach}
    </tbody>
    <tbody>
        <tr class="preset-empty" {if $widget.config.presets}style="display: none"{/if}>
            <td colspan="5" style="text-align: center">{$lang.nothingtodisplay}</td>
        </tr>
        <tr class="preset-new">
            <td><input type="text" class="inp" name="presetName" placeholder="Name"></td>
            <td><input type="text" class="inp" name="presetCidr" placeholder="eg. 0.0.0.0/0" value="0.0.0.0/0" size="10"></td>
            <td>
                <select name="presetProto">
                    <option>TCP</option>
                    <option>UDP</option>
                    <option>ICMP</option>
                </select>
            </td>
            <td>
                <input type="text" class="inp" name="presetVal1" placeholder="Start Port / Type" title="Start Port / ICMP Type" size="12"> -
                <input type="text" class="inp" name="presetVal2" placeholder="End Port / Code" title="Start Port / ICMP Type" size="12">
            </td>
            <td><button onclick="return addPresetToWidget()">Add</button></td>
        </tr>
    </tbody>
</tr>
</table>
{literal}
    <style>

        #preset-table input, #preset-table select{
            margin:0!important;
            float:none!important;
        }
        #preset-table tbody tr td,
        #preset-table tbody tr th{
            border-bottom: 1px solid #DEDEDE
        }
    </style>
    <script type="text/javascript">
        String.prototype.tpl = function() {
            var string = this.toString();
            for (var i = 0; i < arguments.length; i++) {
                if (typeof arguments[i] == 'object') {
                    var repl = arguments[i];
                    string = string.replace(/\{([^}]+)\}/g, function(s, k) {
                        return repl[k] || '';
                    });
                } else {
                    string = string.replace(/\{[^}]+\}/, arguments[i]);
                }
            }
            return string;
        }
        String.prototype.hashCode = function() {
            var hash = 0, char, i;
            if (this.length == 0)
                return hash;
            for (i = 0; i < this.length; i++) {
                char = this.charCodeAt(i);
                hash = ((hash << 5) - hash) + char;
                hash = hash & hash; // Convert to 32bit integer
            }
            return hash;
        }
        var widgetEntries = {};

        function setPresetWidget(elm) {
            $('.preset-new input[name=presetName]').val($(elm).text());
        }

        function delWidgetPreset(elm) {
            var row = $(elm).parents('tr').eq(0),
                    inputfields = $('input, select', row),
                    formhash = 0,
                    hash = inputfields.eq(0).attr('name').match(/presets\]\[(\d+)\]/)[1],
                    head = $('input[name="config[presets][' + hash + '][name]"]');
  
            if (head.parents('tr').eq(0).is(row)) {
                row.next().children().eq(0).append(head.parent().children().detach());
                formhash = inputfields.serialize().replace(/[^&]*=/g, '').hashCode();
            }else{
                formhash = head.val() + '&' + inputfields.serialize().replace(/[^&]*=/g, '')
                formhash = formhash.hashCode();
            }
            
            var indexof = widgetEntries[hash] && widgetEntries[hash].indexOf(formhash) || -1;
            if (indexof >= 0)
                widgetEntries[hash][indexof] = false;

            row.remove();
            return false;
        }

        function addPresetToWidget() {
            var tr = $('<tr></tr>'),
                    inputfields = $('input, select', '.preset-new'),
                    form = inputfields.serializeObject(),
                    tpl1 = '<input type="hidden" name="config[presets][{$index}][{$name}]" value="{$value}" /> <a href="#" onclick="return setPresetWidget(this)">{$value}</a>',
                    tpl2 = '<input type="hidden" name="config[presets][{$index}][data][{$subindex}][{$name}]" value="{$value}" /> {$value}';

            if (!form.presetCidr.length)
                form.presetCidr = '0.0.0.0/0';

            inputfields.css({
                boxShadow: ''
            })

            if (!form.presetName.length || !form.presetProto.length || !form.presetVal1.length) {
                inputfields.filter(function() {
                    return $(this).val() == ''
                }).css({
                    boxShadow: '0 0 2px 1px #FF0000'
                })
                return false;
            }

            if (!form.presetVal2.length)
                form.presetVal2 = form.presetVal1;

            var subi = 0,
                    hash = form.presetName.hashCode(),
                    group = $('input[name^="config[presets][' + hash + ']"][name$="[proto]"]'),
                    formhash = inputfields.serialize().replace(/[^&]*=/g, '').hashCode();

            if (!widgetEntries[hash])
                widgetEntries[hash] = [];

            if (widgetEntries[hash].indexOf(formhash) >= 0)
                return false;

            widgetEntries[hash].push(formhash);

            if (group.length) {
                tr.append('<td></td>');
                subi = parseInt(group.last().attr('name').match(/data\]\[(\d+)\]/)[1])+1;
            } else
                tr.append('<td>' + tpl1.tpl(hash, 'name', form.presetName, form.presetName) + '</td>')

            tr.append('<td>' + tpl2.tpl(hash, subi, 'cidr', form.presetCidr, form.presetCidr) + '</td>')
                    .append('<td>' + tpl2.tpl(hash, subi, 'proto', form.presetProto, form.presetProto) + '</td>')
                    .append('<td>' + tpl2.tpl(hash, subi, 'val1', form.presetVal1, form.presetVal1) + ' - '
                            + tpl2.tpl(hash, subi, 'val2', form.presetVal2, form.presetVal2) + '</td>')
                    .append('<td><a href="#" onclick="return delWidgetPreset(this)" class="delbtn"></a></td>');

            tr.appendTo('#widget-presets');
            $('.preset-empty').hide();
            return false;
        }
    </script>
{/literal}