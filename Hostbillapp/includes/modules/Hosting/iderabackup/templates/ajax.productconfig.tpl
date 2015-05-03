{if $make=='importformel' && $fid}
    <a href="#" onclick="return editCustomFieldForm('{$fid}', '{$pid}')" class="editbtn orspace">Edit related form element</a>
    <script type="text/javascript">editCustomFieldForm('{$fid}', '{$pid}');</script>
{/if}