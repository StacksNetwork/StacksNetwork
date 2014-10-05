<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2"><h3>{$lang.promocodes}</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=coupons"  data-pjax class="tstyled {if $action=='default'}selected{/if}">{$lang.listcodes}</a>
            <a href="?cmd=coupons&action=new"  data-pjax class="tstyled {if $action=='new'}selected{/if}">{$lang.addnewcode}</a>

        </td>
        <td  valign="top"  class="bordered"><div id="bodycont">
                {include file='ajax.coupons.tpl'}
            </div>
        </td>
    </tr>
</table>
{literal}
    <script type="text/javascript">

        function sh_(what, ins) {
            if ($(ins).is(':checked')) {
                $(what).show();
                $('#cycles').show();

            } else {
                $(what).hide();
                if (!$('#products').is(':visible') && !$('#upgrades').is(':visible') && !$('#addons').is(':visible') && !$('#domains').is(':visible')) {
                    $('#cycles').hide();
                }
            }


        }
        function randomCode(target) {
            var length = 20;
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            pass = "";
            for (x = 0; x < length; x++)
            {
                i = Math.floor(Math.random() * 62);
                pass += chars.charAt(i);
            }
            $(target).val(pass);
            return false;
        }
        function client_check(vals) {
            if (vals == 'existing') {
                $('#specify').show();
            } else
                $('#specify').hide();

        }
        var applycode = $('#apply_code').val();
        function recurring_check(vals){
            if (vals == 'setupfee') {
                $('#cycle_code').val('once').find('option:last').prop('disabled',true).attr('disabled','disabled').parents('tr').eq(0).ShowNicely();
            } else if(applycode == 'setupfee')
               $('#cycle_code option').prop('disabled',false).removeAttr('disabled').parents('tr').eq(0).ShowNicely();
           applycode = vals;
        }
        function check_i(element) {
            var td = $(element).parent();
            if ($(element).is(':checked'))
                $(td).find('input.config_val').removeAttr('disabled');
            else
                $(td).find('input.config_val').attr('disabled', 'disabled');
        }
    </script>
{/literal}