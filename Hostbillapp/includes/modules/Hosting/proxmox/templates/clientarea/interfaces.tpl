<table class="tonapp"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td width="50">Id</td>
            <td width="50">Model</td>
            <td>MAC</td>
            <td width="100">Bridge</td>
        </tr>
    </thead>
    {foreach  from=$interfaces item=interface}
    <tr>
          <td >{$interface.name}</td>
          <td >{$interface.model}</td>
        <td >{$interface.mac}</td>
        <td >{$interface.bridge}</td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="4">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>