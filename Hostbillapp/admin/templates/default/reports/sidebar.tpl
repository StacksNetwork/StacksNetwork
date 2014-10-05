
		<br>
        <a href="?cmd=reports"  class="tstyled {if $cmd=='reports'}selected{/if}">{$lang.reports}</a>

		<br>
	<strong>营收</strong>
	<a href="?cmd=stats&action=income&range=year"  class="tstyled {if ($action=="income" || ($cmd=='stats' && $action=="default")) && $range=="year"}selected{/if}">年收入</a>
	<a href="?cmd=stats&action=income&range=month"  class="tstyled {if $action=="income" && $range=="month"}selected{/if}">当月收入</a>
	<a href="?cmd=stats&action=incomebycountry&range=year"  class="tstyled {if $action=="incomebycountry" && $range=="year"}selected{/if}">年收入(按国家排列)</a>
	<a href="?cmd=stats&action=incomebycountry&range=month"  class="tstyled {if $action=="incomebycountry" && $range=="month"}selected{/if}">月收入(按国家排列)</a>
	<a href="?cmd=stats&action=incomebyservice&range=year"  class="tstyled {if $action=="incomebyservice" && $range=="year"}selected{/if}">年收入(按服务排列)</a>
	<a href="?cmd=stats&action=incomebyservice&range=month"  class="tstyled {if $action=="incomebyservice" && $range=="month"}selected{/if}">月收入(按服务排列)</a>
	<br>
	<strong>注册</strong>
	<a href="?cmd=stats&action=singup&range=year"  class="tstyled {if $action=="singup" && $range=="year"}selected{/if}">年注册用户</a>
	<a href="?cmd=stats&action=singup&range=month"  class="tstyled {if $action=="singup" && $range=="month"}selected{/if}">当月注册用户</a>
	<a href="?cmd=stats&action=singupbycountry&range=year"  class="tstyled {if $action=="singupbycountry" && $range=="year"}selected{/if}">年注册用户(按国家排列)</a>
	<a href="?cmd=stats&action=singupbycountry&range=month"  class="tstyled {if $action=="singupbycountry" && $range=="month"}selected{/if}">月注册用户(按国家排列)</a>
    <br>
    <strong>服务工单</strong>
    <a href="?cmd=stats&action=ticketsgen"  class="tstyled {if $action=="ticketsgen" }selected{/if}">常规</a>
	<a href="?cmd=stats&action=tickets&range=year"  class="tstyled {if $action=="tickets" && $range=="year"}selected{/if}">年新增工单 </a>
	<a href="?cmd=stats&action=tickets&range=month"  class="tstyled {if $action=="tickets" && $range=="month"}selected{/if}">当月新增工单 </a>
	<a href="?cmd=stats&action=supportreply&range=year"  class="tstyled {if $action=="supportreply" && $range=="year"}selected{/if}">年工作人员响应</a>
	<a href="?cmd=stats&action=supportreply&range=month"  class="tstyled {if $action=="supportreply" && $range=="month"}selected{/if}">月工作人员响应</a>
    <br>{*
    <strong>财务报告</strong>
    <a href="?cmd=stats&action=report&range=year"  class="tstyled {if $action=="report"  && $range=="year"}selected{/if}">年度报告</a>
    *}