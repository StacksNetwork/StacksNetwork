{if $action=='getvariables'}
    {include file='ajax.emailvariables.tpl'}
{elseif $action=='adds'}
{literal}<script type="text/javascript">

    function submitform(el) {
        ajax_update("?cmd=emailtemplates&action=add&inline=true",$(el).serialize());
        return false;
    }
 
</script>   {/literal}
<form method="post"  action="?cmd=emailtemplates&action=add" {if $inline} onsubmit="return submitform(this)"{/if}>
    {if !$inline}
    <div class="blu"> <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;
        <input type="submit" name="submit" style="font-weight:bold" value="{$lang.addtemplate}" />
        <input type="button" onclick="window.location='?cmd=emailtemplates'" value="{$lang.Cancel}"/>
    </div>
    {/if} 
    <div class="lighterblue" style="padding:5px;">
        {if $to}<input type="hidden" name="to" value="{$to}" />{/if}
        {if $dontclose}<input type="hidden" name="dontclose" value="true" />{/if}
        <input type="hidden" name="make" value="add" />
        <input type="hidden" value="{if !$submit || $submit.plain}1{else}0{/if}" name="plain" id="email_plain" />
        {foreach from=$langs item=lgname key=lgid name="loop"}
            {if !is_array($email.plain)}
                {assign var=is_plain value=$email.plain}
                {assign var=tpl_subject value=$email.subject}
                {assign var=tpl_message value=$email.message}
            {else}
                {assign var=is_plain value=$email.plain.$lgid}
                {assign var=tpl_subject value=$email.subject.$lgid}
                {assign var=tpl_message value=$email.message.$lgid}
            {/if}
        <table width="100%" cellspacing="0" cellpadding="6" {if !$smarty.foreach.loop.first}style="display:none"{/if} id="langform_{$lgid}">
            <tbody>
                <tr>
                    <td width="160">
                        <strong>{$lang.Subject}:</strong>
                    </td>
                    <td>
                        {hbinput value=$submit.subject style="" class="inp" size="50" name="subject"}
                    </td>
                </tr>
            {if $inline}
                <tr>
                    <td style="vertical-align: top" colspan="2">
                        <strong>{$lang.Body}:</strong>
                    </td>
                </tr>
            {/if}
            </tbody>
            <tbody id="mbody">
                <tr>
                    {if !$inline}
                        <td  valign="top">
                            <strong>{$lang.Body}:</strong>
                        </td>
                    {/if}
                    <td style="vertical-align: top"   {if $inline}colspan="2"{/if}>
                        {hbwysiwyg wrapper="div" style="width:99%;" value=$submit.message 
                        additionaltabs=$language_tabs cols="100" rows="15"
                        class="inp wysiw_editor" name="message" 
                        featureset="full" onclickplain="$(\"#email_plain\").val(1);" 
                        onclickeditor="$(\"#email_plain\").val(0);" editortag="HTML"}
                    </td>
                </tr>
            </tbody>
            <tbody>
                <tr>
                    <td id="emailvariables" style="vertical-align: top" colspan="2">{include file='ajax.emailvariables.tpl'}</td>
                </tr>
            </tbody>
        </table>
        <script type="text/javascript">$('#langform_{$lgid} .additional').eq($('#langform_{$lgid}').prevAll('table').length+1).addClass('active');</script>
       {/foreach}
       {literal}
       <script type="text/javascript">
       function set_email_mode(ths,to){
            $(ths).parents("table[id^='langform']").find("input.email_plain").val(to);
        }
        $('.tabs_wysiw li').click(function(){
            if($(this).index() < 2){
                var el = $(this).nextAll('.additional').eq($(this).parents('table[id^="langform"]').prevAll('table').length+1);
                el.addClass('active');
                if($(this).index() == 1)
                    el.find('a').css('background', '#F0F0EE');
                else el.find('a').css('background', '')
            }else{
                var el = $('table[id^="langform"]').hide().eq($(this).prevAll('.additional').length-1).show();
                if(el.find("input.email_plain").val() == 0 && !el.find(".tabs_wysiw li").eq(1).hasClass('active') && !el.find(".tabs_wysiw li").eq(1).data('autooff')){
                    el.find(".tabs_wysiw li").eq(1).data('autooff', true).children().click();
                }
                
            }
        });
        {/literal}{if $submit &&  !$submit.plain}{literal}
            function bindhtmlswitch() {
                    $('.tabs_wysiw li:eq(1) a').click();
            }
            appendLoader('bindhtmlswitch');
        {/literal}{/if}{literal}
        </script>
        
       {/literal}
</div>
<div class="blu">
    {if !$inline}<a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;{/if}
    <input type="submit" name="submit" style="font-weight:bold" value="{$lang.addtemplate}" />
    {if !$inline}     <input type="button" onclick="window.location='?cmd=emailtemplates'" value="{$lang.Cancel}"/> {/if}
</div>
{securitytoken}</form>
<form id="previewform" target="_blank" method="post" action="?cmd=emailtemplates&action=preview">
    <input type="hidden" name="body" id="prevbody" value=""/>
    {securitytoken}</form>



{elseif $action == 'edit' || $action=='add'}
{literal}
<script type="text/javascript">
    function submitform(el) {
        ajax_update("?cmd=emailtemplates&action={/literal}{if $action=='add'}add{else}edit&id={$email.id}{/if}{literal}&inline=true",$(el).serialize());
        return false;
    }
</script>   
{/literal}
<form method="post" {if $action=='add'}action="?cmd=emailtemplates&action=add"{else}action="?cmd=emailtemplates&action=edit&id={$email.id}"{/if}  {if $inline} onsubmit="return submitform(this)"{/if}>

      {if !$inline}
        <div class="blu"> 
            {if $email.group=='Mobile'}
                <a href="?cmd=notifications" class="tload2"><strong>&laquo; {$lang.backto} {$lang.Notifications}</strong></a>&nbsp;
            {else}
                <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;
            {/if}
            <input type="submit" name="submit" style="font-weight:bold" value="{if $action=='add'}{$lang.addtemplate}{else}{$lang.savechanges}{/if}" />
            <input type="button" onclick="window.location='?cmd=emailtemplates'" value="{$lang.Cancel}"/>
            {if $email.system=='0'}
                <input type="button" onclick="{literal}if(confirm('{/literal}{$lang.deletetemplateconfirm}{literal}')){window.location='?cmd=emailtemplates{/literal}&security_token={$security_token}{literal}&make=delete&id={/literal}{$email.id}{literal}'} else {return false;}{/literal}" style="color:red" value="{$lang.Delete}"/>
            {/if}
        </div>
    {/if}
    <div class="lighterblue" style="padding:5px;">
        {if $email.send=='0'}
            <div class="imp_msg" id="disablednote"><strong>{$lang.disablednote}</strong> <a href="#" onclick="$('#disablednote').hide();ajax_update('?cmd=emailtemplates&make=enable&id={$email.id}');return false;" class="editbtn">{$lang.Enable}</a></div>
        {/if}
        {if $action=='add'}
            <input type="hidden" name="make" value="add" />
        {else}
            <input type="hidden" name="make" value="edit" />
        {/if}
        {if $to}<input type="hidden" name="to" value="{$to}" />{/if}
        {if $dontclose}<input type="hidden" name="dontclose" value="true" />{/if}
        <input type="hidden" name="group"  value="{$email.group}"/>
        <input type="hidden" name="send"  value="{$email.send}"/>
        <input type="hidden" name="tplname"  value="{$email.tplname}"/>
        <input type="hidden" name="system"  value="{$email.system}"/>
        {foreach from=$langs item=lgname key=lgid name="loop"}
            {if !is_array($email.plain)}
                {assign var=is_plain value=$email.plain}
                {assign var=tpl_subject value=$email.subject}
                {assign var=tpl_message value=$email.message}
            {else}
                {assign var=is_plain value=$email.plain.$lgid}
                {assign var=tpl_subject value=$email.subject.$lgid}
                {assign var=tpl_message value=$email.message.$lgid}
            {/if}
        <table width="100%" cellspacing="0" cellpadding="6" {if !$smarty.foreach.loop.first}style="display:none"{/if} id="langform_{$lgid}">
            <tr>
                <td width="160">
                    <input type="hidden" value="{$lgid}" name="language_id[{$lgid}]"/>
                     <input type="hidden" value="{$lgname}" name="language_name[{$lgid}]"/>
                    <input type="hidden" value="{if (!$email && $inline) || $is_plain}1{else}0{/if}" name="plain[{$lgid}]" class="email_plain" />
                    <strong>{$lang.Subject}:</strong>{if $language_tabs }<br />
                    <small>({$lgname|capitalize})</small>{/if}
                </td>
                <td >
                    {hbinput value=$tpl_subject style="" class="inp" size="50" name="subject[`$lgid`]"}
                    
                </td>
            </tr>
            <tbody id="mbody">
                <tr>
                    <td  valign="top"><strong>{$lang.Body}:</strong></td>
                    <td valign="top">
                        {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs 
                            value=$tpl_message  class="inp wysiw_editor" cols="100" rows="15"  name="message[`$lgid`]" featureset="full" 
                            onclickplain="set_email_mode(this,1);" 
                            onclickeditor="set_email_mode(this,0);" editortag="HTML"}
                    </td>
                </tr>
            </tbody>
            <tr>
                <td id="emailvariables" style="vertical-align: top" colspan="2">{include file='ajax.emailvariables.tpl'}</td>
            </tr>
        </table>
        <script type="text/javascript">$('#langform_{$lgid} .additional').eq($('#langform_{$lgid}').prevAll('table').length+1).addClass('active');</script>
        
        {/foreach}
       
       {literal}
       <script type="text/javascript">
        function set_email_mode(ths,to){
            $(ths).parents("table[id^='langform']").find("input.email_plain").val(to);
        }
        $('.tabs_wysiw li a').click(function(){
            if($(this).parent().index() < 2){
                var el = $(this).parent().nextAll('.additional').eq($(this).parents('table[id^="langform"]').prevAll('table').length+1);
                el.addClass('active');
                if($(this).parent().index() == 1)
                    el.find('a').css('background', '#F0F0EE');
                else el.find('a').css('background', '')
            }else{
                var el = $('table[id^="langform"]').hide().eq($(this).parent().prevAll('.additional').length-1).show();
                if(el.find("input.email_plain").val() == 0 && !el.find(".tabs_wysiw li").eq(1).hasClass('active') && !el.find(".tabs_wysiw li").eq(1).data('autooff')){
                    el.find(".tabs_wysiw li").eq(1).data('autooff', true).children().click();
                }
                $('.tabs_wysiw li select').val($(this).parent().prevAll('.additional').length);
            }
            
            return false;
        });

        if($(".email_plain","#langform_1, #langform_0").val() == 0)
            $('.tabs_wysiw li:eq(1) a').click();

        </script>
       {/literal}
      
    </div>
    <div class="blu"> {if !$inline}
            {if $email.group=='Mobile'}
                <a href="?cmd=notifications" class="tload2"><strong>&laquo; {$lang.backto} {$lang.Notifications}</strong></a>&nbsp;
            {else}
                <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;
            {/if}
        {/if}
        <input type="submit" name="submit" style="font-weight:bold" value="{$lang.savechanges}" />
        {if !$inline}<input type="button" onclick="window.location='?cmd=emailtemplates'" value="{$lang.Cancel}"/>{/if}
        {if !$inline}{if $email.system=='0'}<input type="button" onclick="{literal}if(confirm('{/literal}{$lang.deletetemplateconfirm}{literal}')){window.location='?cmd=emailtemplates{/literal}&security_token={$security_token}{literal}&make=delete&id={/literal}{$email.id}{literal}'} else {return false;}{/literal}" style="color:red" value="{$lang.Delete}"/>{/if}{/if}
    </div>
    {securitytoken}</form>
<form id="previewform" target="_blank" method="post" action="?cmd=emailtemplates&action=preview">
    <input type="hidden" name="body" id="prevbody" value=""/>
    {securitytoken}</form>
{/if}