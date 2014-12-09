#!/usr/bin/perl
#
# Daemon used to watch the maillog messages for certain messages and trigger events when
# certain messages occur
#
# By Jason Warnes
#
# Change Log
# ~~~~~~~~~~
# 2006-08-22: Initial release
# 2006-09-05: Fixed signal handling
#             Added /var/run/watchmaillog.pid file for logrotate usage
# 2006-09-07: Added proper signal handling (Thanks pvenezia!)
#             Added SpamAssassin spamd checking support for SPAM (Thanks raiten!)
# 2006-09-18: Added new item mess_waiting, which is the number of messages MailScanner
#             detects when a new batch is started.
# 2006-11-02: Changed the way SPAM messages were detected so the script works
#             on servers configured for less verbose logging. (Thanks sdetroch!)
# 2006-11-08: Added new item mess_rejected, which is the number of rejected
#             messages by Sendmail.
# 2007-02-06: Fixed <MAILLOG> close statement at end of main program. (Thanks Avenger!)
#             Fixed warning messages about uninitialized $line used in pattern 
#             matching (Thanks Avenger!)
# 2007-05-04: Properly closed the maillog file on SIGHUP received.  (Thansks thomasch!)


$debug=0;       # 1=Debug messages are displayed, 0=No debug messages are displayed
$daemon=1;      # 1=Daemonize the program, 0=Run interactive
$syslog=1;      # 1=Log stuff to syslog, 0=No logging to syslog
$self="/opt/observium/scripts/watchmaillog/watchmaillog.sh";			# Location of this script
$counterfile="/opt/observium/scripts/watchmaillog/watchmaillog_counters";	# Location to store the counter file
$resetfile="/opt/observium/scripts/watchmaillog/watchmaillog_reset";		# Location of the reset counter flag file
$pidfile="/var/run/watchmaillog.pid";						# Location of the running process ID file (used in logrotate)

use Sys::Syslog;
use POSIX;
use Time::HiRes qw( gettimeofday tv_interval );

 $|=1;

my $sigset = POSIX::SigSet->new();
my $hupaction = POSIX::SigAction->new('hup_signal_handler',
                                     $sigset,
                                     &POSIX::SA_NODEFER);
my $osigaction = POSIX::SigAction->new('signal_handler',
                                     $sigset,
                                     &POSIX::SA_NODEFER);
POSIX::sigaction(&POSIX::SIGHUP, $hupaction);
POSIX::sigaction(&POSIX::SIGINT, $osigaction);
POSIX::sigaction(&POSIX::SIGTERM, $osigaction);


if($daemon){
        $pid=fork;
	if($pid) {
		open(PID,">".$pidfile) or die "无法打开 PID 文件: $!.";
			print PID ("$pid\n");	# Write the PID out to the PID file for logrotate
		close(PID);
	}
        exit if $pid;
        die "无法交叉 : $!" unless defined($pid);
        setsid() or die "无法开启新的会话: $!";
	$time_to_die=0;
}

sub signal_handler {
        $time_to_die=1;
}

sub hup_signal_handler {
      if($debug){print "got SIGHUP\n";}
      close(MAILLOG);
      exec($self) or die "无法重启: $!\n";
}

if($syslog){openlog("watchmaillog","pid","daemon");}
if($syslog){syslog("notice","开始.");}
if($debug){print("watchmaillog 已开始.\n");}

# Main part of the program
open(MAILLOG, "tail -n 0 -f /var/log/maillog|") or die "无法打开邮件日志: $!.";
my $line="";
while(!$time_to_die && ( $line = <MAILLOG> )){
#	$line=<MAILLOG>;
	# Look for received messages where the sender is not from our domain(s)
               if(($line=~/from\=/) && ($line!~/\@domain1.com|\@domain2.com/)){
		$item="mess_recv";
		&readcounterfile;
		$counter{$item}++;
		if($debug){print("发现了一个内部信息, 信息收到计数器递增 $counter{$item}.\n");}
		&writecounterfile;
	}
	# Look for messages sent to our domain(s), indicates an inbound message relayed to an internal server
	if(($line=~/stat\=Sent/) && ($line=~/\@domain1.com|\@domain2.com/)){
		$item="mess_relay";
		&readcounterfile;
		$counter{$item}++;
		if($debug){print("发现一个干净的内部信息, 增加干净的信息接收计数器 $counter{$item}.\n");}
		&writecounterfile;
	}
	# Look for sent messages to NOT our email domain(s), indicates an outbound message
	if(($line=~/stat\=Sent/) && ($line!~/\@domain1.comd|\@domain2.com/)){
		$item="mess_sent";
		&readcounterfile;
		$counter{$item}++;
		if($debug){print("发现出站发送的信息, 递增信息计数器 $counter{$item}.\n");}
		&writecounterfile;
	}
	# Look for rejected messages
	if((($line=~/ruleset/) && ($line=~/reject\=/)) || ($line =~/rejecting/)){
		$item="mess_rejected";
		&readcounterfile;
		$counter{$item}++;
		if($debug){print("发现一个拒绝信息, 拒绝计数器递增的信息 $counter{$item}.\n");}
		&writecounterfile;
	}
	# Look for MailScanner spam scanning batch results
	if($line=~/Spam\ Checks\:\ Found/){
		$item="spam";
		$spam_count_pos = index($line,"Spam\ Checks\:\ Found");
		$spam_count_pos2 = index($line, "\ spam\ messages");
		$spam_count = substr($line,($spam_count_pos+19),($spam_count_pos2-($spam_count_pos+19)));
		&readcounterfile;
		$counter{$item}=$counter{$item}+$spam_count;
		if($debug){print("发现 $spam_count SPAM 在邮件扫描批递增计数器, 垃圾邮件 $counter{$item}.\n");}
		&writecounterfile;
	}
	# Look for MainScanner virus scanning batch results
	if($line=~/Virus\ Scanning\:\ Found/){
		$item="virus";
		$virus_count_pos = index($line,"Virus\ Scanning\:\ Found");
		$virus_count_pos2 = index($line, "\ viruses");
		$virus_count = substr($line,($virus_count_pos+22),($virus_count_pos2-($virus_count_pos+22)));
		&readcounterfile;
		$counter{$item}=$counter{$item}+$virus_count;
		if($debug){print("发现 $virus_count 在邮件扫描病毒，病毒计数器递增 $counter{$item}.\n");}
		&writecounterfile;
	}
	# Look for MailScanner waiting messages
	if($line=~/New\ Batch\:\ Found/){
		$item="mess_waiting";
		$mess_waiting_pos = index($line,"New\ Batch\:\ Found");
		$mess_waiting_pos2 = index($line,"\ messages\ waiting");
		$mess_waiting = substr($line,($mess_waiting_pos+17),($mess_waiting_pos2-($mess_waiting_pos+17)));
		&readcounterfile;
		$counter{$item}=$mess_waiting;
		if($debug){print("邮件扫描器发现 $mess_waiting 消息等待, 设置 mess_waiting 计数器到 $counter{$item}.\n");}
		&writecounterfile;
	}
}
close(MAILLOG);
if($debug){print("watchmaillog 已结束.\n");}
if($syslog){syslog("notice","Ending.");}
unlink($pidfile);

# Subroutine to read the contents of the counter file
sub readcounterfile {
	# Read the counter values from the file
	if($debug){print("读取文件内容的计数器.\n");}
	open(COUNTER,$counterfile);
	while($line=<COUNTER>){
		@line=split(/\:/,$line);
		chop($line[1]); # Drop the trailing LF off the value
		# Check for reset counter flag file
		if(-e $resetfile."_".$line[0]){
			if($debug){print("计数器复位标志文件发现计数器 $line[0], 复位计数器的值为 0.\n");}
			$counter{$line[0]}=0;
			unlink($resetfile."_".$line[0]);
		} else {
			$counter{$line[0]}=$line[1];
		}
		if($debug){print("计数器 $line[0] = $counter{$line[0]}.\n");}
	}
	close(COUNTER);
}

# Subrouting to write the contents of the counter file
sub writecounterfile {
	if($debug){print("写计数器值以便计算文件.\n");}
	open(COUNTER,">".$counterfile);
	# Write each counter item out to the counter file
	foreach $item (sort keys(%counter)) {
		print COUNTER ($item."\:".$counter{$item}."\n");
	}
	close(COUNTER);
	chmod(0666,$counterfile);
}
