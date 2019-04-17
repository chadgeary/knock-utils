#!/usr/bin/perl
use strict;
use warnings;
use IO::Socket;

# first and second args must be defined
if (! defined $ARGV[0]
	|| ! defined $ARGV[1]
)
{
	print "target:port and port list required, e.g.:
$0 hostname:port tcp:1000,udp:2020,tcp:399\n";
	exit 1;
}

# target and targetsshport from argv0
my ($target, $targetsshport) = split(/:/, $ARGV[0], 2);

# list from argv1
my @protoports = split(/,/, $ARGV[1], 64);

# split protocol and port pairs
foreach my $protoport (@protoports) {
	my @protoport = split(/:/, $protoport, 2);
	my $proto = $protoport[0];
	my $port = $protoport[1];
	print "knocking: $target:$proto:$port\n";
	if ($proto eq "udp") {
		my $packet = IO::Socket::INET->new(Proto=>"$proto",PeerPort=>"$port",PeerAddr=>"$target",Type=>SOCK_DGRAM);
		$packet->send("1");
	} else {
		my $packet = IO::Socket::INET->new(Proto=>"$proto",PeerPort=>"$port",PeerAddr=>"$target");
	}
}

# ssh command
print "knocking complete, exiting.\nto connect, run: ssh $target -p $targetsshport"
