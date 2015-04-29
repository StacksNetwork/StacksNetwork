<link rel="stylesheet" href="{$template_dir}js/codemirror/lib/codemirror.css">
<script src="{$template_dir}js/codemirror/lib/codemirror.js?v={$hb_version}"></script>
<script src="{$template_dir}js/codemirror/lib/util/simple-hint.js?v={$hb_version}"></script>
<link rel="stylesheet" href="{$template_dir}js/codemirror/lib/util/simple-hint.css">
<script src="{$template_dir}js/codemirror/mode/mysql/mysql.js?v={$hb_version}"></script>
<script src="{$template_dir}js/codemirror/lib/util/mysql-hint.js?v={$hb_version}"></script>
<form action="" method="post" id="editform" class="p6" >
    <input type="hidden" name="make" value="save" />
    <table width="100%" cellspacing="0" cellpadding="6" border="0" style="table-layout: fixed">
        <tbody>
            <tr>
                <td width="160" align="right"><strong>Name:</strong></td>
                <td>
                    <input type="text" style="font-size: 16px !important; font-weight: bold;" size="60" value="{$report.name}" class="inp" name="name" />
                </td>
            </tr>
{if $report.handler=='sql'}
            <tr>
                <td width="160" align="right"><strong>Query:</strong></td>
                <td style="background:#fff;font-size:140%;">
                    <textarea name="query" id="query" style="width:98%;height:150px;">{$report.query}</textarea>
                    <small style="font-size:11px"><em>Hint: Use <B>CTRL+space</B> to list HostBill table names or their fields after "." (dot)</em></small>
                </td>
            </tr>
            {/if}
            <tr><td colspan="2"><center><input type="submit" style="font-weight:bold;padding:6px;font-size:13px" value="Save changes" /></center></td></tr>
        </tbody>
    </table>
    {securitytoken}
</form>

{if $report.handler=='sql'}
{literal}

 <script>
     var hb_tables = {/literal}{$tables}{literal};
      CodeMirror.commands.autocomplete = function(cm) {
        CodeMirror.simpleHint(cm, CodeMirror.mysqlHint);
      }
      var editor = CodeMirror.fromTextArea(document.getElementById("query"), {
        lineNumbers: true,
        extraKeys: {"Ctrl-Space": "autocomplete"},
        hb_tables: hb_tables
      });
    </script>
{/literal}
{/if}