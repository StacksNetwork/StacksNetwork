<link href="{$system_url}templates/nextgen/css/bootstrap.css?v={$hb_version}" rel="stylesheet" media="all" />
<script type="text/javascript" src="{$system_url}templates/nextgen/js/bootstrap.js"></script>
<style>
    {literal}
    .controls {
        display:block !important;
}
    {/literal}
</style>
<div class="container-fluid" style="margin-top:20px">
    <div class="row-fluid">
        <div class="span2" style="padding-top:40px" >
            &nbsp;
            {if !$action || $action=='default'}
                {include file="`$tpldir`list_items.tpl"}
                {elseif $action=="edit" || $action=="add"}
                <b><a href="?cmd=hbslider">&laquo; Back</a></b><br/>
                <em>Use this form to configure your slider details, once saved you will be able to add slides</em>
                {elseif $action=="slides"}
                <b><a href="?cmd=hbslider">&laquo; Back</a></b><br/>
                <em>Use this form to upload/define new slides to your slideshow</em>
                {elseif $action=="html"}
                <b><a href="?cmd=hbslider">&laquo; Back</a></b><br/>
                <em>Grab your slider code and use it on your website!</em>
            {/if}
        </div>
        <div class="span10" >
            {if $direrror}
            <div class="alert">
              <strong>{$direrror}</strong>
            </div>
            {/if}
            <!--Body content-->

            {if $action=="edit" || $action=="add"}
                {include file="`$tpldir`edit.tpl"}
            {elseif $action=="slides"}
                {include file="`$tpldir`slides.tpl"}
            {elseif $action=="html"}
                {include file="`$tpldir`html.tpl"}
            {else}
                {include file="`$tpldir`list.tpl"}
            {/if}

        </div>
    </div>
</div>