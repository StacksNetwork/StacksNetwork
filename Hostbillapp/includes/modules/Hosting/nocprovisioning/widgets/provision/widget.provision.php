<?php
class widget_provision extends HostingWidget
{
	protected $description = '允许用户安装服务器操作系统的组件';
    protected $widgetfullname = '配置';
	
	public function clientFunction($module)
	{
		if ( isset($_POST['oldeventid']) )
		{
			$module->ajaxStatusPoll(intval($_POST['oldeventid']));
		}
		
		/* Call legacy function */
		return array('provision.tpl', $module->getProvision() );
	}
}
