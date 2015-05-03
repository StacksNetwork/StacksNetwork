<div class="gbar" id="rswitcher">
    <a href="?cmd=predefinied&action=gettop" class="active d1">{$lang.mymacros}</a>
    <a href="?cmd=predefinied&action=browser" class="d2">{$lang.browsemacros}</a>
    <a href="?cmd=knowledgebase&action=browser" class="d3">{$lang.kbarticles}</a>
    <div class="clear"></div>
</div>
<div id="suggestion">
    <div class="d1" style="display: block">Loading...</div>
    <div class="d2">Loading...</div>
    <div class="d3">Loading...</div>
</div>

{literal}
<script>
    if ($('#suggestion').length > 0) {
        $('#rswitcher a').click(function() {
            $('#rswitcher a').removeClass('active');
            $('#suggestion').addLoader();
            var el = $(this);

            $.post($(this).attr('href'), {empty1mc: 'param'}, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#suggestion div').hide();
                    $('#suggestion div.' + el.attr('class')).html(resp).show();
                    $('#suggestion').hideLoader();
                    el.addClass('active');
                }
            });
            return false;
        });
        $.post('?cmd=predefinied&action=gettop', {empty1mc: 'param'}, function(data) {
            var resp = parse_response(data);
            if (resp) {
                $('#suggestion div.d1').html(resp);
                $('#suggestion div.d1').show();
            }
        });

    }

</script>
{/literal}