package Cpanel::SuspendCheck;

use strict;
use YAML::Syck;
use Cpanel::Locale   ();    # not really needed but harmless


our $VERSION = 1.0;

my $suspend_log="/usr/local/cpanel/logs/suspendthem_log.yaml";
my $ticket_log="/usr/local/cpanel/logs/ticketthem_log.yaml";

sub SuspendCheck_init { }

sub _get_suspend_log {
    open $data_in, '<', $suspend_log || return;
    my $yaml = do { local $/; <$data_in>; };
    close($data_in);
    my $loaded_list_p = Load($yaml);
    my @loaded_list=();
    my @loaded_list2=();
    if($loaded_list_p) {
        @loaded_list = @{$loaded_list_p};
     } else {
       @loaded_list=();
    }
    if(@loaded_list) {
        foreach my $index (0..$#loaded_list) {
                if($loaded_list[$index]{suspend}!=0) {
                    push(@loaded_list2,$loaded_list[$index]);
                    delete $loaded_list[$index];
                }
        }
        DumpFile($suspend_log, \@loaded_list);
    }

    return \@loaded_list2;
}

sub _get_ticket_log {
    open $data_in, '<', $ticket_log || return;
    my $yaml = do { local $/; <$data_in>; };
    close($data_in);
    my $loaded_list_p = Load($yaml);
    my @loaded_list=();
    my @loaded_list2=();
    if($loaded_list_p) {
        @loaded_list = @{$loaded_list_p};
     } else {
       @loaded_list=();
    }
    if(@loaded_list) {
        foreach my $index (0..$#loaded_list) {            
                if($loaded_list[$index]{ticket}!=0) {
                    push(@loaded_list2,$loaded_list[$index]);
                    delete $loaded_list[$index];
                }
        }
        DumpFile($ticket_log, \@loaded_list);
    }
    
    return \@loaded_list2;
}

sub api2_inplace {
    #confirm that module is in place, and working
     my @RSD=({'imhere'=>'boss!'});
    return \@RSD;
}

sub api2_stat {
    my %CFG = @_;


$l=_get_ticket_log();
$s=_get_suspend_log();
    
    #ok, read from log files 

    my @RSD=({'ticket'=>$l,'suspend'=>$s});
    
    return \@RSD;

}

sub api2 {
    my $func = shift;

    my %API = (
        'stat' => {
            'func'    => 'api2_stat',
            'engine'  => 'hasharray',
        }, 'inplace' => {
            'func'    => 'api2_inplace',
            'engine'  => 'hasharray',
        }
    );

    return \%{ $API{$func} };
}

1;
