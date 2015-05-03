{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.createnewserver}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">

    <form method="post" action="">
        <input type="hidden" value="createmachine" name="createmachine" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
            <tr>
            <tr>
                <td colspan="2">
                    <p style="border:none; padding-left: 15px">
                        Before we can create your server, You will need to provide at least one public key for ssh authentication.<br />
                        You will then be able to use your private key to access this server. Provided keys have to be in OpenSSH format.
                    </p>
                </td>
            </tr>
            <td style="vertical-align: top; width: 180px;">
                <span class="slabel" >SSH Keys</span>
            </td>
            <td>
                <div  style="border:none; padding:0 0 15px ">
                    {foreach from=$sshkeys item=key }
                        <p>
                            <input type="checkbox" value="{$key.id}" name="CreateVM[sshkeys][]" /> {$key.name} 
                        </p>
                    {foreachelse}
                        <textarea name="sshkey[]" style="width: 90%; height: 2em"></textarea>
                    {/foreach}
                    <div id="pubkeys">
                    </div>
                    <a href="#" class="btn btn-success" onclick="$('<textarea name=\'sshkey[]\' style=\'width: 90%; height: 2em\'></textarea>').appendTo('#pubkeys');
                            return false;">
                        <i class="icon-plus icon-white"></i> New Key
                    </a>
                </div>
                <br />

                <br />
            </td>
            </tr>
            <tr>
                <td style="border:none; padding-left: 15px" colspan="2">
                    <input type="submit" value="Setup my server" style="font-weight:bold" class="btn btn-primary" />
                </td>
            </tr>
        </table>
        {securitytoken}
    </form>
</div>
{literal}
    <script type="text/javascript">
                        function addSSHForm() {

                        }
    </script>
{/literal}
{include file="`$onappdir`footer.cloud.tpl"}