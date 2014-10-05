<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td>
            <h3>{$lang.securitysettings}</h3>
        </td><td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration"  class="tstyled">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled">{$lang.cronprofiles}</a>
            <a href="?cmd=security"  class="tstyled selected">{$lang.securitysettings}</a>
            <a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a>
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="background:#F5F9FF">
                <form action="" method="post" >
                    <input type="hidden" name="make" value="saveacl" />
                    <div class="sectioncontent" style="padding:10px;">
                        <table>
                            <tr>
                                <td colspan="4" class="sectionhead_ext open">
		Allowed functions for API ID: {$api.api_id}
                                </td>
                            </tr>
                            <tr id="privileges" >
                                <td valign="top" class="sectionbody" colspan="4">
                                    <fieldset>
                                        <legend><label><input type="checkbox" onclick="$('.checker').attr('checked',$(this).is(':checked'))"/>Enable all</label></legend>
                                        {foreach from=$methods item=method key=name}
                                        <label><input type="checkbox" name="methods[{$name}]" value="{$name}"  class="checker" {if $api.acl.$name}checked="checked"{/if}/> <a href="http://api.hostbillapp.com/{$method.APIgroup}/{$name}/" target="_blank">{$name}</a></label>

                                        {/foreach}
                                    </fieldset>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="4"></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <input type="submit" style="font-weight:bold" value="{$lang.savechanges}" class="submitme"/> <span class="orspace">{$lang.Or} <a href="?cmd=security" class="editbtn">{$lang.Cancel}</a></span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </td>
    </tr>
</table>