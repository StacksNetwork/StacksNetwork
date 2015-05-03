<?php
class widget_console extends HostingWidget
{
	protected $description = '服务器控制台显示组件';
	protected $widgetfullname = '控制台';
	
	public function clientFunction($module)
	{
		/* Call legacy function */
		return array('console.tpl', $module->getConsole() );
	}
}
