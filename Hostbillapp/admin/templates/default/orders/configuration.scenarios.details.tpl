{if $do=='add'}
<form action="" method="post">
    <input type="hidden" name="make" value="add"/>
    <table width="760" cellspacing="0" cellpadding="6" border="0">
        <tbody>
            <tr>
                <td width="205" align="right"><b>方案名称</b></td>
                <td><input type="text" name="name" class="inp" size="30" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                        <tbody>
                            <tr>
                                <th align="left" width="20"><b>正位于</b></th>
                                <th align="left" ><b>步骤</b></th>
                                <th align="left" width="50"></th>
                                <th align="left" width="200"></th>
                            </tr>

                            {foreach from=$defaults item=step name=scloop}
                            <tr >
                                <td><input value="1" type="checkbox" name="steps[{$step.name}][enabled]" {if !($step.options & 8)}disabled="disabled" checked="checked"{else}{if $step.enabled}checked="checked"{/if}{/if} /></td>
                                <td class="lastitm">{$lang[$step.name]}</td>
                                <td ><img src="templates/default/img/question-small-white.png" alt="" class="left"><a href="#" class="fs11" onclick="$('#description_{$step.name}').toggle();return false;">关于</a></td>
                                <td class="lastitm"><input type="radio"  {if !($step.options & 1)}disabled="disabled"{/if} {if $step.auto=='1'}checked="checked"{/if} name="steps[{$step.name}][auto]" value="1" /> 自动  
                                                           <input type="radio"  {if !($step.options & 2)}disabled="disabled"{/if} {if $step.auto!='1'}checked="checked"{/if} name="steps[{$step.name}][auto]" value="0" /> 手动</td>

                            </tr>
                            <tr class="even">
                                <td colspan="4" style="display:none" class="fs11" id="description_{$step.name}">{$step.description}</td>

                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="添加方案" style="font-weight:bold" class="submitme" />
                </td>
            </tr>
        </tbody>

    </table>
    {securitytoken}
</form>
{elseif $do=='edit'}
<form action="" method="post">
    <input type="hidden" name="make" value="edit"/>
    <table width="760" cellspacing="0" cellpadding="6" border="0">
        <tbody>
            <tr>
                <td width="205" align="right"><b>方案名称</b></td>
                <td><input type="text" name="name" class="inp" size="30" value="{$scenario.name}"/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                        <tbody>
                            <tr>
                                <th align="left" width="20"><b>正位于</b></th>
                                <th align="left" ><b>步骤</b></th>
                                <th align="left" width="50"></th>
                                <th align="left" width="200"></th>
                            </tr>

                            {foreach from=$scenario.steps item=step name=scloop}
                            <tr >
                                <td><input value="1" type="checkbox" name="steps[{$step.id}][enabled]" {if !($step.options & 8)}disabled="disabled" checked="checked"{else}{if $step.enabled}checked="checked"{/if}{/if} /></td>
                                <td class="lastitm">{$lang[$step.name]}</td>
                                <td ><img src="templates/default/img/question-small-white.png" alt="" class="left"><a href="#" class="fs11" onclick="$('#description_{$step.name}').toggle();return false;">关于</a></td>
                                <td class="lastitm"><input type="radio"  {if !($step.options & 1)}disabled="disabled"{/if} {if $step.auto=='1'}checked="checked"{/if} name="steps[{$step.id}][auto]" value="1" /> 自动
                                <input type="radio"  {if !($step.options & 2)}disabled="disabled"{/if} {if $step.auto!='1'}checked="checked"{/if} name="steps[{$step.id}][auto]" value="0" /> 手动</td>
                                <input type="hidden" name="steps[{$step.id}][options]" value="{$step.options}"/>
                            </tr>
                            <tr class="even">
                                <td colspan="4" style="display:none" class="fs11" id="description_{$step.name}">{$step.description}</td>

                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="submitme" />
                </td>
            </tr>
        </tbody>

    </table>
    {securitytoken}
</form>


{else}

<table border="0" cellspacing="0" cellpadding="6" width="100%">
    <tr>
        <td width="33%" valign="top">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
                <tbody>
                    <tr>
                        <th align="left" colspan="2"><b>可用的方案</b></th>
                    </tr>

                    {foreach from=$scenarios item=scenario name=scloop}
                    <tr {if $smarty.foreach.scloop.index%2==0}class="even"{/if}>
                        <td><a href="?cmd=configuration&action=orderscenarios&do=edit&id={$scenario.id}">{$scenario.name}</a></td>
                        <td width="20" class="lastitm">
                            {if $scenario.id!=1} <a onclick="return confirm('您真需要删除该方案吗?')" class="delbtn" href="?cmd=configuration&action=orderscenarios&make=delete&security_token={$security_token}&id={$scenario.id}">删除</a>{/if}
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
            <br/>
            <div>
                <a href="?cmd=configuration&action=orderscenarios&do=add" class=" new_control greenbtn"><span>创建新的方案</span></a>
            </div>

        </td>
        <td valign="top">
            <div class="blank_state blank_news" style="padding:30px 0px">
                <div class="blank_info">
                    <h1>保持订单的使用周期为可控制</h1>
                    允许您设置Hostbill订单方案的处理步骤以最完美的匹配您的业务.<br />
                    您可以选择以服务周期其中部分控制自动流程, 并要求工作人员审查.<br />
                    每个订单页面可以有不同的场景
                    <div class="clear"></div>
                </div>
            </div>
        </td>
    </tr>
</table>

{/if}