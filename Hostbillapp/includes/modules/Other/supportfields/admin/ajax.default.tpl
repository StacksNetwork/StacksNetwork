
{if $do=='fconfig'}

{$configform}
{elseif $do=='newfield' || $do=='field'}
<div class="nicerblu">

<form action="" method="post">
{if $do=='field'}
    <input type="hidden" name="make" value="edit"/>
    <input type="hidden" name="fid" value="{$field.id}"/>
{else}
    <input type="hidden" name="make" value="addnew"/>
{/if}
    <div id="ftype" {if $do=='field'}style="display:none"{/if}>
        {if $do=='field'}<h1>编辑字段 {$field.name}</h1>{else}<h1>添加新字段 1/4</h1>{/if}
    <table border=0 cellspacing=0 cellpadding=3 width="100%">
    <tr>
        <td width="160"><strong>选择您的字段类型:</strong></td>
        <td >{foreach from=$types item=type key=k}
    <input type="radio" name="type" value="{$k}" onclick="loadfconf('{$k}');"/> {$type}<br />
    {/foreach}</td>
    </tr>
    <tr><td colspan="2" align="center"><a class=" menuitm disabled" href="#" onclick="return loadfconf();">
                <span><b>继续</b></span>
            </a>
        </td></tr>
    
</table>
    </div>
    <div id="configform"  {if $do!='field'}style="display:none"{/if}>
{if $do=='field'}<h1>编辑字段 {$field.name} 1/3</h1>{else}<h1>添加新字段 2/4</h1>{/if}
<table border=0 cellspacing=0 cellpadding=3  width="100%">
    <tr>
        <td width="160"><b>名称</b></td>
        <td ><input name="name" value="{$field.name}" class="inp" onkeyup="return loadept(this);"/></td>
    </tr>
    <tr>
        <td width="160" valign="top"><b>说明</b></td>
        <td ><textarea name="description" cols=60 rows=3 class="inp">{$field.description}</textarea></td>
    </tr>
</table>
    <div id="fconfiguration">
        {if $do=='field' }
        {$field.configform}
        {/if}
    </div>
      <center><br/><a class=" {if $do=='field'}new_control greenbtn{else}menuitm disabled{/if}" href="#" onclick="if($(this).hasClass('disabled'))return false;$('#configform').slideUp();$('#fdepts').slideDown();return false;">
                <span><b>继续</b></span>
            </a>  </center>
    </div>
    <div id="fdepts" style="display:none">
        {if $do=='field'}<h1>编辑字段 {$field.name} 2/3</h1>{else}<h1>添加新字段 3/4</h1>{/if}
<table border=0 cellspacing=0 cellpadding=3  width="100%">
    <tr>
        <td width="160"><b>部门</b></td>
        <td >
            {foreach from=$depts item=dept}
            <input type="checkbox" value="0" id="dept_{$dept.id}" name="dept[{$dept.id}][0]" onclick="shh(this)" class="deptsin" {if $field.depts[$dept.id]}checked="checked"{/if}> {$dept.name}<br/>
            <div class="fs11" style="padding:5px 0px 5px 20px;{if !$field.depts[$dept.id]}display:none{/if}">
               <input type="checkbox" value="1"  name="dept[{$dept.id}][1]" class="deptsin2"  onclick="shh(this)" {if $field.depts[$dept.id] && ($field.depts[$dept.id] |1)}checked="checked"{/if}> 新工单 <br/>
               <input type="checkbox" value="2"  name="dept[{$dept.id}][2]"  class="deptsin2" onclick="shh(this)" {if $field.depts[$dept.id] && ($field.depts[$dept.id] |2)}checked="checked"{/if}> 已答复的工单
            </div>
            {/foreach}
        </td>
    </tr>

</table>
         <center><br/>
             <a class="{if $do!='field' } menuitm disabled{else}new_control greenbtn{/if}" href="#" onclick="if($(this).hasClass('disabled'))return false;$('#fdepts').slideUp();$('#fpostaction').slideDown();return false;">
                <span><b>继续</b></span>
            </a>  </center>
    </div>
     <div id="fpostaction" style="display:none">
         {if $do=='field'}<h1>编辑字段 {$field.name} 3/3</h1>{else}<h1>添加新字段 4/4</h1>{/if}
<table border=0 cellspacing=0 cellpadding=3  width="100%">
    <tr>
        <td width="160"><b>后续动作</b></td>
        <td >
         
            <input type="radio" value="ticket" name="action" checked="checked" {if !$field || $field.action=='ticket'}checked="checked"{/if}> 保存在工单内<br />
            <input type="radio" value="client" name="action" {if $field.action=='client'}checked="checked"{/if}> 保存在客户配置文件中<br />
            
          
        </td>
    </tr>

</table>
         <center>
            <input type="submit" class="submitme" style="font-weight:bold" value="{if $do=='field'}{$lang.savechanges}{else}添加新字段{/if}"/>
         </center>
    </div>
</form>
</div>
<script type="text/javascript">
{literal}
    function shh(el) {
        if($(el).is(':checked') && $(el).attr('id')) {
            $(el).next().next('div').show().find('input').attr('checked','checked');
        } else {
            $(el).next().next('div').hide().find('input').removeAttr('checked');
         }

        if($('#fdepts .deptsin2:checked').length) {
            $('#fdepts .menuitm').attr('class',"new_control greenbtn");
        } else {
           $('#fdepts .new_control').attr('class',"menuitm disabled");
        }

    }
    function loadept(el) {
        if($(el).val()!='')
          $('#configform .menuitm').attr('class',"new_control greenbtn");
        else {
          $('#configform .new_control').attr('class',"menuitm disabled");
        }
    }
  function loadfconf(field) {
      if(field) {
        $('#ftype .menuitm').attr('class',"new_control greenbtn");
    } else {
        var f=$('#ftype input:checked');
        if(f.length<1)
            return false;

$('#ftype').slideUp();
      $('#configform').slideDown();
    ajax_update("?cmd=module&module={/literal}{$moduleid}{literal}&do=fconfig",{type:f.val()},"#fconfiguration");

    }
return false;
    }
{/literal}
</script>
{elseif $do=='getjs' && $fields}{literal}
(function ($) {
    var wrapper = $("<div></div>").attr('id','asker_fields').css({
        padding:5,
        margin:10,
        width:280,
        background:'#FFF890'
    });
{/literal}
    {if $place=='client'}
    {foreach from=$fields item=field}
        wrapper.append({$field.html});
    {/foreach}
{literal}

    $('#AdmNotes').after(wrapper);
{/literal}
    {else}
    {foreach from=$fields item=field}
        wrapper.append({$field.html});
    {/foreach}
{literal}
   
  wrapper.css('float','right');
$('#client_tab .slide').eq(0).append(wrapper);
wrapper.prev().addClass('left');
{/literal}

    {/if}
{literal}
wrapper.after("<div class='clear'></div>");
})(jQuery);
{/literal}{/if}