  <table cellpadding="3" cellspacing="0" width="100%" class="whitetable">
                <tbody>
                    <tr>
                    <th width="280">Module</th>
                    <th>License Key</th>
                    <th width="120">Actions</th>
                    </tr>
                    
                    {if $keys}
                        
                        
                        
             {foreach from=$keys key=da item=val name=usageloop}
                 <tr class="{if $smarty.foreach.usageloop.iteration%2==0}even{else}odd{/if}">
                    <td >{$val.modname}</td>
                    <td >
                        {if !$val.key}
                            <strong style="color:red">No license key added yet, or key has expired</strong>
                            <div style="padding: 10px;background: rgb(255, 255, 165)">
                            <form action="" method="post" >
                                Enter valid license key: 
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
                            <a href="?cmd=paidaddons&action=deactivate&module={$val.module}&security_token={$security_token}" class="editbtn">Deactivate module</a>
                        {/if}
                    </td>
                    </td>
                </tr>
                 
            {/foreach}
                        
                        {else}
                    <tr>
                        <td colspan="2">You dont have any paid addon yet</td>
                    </tr> 
                            
                   {/if}
                </tbody>
            </table>
                
            <div class="stepsh3" style="padding:10px 0px">
              <h3><span class="numberCircle">1</span> <a href="http://hostbillapp.com/pricing">Order</a> HostBill license</h3>
              <h3><span class="numberCircle">2</span> <a href="http://hostbillapp.com/paid-apps">Add Apps</a> to extend your billing platform</h3>
              <h3><span class="numberCircle">3</span> Something missing? <a href="http://hostbillapp.com/services/customdevelopment/">Hire us</a> to create App.</h3>
              </div>
                
                
                        <div class="mmfeatured" id="latest_additions">
                            <div class="mmfeatured-inner">
                                <h2>Latest additions</h2>
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