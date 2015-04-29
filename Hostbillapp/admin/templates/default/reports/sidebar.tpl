
		<br>
        <a href="?cmd=reports"  class="tstyled {if $cmd=='reports'}selected{/if}">{$lang.reports}</a>

		<br>
	<strong>Income</strong>
	<a href="?cmd=stats&action=income&range=year"  class="tstyled {if ($action=="income" || ($cmd=='stats' && $action=="default")) && $range=="year"}selected{/if}">Yearly income</a>
	<a href="?cmd=stats&action=income&range=month"  class="tstyled {if $action=="income" && $range=="month"}selected{/if}">Current Month Income</a>
	<a href="?cmd=stats&action=incomebycountry&range=year"  class="tstyled {if $action=="incomebycountry" && $range=="year"}selected{/if}">Yearly income by country</a>
	<a href="?cmd=stats&action=incomebycountry&range=month"  class="tstyled {if $action=="incomebycountry" && $range=="month"}selected{/if}">Monthly income by country</a>
	<a href="?cmd=stats&action=incomebyservice&range=year"  class="tstyled {if $action=="incomebyservice" && $range=="year"}selected{/if}">Yearly income by service</a>
	<a href="?cmd=stats&action=incomebyservice&range=month"  class="tstyled {if $action=="incomebyservice" && $range=="month"}selected{/if}">Monthly income by service</a>
	<br>
	<strong>Sign-ups</strong>
	<a href="?cmd=stats&action=singup&range=year"  class="tstyled {if $action=="singup" && $range=="year"}selected{/if}">Yearly Sign-ups</a>
	<a href="?cmd=stats&action=singup&range=month"  class="tstyled {if $action=="singup" && $range=="month"}selected{/if}">Current Month Sign-ups</a>
	<a href="?cmd=stats&action=singupbycountry&range=year"  class="tstyled {if $action=="singupbycountry" && $range=="year"}selected{/if}">Yearly Sign-ups by country</a>
	<a href="?cmd=stats&action=singupbycountry&range=month"  class="tstyled {if $action=="singupbycountry" && $range=="month"}selected{/if}">Monthly Sign-ups by country</a>
    <br>
    <strong>Support Tickets</strong>
    <a href="?cmd=stats&action=ticketsgen"  class="tstyled {if $action=="ticketsgen" }selected{/if}">General</a>
	<a href="?cmd=stats&action=tickets&range=year"  class="tstyled {if $action=="tickets" && $range=="year"}selected{/if}">Yearly new tickets </a>
	<a href="?cmd=stats&action=tickets&range=month"  class="tstyled {if $action=="tickets" && $range=="month"}selected{/if}">Current Month new tickets </a>
	<a href="?cmd=stats&action=supportreply&range=year"  class="tstyled {if $action=="supportreply" && $range=="year"}selected{/if}">Replies by staff in year</a>
	<a href="?cmd=stats&action=supportreply&range=month"  class="tstyled {if $action=="supportreply" && $range=="month"}selected{/if}">Replies by staff in month</a>
    <br>{*
    <strong>Financial reports</strong>
    <a href="?cmd=stats&action=report&range=year"  class="tstyled {if $action=="report"  && $range=="year"}selected{/if}">Yearly report</a>
    *}