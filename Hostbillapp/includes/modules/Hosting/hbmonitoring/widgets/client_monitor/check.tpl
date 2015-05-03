<script src="{$widuri}/javascript/moment.min.js"></script>
<script src="{$widuri}/javascript/checkState.js"></script>
<script src="{$widuri}/javascript/dateInterval.js"></script>
<script src="{$widuri}/javascript/dateNavigation.js"></script>
<script src="{$widuri}/javascript/statNavigation.js"></script>
<script src="{$widuri}/javascript/uptimeBar.js"></script>
<script src="{$widuri}/javascript/flotr2.min.js"></script>

<div style="margin-top:15px"></div>

<div style="float: right;">
  <span id="check_24h"></span>
  <a href="{$widurl}&make=removecheck&security_token={$security_token}&_id={$check._id}" class="btn btn-small btn-danger" onclick="return confirm('您确定吗?');">删除</a>
</div>
<h2>
  主机: {$check.name}
</h2>
<div class="clear"><br/></div>
<div id="dateNavigationContainer">
  <div id="dateNavigation">
    
  
        <ul class="btn-group zoom"></ul>
     
        <div class="periods"></div>
      
        <div class="clear"></div>
    </div>
</div>
<div id="sectionList" class="row">
  
    <section id="availability">
    {include file="`$widpath`/availability.tpl"}
    </section>
    <section id="responseTime">
    {include file="`$widpath`/responseTime.tpl"} 
    </section>
    <section id="responsiveness">
    {include file="`$widpath`/responsiveness.tpl"}
    </section>
</div>
   
<script>
var dateInterval = new DateInterval(
  '{$type}',
  {$date},
  {$firstTested},
  '?cmd=hbmonitoring&action=api&_id={$check._id}&account_id={$check.account_id}',
  'hour'
);
     {literal}
jQuery(document).ready(function($) {
  // highlight current section in main nav
  $('.navbar-inner li').eq(1).addClass('active');
    {/literal}
  // update check state live
  updateCheckState({$check_json});
  {literal}
  
  // initialize secondary navigation
  new StatNavigation(dateInterval);
  
  // initialize date navigation
  new DateNavigation(dateInterval);
  
  $('.havetooltip').tooltip();
  
  
});
</script>
<style>
.periods .btn {
    font-size:11px;
    padding-left:2px;
    padding-right:2px;
    }
    .graph {
  margin: 20px auto;
  width:600px;
  height:200px;
}
.tooltip-inner {
    white-space: normal !important;
    }
.zoom {
    float:left;
    margin:10px 10px 10px 0px;
    }
    .periods {
        float:right;
    margin:10px 10px 10px 0px;
        }
        
</style>
    {/literal}