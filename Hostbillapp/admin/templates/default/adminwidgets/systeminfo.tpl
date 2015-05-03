{if $self_check}
<div class="bborder">
    <div class="bborder_header">
        {$lang.systeminfo}
    </div>
    <div class="bborder_content">
        <table class="whitetable fs11 statustables" width="100%" cellspacing="0" cellpadding="3">
            <tr class="odd">
                <td width="12%" align="right">PHP</td>
                <td width="12%">{if $self_check.php.ok}<b>{$self_check.php.version}</b>{else}<b class="err vtip_description" title="Error: HostBill requires PHP 5.3+, with lower versions it may not work stable.">{$self_check.php.version}</b>{/if}</td>
                <td width="12%" align="right">MySQL</td>
                <td width="12%">{if $self_check.mysql.ok}<b>{$self_check.mysql.version}</b>{else}<b class="err vtip_description" title="Error: HostBill requires MySQL 5+, with lower versions it wont work stable.">{$self_check.mysql.version}</b>{/if}</td>
                <td width="12%" align="right">PDO</td>
                <td width="12%">{if !$self_check.pdo}<b>Enabled</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is compiled without PDO extension, to make sure all modules work add pdo+pdo_mysql to your php">Disabled</b>{/if}</td>
                <td width="12%" align="right">PDO_MySQL</td>
                <td>{if !$self_check.pdo_mysql}<b>Enabled</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is compiled without PDO_MySQL extension, to make sure all modules work add pdo+pdo_mysql to your php">Disabled</b>{/if}</td>
            </tr>
            <tr class="even">
                <td  align="right">cURL installed</td>
                <td >{if !$self_check.curl}<b>Yes</b>{else}<b class="err vtip_description" title="ERROR: Your PHP missing cURL extension - HostBill will not work stable!">Disabled</b>{/if}</td>
                <td  align="right">cURL enabled</td>
                <td >{if !$self_check.curl_disabled}<b>Yes</b>{else}<b class="err vtip_description" title="ERROR: cURL is in php.ini disable_functions - HostBill will not work stable!">Disabled</b>{/if}</td>
                <td align="right">JSON</td>
                <td>{if !$self_check.json}<b>Enabled</b>{else}<b class="err vtip_description" title="ERROR: Your PHP is missing JSON support, many modules will not work.">Disabled</b>{/if}</td>
                <td align="right">SimpleXML</td>
                <td>{if !$self_check.simplexml}<b>Enabled</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is missing JSON support, many modules will not work.">Disabled</b>{/if}</td>
            </tr>

            <tr class="odd">
                <td  align="right">Memory Limit</td>
                <td >{if $self_check.memory_limit.ok}<b>{$self_check.memory_limit.limit}</b>{else}<b class="err vtip_description" title="Error: Your PHP memory_limit is too low - PDF invoice generation may fail. HostBill require at leasts 32M">{$self_check.memory_limit.limit}</b>{/if}</td>
                <td  align="right">Magic Quotes</td>
                <td >{if !$self_check.magic_quotes}<b>Disabled</b>{else}<b class="warn vtip_description" title="Warning: Your PHP have magic_quotes_gpc enabled in php.ini. It may slow down HostBill performance.">Enabled</b>{/if}</td>
                <td align="right">SPL</td>
                <td>{if !$self_check.spl}<b>Enabled</b>{else}<b class="err vtip_description" title="ERROR: Your PHP is missing SPL extension - many functions will not work!.">Disabled</b>{/if}</td>
                <td align="right">IMAP</td>
                <td>{if !$self_check.imap}{if !$self_check.imap_ssl}<b>Enabled</b>{else}<b class="warn vtip_description" title="Warning: Your PHP IMAP extension is missing SSL support, importing tickets using POP method over ssl will fail.">No ssl support</b>{/if}{else}<b class="warn vtip_description" title="Warning: Your PHP is missing IMAP extension, importing tickets using POP method will fail.">Disabled</b>{/if}</td>
            </tr>
            <tr class="even">

                <td align="right">PHP MBstring</td>
                <td>{if !$self_check.mbstring}<b>Yes</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is missing mbstring extension - PDF invoice customization wont work.">No</b>{/if}</td>

                <td align="right">DOM support</td>
                <td>{if !$self_check.dom}<b>Yes</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is missing DOM extension - PDF invoices may not work.">No</b>{/if}</td>
                <td  align="right">GD installed</td>
                <td >{if !$self_check.gd}<b>Yes</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is missing GD extension - PDF invoices will not show images.">No</b>{/if}</td>
                <td  align="right">GD GIF</td>
                <td >{if !$self_check.gdgif}<b>Yes</b>{else}<b class="warn vtip_description" title="Warning: Your PHP is missing GD extension - PDF invoices will not show images">No</b>{/if}</td>

            </tr>
            <tr class="odd">
                <td width="12%" align="right">Main HB dir</td>
                <td width="12%">{$hb_maindir}</td>
                <td colspan="6"></td>
            </tr>
        </table>
    </div>
    <div style="text-align:right; margin:0 4px 4px"><a target="_blank" class="fs11  external
                                                       " href="?action=phpinfo">更多详情</a></div>
</div>
<script type="text/javascript">
    {literal}
    function fn123() {
        $("b.vtip_description").vTip();
    }
    appendLoader('fn123');
    {/literal}
</script>
{/if}