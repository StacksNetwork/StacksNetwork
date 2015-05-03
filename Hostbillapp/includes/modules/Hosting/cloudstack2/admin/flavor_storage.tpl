<div class="clrearfix">
    <textarea class="left" name="limits[{$key}]" style="width: 160px" class="inp" >{$entry.limits.$key|regex_replace:"/[\s;,]+/":"\n"}</textarea>
    <div class="left shownice fs11" style="padding: 10px">
        <b>进入名单的标签使用时创造的 {if $key=='data_storage_tag'}数据流量{else}新的VM{/if} . </b><br/>
        第一个标签(从列表中选择服务器发现)将被使用, 留空使用产品默认配置.
    </div>
</div>