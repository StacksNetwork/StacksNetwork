<div  class="nicerblu">
    {if $ChatGeoIPEnabled!='on'} <div class="imp_msg">Note: GeoIP tracking is not enabled in your HostBill yet! Follow instructions below to update your database</div>{/if}

    {if $import}
    <div class="p6" style="padding:15px;margin-top:10px;">
        <table border="0" cellspacing="0" cellpadding="3" >
            <tr><td colspan="2"> <strong>Database to import/update: {$import} </strong></td></tr>
            <tr><td width="150">Lines <a class="vtip_description" title="Number of csv lines to parse per one ajax call. Higher values require more powerful servers"></a></td><td><input class="inp" size="3" value="1000" id="line_limit" /></td></tr>
             <tr><td width="150">Transactions <a class="vtip_description" title="Number of database transactions to use per ajax call. Higher values require more powerful servers"></a></td><td><input class="inp" size="3" value="2" id="pass_limit" /></td></tr>
             <tr><td colspan="2" style="padding-top:15px;"><a href="#" class="new_control" onclick="$(this).hide(); return start_import('{$import}');"><span class="gear_small"><b>Import database</b></span></a></td></tr>

        </table>

    
</div>

   
    <div id="testconfigcontainer" style="padding:15px">
        <div style="height:20px"><div style="display: none;" class="lxa spinner " id="spinner"><img src="ajax-loading2.gif"></div></div>
        <div style="display: none;height:60px;" id="testcontainer">
            <div><strong>Do not refresh or close this page! If progress will stop or hang, re-login and try again.</strong></div>
            <div id="testcontent" >
                
            </div>
        </div>
    </div>
    {/if}

    <br/><br/><strong >HowTo: Install/Update GeoIP database <a href="#" onclick="$('#geoshow').show();return false" >show</a></strong>
    <div id="geoshow" style="display:none;padding:5px;">
        1. Download latest CSV zip file from <a href="http://www.maxmind.com/app/geolitecity" target="_blank">http://www.maxmind.com/app/geolitecity</a> <br/>
        2. Upload on server and extract archive contents into includes/libs/geoip directory. It will create directory, i.e.: includes/libs/geoip/GeoLiteCity_20111206 <br />
        3. Refresh this page - database import/update option will show up. <br/>
        4. Once import starts - do not refresh this page! Database import is time-consuming process, you will be notified about its progress.<br />
        5. If import process fails (hangs), refresh browser and adjust import parameters</div>
</div>
{literal}
<script type="text/javascript">
    var line_limit=300;
    var pass_limit=3;
    function start_import(filex) {
        line_limit=$('#line_limit').val();
        pass_limit=$('#pass_limit').val();
        $('#testcontainer').slideDown();
        $('#spinner').show();
        $.getJSON('?cmd=hbchat&action=geoimport',{part:'blocks',file:filex,limit:line_limit,passes:pass_limit,lightweight:'true'},blocks_loop);
        return false;
    }


    function blocks_loop(response) {
        if(response.re.loop==0) {
            $('#spinner').hide();
         $('#testcontent').prepend('<div><strong>ERROR!</strong></div>');
         $('#testcontent').prepend('<div><strong>'+response.re.msg+'</strong></div>');
            return;
        }
        if(response.re.finished) {         $('#spinner').hide();

            return location_loop({re:{loop:1,file:response.re.file}});
        }
        if(response.re.msg) {
         $('#testcontent').text(response.re.msg);
        }
        var offset = typeof(response.re.offset)!='undefined'?response.re.offset:0;
        $.getJSON('?cmd=hbchat&action=geoimport',{part:'blocks',file:response.re.file,offset:offset,limit:line_limit,passes:pass_limit,lightweight:'true'},blocks_loop)
         

    }
    function location_loop(response) {
        if(response.re.loop==0) {
         $('#testcontent').prepend('<div><strong>ERROR!</strong></div>');
         $('#testcontent').prepend('<div><strong>'+response.re.msg+'</strong></div>');
         $('#spinner').hide();
            return;

        }

         if(response.re.finished) {
         $('#testcontent').prepend('<div><strong>IMPORT FINISHED!</strong></div>');
         $('#spinner').hide();
            return ;
        }

        if(response.re.msg) {
         $('#testcontent').text(response.re.msg);
        }
        var offset = typeof(response.re.offset)!='undefined'?response.re.offset:0;
         $.getJSON('?cmd=hbchat&action=geoimport',{part:'locations',file:response.re.file,offset:offset,limit:line_limit,passes:pass_limit,lightweight:'true'},location_loop);
        
    }
</script>

<style type="text/css">
    #testcontainer {
    background: none repeat scroll 0 0 #303030;
    color: #FFFFFF;
    height: 220px;
    overflow: auto;
}
.lxa {
    margin-right: 10px;
}
#facebox .lxa {
    display: none;
    height: 0;
}
#testcontainer #testcontent {
    padding: 5px;
}

</style>
{/literal}