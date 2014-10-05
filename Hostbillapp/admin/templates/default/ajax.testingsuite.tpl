{if $action=='beginsimpletest'}
<div style="background:#fff;padding:10px;">
    <h3 style="margin-top:0px;">Testing App configuration for {$pname}</h3>
    
    <div id="testcontainer" style="display:none">
        <div id="testcontent">
            <em>Test started {$nowdate|dateformat:$date_format} ...</em><br/>
        </div>
    </div>
    <div  style="padding:10px 0px;">
        <div class="lxa spinner left" style="display:none;"><img src="ajax-loading2.gif"></div>
<a href="#" class="new_control" onclick="return  HBTestingSuite.runSimpleTest();"><span class="gear_small">Test again</span></a>
    </div>
</div>
<div class="dark_shelf dbottom">
 <div class="left spinner"><img src="ajax-loading2.gif"></div>

        <div class="right">
  <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


        </div>
        <div class="clear"></div>
 </div>{literal}
<style type="text/css">
    #testcontainer {
        height:220px;
        overflow:auto;
        background:#303030;
        color:#fff;
}
.lxa {
    margin-right: 10px;
}
#facebox .lxa {
    display:none;
    height:0px;
}
#testcontainer #testcontent {
    padding:5px;
}
</style>
<script type="text/javascript"> 
    if (typeof(HBTestingSuite)=='undefined')
        var HBTestingSuite={};

HBTestingSuite.runSimpleTest=function(){
    $('.spinner').show();
    $('#testcontainer').slideDown();
    var config =  $('form#productedit').serialize();
    $.post(
        '?cmd=testingsuite&action=runsimpletest&product_id='+this.product_id,
        {'fields':config},
        function(data){
            $('.spinner').hide();
            var r = data.substr(data.indexOf('-->')+3, data.length);
            if(r)
                $('#testcontainer #testcontent').append(r);

        }
    );
    return false;
};
HBTestingSuite.runSelfHealing=function(test_id,indicat){
    $(indicat).parents('div').eq(0).hide();
    $('#testcontainer em:last').after('<span>Attempting to fix mentioned issues...</span></br>');
     $('.spinner').show();
     var config =  $('form#productedit').serialize();
    $.post(
        '?cmd=testingsuite&action=runsimplefix&product_id='+this.product_id,
        {'fields':config,task:test_id},
        function(data){
            $('.spinner').hide();
            var r = data.substr(data.indexOf('-->')+3, data.length);
            if(r)
                $('#testcontainer #testcontent').append(r);

        }
    );
};
 HBTestingSuite.runSimpleTest();
</script>{/literal}
{elseif $action=='runsimpletest'}
    {if $output}
        {foreach from=$output item=line}
             <span style="line-height:19px;{if $line.type=='error'}color:#FF9900;{elseif $line.type=='bold'}font-weight:bold{/if}">{$line.text} </span> {if !$line.type && !$line.offerfix}<span style="color:#35ee20">OK</span>{elseif $line.type=='error'}<span style="color:#FF9900;font-weight:bold">ERROR</span>{/if}<br/>
             {if $line.offerfix}<div style="padding:8px;">
                 <a href="#" class="new_control" onclick="HBTestingSuite.runSelfHealing('{$line.test}',this);return false"><span class="wizard"><strong>Auto-Fix: {if $line.fixname}{$line.fixname}{else}found problems{/if}</strong></span></a></div>{/if}
        {/foreach}
    {/if}
    {if $stoptime}
    <em>...Test finished {$stoptime|dateformat:$date_format}<br/></em>
    {/if}


{elseif $action=='runsimplefix'}
{if $output}
        {foreach from=$output item=line}
             <span style="line-height:19px;{if $line.type=='error'}color:#FF9900;{elseif $line.type=='bold'}font-weight:bold{/if}">{$line.text}</span><br/>
             {if $line.offerfix}<div style="padding:8px;"><a href="#" class="new_control" onclick="HBTestingSuite.runSelfHealing('{$line.test}',this);return false"><span class="wizard"><strong>Auto-Fix {if $line.fixname}{$line.fixname}{else}found problems{/if}</strong></span></a></div>{/if}
        {/foreach}
    {/if}
    {if $stoptime}
     <em>...Patching finished {$stoptime|dateformat:$date_format}<br/></em>
    {/if}
{/if}