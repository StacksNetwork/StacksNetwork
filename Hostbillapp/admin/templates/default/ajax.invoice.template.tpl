{if $action=='edittemplate'}
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
{literal}
<script type="text/javascript">
    function loadTPLEditor() {
        var w = {
            theme : "advanced",
            theme_advanced_buttons1 :  "bold,italic,underline,separator,justifyleft,justifycenter,justifyright,bullist,numlist,separator,fontselect,fontsizeselect,forecolor,backcolor,separator,code",
            theme_advanced_buttons2 : "visualaid,separator,tablecontrols",
            skin : "o2k7",
            visual : false, //hide table borders
            skin_variant : "silver",
            plugins : "table,inlinepopups",
            entity_encoding : "raw",
            theme_advanced_buttons3 : "",
            font_size_style_values : "8px,9px,10px,11px,12px,14px,16px,18px,22px",
            theme_advanced_font_sizes: "8px,9px,10px,11px,12px,14px,16px,18px,22px",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_statusbar_location : "bottom",
            body_class : "my_class",
            valid_children : "+body[style]",
            theme_advanced_fonts :
                "Arial=arial,helvetica,sans-serif;"+
                "Arial Black=arial black,avant garde;"+
                "Georgia=georgia,palatino;"+
                "Helvetica=helvetica;"+
                "Tahoma=tahoma,arial,helvetica,sans-serif;"+
                "Times New Roman=times new roman,times;"+
                "Verdana=verdana,geneva;"
        };
        $('#tplcontent').addClass('tinyApplied').tinymce(w);

    }

    function previewTemplate() {
        $('#preview_content').val($('#tplcontent').html());
        $('#previewform').submit();
        return false;
    }
    function switchVariableGroup(el) {
        var v=$(el).val();
        $('optgroup','#tpl_variables').hide().eq(0).show();
        $('#og_'+v,'#tpl_variables').show();

        $('#tpl_variables').val(0);
    }
    function switchVariable(el) {
        var v=$(el).val();
        if(v==0)
            return;
        $('#variable-box div').html(v);
        $('#variable-box').show();
    }
    appendLoader('loadTPLEditor');

</script>{/literal}
<form id="previewform" target="_blank" method="post" action="?cmd=configuration&action=invoicetemplates&make=preview">
    <input type="hidden" name="content" id="preview_content" value=""/>
    {securitytoken}</form>

{if !$mbstring}<div class="imp_msg"><strong>注意: 您的PHP缺少mbstring扩展 - 在这里所做的更改仅会影响HTML账单模板.</strong> </div>{/if}

<form action="" method="post" id="invoiceeditform">
    <input type="hidden" name="id" value="{$invtpl.id}" />
    <input type="hidden" name="make" value="edit" />
    <input type="hidden" name="template_id" value="{$invtpl.template_id}" />

    <table border="0" cellspacing="0" cellpadding="10" width="100%">
        <tr>
            <td colspan="2">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td width="205" style="padding-right:6px;" align="right"><b>模板名称:</b></td>
                        <td><input name="name" value="{$invtpl.template_name}" size="30" class="inp" /></td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td width="760" valign="top" >
                <textarea name="content" id="tplcontent" style="width:99%;height:800px;">{$invtpl.content}</textarea>
            </td>
            <td valign="top">
                <table width="300" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="sectionhead_ext open">工具箱</td>
                    </tr>
                    <tr>
                        <td valign="top"  class="sectionbody" style="padding:10px;">
                            <b>模板变量: <a class="vtip_description" title="变量将被实际值时, 会在账单更换/下载时显示.<br/> I.e. {literal}{$invoice.date}{/literal} 将被替换为账单日期"></a></b><br/>
                             
                           <table border="0" cellspacing="0" cellpadding="3" width="100%">
                              
                               <tr>
                               <td>
                                   <b class="fs11">选择变量:</b>
                                   <select class="inp" style="width:99%" onchange="switchVariable(this);" id="tpl_variables">
                                       <option value="0">---</option>
                                        {foreach from=$vars item=v key=k}
                                            <optgroup label="{foreach from=$vargroups item=vg key=kg}{if $kg==$k}{$lang.$vg}{break}{/if}{/foreach}">
                                            {foreach from=$v item=i key=kk}
                                               <option value="{$kk}" class="opt_{$k}" >{$i}</option>
                                            {/foreach}
                                            </optgroup>
                                         {/foreach}
                                   </select>
                               </td>
                                </tr>
                                <tr>
                               <td id="variable-box" style="display:none">
                                   <b class="fs11">复制 & 粘贴到模板:</b>
                                   <div id="var-container" style="border:solid 1px #DDD;padding:5px;font-size:13px;"></div>
                               </td>
                               </tr>
                           </table>
                            <br><br>

                            <span class="fs11">Tip: <em>如果您希望使用图片请确保将它们放置在 /templates 目录中</em></span>
                            <br/>
                        </td>
                    </tr>
                </table>
                <br/>
                
                                       <br/>
                <div style="text-align: center; width: 300px;" >
                    <a class=" new_control" href="#" onclick="return previewTemplate();"><span class="zoom"><b>{$lang.Preview}</b></span></a>
                  <a class=" new_control greenbtn" href="#" onclick="$('#invoiceeditform').submit();return false;"><span>{$lang.savechanges}</span></a>
                  <span class="orspace fs11">{$lang.Or}</span>
                  <a href="?cmd=configuration&action=invoicetemplates" class="fs11 editbtn">{$lang.Cancel}</a>
                </div>

            </td>
        </tr>

    </table>

{securitytoken}
</form>

{elseif $action=='invoicetemplates'}
<form action="" method="post" enctype="multipart/form-data">
    <input type="hidden" name="make" value="saveconfig"/> 
<table border="0" cellpadding="10" width="100%" cellspacing="0"  class="sectioncontenttable">
    <tr class="bordme">
        <td width="205" align="right" valign="top"><strong>{$lang.InvCompanyLogo}</strong></td>

        <td colspan="3">
            <input type="radio" value="0" {if $configuration.InvCompanyLogo==''}checked="checked"{/if} name="InvCompanyLogoY"  onclick="$('#logouploaders').slideUp();"/> <strong>{$lang.InvCompanyLogo_descr1}</strong><br />
            <input type="radio" value="1" {if $configuration.InvCompanyLogo!=''}checked="checked"{/if} name="InvCompanyLogoY" onclick="$('#logouploaders').slideDown();" /> <strong>{$lang.InvCompanyLogo_descr}</strong>
            <div class="clear"></div>
            <div class="p6 left" id="logouploaders" style="{if $configuration.InvCompanyLogo==''}display:none;{/if}padding:10px 5px;margin-top:10px;">
                <table border="0" cellspacing="0" cellpadding="6" >
                     <tr>
                         <td width="200" style="border:none" valign="top"  align="center" class="fs11">
                             {if $configuration.InvCompanyLogo!=''}
                             当前的Logo文件: 
                             <img src="../templates/{$configuration.InvCompanyLogo}" alt="{$configuration.BusinessName}" />
                             {else}
                             尚无Logo文件上传
                             {/if}
                         </td>
                         <td style="border:none">
                             上传新的Logo文件: <input  name="file"  id="InvCompanyLogo"   type="file" /><br />

                         </td>
                     </tr>
                     
                </table>
            </div>
            <div class="clear"></div>

            
		
        </td></tr>
    <tr class="bordme">
        <td width="205" align="right" valign="top"><strong>账单模板</strong></td>
        <td colspan="3">
            <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">

            {foreach from=$invtemplates item=tpl}
             <tr><td style="border:1px solid #CCCCCC; background: #fff;">
            <input class="left" type="radio" name="InvoiceTemplate" value="{$tpl.id}" {if $configuration.InvoiceTemplate==$tpl.id}checked="checked"{/if} id="seo_{$tpl.id}" />
            <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
            <div class="left">
            <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}" class="fs11">预览</a>
            {if $tpl.parent_id=='0'}
            <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}" class="fs11 orspace">自定义</a>

            {else}
            <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}" class="fs11 orspace">编辑</a>
            <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}" class="fs11 editbtn orspace" onclick="return confirm('您确定需要删除该模板吗?')">删除</a>
            {/if}
            </div>
            <div class="clear"></div>
            </td></tr>
            {/foreach}
            </table>
        </td>
    </tr>
    {if $configuration.CnoteEnable=='on'}
        <tr class="bordme">
            <td width="205" align="right" valign="top"><strong>信用记录模板</strong></td>
            <td colspan="3">
                <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">
                    {foreach from=$cnotetemplate item=tpl}
                        <tr><td style="border:1px solid #CCCCCC; background: #fff;">
                                <input class="left" type="radio" name="CNoteTemplate" value="{$tpl.id}" {if $configuration.CNoteTemplate==$tpl.id}checked="checked"{/if} id="seo_{$tpl.id}" />
                                <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
                                <div class="left">
                                    <a href="?cmd=configuration&action=invoicetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}" class="fs11">预览</a>
                                    {if $tpl.parent_id=='0'}
                                        <a href="?cmd=configuration&action=invoicetemplates&make=customize&id={$tpl.id}&security_token={$security_token}" class="fs11 orspace">自定义</a
                                    {else}
                                        <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}" class="fs11 orspace">编辑</a>
                                        <a href="?cmd=configuration&action=invoicetemplates&make=delete&id={$tpl.id}&security_token={$security_token}" class="fs11 editbtn orspace" onclick="return confirm('您确定需要删除该模板吗?')">删除</a>
                                    {/if}
                                </div>
                                <div class="clear"></div>
                            </td></tr>
                        {/foreach}
                </table>
            </td>
        </tr>
    {/if}
                    
                    <tr class="bordme">
                        <td width="205" align="right" valign="middle">
                           <b>Use 2nd currency: <a class="vtip_description" title="所有帐单金额将用两种货币显示, 来源 (在一份生成的账单中), 及从下面列表中选择的第二货币. <br/>仅对启用该选项之后的账单生效."></a></b><br/>
                           </td>  
                    <td colspan="3">
                         <input type="checkbox" name="Invoice2ndcurrency" value="1" {if $configuration.Invoice2ndcurrency}checked="checked"{/if} onclick="$('#daybefore,#comment').toggle()" />
                       
                         <select class="inp" name="Invoice2ndcurrency_val">
                                           {foreach from=$a_currencies item=v key=k}
                                            <option value="{$k}" {if $configuration.Invoice2ndcurrency_val == $k}selected="selected"{/if}>{$v.iso}</option>
                                           {/foreach}
                                       </select>
                          </tr>   
                          
                           <tr class="bordme" id="daybefore" {if !$configuration.Invoice2ndcurrency}style="display:none"{/if}>
                        <td width="205" align="right" valign="middle">
                           <b>'日期前' 汇率: <a class="vtip_description" title="如果第二种货币被启用, 系统将从第一天发票创建时的汇率 (用于欧盟账单的付款日期). <br/> 使用汇率从前面所提到日期第一天开始, 使用此选项 (在一些欧盟国家所需)"></a></b><br/>
                           </td>  
                    <td colspan="3"> <input type="checkbox" name="InvoiceDayBefore" value="1" {if $configuration.InvoiceDayBefore}checked="checked"{/if} />
                        
                          </tr> 
                          
                           <tr class="bordme" id="comment" {if !$configuration.Invoice2ndcurrency}style="display:none"{/if}>
                        <td width="205" align="right" valign="middle">
                           <b>汇率替换注意事项: <a class="vtip_description" title="在账单中使用第二货币是替换为当地汇率"></a></b><br/>
                           </td>  
                    <td colspan="3"> <input type="checkbox" name="InvoiceConversionRate" value="1" {if $configuration.InvoiceConversionRate}checked="checked"{/if} />
                        
                          </tr> 
                          
                          <tr class="bordme">           
                            <td width="205" align="right" valign="middle">
                            <b>使用第二语言: <a class="vtip_description" title="当启用所有 {literal}{$lang}{/literal} 将额外翻译成第二语言"></a></b><br/>
                              </td>  
                    <td colspan="3">
                        <input type="checkbox" name="Invoice2ndlanguage" value="1" {if $configuration.Invoice2ndlanguage}checked="checked"{/if} />
                        <select class="inp"  name="Invoice2ndlanguage_val">
                                           {foreach from=$a_languages item=v key=k}
                                            <option value="{$v.name}" {if $configuration.Invoice2ndlanguage_val == $v.name}selected="selected"{/if}>{$v.name}</option>
                                           {/foreach}
                                       </select>
                        </td>
                    </tr>
                    
                   

        {if $mbstring}
                <tr class="bordme">
                    <td width="205" align="right" valign="top"><strong>{$lang.PayToText}</strong></td>
                    <td colspan="3"><textarea  style="width:50%" name="PayToText"  class="inp">{$configuration.PayToText}</textarea></td>
                </tr>
                <tr  class="bordme">
                    <td width="205" align="right"   valign="top" ><strong>{$lang.UseInvoiceFooter}</strong></td>
                    <td colspan="3"><textarea  style="width:50%" name="InvoiceFooter" id="InvoiceFooter"  class="inp" >{$configuration.InvoiceFooter}</textarea></td>
                </tr>
        {/if}

    

</table>
    <div style="text-align:center" class="nicerblu">
        <input type="submit" class="submitme" style="font-weight:bold" value="{$lang.savechanges}">
    </div>
    {securitytoken}
</form>

    
    
    
{elseif $action=='estimatetemplates'}
<form action="" method="post" enctype="multipart/form-data">
    <input type="hidden" name="make" value="saveconfig"/> 
<table border="0" cellpadding="10" width="100%" cellspacing="0"  class="sectioncontenttable">
    
    <tr class="bordme">
        <td width="205" align="right" valign="top"><strong>预算模板</strong></td>
        <td colspan="3">
            <table style="border:1px solid #CCCCCC; border-collapse: collapse" cellspacing="0" cellpadding="3">

            {foreach from=$invtemplates item=tpl}
             <tr><td style="border:1px solid #CCCCCC; background: #fff;">
            <input class="left" type="radio" name="InvoiceTemplate" value="{$tpl.id}" {if $configuration.EstimateTemplate==$tpl.id}checked="checked"{/if} id="seo_{$tpl.id}" />
            <label for="seo_{$tpl.id}" class="w150 left">{$tpl.name}</label>
            <div class="left">
            <a href="?cmd=configuration&action=estimatetemplates&make=preview&content_id={$tpl.id}&security_token={$security_token}" class="fs11">预览</a>
            {if $tpl.parent_id=='0'}
            <a href="?cmd=configuration&action=estimatetemplates&make=customize&id={$tpl.id}&security_token={$security_token}" class="fs11 orspace">自定义</a>

            {else}
            <a href="?cmd=configuration&action=edittemplate&template_id={$tpl.id}&type=estimate" class="fs11 orspace">编辑</a>
            <a href="?cmd=configuration&action=estimatetemplates&make=delete&id={$tpl.id}&security_token={$security_token}" class="fs11 editbtn orspace" onclick="return confirm('您确定需要删除该模板吗?')">删除</a>
            {/if}
            </div>
            <div class="clear"></div>
            </td></tr>
            {/foreach}
            </table>
        </td>
    </tr>
             
      

    

</table>
    <div style="text-align:center" class="nicerblu">
        <input type="submit" class="submitme" style="font-weight:bold" value="{$lang.savechanges}">
    </div>
    {securitytoken}
</form>

    
{/if}

