<link href="{$template_dir}hbchat/media/settings.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}templates/nextgen/css/bootstrap.css?v={$hb_version}" rel="stylesheet" media="all" />
<link href="{$system_url}includes/modules/Other/styleswitcher/template/js/css/jPicker-1.1.6.min.css" rel="stylesheet" media="all" />
<script src="{$system_url}includes/modules/Other/styleswitcher/template/js/jpicker-1.1.6.min.js"></script>
{literal}<style>
    .smlr {
        width:100px;
}

</style>
<script type="text/javascript">
  $(document).ready(
    function()
    {
      $('.jpicker').jPicker({images:{
    clientPath: {/literal}'{$system_url}includes/modules/Other/styleswitcher/template/js/images/'{literal}
    }}
);
    });
</script>
{/literal}
<table width="100%" border="0" cellspacing="0" cellpadding="6" id="content_tb">
    <tbody>
        <tr>
            <td colspan="2"><h3>Style Switcher</h3></td>
        </tr>
        <tr>
            <td width="180" valign="top"><div style="padding: 8px 0;" class="well">
        <ul class="nav nav-list">
          <li class="nav-header">Saved themes</li>
          {if $styles}
          {foreach from=$styles item=style}
          <li {if $theme.id==$style.id}class="active"{/if}><a href="?cmd=styleswitcher&action=edit&id={$style.id}">{$style.name}</a></li>
          {/foreach}
          {else}
          <li><em>None added yet</em></li>
          {/if}
          <li class="divider"></li>
          <li><a href="?cmd=styleswitcher&action=add">Create new theme</a></li>
        </ul>
      </div>
            </td><td valign="top">

                {if $action=='edit'}
<form action="" method="post">
    <input type="hidden" name="make" value="submit"/>
    <input type="hidden" name="id" value="{$theme.id}"/>

    {securitytoken}
    <div class="well">
        <label>Theme name</label>
        <input type="text" placeholder="Autosave" name="name" value="{$theme.name}" class="span3">
        <label class="checkbox">
          <input type="checkbox" name="enabled" {if $theme.enabled}checked="checked"{/if}> Use it in clientarea
        </label>
        <button class="btn btn-primary" type="submit" name="save">Save changes</button>
        <button class="btn btn-danger" type="submit" name="delete" onclick="return confirm('Are you sure?')">Delete this theme</button>
        </div>

     <h1>Custom CSS:</h1>
     <textarea placeholder="Place any custom CSS you'd like to include in your style" style="width:99%;height:150px;" name="variables[@customcss]" name="">{$theme.variables.$customcss}</textarea>


    <h1>Available regions:</h1>
    <table class="table table-bordered" width="100%">

    {foreach from=$regions item=region key=r}
    <tr><td class="form-horizontal">
            {foreach from=$region item=reg}
            <label class="control-label">{$reg}:</label> <input type="text" name="variables[{$reg}]" value="{$theme.variables.$reg}" class="smlr jpicker"/> <br/>
            {/foreach}

        </td><td> <img src="{$system_url}includes/modules/Other/styleswitcher/template/region/{$r}.png" style="max-width:300px"/></td></tr>
    {/foreach}
    <tr><td colspan="2" class="form-horizontal">

           <label class="control-label">@BodyTopHeight:</label> <input type="text" name="variables[@BodyTopHeight]" value="{$theme.variables.$bh}" class="smlr"/> <br/>
           <label class="control-label">Font family:</label> <input type="text" name="variables[@sansFontFamily]" value="{$theme.variables.$sansi|htmlspecialchars}" class=""/> <br/>
           <label class="control-label">Font size:</label> <input type="text" name="variables[@baseFontSize]" value="{$theme.variables.$size}" class="smlr"/> <br/>

        </td></tr>
        </table>

      </form>
                {else}

                <div class="hero-unit">
                    <h1>HostBill theme modifier</h1>
                    <p>Using this tool you can modify colors/basic css of nextgen theme visible in HostBill without modifying any files.</p>
                    <p><a class="btn btn-primary btn-large" href="?cmd=styleswitcher&action=add" style="color:white">Create new theme version</a></p>
                  </div>
                {/if}
            </td>
        </tr>
</table>