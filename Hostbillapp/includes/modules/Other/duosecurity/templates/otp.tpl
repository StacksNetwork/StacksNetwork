<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>HostBill - {$business_name} </title>
        <link href="{$template_dir}_style.css" rel="stylesheet" media="all" />
        <script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js"></script>
        {literal}
            <style>
                a {
                    font-weight:bold;
                    color:#699ccb;
                    text-decoration:none;
                }
                a:hover {
                    text-decoration:underline;
                    color:#a1c4e1;
                }
                small {
                    font-size:11px;
                }

                .foc2 {
                    border: solid 1px #dddddd;
                    padding:4px 4px;
                    width:320px;
                }
                .foc2:hover, .foc2:focus {
                    border: solid 1px #6694e3;
                    color:#666666;
                }
                html, body {
                    height:100%;
                    min-height:100%;
                    position:relative;
                    line-height:20px;
                    font-size:11px;
                    font-family:Tahoma,Arial !important;
                }
            </style>
            <script src="{/literal}{$moduleurl}{literal}lib/js/Duo-Web-v1.min.js"></script>
            <script>
              Duo.init({
                {/literal}
                'host': '{$host}',
                'sig_request': '{$sign_request}',
                'post_action': '{$admin_url}/?cmd=duosecurity'
                {literal}
              });
            </script>
        {/literal}
    </head>

    <body style="" onload="$('#username').focus();">
        <div style="width:370px;margin:0px auto;position:relative;height:100%;padding:0px;min-height:100%">
            <div style="width:370px;position:absolute;top:50%;margin-top:-230px;"><img src="{$template_dir}img/hb_logo.gif" style="margin-bottom:10px;" />
                <div style="border:3px solid #85a8c8; padding:2px;margin-bottom:4px;background:#ffffff;">
                    <div>
                        <iframe id="duo_iframe" width="100%" height="500" frameborder="0" style="background: url('../includes/modules/Other/duosecurity/templates/blank.png') repeat-y"></iframe>
                    </div>
                </div>
                <div style="text-align:center;"><small>Powered by <a href="https://www.stacksnet.com/" target="_blank" >STACKS® NETWORK</a></small></div>
            </div>
        </div>
    </body>
</html>