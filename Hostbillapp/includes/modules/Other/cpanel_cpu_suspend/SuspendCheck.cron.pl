#!/usr/bin/perl
#use strict;
use YAML::Syck;
$YAML::Syck::ImplicitTyping = 1;

#configuration file that should be used.
my $yaml_config="/usr/local/cpanel/Cpanel/HBSuspend.config.yaml";

#accounts that might be suspended
#serialized structure of
# 0=>(
#     account=>username  
#     count=>int   #minutes of exceed cpu usage
#     suspend=>1/0 #whether account should be suspended in api call
#    )
my $suspend_log="/usr/local/cpanel/logs/suspendthem_log.yaml";

#accounts that might be ticketed
my $ticket_log="/usr/local/cpanel/logs/ticketthem_log.yaml";

	
my %defconfig = (
	ticket_level=>21,
	suspend_level=>80,
	time_period=>20
	);
	# ticket_level element is %level after ticket should be sent
	# suspend_level element is %level after acocunt should be suspended
	# time_period element is period in minutes after action should take place


sub read_hb_config {
	
	if(open my $data_in,'<',$yaml_config) {
		my $yaml = do { local $/; <$data_in>; };
		#load configuration assoc array
		my $config = Load($yaml);

		return $config;
	} else {
		
		store_hb_config(\%defconfig);
		return %defconfig;
	}	



}

sub store_hb_config {
	my $cnf = $_[0];
	my $data;	
	open $data, '>', $yaml_config || return;
	my $yaml = Dump($cnf);
	print $data $yaml;

}

sub add_to_ticket {

   my ($slimit,$accoun)=@_;

    my @accounts=@{$accoun};
    if (!@accounts || $slimit<=0) {

        return 1;
       }

    my $data_in;
   
    open $data_in, '<', $ticket_log || return;
    my $yaml = do { local $/; <$data_in>; };
    close($data_in);
    my $loaded_list_p = Load($yaml);
    my @loaded_list=();
    if($loaded_list_p) {
        @loaded_list = @{$loaded_list_p};
     } else {
       @loaded_list=();
    }

    if(@loaded_list) {
        foreach my $index (0..$#loaded_list) {
            if(!grep $_ eq $loaded_list[$index]{'account'},@accounts) {
                if($loaded_list[$index]{ticket}==0) {
                    #this account is not over limit at the moment
                    delete $loaded_list[$index];
                }
            }else {
                if($loaded_list[$index]{ticket}!=1) {
                    $loaded_list[$index]{count}+=2;
                }
                if($loaded_list[$index]{count}>$slimit) {
                    #suspend this account
                    $loaded_list[$index]{ticket}=1;
                }
                 my( $ind )= grep { $accounts[$_] eq $loaded_list[$index]{account} } 0..$#accounts;
                 delete $accounts[$ind];
            }
        }
    }
    if(@accounts) {
        #some new exceeding accounts shown up


        for my $acc (@accounts) {
            push(@loaded_list,{account=>$acc,ticket=>'0',count=>'2'});
        }
    }

DumpFile($ticket_log, \@loaded_list);
#print Dump \@loaded_list;

return 1;

}
sub _check_log_files() {
    unless(-e $suspend_log) {
        system("echo ' ' > $suspend_log");
        chmod(0777,$suspend_log);

    }
    unless(-e $ticket_log) {
        system("echo ' ' > $ticket_log");
        chmod(0777,$ticket_log);
    }

}
sub add_to_suspend {
   
   my ($slimit,$accoun)=@_;

    my @accounts=@{$accoun};
    if (!@accounts || $slimit<=0) {   
            
        return 1;
       }

    my $data_in;
    
    open $data_in, '<', $suspend_log || return;
    my $yaml = do { local $/; <$data_in>; };
    close($data_in);
    my $loaded_list_p = Load($yaml);
    my @loaded_list=();
    if($loaded_list_p) {
        @loaded_list = @{$loaded_list_p};
     } else {
       @loaded_list=();
    }
 
    if(@loaded_list) {
        foreach my $index (0..$#loaded_list) {
            if(!grep $_ eq $loaded_list[$index]{'account'},@accounts) {
                if($loaded_list[$index]{suspend}==0) {
                    #this account is not over limit at the moment
                    delete $loaded_list[$index];
                }
            }else {
                if($loaded_list[$index]{suspend}!=1) {
                    $loaded_list[$index]{count}+=2;
                }
                if($loaded_list[$index]{count}>$slimit) {
                    #suspend this account
                    $loaded_list[$index]{suspend}=1;                   
                }
                 my( $ind )= grep { $accounts[$_] eq $loaded_list[$index]{account} } 0..$#accounts;
                 delete $accounts[$ind];
            }
        }
    } 
    if(@accounts) {
        #some new exceeding accounts shown up
        

        for my $acc (@accounts) {          
            push(@loaded_list,{account=>$acc,suspend=>'0',count=>'2'});
        }
    }

DumpFile($suspend_log, \@loaded_list);
#print Dump \@loaded_list;

return 1;

}

sub get_current_top {
    my ($tlimit,$slimit)=@_;
    my $top = `top -b -n 1`;
    $top =~ s/^.+?PID[^\n]+\n//s;
    my @procs = split(/\n/, $top);
    my @ignore = ("mysql","mailnull","dbus","named","root","nobody");
    #add root, nobody
    my @to_suspend=();
    my @to_ticket=();

    my %peruser;

    for my $proc (@procs) {
        $proc = " ".$proc;
        my @tmpa = split(/\s+/, $proc);
        if(!grep $_ eq $tmpa[2],@ignore) {
            #cpu is under $tmpa[9]
            if($peruser{$tmpa[2]}) {
               $peruser{$tmpa[2]}+= $tmpa[9];
            } else {
                $peruser{$tmpa[2]}=$tmpa[9];
            }
            
            
        }
        
    }
    foreach my $key ( keys %peruser )
     {
        if($peruser{$key}>=$slimit) {
               #possible suspend
               if(!grep $_ eq $key, @to_suspend){
                    push(@to_suspend,$key);
                }
            } elsif($peruser{$key}>=$tlimit) {
                #possible ticket
                 if(!grep $_ eq $key, @to_suspend) {
                    push(@to_ticket,$key);
                 }
            }
    }


    return {'to_suspend'=>\@to_suspend, 'to_ticket'=>\@to_ticket};

}

my $current_config= read_hb_config();
_check_log_files();


my $top_proc=get_current_top($current_config->{ticket_level},$current_config->{suspend_level});
#comment below, for testing only!
#my $top_proc=get_current_top(-1,-1);

add_to_suspend($current_config->{time_period},$top_proc->{'to_suspend'});
add_to_ticket($current_config->{time_period},$top_proc->{'to_ticket'});