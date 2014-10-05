<link rel="stylesheet" href="{$template_dir}js/codemirror/lib/codemirror.css">
<script src="{$template_dir}js/codemirror/lib/codemirror.js"></script>
<script src="{$template_dir}js/codemirror/lib/util/simple-hint.js"></script>
<link rel="stylesheet" href="{$template_dir}js/codemirror/lib/util/simple-hint.css">
<script src="{$template_dir}js/codemirror/mode/mysql/mysql.js"></script>
<script src="{$template_dir}js/codemirror/lib/util/mysql-hint.js"></script>
<form action="" method="post" id="editform" class="p6" >
    <input type="hidden" name="make" value="save" />
    <table width="100%" cellspacing="0" cellpadding="6" border="0">
        <tbody>
            <tr>
                <td width="160" align="right"><strong>名称:</strong></td>
                <td>
                    <input type="text" style="font-size: 16px !important; font-weight: bold;" size="60" value="{$report.name}" class="inp" name="name" />
                </td>
            </tr>
{if $report.handler=='sql'}
            <tr>
                <td width="160" align="right"><strong>查询:</strong></td>
                <td style="background:#fff;font-size:140%;">
                    <textarea name="query" id="query" style="width:98%;height:150px;">{$report.query}</textarea>
                    <small style="font-size:11px"><em>提示: 使用 <B>[CTRL]+[Space]</B> 列出系统表名称或"."(点)后的相关字段</em></small>
                </td>
            </tr>
            {/if}
            <tr><td colspan="2"><center><input type="submit" style="font-weight:bold;padding:6px;font-size:13px" value="保存更改" /></center></td></tr>
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