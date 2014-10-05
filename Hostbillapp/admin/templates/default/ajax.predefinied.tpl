{if $action=='default' || $action=='newcat' || $action=='new' || $action=='view' || $action=='viewcat'}
    <div class="blu"> 
        {if $action!='default'}
            <a href="?cmd={$cmd}"> <strong>{$lang.ticketmacros}</strong> </a>
        {else}
            <strong>{$lang.ticketmacros}</strong>
        {/if}
        {if $action=='newcat'}
            &raquo; <strong>{$lang.addcat}</strong>
        {/if}
        {if $action=='new'}
            &raquo; <strong>{$lang.addmacro}</strong>
        {/if}
        {if $action=='view'}
            &raquo; <strong>{$lang.Edit} {$lang.macro}</strong>
        {/if}
        {if $action=='viewcat'}
            &raquo; <strong>{$lang.Edit} {$lang.Category}</strong>
        {/if}
    </div>
{/if}
{if ($action=="default" || $action=="myreplies" || !$action) && $category}

    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li {if $picketdtab || $pickedtab == 0}class="active"{/if}>
                    <a href="#">{$lang.listcats}</a>
                </li>
                <li class="last">
                    <a href="#">{$lang.mymacros}</a>
                </li>
            </ul>
        </div>
        <div class="list-2">
            <div class="navsubmenu haveitems">
                <ul>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=newcat" ><span>{$lang.addcat}</span></a></li>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=new" ><span>{$lang.addmacro}</span></a></li>
                </ul>
            </div>
            <div class="navsubmenu haveitems" style="display:none">
                <ul>
                    <li class="list-2elem"><a href="?cmd={$cmd}&action=new&mine" ><span>{$lang.addmacro}</span></a></li>
                </ul>
            </div>
        </div>
    </div>
    {literal}
        <style>
            /*.treeview .hitarea{
            background-image: url("{/literal}{$template_dir}{literal}/tree/treeview-default-filed.gif")   
            }*/
            .treeview ul{
                background-color: transparent
            }
            a.sorter-handler{
                cursor:n-resize
            }
            a.sorter-handler:active{
                border-color:#B0B0B0!important;
                background:#f2f2f2!important
            }
            ul.grab-sorter{
                border:solid 1px #ddd;
                border-bottom:none;
                position: relative;
            }
            ul.grab-sorter li{
                border-bottom:solid 1px #ddd;
                clear: both;
                background: #fff;
                width: 100%
            } 

            ul.grab-sorter li div.actions,
            ul.grab-sorter li div.lastitm,
            ul.grab-sorter li div.name{
                float:left;
                padding: 10px 5px;
            }

            ul.grab-sorter li:after{
                content: ".";
                display: block;
                clear: both;
                visibility: hidden;
                line-height: 0;
                height: 0;
            }
            ul.grab-sorter li div.lastitm{
                width:150px;
                float:right;
                padding: 3px 5px;
                background:#F0F0F3;
                color:#767679;
            }
            ul.grab-sorter li div.actions{
                height: 15px;
                width: 85px;
            }
            ul.grab-sorter li:hover div.lastitm, ul.grab-sorter li:hover{
                background: #FFFED1;
            }
            ul.grab-sorter li.placeHolder{
                height:35px;
                border:dashed 1px #999
            }
            .macros{
                background: #FFFFFF;
                border: 1px solid #DDDDDD;
                padding: 2px 5px 10px;
            }
            .actions label{
                display:block
            }
        </style>
    {/literal}
{/if}
{if $action=='gettop' || $action=='browser'}
    {literal}
        <script type="text/javascript">
            $('.replyget a','#replybrocontainer').unbind('click').bind('click',function(){
                predef_macro(this);
                return false;
            });
            function predef_macro(thiss){
                $.post($(thiss).attr('href'),{}, function(resp){		
                if (typeof resp == 'object' && typeof resp.macro == 'object')  { 
                    if (resp.macro.errors != undefined){
                        //handle errors;
                    }else{
                        if(resp.macro.priority != undefined && resp.macro.priority != null){
                            switch(resp.macro.priority){
                                case '0': var prio = 'Low'; break; 
                                case '1': var prio = 'Medium'; break;  
                                case '2': var prio = 'High'; break;  
                            }
                            $('#ticketbody h1').attr('class','').addClass('prior_'+prio);
                            $.post('?cmd=tickets&action=menubutton&make=setpriority',{id:$('#ticket_number').val(),priority:prio});
                        }
                        if(resp.macro.status != undefined && resp.macro.status != null){
                           // var trts = ["Open", "Closed", "Answered", "In-Progress", "Client-Reply"];
                            $('select[name="status_change"]').val(resp.macro.status);
                        }
                        if(resp.macro.owner != undefined && resp.macro.owner != null){
                            if($('select[name="owner"]').children('[value="'+resp.macro.owner+'"]').length){
                                var txt = $('select[name="owner"]').children('[value="'+resp.macro.owner+'"]').text(); 
                                $('select[name="owner"]').val(resp.macro.owner).prev().text(txt);
                                $('#hd6 span').text('Assigned to '+txt)
                                
                            }
                        }
                        if(resp.macro.tags != undefined && resp.macro.tags != null && resp.macro.tags.length){
                            if(ticket != undefined && typeof ticket.insertTags == 'function'){
                                
                                for(var i = 0; i < resp.macro.tags.length; i++){
                                    var ev = jQuery.Event("keyup");
                                    ev.which = 13;
                                    $('input#tagsin').val(resp.macro.tags[i]).trigger(ev).val('').next('ul').hide();
                                }
                                
                            }
                        }
                        if(resp.macro.tags_rem != undefined && resp.macro.tags_rem != null && resp.macro.tags_rem.length){
                            if(ticket != undefined && typeof ticket.insertTags == 'function'){
                                var tags = $('a:first-child', '#tagsCont');
                                for(var i = 0; i < resp.macro.tags_rem.length; i++){
                                    tags.filter(function(){return $(this).text() == resp.macro.tags_rem[i]}).next().click();
                                }
                            }
                        }
                        if(resp.macro.reply != undefined && resp.macro.reply != null && resp.macro.reply.length){
                            if(resp.macro.note != undefined && resp.macro.note != null && parseInt(resp.macro.note) == 1){
                                $('a[name="notes"]').click();  
                                var reply = $('#ticketnotesarea').val().length ? $('#ticketnotesarea').val()+ "\r\n"  : '';
                                $('#ticketnotesarea').val(reply + resp.macro.reply).focus();
                            }else{
                                var reply = $('#replyarea').val().length ? $('#replyarea').val() + "\r\n": '';
                                $('#replyarea').val(reply + resp.macro.reply).focus();
                            }
                        }
                    }
                }});
            }
        </script>
    {/literal}
{/if}
{if $action=='gettop'}
    <div id="replybrocontainer">
        {if $replies}
            {foreach from=$replies item=reply key=k}
                <div  class="replyget"><a href="?cmd={$cmd}&action=getmacro&id={$reply.id}"><strong>{$reply.name}</strong></a> <i style="color:#999">{$reply.reply|truncate:100}</i></div>
            {/foreach}
            <div style="text-align:right;" class="fs11"><a href="?cmd=predefinied&action=myreplies" target="_blank" class="editbtn" >{$lang.manageyour}</a></div>
        {else}
            <center> {$lang.blank_kb2} <a href="?cmd={$cmd}&action=myreplies" target="_blank" >{$lang.heretoadd}</a></center>
        {/if}
    </div>
{elseif $action == 'getmacros'}
    {if $replies}
        {foreach from=$replies item=reply key=k}
            <li><a href="{$reply.id}">{$reply.name}</a></li>
        {/foreach}
    {/if}
{elseif $action=='getcat'}	
    {if $category.name}	
        <div class="hitarea collapsable-hitarea "></div>
        <a class="folder" href="?cmd=predefinied&action=getcat&cid={$category.id}">{$category.name}</a> 
        <a href="?cmd=predefinied&action=viewcat&cid={$category.id}" class="edit ">{$lang.Edit}</a> 
        <a href="?cmd=predefinied&action=deletecat&cid={$category.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.removecategoryconfirm}')">{$lang.delete}</a>
        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=predefinied&action=getcat&cid={$cat.id}">{$cat.name}</a>
                    </li>
                {/foreach}
            {/if}

            {if $category.replies}
                {foreach from=$category.replies item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}">
                        <a class="file" href="?cmd=predefinied&action=view&id={$rep.id}">{$rep.name}</a>
                        <a href="?cmd=predefinied&action=deletereply&id={$rep.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.removereplyconfirm}')">{$lang.delete}</a> 
                        {$rep.reply}
                    </li>
                {/foreach}
            {/if}
        </ul>
        <script type="text/javascript">bindPredefinied();</script>
    {/if}
{elseif $action=='getcat2'}	
    {if $category.name}	
        <div class="hitarea collapsable-hitarea "></div>
        <a class="folder" href="?cmd=predefinied&action=getcat2&cid={$category.id}">{$category.name}</a>
        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.replies}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=predefinied&action=getcat2&cid={$cat.id}">{$cat.name}</a>
                    </li>
                {/foreach}
            {/if}

            {if $category.replies}
                {foreach from=$category.replies item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}"><a class="file fil2" href="?cmd=predefinied&action=getmacro&id={$rep.id}">{$rep.name}</a> {$rep.reply}</li>
                {/foreach}
            {/if}
        </ul>

        {literal}
        <script type="text/javascript">
            bindPredefinied();
            $('a.fil2','#suggestion').unbind('click').bind('click',function(){
                predef_macro(this);
                return false;
            });
        </script>
        {/literal}
    {/if}	

{elseif $action=='browser'}	
    {if $category}
        <ul class="filetree treeview" id="browser">

            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=predefinied&action=getcat2&cid={$cat.id}">{$cat.name}</a>
                    </li>
                {/foreach}
            {/if}
        </ul>

        <script type="text/javascript">bindPredefinied();</script>
    {else}
        <p align="center" >{$lang.nothingtodisplay} - <a href="?cmd=predefinied&action=newcat">{$lang.addnewcategory}</a> {$lang.tostart}.</p>
    {/if}
{elseif $action=='getr'}{*
    *}{$reply}{*
*}{elseif $action=='new' || $action=='view'}
    {literal}
        <style>
            .action-label{
                display:block;
                padding: 0 0 4px;
            }
            .action-label span{

                float:left;
                width: 30%;
            }
        </style>
    {/literal}
    <form action="?cmd={$cmd}&action={$action}{if $action=='view'}&id={$reply.id}{/if}" method="post" >
        <input type="hidden" name="make" value="{if $action=='view'}update{else}add{/if}" />
    {if $reply.mine}<input type="hidden" value="1" name="mine" />{/if}
    <div class="nicerblu" style="padding:10px;">
        <table border="0" cellpadding="3" cellspacing="0" width="100%">
            <tr>
                <td width="100"><b>{$lang.Category}:</b></td>
                <td>
                    <select name="category_id" id="catpicker" class="inp">
                        {foreach from=$categories item=cat}
                            <option value="{$cat.id}" {if $reply.category_id==$cat.id}selected="selected"{/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name} </option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <td><b>{$lang.Name}:</b></td>
                <td><input name="name" value="{$reply.name}" size="70" class="inp"/></td>
                <td colspan="2" style="width:40%"><b>{$lang.availactions}</b></td>
            </tr>
            <tr>
                <td >{*
                    <label><input type="radio" {if !$reply.note}checked="checked"{/if} name="note" value="0" /> <b>Reply</b></label><br />
                    <label><input type="radio" {if $reply.note}checked="checked"{/if} name="note" value="1" /> <b>Note</b></label>
                    *}<b>Reply</b>:
                </td>
                <td>
                    <textarea style="width:99%" rows="12"  name="reply">{$reply.reply}</textarea>
                </td>

                <td style="vertical-align: top" >
                    <label class="action-label">
                        <span>{$lang.changestatus}:</span>
                        <select name="status" class="inp">
                            <option value="">{$lang.nochange}</option>
                            {foreach from=$statuses item=status}
                            <option value="{$status}" {if $status==$reply.status}selected="selected"{/if}>{$lang.$status}</option>
                            {/foreach}
                        </select>
                    </label>

                    <label class="action-label">
                        <span>{$lang.changepriority}:</span>
                        <select name="priority" class="inp">
                            <option value="">{$lang.nochange}</option>
                            <option {if $reply.priority == '0'}selected="selected"{/if} value="0">{$lang.Low}</option>
                            <option {if $reply.priority == '1'}selected="selected"{/if} value="1">{$lang.Medium}</option>
                            <option {if $reply.priority == '2'}selected="selected"{/if} value="2">{$lang.High}</option>
                        </select>

                    </label>

                    <label class="action-label">
                        <span>{$lang.assignto}:</span>
                        <select name="owner" class="inp">
                            <option value="">{$lang.nochange}</option>
                            {foreach from=$staff_members item=stfmbr}
                                <option {if $reply.owner == $stfmbr.id}selected="selected"{/if} value="{$stfmbr.id}">{$stfmbr.firstname} {$stfmbr.lastname}</option>
                            {/foreach}
                        </select>
                    </label>
                        
                    <label class="action-label">
                        <span>{$lang.sharewith}:</span>
                        <select name="share" class="inp">
                            <option value="">{$lang.nochange}</option>
                            {foreach from=$agreements item=agree}
                                <option {if $reply.share == $agree.id}selected="selected"{/if} value="{$agree.id}">#{$agree.tag}</option>
                            {/foreach}
                        </select>
                    </label>
                    <div class="clear">Tags to add</div>
                    <div id="tagsInput" class="left ticketsTags" style="position:relative; width:400px;line-height: 14px; padding: 3px 0 0 5px; border: 1px solid #ddd; background: #fff; margin-right: 3px; overflow: visible">
                        {foreach from=$reply.tags item=tag}
                            <span class="tag"><a>{$tag}</a> |<a class="cls">x</a></span>
                        {/foreach}
                        <label style="position:relative" for="tagsin" class="input">
                            <em style="position:absolute">{$lang.tags}</em>
                            <input id="tagsin" autocomplete="off" style="width: 80px">
                            <ul style="overflow-y:scroll; max-height: 100px; bottom: 23px; left: -7px"></ul>
                        </label>
                    </div>
                    <div id="tags" style="display: none">
                        {foreach from=$reply.tags item=tag}
                            <input type="hidden" name="tags[]" value="{$tag}" />
                        {/foreach}
                    </div>

                    <div class="clear" style="padding-top:10px;">Tags to remove</div>
                    <div id="tagsInput2" class="left ticketsTags" style="position:relative; width:400px;line-height: 14px; padding: 3px 0 0 5px; border: 1px solid #ddd; background: #fff; margin-right: 3px; overflow: visible">
                        {foreach from=$reply.tags_rem item=tag}
                            <span class="tag"><a>{$tag}</a> |<a class="cls">x</a></span>
                        {/foreach}
                        <label style="position:relative" for="tagsin2" class="input">
                            <em style="position:absolute">{$lang.tags}</em>
                            <input id="tagsin2" autocomplete="off" style="width: 80px">
                            <ul style="overflow-y:scroll; max-height: 100px; bottom: 23px; left: -7px"></ul>
                        </label>
                    </div>
                    <div id="tags2" style="display: none">
                        {foreach from=$reply.tags_rem item=tag}
                            <input type="hidden" name="tags_rem[]" value="{$tag}" />
                        {/foreach}
                    </div>
                </td>
            </tr>

        </table>

    </div>
    <div class="blu">
        <a href="?cmd={$cmd}"  class="tload2"><strong>&laquo; {$lang.backtolisting}</strong></a>
        <input type="submit" style="font-weight:bold" value="{if $action=='view'}{$lang.savechanges}{else}{$lang.addmacro}{/if}">
        <span class="orspace">{$lang.Or}</span> <a class="editbtn"  href="?cmd=predefinied">{$lang.Cancel}</a>
    </div>
    {literal}
        <script type="text/javascript">
        $(function(){

            ticket.bindTagsActions('#tagsInput', 0, 
                function(tag){$('#tags').append('<input type="hidden" name="tags[]" value="'+tag+'" />'); repozition('#tagsInput');},
                function(tag){repozition('#tagsInput');$('#tags input[value="'+tag+'"]').remove(); } 
            );
            ticket.bindTagsActions('#tagsInput2', 0, 
                function(tag){$('#tags2').append('<input type="hidden" name="tags_rem[]" value="'+tag+'" />'); repozition('#tagsInput2');},
                function(tag){repozition('#tagsInput2');$('#tags2 input[value="'+tag+'"]').remove(); } 
            );
                
            function repozition(el){
                $(el+' ul').css({left: - $(el+' label').position().left - 2, bottom:$(el).height()+2});
            }
            repozition();
        });
        </script>
    {/literal}
    {securitytoken}
</form>
{elseif $action=='viewcat' || $action=='newcat'}

    <form action="?cmd={$cmd}&action={$action}{if $action=='viewcat'}&cid={$category.id}{/if}" method="post" >
        {if $action=='viewcat'}
            <input type="hidden" name="make" value="update" />
        {else}
            <input type="hidden" name="make" value="add" />
        {/if}

        <div class="nicerblu" style="min-height:250px;">
            <table border="0" cellpadding="6" cellspacing="0" width="600">
                <tr>
                    <td width="160"><b>{$lang.parentcat}:</b></td>
                    <td>
                        <select name="parent_cat" id="catpicker"  class="inp">
                            <option value="0">{$lang.topcategory}</option>
                            {foreach from=$categories item=cat}
                                <option value="{$cat.id}" {if $category.parent_cat==$cat.id}selected="selected"{/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="160"><b>{$lang.Name}:</b></td>
                    <td>
                        <input name="name" value="{$category.name}" size="75" class="inp"/>
                    </td>
                </tr>
            </table>

        </div>
        <div class="blu">
            <a href="?cmd={$cmd}"  class="tload2"><strong>&laquo; {$lang.backtolisting}</strong></a>
            {if $action=='viewcat'}
                <input type="submit" style="font-weight:bold" value="{$lang.savechanges}">
            {else}
                <input type="submit" style="font-weight:bold" value="{$lang.addcat}">
            {/if}
            <span class="orspace">{$lang.Or}</span> <a class="editbtn"  href="?cmd=predefinied">{$lang.Cancel}</a>
        </div>
        {securitytoken}
    </form>
{else}

    {if $category}
        <div class="sectioncontent">
            <div style="min-height:250px; padding: 5px" class="nicerblu">
                <div class="macros">
                    <h3>{$lang.topcategory}</h3>
                    <ul class="filetree treeview" id="browser">
                        {if $category.categories}
                            {foreach from=$category.categories item=cat name=checklast}
                                <li class="closed expandable {if $smarty.foreach.checklast.last}lastExpandable{/if}" id="folder_{$cat.id}">
                                    <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last}lastExpandable-hitarea{/if}"></div>
                                    <a class="folder" href="?cmd=predefinied&action=getcat&cid={$cat.id}">{$cat.name}</a>
                                    <a href="?cmd=predefinied&action=viewcat&cid={$cat.id}" class="edit ">{$lang.Edit}</a> 
                                    <a href="?cmd=predefinied&action=deletecat&cid={$cat.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.removecategoryconfirm}')">{$lang.delete}</a>
                                </li>
                            {/foreach}
                        {/if}
                    </ul>
                </div>
            </div>
            {literal}
                <script type="text/javascript">
                bindPredefinied();
                </script>
            {/literal}
        </div>
        <div style="display: none" class="sectioncontent">
            <div class="nicerblu">
                <ul class="grab-sorter">
                    {if $myreplies}
                        {foreach from=$myreplies item=reply name=loop}
                            <li class="{if $smarty.foreach.loop.index%2==0}even{/if}">
                                <div class="actions">
                                    <input type="hidden" name="order[{$reply.id}]" value="{$reply.sort_order}" class="sort-order"/>
                                    <a href="#" onclick="return false" class="sorter-handler menuitm menuf">{*
                                        *}<span class="movesth" title="move">&nbsp;</span>{*
                                    *}</a>{*
                                    *}<a title="edit" href="?cmd={$cmd}&action=view&id={$reply.id}" class="menuitm menuc">{*
                                        *}<span class="editsth"></span>{*
                                    *}</a>{*
                                    *}<a onclick="return confirm('Are you sure you wish to remove this from your list?');" href="?cmd={$cmd}&action={$action}&make=deletemyreply&reply_id={$reply.id}&security_token={$security_token}" title="delete" class="menuitm menul">{*
                                        *}<span class="delsth"></span>{*
                                    *}</a>    
                                </div>
                                <div class="name">{$reply.name}</div>
                                <div class="lastitm fs11">
                                    {$lang.Affects}:
                                    <span class="fold-text" style="display: inline-block; vertical-align: text-bottom; width: 100px; padding-left: 5px;"><i>
                                    {if $reply.reply}{if $reply.note}{$lang.Note}{else}{$lang.Reply}{/if}{if $reply.tags || $reply.Owner || $reply.priority || $reply.status}, {/if}{/if}
                                    {if $reply.tags}{$lang.tags}{if $reply.Owner || $reply.priority || $reply.status}, {/if}{/if}
                                    {if $reply.owner}{$lang.owner}{if $reply.priority || $reply.status}, {/if}{/if}
                                    {if $reply.priority}{$lang.priority}{if $reply.status}, {/if}{/if}
                                    {if $reply.status}{$lang.Status}{/if}
                                        </i></span><br />
                                    {$lang.Usage}: <b>{$reply.usability}</b>
                                </div>
                            </li>
                        {/foreach}
                    {else}
                        <li><div style="float:none; text-align: center">Your list is currently empty</div></li>
                    {/if}
                </ul>
                <br />
                {if $allreplies}
                    <form method="post" action="">
                        <input type="hidden" name="tab" value="1" />
                        <input type="hidden" name="make" value="addmyreply"/>
                        <div class="p6">
                            <table cellspacing="0" cellpadding="3">
                                <tbody><tr>
                                        <td>
                                            {$lang.addtoyourlist}: 
                                            <select name="reply_id">
                                                {foreach from=$allreplies item=r}
                                                    <option value="{$r.id}">{$r.catname} - {$r.name}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td>
                                            <input type="submit" onclick="" style="font-weight:bold" value="{$lang.Add}">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        {securitytoken}
                    </form>
                {/if}
            </div>
            <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
            {literal}
                <script type="text/javascript">
 
                $('#newshelfnav').TabbedMenu({elem:'.sectioncontent',picker:'.list-1 li',aclass:'active'{/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}});
                $('#newshelfnav').TabbedMenu({elem:'.navsubmenu',picker:'.list-1 li',aclass:'active'{/literal}{if $pickedtab}, picked:'{$pickedtab}'{/if}{literal}});
                
                $(function(){
                    $(".grab-sorter").dragsort({
                        dragSelector: "a.sorter-handler", 
                        dragBetween: false, 
                        itemSelector:'li',
                        placeHolderTemplate: "<li class='placeHolder'></li>",
                        dragEnd: set_sort
                    });
                });
                function set_sort(){
                    var list = $(this).parents(".grab-sorter");
                    var len = list.find('.sort-order').length;
                    list.find('.sort-order').each(function(i){
                        $(this).val(len-i);
                    });
                    ajax_update("{/literal}?cmd={$cmd}&action={$action}&make=sort{literal}&"+list.find('.sort-order').serialize(), {}, false);
                }
                </script>
            {/literal}
        </div>

    {else}

        <div class="blank_state blank_kb">
            <div class="blank_info">
                <h1>{$lang.blank_kb}</h1>
                {$lang.blank_kb_desc}
                <div class="clear"></div>

                <a class="new_add new_menu" href="?cmd=predefinied&action=newcat" style="margin-top:10px">
                    <span>{$lang.addcat}</span></a>
                <div class="clear"></div>

            </div>
        </div>

    {/if}
{/if}