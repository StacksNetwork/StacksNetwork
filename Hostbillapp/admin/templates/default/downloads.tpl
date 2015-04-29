<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td ><h3>{$lang.Downloads}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=downloads"  class="tstyled selected">{$lang.Downloads}</a>
        </td>
        <td valign="top"  class="bordered"><div id="bodycont" style="">

                {if $action=='addcategory'}
                    <form action="" method="post">
                        <input type="hidden" name="make" value="add" />
                        <div class="lighterblue" style="padding:5px">
                            <table cellpadding="0" cellspacing="6" width="600">
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                                    <td>
                                        {hbinput value="" style="" size="80" name="name" class="inp"}
                                    </td>
                                </tr>
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Visible}</strong></td>
                                    <td><input  name="visible" value="1" type="checkbox" checked="checked"/></td>
                                </tr>
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Description}</strong></td>
                                    <td>
                                        {hbwysiwyg value=$submit.description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" name="description"}
                                    </td>
                                </tr>

                            </table></div>

                        <div class="blu">
                            <input type="submit" value="{$lang.addnewcat}" style="font-weight:bold"/> 
                        </div>
                        {securitytoken}</form>

                {elseif $action=='category'}
                    <form action="" method="post">
                        <input type="hidden" name="make" value="update" />
                        <div class="lighterblue" style="padding:5px">
                            <table cellpadding="0" cellspacing="6" width="600">
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                                    <td>
                                        {hbinput value=$category.name style="" size="80" name="name" class="inp"}
                                    </td>
                                </tr>
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Visible}</strong></td>
                                    <td><input  name="visible" value="1" type="checkbox" {if $category.visible}checked="checked"{/if}/></td>
                                </tr>
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Description}</strong></td>
                                    <td>
                                        {hbwysiwyg value=$category.description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" name="description"}
                                    </td>
                                </tr>

                            </table></div>

                        <div class="blu">
                            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold"/> 
                        </div>
                        {securitytoken}</form>
                    {elseif $action=='add'}

                    <form action="" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="make" value="add" />
                        <div class="lighterblue" style="padding:5px">
                            <table cellpadding="0" cellspacing="6" width="600">
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                                    <td>
                                        {hbinput value=$submit.name style="" size="80" name="name" class="inp"}
                                    </td>
                                </tr>

                                <script type="text/javascript">
                                    {literal}
                                        function vala(ele) {
                                            if ($(ele).val() == 'true') {
                                                $('#uploader').show();
                                                $('#pathx').hide();
                                            } else {
                                                $('#pathx').show();
                                                $('#uploader').hide();
                                            }
                                        }
                                    {/literal}
                                </script>


                                <tr>
                                    <td width="160" align="right"  valign="top"><strong>{$lang.file}</strong></td>
                                    <td valign="top">
                                        <input type="radio" name="upload" value="true" onclick="vala(this)" checked="checked"/> {$lang.uploadnew} 
                                        <input type="radio" name="upload" value="false"  onclick="vala(this)"/> {$lang.specifyfile}

                                        <div id="uploader" style="margin-top:10px;">
                                            {if !$writeable}
                                                <span style="color:red;font-weight:bold;">{$lang.notwrite}</span>
                                            {/if}
                                            <input type="file" name="file" />
                                        </div>

                                        <div id="pathx" style="margin-top:10px;display:none;">
                                            {$lang.filename}:<input name="path" size="80"/>
                                        </div>
                                    </td>
                                </tr>	

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Category}</strong></td>
                                    <td><select class="inp" name="category_id">{foreach from=$categories item=category}<option value="{$category.id}" {if $category.id==$submit.category_id}selected="selected"{/if}>{$category.name}</option>{/foreach}</select></td>
                                </tr>	



                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Description}</strong></td>
                                    <td>
                                        {hbwysiwyg value=$submit.description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" name="description"}
                                    </td>
                                </tr>

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.clientsonly}</strong></td>
                                    <td><input type="checkbox" name="clients" value="1" {if $file.clients=='1'}checked="checked"{/if}/></td>
                                </tr>

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.hasproduct}</strong></td>
                                    <td><input type="checkbox" onclick="check_i(this)" /> <select name="product_id" disabled="disabled"  class="config_val">

                                            {foreach from=$products item=category}
                                                {if $category.products}
                                                    {foreach from=$category.products item=product}
                                                        <option value="{$product.id}" {if $file.product_id==$product.id}selected="selected"{/if}>{$category.name}: {$product.name}</option>
                                                    {/foreach}
                                                {/if}
                                            {/foreach}

                                        </select></td>
                                </tr>

                            </table>
                        </div>
                        <div class="blu">
                            <input type="submit" value="{$lang.addnewfile}" style="font-weight:bold"/> 
                        </div>
                        {securitytoken}</form>
                    {elseif $action=='edit'}
                    <form method="post" action="">
                        <input type="hidden" name="make" value="update" />
                        <div class="lighterblue" style="padding:5px" width="600">

                            <table cellpadding="0" cellspacing="6">
                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Name}</strong></td>
                                    <td>
                                        {hbinput value=$file.name style="" size="80" name="name" class="inp"}
                                    </td>
                                </tr>

                                <tr>
                                    <td></td>
                                    <td><a href="?cmd=root&action=download&type=downloads&id={$file.id}">{$lang.download}</a> <em>({$file.downloads} {$lang.timesdown})</em></td>
                                </tr>

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.filename}</strong></td>
                                    <td><input class="inp" name="filename" value="{$file.filename}" size="80"/></td>
                                </tr>


                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Category}</strong></td>
                                    <td><select class="inp" name="category_id">{foreach from=$categories item=category}<option value="{$category.id}" {if $category.id==$file.category_id}selected="selected"{/if}>{$category.name}</option>{/foreach}</select></td>
                                </tr>	

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Uploaded}</strong></td>
                                    <td><input name="uploaded" value="{$file.uploaded|dateformat:$date_format}" class="inp haspicker" size="12"/></td>
                                </tr>

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.Description}</strong></td>
                                    <td>
                                        {hbwysiwyg value=$file.description style="width:700px;" class="inp wysiw_editor" cols="100" rows="6" name="description"}
                                    </td>
                                </tr>

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.clientsonly}</strong></td>
                                    <td><input type="checkbox" name="clients" value="1" {if $file.rel_type=='1'}checked="checked"{/if}/></td>
                                </tr>

                                <tr>
                                    <td width="160" align="right"><strong>{$lang.hasproduct}</strong></td>
                                    <td><input type="checkbox" onclick="check_i(this)" {if $file.product_id!='0'}checked="checked"{/if}/> <select name="product_id" {if $file.product_id=='0'}disabled="disabled"{/if} class="config_val">
                                            {foreach from=$products item=category}
                                                {if $category.products}
                                                    {foreach from=$category.products item=product}
                                                        <option value="{$product.id}" {if $file.product_id==$product.id}selected="selected"{/if}>{$category.name}: {$product.name}</option>
                                                    {/foreach}
                                                {/if}
                                            {/foreach}

                                        </select>
                                    </td>
                                </tr>

                            </table>
                        </div>

                        <div class="blu">
                            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold"/> 
                        </div>
                        {securitytoken}</form>	
                    {else}
                    <div class="blu">
                        <input type="button" href="?cmd=downloads&action=add" class="linkDirectly" value="{$lang.addnewfile}">
                        <input type="button" href="?cmd=downloads&action=addcategory" class="linkDirectly" value="{$lang.addnewcat}">
                    </div>

                    <table class="glike" width="100%" cellspacing="0" cellpadding="3" border="0">
                        {if $categories}
                            <tr>
                                <th width="70%">Name</th>
                                <th>Downloaded</th>
                                <th></th>
                                <th></th><th></th>
                            </tr>

                            {foreach from=$categories item=cat}

                                <tr>
                                    <td colspan="5">
                                        <table  width="100%" cellspacing="0" cellpadding="3" border="0" class="gnoborder">
                                            <tr>
                                                <td width="70%"><strong>{$lang.Category}: {if !$cat.id}Single client files{else}<a href="?cmd=downloads&action=category&id={$cat.id}">{$cat.name}</a>{/if}</strong></td>
                                                <td></td>

                                                <td></td>
                                                <td  width="20">{if $cat.id}<a href="?cmd=downloads&action=category&id={$cat.id}" class="editbtn">{$lang.Edit}</a>{/if}</td>
                                                <td  width="20">{if $cat.id}<a href="?cmd=downloads&make=deletecat&id={$cat.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.dconfirm2}')">{$lang.delete}</a>{/if}</td>
                                            </tr>	
                                            {foreach from=$cat.files item=file}
                                                <tr class="product">
                                                    <td>{if $cat.id}<a href="?cmd=downloads&action=edit&id={$file.id}">{$file.name}</a>{else}{$file.name}{/if}</td>
                                                    <td>{$file.downloads}</td>
                                                    <td  width="20"><a href="?cmd=root&action=download&type=downloads&id={$file.id}" class="dwbtn">{$lang.download}</a></td>
                                                    <td  width="20">{if $cat.id}<a href="?cmd=downloads&action=edir&id={$file.id}" class="editbtn" >{$lang.Edit}</a>{/if}</td>
                                                    <td width="20"><a href="?cmd=downloads&make=delete&id={$file.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.dconfirm1}')">{$lang.delete}</a></td>
                                                </tr>

                                            {/foreach}	
                                        </table>

                                    </td>

                                </tr>
                            {/foreach}

                        {else}
                            <tr>
                                <td align="center" colspan="5" align="center"><strong>{$lang.nothingtodisplay}</strong></td>
                            </tr>
                        {/if}

                    </table>
                {/if}  


            </div></td></tr></table>{literal}
<script type="text/javascript">
    function check_i(element) {
        var td = $(element).parent();
        if ($(element).is(':checked'))
            $(td).find('.config_val').removeAttr('disabled');
        else
            $(td).find('.config_val').attr('disabled', 'disabled');
    }

</script>
{/literal}