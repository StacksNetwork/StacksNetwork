  <table cellpadding="3" cellspacing="0" width="100%" class="whitetable">
                <tbody>
                    <tr>
                    <th width="280">模块</th>
                    <th>许可证</th>
                    <th width="120">操作</th>
                    </tr>
                    
                    {if $keys}
                        
                        
                        
             {foreach from=$keys key=da item=val name=usageloop}
                 <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
                    <td >{$val.modname}</td>
                    <td >
                        {if !$val.key}
                            <strong style="color:red">尚无任何许可证, 或者密钥已过期</strong>
                            <div style="padding: 10px;background: rgb(255, 255, 165)">
                            <form action="" method="post" >
                                输入了无效的许可证: 
                                <input type="hidden" name="action" value="submitlicense"/>
                                <input type="hidden" name="module" value="{$val.module}" />
                                <input type="text" size="60" name="key"/>
                                <input type="submit" value="Submit" />
                                {securitytoken}
                            </form>
                            </div>
                        {else}
                            {$val.key}
                         {/if}
                    
                    <td >
                        {if !$val.key && $val.active=='1'}
                            <a href="?cmd=paidaddons&action=deactivate&module={$val.module}&security_token={$security_token}" class="editbtn">停用模块</a>
                        {/if}
                    </td>
                    </td>
                </tr>
                 
            {/foreach}
                        
                        {else}
                    <tr>
                        <td colspan="2">您尚无任何付费App</td>
                    </tr> 
                            
                   {/if}
                </tbody>
            </table>
                
            <div class="stepsh3" style="padding:10px 0px">
              <h3><span class="numberCircle">1</span> <a href="http://hostbillapp.com/pricing">购买</a> HostBill许可证</h3>
              <h3><span class="numberCircle">2</span> <a href="http://hostbillapp.com/paid-apps">添加 Apps</a> 扩展您的计费平台</h3>
              <h3><span class="numberCircle">3</span> 缺了点什么? <a href="http://hostbillapp.com/services/customdevelopment/">雇佣我们</a> 开发App.</h3>
              </div>
                
                
                        <div class="mmfeatured" id="latest_additions">
                            <div class="mmfeatured-inner">
                                <h2>最新增加</h2>
                                <div id="loadme">
                                    <div style="text-align:center; padding:80px;">
                                        <img src="ajax-loading2.gif" alt="" />
                                    </div>
                                </div>
                            </div>
                        </div>
                
                             </div>
                
                
            


	</div>
    </td>
  </tr>
</table>