<?php
class widget_vpspower extends HostingWidget
{
	protected $description = '电源管理组件(电源打开/关闭/重启)';
	protected $widgetfullname = 'VPS电源管理';
	
	public function clientFunction($module)
	{
		/* Call legacy function */
		return array('powermanagement.tpl', $module->getPower() );
	}
}
