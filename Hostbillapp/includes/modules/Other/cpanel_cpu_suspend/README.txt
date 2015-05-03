Installation & configuration instructions:

cPanel:
- login as root to ssh
- file SuspendCheck.cron.pl copy to /scripts directory
- file SuspendCheck.pm copy to /usr/local/cpanel/Cpanel directory
- add following crontab line: (crontab -e)
*/2 * * * * /usr/bin/perl /scripts/SuspendCheck.cron.pl
- you can edit threshold for account suspension and warning ticket in SuspendCheck.cron.pl file
  by editing %defconfig hash values. By default ticket notification value is set to 20% of CPU usage,
  so for testing purposes please set it to lower level.

Note: HostBill addon settings decide whether account should be suspended or warned, regardless of 
local threshold setting


HostBill
- copy file class.cpanel_cpu_suspend.php and folder cpanel_cpu_suspend to /includes/modules/Other directory
under your HostBill installation directory
- proceed to Plugins section in your HostBill
- activate Plugin Cpanel_cpu_suspend
- under Extras menu new item will show up - cPanel: CPU overusage protect - use it to set your plugin configuration
- You will see list of your cPanel servers - you can check whether module SuspendCheck.pm is in place, check servers you wish
to monitor (with module in place)
- You can pick predefined reply that will be used as ticket message for clients that should be warned.
- Administrators that normally receives cronRun results will also receive module log - if any account would require
taking action, or action was taken, they will be notified.


For testing purposes use just ticket notification option, without auto suspension option on.