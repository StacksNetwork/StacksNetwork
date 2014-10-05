{if !empty($todo)}

<div class="bborder">

    <div class="bborder_header">
				{$lang.noteattention}
    </div>
    <div class="bborder_content">
					{if $todo.emailoff}
        <font color="red"> {$lang.emailisturnetoff}</font> <br />
					{/if}
					{if $todo.install}
        <font color="red">{$lang.critical}</font>  {$lang.removeinstall}<br />
					{/if}
					{if $todo.changepass}
        <font color="red">{$lang.critical}</font>  {$lang.changeadminpass}<br />
					{/if}
					{if $todo.cron}
        <font color="red">{$lang.critical}</font>  {$lang.cronnotwork}<a href="?cmd=configuration&action=cron">{$lang.doitnow}.</a><br />
					{/if}
					{if $todo.crontaskblock}
        <font color="red">{$lang.crontaskdisabled}</font> <a href="?cmd=configuration&action=cron">{$lang.Learnmore}.</a> <a href="?cmd=logs&action=errorlog"> Error Log</a><br />
					{/if}
					{if $todo.chmodcron}
						{$lang.chmodcron}<br />
					{/if}
					{if $todo.downindex}
        <font color="red">{$lang.critical}</font>  {$lang.placeindexdownload}<br />
					{/if}
					{if $todo.tempindex}
        <font color="red">{$lang.critical}</font>  {$lang.placeindextemplates}<br />
					{/if}
					{if $todo.attindex}
        <font color="red">{$lang.critical}</font>  {$lang.placeindexattachments}<br />
					{/if}

				{if $todo.config}
						{$lang.shouldeditconfig}. <a href="?cmd=configuration">{$lang.doitnow}.</a><br />
					{/if}

					{if $todo.modules}
						 {$lang.tostartconfigservers} <a href="?cmd=managemodules">{$lang.doitnow}.</a><br />
					{/if}

					{if $todo.servers}
						 {$lang.configureservers} <a href="?cmd=servers">{$lang.doitnow}.</a><br />
					{/if}


					{if $todo.packages}
						 {$lang.addpackagestosell}<a href="?cmd=services&action=addproduct">{$lang.doitnow}.</a><br />
					{/if}

    </div>
</div>


{/if}