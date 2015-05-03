<div class="bordered-section article text-block clear clearfix">
    <h2 class="h-width">提交新的Bug<a href="?cmd=bugtracker"  class="btn btn-mini right"><i class="icon-chevron-left"></i> {$lang.back}</a></h2>  
    <div class="ribbon form-horizontal">
        <div class="control-group" style="font-weight:normal">
    该分类仅支持系统Bug提交, 请勿在此提交无关内容, 这样可能会导致冻结账户. <br/>
    请尽可能的重现Bug发生时您的操作步骤.

</div>
</div><div class="ribbon-shadow-l"></div><div class="ribbon-shadow-r"></div>
    
    <div class="p19">
       <form  enctype="multipart/form-data" method="post" action="" >
        <input name="make" type="hidden" value="addbug" />
        <table width="100%" cellspacing="0" cellspacing="0"  border="0" >
            <tbody>
                <tr>
                    <td valign="middle" colspan="2">
                        <label>版本</label>
                        <input type="text" value="{$submit.version}"  name="version" size="8" required=""/>
                        
                        <div class="clear"></div>
                    </td>
                </tr>
                <tr>
                    <td valign="middle" colspan="2">
                        <label>Bug分类</label>
                        <select name="category_id" >

                        {foreach from=$categories item=dept}
                            <option value="{$dept.id}" {if $submit.category_id==$dept.id}selected="selected"{/if}>{$dept.name}</option>
                        {/foreach}

                        </select>
                        
                        
                        <div class="clear"></div>
                    </td>
                </tr>
                <tr  class="even">
                    <td colspan="2">
                        <label for="subject">{$lang.subject}</label>
                        <input type="text" value="{$submit.subject}"  name="subject" required="" style="width: 99%;" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label for="body">Bug说明</label>
                        <textarea style="width: 99%;" cols="60" rows="12"  name="description" required="" >{$submit.description}</textarea>
                        <div id="hintarea" style="display:none" class="well"></div>
                    </td>
                </tr>


             


                <tr>
                    <td colspan="2" >
                        <div class="form-actions">

                           
                            <div class="right"><input type="submit" value="{$lang.submit}"  class="btn btn-success btn-large" style="font-weight: bold" id="submitbutton"/></div>
                            <div class="clear"></div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>


        {securitytoken}</form>
    </div>
</div>