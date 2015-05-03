{literal}
    <style>
        .content-cloud {
            background: url("templates/common/cloudhosting/images/bg-action.png") repeat-x scroll left bottom #FFFFFF;
            margin-top: -1px;
        }
        .content-cloud .header-bar h3 {
            color: #FFFFFF;
            display: inline-block;
            float: left;
            font-size: 12px;
            margin: 0 0 0 8px;
            padding: 0 0 0 10px;
            text-shadow: 0 1px 0 #000000;
        }
        .content-cloud .header-bar .hasicon {
            padding-left: 20px;
        }
        .content-cloud .header-bar .pass{
            background: url("templates/common/cloudhosting/images/key-solid.png") no-repeat scroll left center transparent;
        }
        .content-cloud .header-bar {
            background: url("templates/common/cloudhosting/images/bg_header1.png") repeat-x scroll left top transparent;
            border-color: #2B5177 #2B5177 -moz-use-text-color;
            border-radius: 3px 3px 0 0;
            border-style: solid solid none;
            border-width: 1px 1px 0;
            height: 30px;
            line-height: 30px;
        }
        .content-cloud .content-bar {
            border-color: #2B5177 #C8C8C8 #C8C8C8;
            border-radius: 0 0 3px 3px;
            border-style: solid;
            border-width: 1px;
            padding: 10px;
        }
        .content-cloud .nopadding {
            background: none repeat scroll 0 0 #F5F5F5;
            padding: 0 !important;
        }
    </style>
{/literal}
<div class="content-cloud">
    <div class="header-bar">
        <h3 class="pass hasicon">{$lang.changepass}</h3>
    </div>
    <div class="content-bar form-horizontal">
        <form method="POST">
            <p>
                <strong>
                {if $type == 'vnc'} VNC console{elseif $type=="console"} Console{elseif $type=='root'} ROOT password{else}Account password{/if}
                </strong>
            </p>
            <div class="input-append">
                {$lang.resetpass}: <input class="span3" size="26" type="text" name="newpassword"><button class="btn" type="button" onclick="$(this).parents('form').submit(); return false;">{$lang.changepass}</button>
            </div>
            {securitytoken}
        </form>
    </div>
</div>