<div class="modal hide fade" id="action-password">
    <form action="" method="POST" style="margin: 0">
        <div class="modal-header">
            <button type="button" class="close hide-modal" aria-hidden="true">×</button>
            <h2 id="myModalLabel">{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h2>
        </div>

        <div class="modal-body form-horizontal">
            <div class="control-group">
                <label class="control-label">{$lang.newpassword}</label>
                <div class="controls">
                    <input type="password" name="newpass" />
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">{$lang.password2}</label>
                <div class="controls">
                    <input type="password" name="newpass2" />
                </div>
            </div>
        </div> 
        <div class="modal-footer">
            <span class="pull-right">
                <button type="submit" class="default btn btn-flat-primary btn-primary">{$lang.changepass}</button>
                <button type="button" class="default btn hide-modal">{$lang.cancel}</button>
            </span>
        </div>
        <input type="hidden" name="do" value="change"/>
        {securitytoken}
    </form>
</div>
{literal}
    <script type="text/javascript">
        $(function() {
            var edit = $('#action-password').clone(true);

            edit.find('.hide-modal').click(function() {
                edit.modal('hide');
            });
            edit.on('hidden', function() {
                edit.remove();
            });
            edit.find(".vtip_description").data('tooltip', '');

            edit.on('shown', function() {
                edit.find(".vtip_description").tooltip();
            });
            edit.modal({
                show: true,
            })
        })
    </script>
{/literal}