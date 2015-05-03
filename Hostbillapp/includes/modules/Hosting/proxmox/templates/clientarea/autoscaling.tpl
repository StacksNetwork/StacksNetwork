<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{if $vpsdo=='editvm'}{$lang.scalevm}{else}{$lang.autoscaling}{/if}</h3>

    <ul class="sub-ul">
        <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=editvm&vpsid={$vpsid}" class="{if $vpsdo=='backups'}active{/if}" ><span>{$lang.scale}</span></a></li>
        <li><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=autoscaling&vpsid={$vpsid}" class="{if $vpsdo=='disks'}active{/if}" ><span>{$lang.autoscaling}</span></a></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding">

    <form method="post" action="" >
        <input type="hidden" name="do" value="applyrules" />
        <center> <table border="0" cellspacing="0" cellpadding="0" class="checker" width="100%">
                <tr>
                    <td>
                        <input type="checkbox" name="scale[memory][enabled]" value="1" {if $scale.memory}checked="checked"{/if} />
                               <input type="hidden" name="scale[memory][id]" value="{$scale.memory.id}" />
                    </td>
                    <td>{$lang.ifmemory}
                    </td>
                    <td>{$lang.isabove} <select name="scale[memory][above]" >
                            {section name=foo start=0 loop=105  step=10 max=11}
                            <option value="{$smarty.section.foo.index}" {if $scale.memory.above==$smarty.section.foo.index}selected="selected"{/if}>{$smarty.section.foo.index} %</option>
                            {/section}
                        </select>
                    </td>
                    <td>{$lang.scalefor}
                        <select name="scale[memory][for_minutes]">
                            {section name=foo start=5 loop=35 step=5}
                            <option value="{$smarty.section.foo.index}" {if $scale.memory.for_minutes==$smarty.section.foo.index}selected="selected"{/if}>{$smarty.section.foo.index} {$lang.minutes}</option>
                            {/section}
                        </select>
                    </td>
                    <td> {$lang.scaleadd} <input type="text" class="styled" name="scale[memory][add_units]" size="2" value="{$scale.memory.add_units}" /> MB </td>
                    <td> {$lang.scaleupto}<input type="text" class="styled" name="scale[memory][up_to]" size="2" value="{$scale.memory.up_to}" /> MB {$lang.per24h}</td>

                </tr>


                <tr>
                    <td>
                        <input type="checkbox" name="scale[cpu][enabled]" value="1" {if $scale.cpu}checked="checked"{/if} />
                               <input type="hidden" name="scale[cpu][id]" value="{$scale.cpu.id}" />
                    </td>
                    <td>{$lang.ifcpu}
                    </td>
                    <td>{$lang.isabove} <select name="scale[cpu][above]" >
                            {section name=foo start=0 loop=105  step=10 max=11}
                            <option value="{$smarty.section.foo.index}" {if $scale.cpu.above==$smarty.section.foo.index}selected="selected"{/if}>{$smarty.section.foo.index} %</option>
                            {/section}
                        </select>
                    </td>
                    <td>{$lang.scalefor}
                        <select name="scale[cpu][for_minutes]">
                            {section name=foo start=5 loop=35 step=5}
                            <option value="{$smarty.section.foo.index}" {if $scale.cpu.for_minutes==$smarty.section.foo.index}selected="selected"{/if}>{$smarty.section.foo.index} {$lang.minutes}</option>
                            {/section}
                        </select>
                    </td>
                    <td> {$lang.scaleadd} <input type="text" class="styled" name="scale[cpu][add_units]" size="2" value="{$scale.cpu.add_units}" /> % </td>
                    <td> {$lang.scaleupto}<input type="text" class="styled" name="scale[cpu][up_to]" size="2" value="{$scale.cpu.up_to}" /> % {$lang.per24h}</td>

                </tr>


                <tr>
                    <td>
                        <input type="checkbox" name="scale[disk][enabled]" value="1" {if $scale.disk}checked="checked"{/if} />
                               <input type="hidden" name="scale[disk][id]" value="{$scale.disk.id}" />
                    </td>
                    <td>{$lang.ifdisk}
                    </td>
                    <td>{$lang.isabove}  <select name="scale[disk][above]" >
                            {section name=foo start=0 loop=105  step=10 max=11}
                            <option value="{$smarty.section.foo.index}" {if $scale.disk.above==$smarty.section.foo.index}selected="selected"{/if}>{$smarty.section.foo.index} %</option>
                            {/section}
                        </select>
                    </td>
                    <td>for
                        <select name="scale[disk][for_minutes]">

                            {section name=foo start=5 loop=35 step=5}
                            <option value="{$smarty.section.foo.index}" {if $scale.disk.for_minutes==$smarty.section.foo.index}selected="selected"{/if}>{$smarty.section.foo.index} {$lang.minutes}</option>
                            {/section}
                        </select>
                    </td>
                    <td> {$lang.scaleadd} <input type="text" class="styled" name="scale[disk][add_units]" size="2" value="{$scale.disk.add_units}" /> GB </td>
                    <td> {$lang.scaleupto}<input type="text" class="styled" name="scale[disk][up_to]" size="2" value="{$scale.disk.up_to}" /> GB {$lang.per24h}</td>


                </tr>
                <tr>
                    <td colspan="6" style="text-align: center;border-bottom:none;"><input type="submit" class="blue" value="{$lang.scaleapply}" /></td>
                </tr>
            </table>
            <br/>
            
            {securitytoken}
    </form>
</div>