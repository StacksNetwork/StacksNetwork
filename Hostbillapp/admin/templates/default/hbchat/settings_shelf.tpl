<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li {if $action=='settings'}class="active picked"{/if}><a href="?cmd=hbchat&action=settings">常规设置</a></li>
            <li {if $action=='departments'}class="active picked"{/if}><a href="?cmd=hbchat&action=departments">部门</a></li>
            <li {if $action=='geoip'}class="active picked"{/if}><a href="?cmd=hbchat&action=geoip">Geo IP</a></li>
            <li class="{if $action=='widgets'}active picked{/if} last"><a href="?cmd=hbchat&action=widgets">网站控件</a></li>
        </ul>
    </div>

</div>