<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td colspan="2"><h3>OrderPages A/B Testing</h3></td>
        </tr>
        <tr>
            <td rowspan="2" style="line-height:20px;" class="leftNav">
                <a class="tstyled" href="?cmd=abtesting">Back to all tests</a></td>
            <td  valign="top"  class="bordered" ><div id="bodycont"><form action="" method="post"><input type="hidden" name="make" value="save" />
                        <div class="nicerblu">
                            <table width="100%" cellspacing="0" cellpadding="6" border="0">
                                <tbody>
                                    <tr>
                                        <td width="160" align="right"><strong>Category:</strong><a class="vtip_description" title="Select category you wish to create A/B test for"></a></td>
                                        <td width="400">
                                            <select style="font-weight:bold;" onchange="catchange($(this).val());" class="inp" name="category_id" id="category_id">
                                                {foreach from=$categories item=category}
                                                <option value="{$category.id}" {if $category.id==$test.category_id}selected="selected"{/if}>{$category.name}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td width="160" align="right" >Original Page URL: <a class="vtip_description" title="Paste this in Google Analytics->Original Page URL"></a></td>
                                        <td colspan="2">
                                            <input type="text" style="width:400px" class="inp styled" value="" id="original_url"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="160" align="right" >Variation URL:  <a class="vtip_description" title="Paste this in Google Analytics->Variation URL"></a></td>
                                        <td colspan="2">
                                            <input type="text" style="width:400px" class="inp styled" value="" id="variation_url" /></td>
                                    </tr>
                                    <tr>
                                        <td width="160" align="right"><strong>Variation template:</strong><a class="vtip_description" title="Select other orderpage template your clients will see when redirected by google to Variation URL"></a></td>
                                        <td width="400">
                                             <select style="font-weight:bold;" onchange="" class="inp" name="orderpage">
                                                {foreach from=$templates key=templ item=t name=lop}
                                                    <option value="{$templ}" {if $test.orderpage==$templ}selected="selected"{/if}>
                                                            {if $t.name}{$t.name}
                                                            {elseif $lang.$templ}{$lang.$templ}
                                                            {else}{$templ}
                                                            {/if}
                                                        </option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td width="160" align="right" valign="top"><strong>Google experiment code:</strong><a class="vtip_description" title="Copy experiment code from step 3 of google analytics experiment wizard and paste it here"></a></td>
                                        <td width="400" valign="top">
                                            <textarea name="code" style="width:400px;height:100px">{$test.code}</textarea>
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                            <p align="center">
                                <input type="submit" class="submitme" value="Save Changes">
                            </p>

                        </div>{securitytoken}</form>
                </div>

            </td>
        </tr>
</table>
<script>
    var tid = '{$test.id}';
    var url ='{$system_url}{$ca_url}cart/';
    var slugs=[];
    {foreach from=$categories item=category}
    slugs[{$category.id}]='{$category.slug}';
    {/foreach}
{literal}
    function catchange(cat) {
        var u = url + slugs[cat] + '/';
        $('#original_url').val(u);
        $('#variation_url').val(u + '&e='+tid);
    }
    $(document).ready(function(){
        catchange($('#category_id').val());
    });
</script>
{/literal}