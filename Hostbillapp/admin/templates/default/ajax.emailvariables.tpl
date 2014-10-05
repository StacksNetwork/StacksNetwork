{if $variables}
<div class='sectionhead' style="margin-bottom:5px;padding:8px 5px;">
    <table border="0" cellpadding="2" cellspacing="0">
        <tr>
            <td><a id="addnew_conf_btn" onclick="return previewEmail();" class="new_control" href="#"><span class="zoom">{$lang.Preview}</span></a></td>
            <td>
                <select name="availvars" id="availvars" class="inp" onchange="loadvar(this)">
                    <option value="0">{$lang.availvars}</option>
                    {foreach from=$variables item=var key=var_key}{if ($to=='unsuspend' || $to=='suspend' || $to=='terminate' || $to=='welcome') && ($var_key=='domain' || $var_key=='invoice' || $var_key=='other')}{else}
                    <optgroup label="{if $lang[$var_key]}{$lang[$var_key]}{else}{$var_key}{/if}">

                        {foreach from=$var item=var_desc key=var_name}
                        <option value="{ldelim}${if $var_key != 'other'}{$var_key}.{/if}{$var_name}{rdelim}">{if $lang[$var_desc]}{$lang[$var_desc]}{else}{$var_desc}{/if} </option>
                        {/foreach}

                    </optgroup>
                    {/if}{/foreach}


                </select>
                <!--<a id="addnew_conf_btn" onclick="$(this).hide();$('#accordionc').show();return false;" class="new_control" href="#"  {if $expanded}style="display:none"{/if}>
                    <span class="addsth">{$lang.showmevars}</span></a>--></td>
            <td>{if !$inline && $email.for!='Admin'}
                <!-- <a id="addnewt_conf_btn" onclick="$('#chooselang').show();$(this).hide();return false;" class="new_control" href="#" ><span class="addsth">{$lang.addtransl}</span></a> -->

                <div id="chooselang" style="display:none">
                    <span class="fs11">{$lang.chooselanguage}:</span> <select name="newtr">
		{foreach from=$alanguages item=l}
                        <option >{$l|ucfirst}</option>
		{/foreach}
                    </select>
                    <input type="button" value="{$lang.Add}" onclick="addTranslation()" />
                </div>
                {/if}</td>

        </tr>
    </table>



</div>

<script type="text/javascript">
    {literal}
    function previewEmail() {
         var id = $('#mbody textarea:eq(0)').attr('id');
        if(!id)
            return false;
        var m = $('#'+id);
        $('#prevbody').val(m.val());
        $('#previewform').submit();
        return false;
    }
    function loadvar(item){
        var myValue = $(item).val();
        $(item).val('0');
        if (myValue==0)
            return;

        var tar = $('table[id^="langform_"]:visible textarea');
        if(!tar.length)
            return;

        var tiny = tar.tinymce(),
            editor = false;
        if(tiny && tiny.getContainer() && $(tiny.getContainer()).is(':visible')){
            editor = true;
        }
        
        if(editor){
            tiny.execCommand('insertHTML', false, myValue);
            tiny.save();
        }
        else if (document.selection) {
            tar.focus();
            sel = document.selection.createRange();
            sel.text = myValue;
            tar.focus();
        }
        //MOZILLA/NETSCAPE support
        else if (tar[0].selectionStart || tar[0].selectionStart == '0') {
            console.log('pos', tar[0].selectionStart)
            var startPos = tar[0].selectionStart;
            var endPos = tar[0].selectionEnd;
            var scrollTop = tar[0].scrollTop;
            var content = tar.val().substring(0, startPos)
                + myValue
                + tar.val().substring(endPos,tar.val().length);
            
            if(tiny){
                console.log('pos ed', content);
                tiny.setContent(content);
                tiny.save();
            }else
                tar.val(content);
            tar.focus();
            tar[0].selectionStart = startPos + myValue.length;
            tar[0].selectionEnd = startPos + myValue.length;
            tar[0].scrollTop = scrollTop;
        } else {
            tar.val(tar.val()+myValue);
            tar.focus();
        }
        return false;
    }

    {/literal}
</script>


{/if}