<script type="text/javascript" src="{$moduledir}jquery.ztree.core-3.5.min.js"></script>
	<link rel="stylesheet" href="{$moduledir}zTreeStyle/zTreeStyle.css" type="text/css">
        <div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
        
        
        {literal}
        
        
        <script type="text/javascript">
		var setting = {
                                    async: {
                                    enable: true,
                                    url:"?cmd=module&module={/literal}{$moduleid}{literal}&action=treecomponent",
                                    autoParam:["id", "name=n", "level=lv"],
                                    otherParam:{"otherParam":"zTreeAsyncTest"}
			}
		};

		

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
		});
	</script>
        
        {/literal}