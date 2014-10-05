
<div id="AdmNotes" rel="{$cmd}" >
    <a id="notesurl" href="?cmd={$cmd}&action=notes{if $cmd=='clients'}&id={$client.id}{elseif $draft.id}&id={$draft.id}&draft=1{else}&id={$details.id}{/if}" style="display:none;" ></a>
    <strong>
        {if $cmd == 'accounts'}
            {$lang.accnotes}
        {elseif $cmd == 'clients'}
            {$lang.clientnotes}
        {elseif $cmd == 'orders'}
            {$lang.ordernotes}
        {elseif $cmd == 'domains'}
            {$lang.domainnotes}
        {else}{$lang.notes}
        {/if}

    </strong> 
    <a href="#" class="editbtn" onclick="return AdminNotes.show();">{$lang.Add}</a>
    <div id="notesContainer">

    </div>
    <div class="admin-note-new" style="display:none;">
        <div class="admin-note-input">
            <textarea rows="4" name="note" class="notes_field notes_changed"></textarea>
            <div class="admin-note-attach"></div>
        </div>
        <div id="notes_submit" class="notes_submit admin-note-submit">
            <input type="button" name="savenotes" value="{$lang.savechanges}" onclick="return AdminNotes.addNew();">
        </div>
        <a href="#" class="editbtn" onclick="return AdminNotes.addFile();">Attach file</a>
        <a href="#" class="editbtn" onclick="return AdminNotes.hide();">{$lang.Cancel}</a>
    </div>
</div>
<script src="{$template_dir}js/fileupload/init.fileupload.js"></script>
{literal}
    <script type="text/javascript">
        $(function() {
            {/literal}
            AdminNotes.init();
            AdminNotes.me = '{$admindata.firstname} {$admindata.lastname}';
            AdminNotes.dateformat = '{$date_format}';
            {literal}
        });
    </script>
{/literal}
