{foreach from=$notes item=note}
    <div class="admin-note" rel="{$note.id}">
        <a class="editbtn right" href="#" onclick=" if (confirm('Are you sure you want to delete this note?'))
                    AdminNotes.del({$note.id});
                return false;"><small>[{$lang.Delete}]</small></a>

        <div class="left">
            {$note.date|dateformat:$date_format}{if $note.firstname || $note.lastname} by {$note.firstname} {$note.lastname}{/if}
            <a href="#" class="editbtn" onclick=" AdminNotes.hide();
                $(this).parent().next().hide().next().show();
                return false;">{$lang.Edit}</a>
        </div>

        <div class="admin-note-body">
            {$note.note|escape:'html':'UTF-8'}
        </div>
        <div class="admin-note-edit clear" style="display:none">
            <textarea rows="4" name="notes" class="notes_field notes_changed admin-note-input">{$note.note|escape:'html':'UTF-8'}</textarea>
            <div id="notes_submit" class="notes_submit admin-note-submit">
                <input type="button" name="savenotes" value="{$lang.savechanges}" onclick="AdminNotes.edit({$note.id});">
            </div>
            <a href="#" class="editbtn" onclick="$(this).parent().hide().prev().show(); return false;">{$lang.Cancel}</a>
        </div>
        {if $note.attachments}
            <div class="admin-note-attach">
            {foreach from=$note.attachments item=attachment}
                <div class="attachment"><a href="?cmd=root&action=download&type=downloads&id={$attachment.id}">{$attachment.name}</a></div>
            {/foreach}
            </div>
        {/if}
    </div>
{/foreach}
