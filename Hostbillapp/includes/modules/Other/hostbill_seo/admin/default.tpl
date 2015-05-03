<form action="" method="post">
    <div class="lighterblue" style="padding: 10px">
        <div style="padding: 10px">
            <strong>Note:</strong> You need to edit your <strong>header.tpl</strong> file in <strong>/templates</strong> and remove default element for changes to make effect.
            <br />Get more info at <a href="http://hostbillapp.com/features/apps/seo-plugin.html">http://hostbillapp.com/features/apps/seo-plugin.html</a>.
        </div>
        <div style="padding: 10px">
            <input style="font-weight: bold;" type="submit" name="savecharges" value="Save Changes" />
        </div>
    </div>
    <input type="hidden" value="{$currentpage}" name="currentpage" />
    <script type="text/javascript">{literal}
        function switchPage(pag, elem) {
            $('input[name=currentpage]').val(pag);
            $('.page_shown').hide().removeClass('page_shown');
            $('#page_'+pag).show().addClass('page_shown');
            $('.picked').removeClass('picked');
            $(elem).addClass('picked');
        }
        {/literal}</script>
    <div id="newshelf">
        {foreach from=$availpages item=apg}
        <a href="" onclick="switchPage('{$apg}', this); return false;" class="tchoice {if $currentpage == $apg}picked{/if}">{if $apg == 'root'}Main Page{else}{$apg|capitalize}{/if}</a>
        {/foreach}
    </div>
    {foreach from=$availpages item=apg}
    <div id="page_{$apg}" class='nicerblu {if $currentpage == $apg}page_shown'{else}' style="display:none"{/if}>
        <div style="padding: 10px 20px;"><h3>{if $apg == 'root'}Main Page{else}{$apg|capitalize}{/if}</h3></div>
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
            <tbody>
                <tr>
                    <td width="150" valign="top" style="padding: 20px; font-weight:bold; text-align: right;">SEO Title</td>
                    <td style="padding: 20px;"><input type="text" size="100" value="{$seoconfig.$apg.title}" name="seoconfig[{$apg}][title]" />
                        <br /><small>Title is limited to <font style="color: red">70</font> characters.</small></td>
                </tr>
                <tr>
                    <td valign="top" style="padding: 20px;font-weight:bold; text-align: right;">Description</td>
                    <td style="padding: 20px;""><textarea rows="4" cols="100" name="seoconfig[{$apg}][description]">{$seoconfig.$apg.description}</textarea>
                        <br /><small>Description of the page is limited to the <font style="color: red">155</font> characters.</small></td>
                </tr>
                <tr>
                    <td valign="top" style="padding: 20px;font-weight:bold; text-align: right;">Keywords</td>
                    <td style="padding: 20px;"><textarea rows="4" cols="100" name="seoconfig[{$apg}][keywords]">{$seoconfig.$apg.keywords}</textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    {/foreach}
    <div class="lighterblue" style="padding: 10px">
        <div style="padding: 10px">
            <input style="font-weight: bold;" type="submit" name="savecharges" value="Save Changes" />
        </div>
    </div>
</form>