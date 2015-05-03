<?php
class widget_vpsconsole extends HostingWidget
{
	protected $description = 'VPS控制台显示组件';
	protected $widgetfullname = 'VPS控制台';
	
	public function clientFunction($module)
	{
		/* Call legacy function */
		return array('console.tpl', $module->getConsole() );
	}
}
