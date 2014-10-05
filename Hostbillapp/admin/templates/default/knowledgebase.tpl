<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
{literal}
    <style>
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
        ul.grab-sorter li div.lastitm, ul.grab-sorter li div.lastitm-art{
            width:150px;
            float:right;
            min-height: 28px;
            padding: 3px 5px;
            background:#F0F0F3;
            color:#767679;
        }
        ul.grab-sorter li div.lastitm-art{
            width:50%;
        }
        ul.grab-sorter li div.actions{
            height: 15px;
        }
        ul.grab-sorter li:hover div.lastitm, ul.grab-sorter li:hover{
            background: #FFFED1;
        }
        ul.grab-sorter li.placeHolder{
            height:35px;
            border:dashed 1px #999
        }
        .actions label{
            display:block
        }
        .actions a.menuitm .addsth{
            background-position: center center;
            padding: 0 7px;
        }
    </style>
{/literal}
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.Knowledgebase}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=knowledgebase"  class="tstyled {if $action == 'default'}selected{/if}">{$lang.listcats}</a>
            <br /><br />
            <a href="?cmd=knowledgebase&action=addcategory"  class="tstyled {if $action=='addcategory'}selected{/if}">{$lang.addcat}</a>
            <a href="?cmd=knowledgebase&action=addarticle"  class="tstyled {if $action=='addarticle'}selected{/if}">{$lang.addarticle}</a>

        </td>
        <td  valign="top"  class="bordered"><div id="bodycont" style="">
                {if $action=='article' || $action=='addarticle' || $action=='category' || $action=='addcategory'}
                    <div class="blu"> 
                        <a href="?cmd={$cmd}"> <strong>{$lang.Knowledgebase}</strong> </a>
                        {if $action=='addcategory'}
                            &raquo; <strong>{$lang.addnewcat}</strong>
                        {/if}
                        {if $action=='addarticle'}
                            &raquo; <strong>{$lang.addnewarticle}</strong>
                        {/if}
                        {if $action=='article'}
                            &raquo; <strong>{$lang.Edit} {$lang.kbarticle}</strong>
                        {/if}
                        {if $action=='category'}
                            &raquo; <strong>{$lang.Edit} {$lang.Category}</strong>
                        {/if}
                    </div>
                {/if}
                {if $action=='addarticle' || $action=='article'}
                    <form method="post" action="" id="articleform">
                        {if $categories}
                            <div class="lighterblue" style="padding: 10px;" >
                                <input type="hidden" name="make" value="{if $action=='article'}article{else}addarticle{/if}" />
                                <table cellpadding="1" width="800">
                                    <tr>
                                        <td>{$lang.Category}:</td>
                                        <td>    
                                            <select name="cat_id" id="catpicker" class="inp">
                                                {foreach from=$categories item=cat}
                                                    <option value="{$cat.id}" {if $reply.cat_id==$cat.id}selected="selected" {/if}>{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>{$lang.registeredonly}</td>
                                        <td>    
                                            <input type="checkbox" value="1" name="registered" {if $reply.registered=='1'}checked="checked"{/if} />
                                        </td>
                                    </tr>
                                    {foreach from=$langs item=lgname key=lgid name="loop"}
                                        <tr class="langid{$lgid}" {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                                            <td>
                                                {$lang.Title}:<br />
                                                <small>({$lgname|capitalize})</small>
                                            </td>
                                            <td>    
                                                {hbinput value=$reply.tag_title.$lgid style="" size="75" name="title[`$lgid`]" class="inp"}
                                            </td>
                                        </tr>
                                        <tr class="langtext{$lgid}" {if !$smarty.foreach.loop.first}style="display:none"{/if}>
                                            <td></td>
                                            <td>
                                                <input type="hidden" name="mode[{$lgid}]" value="{if $reply.mode.$lgid}{$reply.mode.$lgid}{else}0{/if}" />
                                                {hbwysiwyg value=$reply.tag_body.$lgid style="width:700px;" 
                                                class="inp wysiw_editor" cols="100" rows="6" 
                                                name="body[`$lgid`]" featureset="full"
                                                additionaltabs=$language_tabs editortag="HTML"
                                                onclickplain="set_art_mode(this,0);" 
                                                onclickeditor="set_art_mode(this,1);"
                                                }
                                            </td>
                                        </tr>
                                    {/foreach}
                                </table>
                            </div>
                            {literal}
                                <script type="text/javascript">
                                    if (HBInputTranslate.tinyMCEFull.plugins.split(',').indexOf('autoresize') == -1)
                                        HBInputTranslate.tinyMCEFull.plugins += ",autoresize";
                                    function set_art_mode(that, mode) {
                                        $(that).parents('td').eq(0).children('input').val(mode);
                                    }
                                    $('textarea.wysiw_editor').elastic();
                                    $('.tabs_wysiw li').click(function() {
                                        if ($(this).index() < 2) {
                                            var el = $(this).nextAll('.additional').eq($(this).parents('tr[class^="langtext"]').prevAll('tr[class^="langtext"]').length + 1);
                                            el.addClass('active');
                                            if ($(this).parent().index() == 1)
                                                el.find('a').css('background', '#F0F0EE');
                                            else
                                                el.find('a').css('background', '')
                                        } else {
                                            if ($(this).find('select').length) {
                                                return true;
                                            }
                                            var el = $('tr[class^="lang"]').hide(),
                                                index = $(this).prevAll('.additional').length - 1;
                                            $('tr[class^="langid"]').eq(index).show();
                                            $('tr[class^="langtext"]').eq(index).show();
                                            el.find(".tabs_wysiw li.active:first").click();
                                            $('.tabs_wysiw li select').val(index + 1);

                                            if ($("input[name^='mode[']").eq(index).val() == 1)
                                                $('.tabs_wysiw:eq(' + index + ') li:eq(1) a').click();
                                        }
                                    });
                                    $('tr[class^="lang"]').find(".tabs_wysiw li.active:first").click();
                                    function art_preview(e) {
                                        e.preventDefault();
                                        $('#previewlang').val($('input[name^=title]:visible:first').attr('name').replace(/^title\[(.+)\]$/, '$1'));
                                        $('#articleform').attr('target', '_blank').attr('action', '../?cmd=knowledgebase&action=preview').submit();
                                        $('#articleform').removeAttr('target').attr('action', '');
                                    }
                                    if ($("input[name^='mode[']:first").val() == 1)
                                        $('.tabs_wysiw li:eq(1) a').click();
                                </script>
                            {/literal}
                            <div class="blu">
                                <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                                <input type="submit" value="{if $action=='article'}{$lang.savechanges}{else}{$lang.addarticle}{/if}" style="font-weight:bold" />
                                <input type="submit" value="{$lang.preview|capitalize}" name="preview" onclick="art_preview(event);" />
                                <input type="hidden" value="1" name="lang" id="previewlang" />
                                <input type="submit" name="cancel" value="{$lang.Cancel}"  />
                            </div>
                            {securitytoken}
                        </form>
                    {else}
                        <div class="blu">
                            {$lang.thereisnocats} - <a href="?cmd=knowledgebase&action=addcategory">{$lang.addnewcat}</a> {$lang.tostart}.
                            <br />
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                        </div>
                    {/if}

                {elseif $action=='article'}
                    <form method="post" action="">
                        <div class="lighterblue" style="padding: 10px;">
                            <input type="hidden" name="make" value="article" />
                            <table cellpadding="1" width="800">
                                <tr>
                                    <td>{$lang.Category}:</td>
                                    <td>    
                                        <select name="cat_id" id="catpicker" class="inp">
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.cat_id==$cat.id}selected="selected" {/if}>{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>{$lang.registeredonly}</td>
                                    <td>    
                                        <input type="checkbox" value="1" name="registered" {if $reply.registered=='1'}checked="checked"{/if} />
                                    </td>
                                </tr>
                                <tr>
                                    <td>{$lang.Title}:</td>
                                    <td>    
                                        {hbinput value=$reply.tag_title style="" size="75" name="title" class="inp"}
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>    
                                        {hbwysiwyg value=$reply.tag_body style="width:700px;" 
                                        class="inp wysiw_editor" cols="100" rows="6" 
                                        id="prod_content" name="body" featureset="full"}
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" />
                            <input type="submit" name="{$lang.cancel}" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>
                {elseif $action=='addcategory'}
                    <form method="post" action="">
                        <div class="lighterblue" style="padding: 10px;">
                            <input type="hidden" name="make" value="addcategory" />
                            <table width="800">
                                <tr>
                                    <td>{$lang.parentcat}:</td>
                                    <td>
                                        <select name="parent_cat" id="catpicker" class="inp">
                                            <option value="0" {if $reply.parent_cat==0}selected="selected" {/if}>{$lang.topcategory}</option>
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.parent_cat==$cat.id}selected="selected" {/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr><td>{$lang.Name}:</td><td>{hbinput value=$reply.name style="" size="75" name="name" class="inp"}</td></tr>
                                <tr><td style="vertical-align: top">{$lang.Description}:</td><td>
                                        {hbwysiwyg value=$reply.description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="prod_content" name="description" featureset="full"}
                                </tr>
                            </table>
                        </div>
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input type="submit" value="{$lang.addcat}" style="font-weight:bold" />
                            <input type="submit" name="cancel" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>

                {elseif $action=='category'}
                    <form method="post" action="">
                        <div class="lighterblue" style="padding: 10px;">
                            <input type="hidden" name="make" value="category" />
                            <table width="800">
                                <tr><td>{$lang.parentcat}:</td><td>
                                        <select name="parent_cat" id="catpicker" class="inp">
                                            <option value="0" {if $reply.parent_cat==0}selected="selected" {/if}>{$lang.topcategory}</option>
                                            {foreach from=$categories item=cat}
                                                <option value="{$cat.id}" {if $reply.parent_cat==$cat.id}selected="selected" {/if}>&mdash;{section loop=$cat.depth name=sect}&mdash;{/section} {$cat.name}</option>
                                            {/foreach}
                                        </select>
                                    </td></tr>
                                <tr><td>{$lang.Name}:</td><td>{hbinput value=$reply.tag_name style="" size="75" name="name" class="inp"}</td></tr>
                                <tr><td style="vertical-align: top">{$lang.Description}:</td><td>
                                        {hbwysiwyg value=$reply.tag_description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" id="prod_content" name="description" featureset="full"}
                                </tr>
                            </table>
                        </div>
                        <div class="blu">
                            <a href="?cmd=knowledgebase"  class="tload2"><strong>&laquo; {$lang.backtocats}</strong></a>
                            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" />
                            <input type="submit" name="cancel" value="{$lang.Cancel}"  />
                        </div>
                        {securitytoken}
                    </form>

                {else}
                    {if !$categories.categories && !$categories.parent_cat}
                        <div class="blank_state blank_kb">
                            <div class="blank_info">
                                <h1>{$lang.blank_kb}</h1>
                                {$lang.blank_kb_desc}
                                <div class="clear"></div>
                                <a class="new_add new_menu" href="?cmd=knowledgebase&action=addcategory" style="margin-top:10px">
                                    <span>{$lang.addnewcat}</span></a>
                                <div class="clear"></div>
                            </div>
                        </div>
                    {else}
                        <div class="newhorizontalnav" id="newshelfnav">
                            <div class="list-1">
                                <ul>
                                    <li class="active last">
                                        <a href="#">{$lang.listcats}</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="list-2">
                                <div class="navsubmenu haveitems">
                                    <ul>
                                        <li class="list-2elem"><a href="?cmd={$cmd}&action=addcategory" ><span>{$lang.addnewcat}</span></a></li>
                                        <li class="list-2elem"><a href="?cmd={$cmd}&action=addarticle" ><span>{$lang.addnewarticle}</span></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>   

                        <div class="nicerblu">
                            <div id="kbtree">
                                {include file="ajax.knowledgebase.tpl"}
                            </div>
                        </div>
                    {/if}
                    {literal}
                        <script type="text/javascript">
                            function set_sort() {
                                var list = $(this).parents(".grab-sorter");
                                var len = list.find('.sort-order').length;
                                list.find('.sort-order').each(function(i) {
                                    $(this).val(len - i);
                                });
                                
                                $.post("{/literal}?cmd={$cmd}&action=sort{literal}" , list.find('.sort-order').serializeObject());
                            }
                            $('#kbtree').on('click', '.loadsubact', function(e) {
                                e.preventDefault();
                                $('#kbtree').addLoader();
                                $.get($(this).attr('href'), function(data) {
                                    data = parse_response(data);
                                    $('#kbtree').html(data);
                                })
                            })
                        </script>
                    {/literal}
                {/if}
            </div>
        </td>
    </tr>
</table>
