<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>CSV导入</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a class="tstyled selected" href="?cmd=csv">导入客户</a>
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont">
                <form  method="post" action="?cmd=csv&action=import" enctype="multipart/form-data" id="csvform">
                    <div class="blank_state blank_news">
                        <div class="blank_info">
                            <h1>从CSV文件导入客户</h1>
                            <div class="clear"></div>
                            <a class="new_add new_menu" href="#" style="margin-top:10px" onclick="$(this).next().show(); $(this).hide(); return false;">
                                <span>上传文件进行导入</span>
                            </a>
                            <div style="display: none; margin-top:10px" class="left">
                                <input type="file" name="csvfile"  style="margin-top: 3px;"/>
                                <a class="new_add new_menu" href="#" onclick="$('#csvform').submit();" >
                                    <span>导入</span>
                                </a>
                            </div>
                            <a class="new_dsave new_menu" href="?cmd=csv&action=sample" style="margin-top:10px">
                                <span>下载样板CSV文件</span>
                            </a>
                            <div class="clear"></div>
                        </div>
                    </div>
                    {securitytoken}
                </form>
            </div>
        </td>
    </tr>
</table>