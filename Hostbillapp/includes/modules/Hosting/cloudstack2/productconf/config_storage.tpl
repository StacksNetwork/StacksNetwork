<div id="flav_storage">
    <b>Using flavor storage</b>
    <br>You can use flavor manager plugin to create predefined storage options for your clients.
    <ul style="list-style: disc inside none; margin: 5px 0px; padding: 0px 3px;">
        <li>Primary storage tags can be defined in VM Flavor</li>
        <li>Data storage can be defined as separate flavors, your clients will be able to select them when adding additiional space</li>
        <li>Flavor settings have higher priority than Tier 2 storage settings</li>
    </ul>
</div>
<script type="text/javascript">
    $('.tierXstorage').hide();
    $('#adv_storage').html($('#flav_storage').detach());
</script>