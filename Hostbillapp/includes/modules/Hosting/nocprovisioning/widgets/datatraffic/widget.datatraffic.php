<?php
class widget_datatraffic extends HostingWidget
{
	protected $description = '数据流量图显示组件';
	protected $widgetfullname = '数据流量图';
	
	public function clientFunction($module)
	{
		/* Call legacy function */
		return array('datatraffic.tpl', $module->getDatatraffic() );
	}
}
