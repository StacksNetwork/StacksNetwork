<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{if $vpsdo=='editvm'}{$lang.scalevm}{else}{$lang.autoscaling}{/if}</h3>
 {if $service.options.option19=='Yes'}
    <ul class="sub-ul">
        <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=editvm&vpsid={$vpsid}" class="{if $vpsdo=='editvm'}active{/if}" ><span>{$lang.scale}</span></a></li>
        <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=autoscaling&vpsid={$vpsid}" class="{if $vpsdo=='autoscaling'}active{/if}" ><span>{$lang.autoscaling}</span></a></li>
    </ul>
 {/if}
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">


    <form method="post" action="">
        <input type="hidden" value="editmachine" name="make" />
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">



            <tr>
                <td colspan="2">
                    <div class='input-with-slider'>
                        <span class="slabel">{$lang.RAM}</span>
                        <input type="text" size="4" required="required" name="CreateVM[memory]" class="styled" value="{if $VMDetails.memory}{$VMDetails.memory}{else}{$CreateVM.limits.mem}{/if}" id="virtual_machine_memory"/>
                        MB
                        <div class='slider' max='{$CreateVM.limits.mem}' min='256' step='4' target='#virtual_machine_memory'></div>
                    </div>

                </td>

            </tr>

            <tr>
                <td colspan="2">
                    <div class='input-with-slider'>
                        <span class="slabel">{$lang.cpucores}</span>
                        <input type="text" size="4" required="required" name="CreateVM[cpu]" class="styled" value="{if $VMDetails.cpu}{$VMDetails.cpu}{else}{$CreateVM.limits.cpu}{/if}" id="virtual_machine_cpus"/>

                        <div class='slider' max='{$CreateVM.limits.cpu}' min='1' step='1' target='#virtual_machine_cpus'  total="{$CreateVM.limits.cpu}"></div>
                    </div>

                </td>

            </tr>

          
            <tr>
                <td align="center" style="border:none" colspan="2">
                    <input type="submit" value="{$lang.adjresall}" class="blue"/>
                </td>
            </tr>
        </table>
   {securitytoken} </form>

    <script type="text/javascript">
        {literal}
        $(document).ready(function(){
            init_sliders();
        });
        {/literal}
    </script>

</div>