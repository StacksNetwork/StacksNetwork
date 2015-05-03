<script>
var currencySettings={literal}{{/literal}
decimalSeparator:".", thousandsSeparator: "", decimalPlaces: {$currency.decimal}, prefix: "{$currency.sign}", suffix:" {$currency.code}", defaultValue: '0.00'
{literal}}{/literal};

</script>
<link rel="stylesheet" type="text/css" media="screen" href="{$moduleliburl}jqueryui/custom-theme/jquery-ui-1.10.0.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="{$moduleliburl}jqgrid/css/ui.jqgrid.css" />
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>

<script src="{$moduleliburl}common.js" type="text/javascript"></script>
<script src="{$moduleliburl}jqueryui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$moduleliburl}jqgrid/js/grid.locale-en.js" type="text/javascript"></script>
<script src="{$moduleliburl}jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>

            <li class="{if $action=='scenarios' || !$action || $action=='default'}active{/if}">
                <a href="?cmd=migration_manager&action=scenarios"><span>割接方案(Migration scenarios)</span></a>
            </li>

            <li class="{if $action=='cases'}active{/if} last">
                <a href="?cmd=migration_manager&action=cases"><span>割接工程(Migration cases)</span>{if $pending_builds>0}<span class="badge">{$pending_builds}</span>{/if}</a>
            </li>
           

        </ul>
    </div>
               {if $action=='cases'}
                <div class="list-2">
				<div class="subm1 haveitems">
					<ul >
					<li {if !$finished}class="picked"{/if} >
						<a href="?cmd=migration_manager&action=cases" ><span >待定/正在进行的割接工程</span></a>
                                        </li>
					<li {if $finished}class="picked"{/if}>
						<a href="?cmd=migration_manager&action=cases&finished=true"><span >已完成的割接工程</span></a>
                                        </li>
					</ul>
					<div class="clear"></div>
				</div>

			</div>
                {/if}  
</div>
<div style="padding:10px">

    {if $action=='scenarios' || !$action || $action=='default'}
        {include file='scenarios.tpl'}
    {elseif $action=='cases'}
        {include file='cases.tpl'}
    {/if}    

        
</div>
    {literal}
    <style>
        #facebox textarea {
           font-family: Consolas, Menlo, Monaco, Lucida Console, Liberation Mono, DejaVu Sans Mono, Bitstream Vera Sans Mono, monospace, serif !important;
           line-height: 14px !important;
font-size: 11px !important;
padding: 5px !important;
        }
        
        #helpcontainer {
       padding-bottom:10px;     
       }
       .modernfacebox .conv_content .tabb {
           position:relative;
           }
       .subgrid-data , .subgrid-cell{
           background:#eee;
           }
           #porteditor {
            background: #F8F8F8;
           bottom: 52px;
           box-shadow: -1px 0 2px rgba(0, 0, 0, 0.2);
           display: none;
           left: 300px;
           position: absolute;
           right: 10px;
           top: 10px;
           padding:20px;
           z-index: 999;
           overflow:auto;
       }
       
      #facebox .ui-jqgrid .jqgrow td input, #facebox .ui-pg-input, #facebox .ui-pg-selbox {
           margin:0px;
           width:auto;
           border-radius:0px;
           padding:1px;
           box-shadow:none;
           }
           .badge {
               background-color: rgb(185, 74, 72);
            border-bottom-left-radius: 9px;
            border-bottom-right-radius: 9px;
            border-collapse: separate;
            border-top-left-radius: 9px;
            border-top-right-radius: 9px;
            color: rgb(255, 255, 255);
            display: inline-block;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            font-size: 12px;
            font-weight: bold;
            height: 14px;
            line-height: 14px;
            padding-bottom: 2px;
            padding-left: 9px;
            padding-right: 9px;
            padding-top: 2px;
            text-align: left;
            text-shadow: rgba(0, 0, 0, 0.247059) 0px -1px 0px;
            vertical-align: baseline;
            white-space: nowrap;    
            margin-left:10px;
            }
    </style>
    {/literal}