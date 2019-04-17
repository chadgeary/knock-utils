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

# loop through protoport pairs
foreach my $protoport (@protoports) {
	# split current protoport pair into list
	my @protoport = split(/:/, $protoport, 2);
	# first item in list is proto
	my $proto = $protoport[0];
	# second item in list is port
	my $port = $protoport[1];
	print "knocking: $target:$proto:$port\n";
	# UDP sends datagram
	if ($proto eq "udp") {
		my $packet = IO::Socket::INET->new(Proto=>"$proto",PeerPort=>"$port",PeerAddr=>"$target",Type=>SOCK_DGRAM);
		$packet->send("1");
	} else {
		my $packet = IO::Socket::INET->new(Proto=>"$proto",PeerPort=>"$port",PeerAddr=>"$target");
	}
}

# ssh command message, because we're not adding a client here
print "knocking complete, exiting.\nto connect, run: ssh $target -p $targetsshport"
