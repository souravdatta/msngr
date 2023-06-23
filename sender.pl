use strict;
use warnings;

use IO::Socket;


print "ENTER IP: ";
my $ip = <STDIN>;
chomp $ip;

print "ENTER MESSAGE: ";
my $message = <STDIN>;
chomp $message;

my $client = IO::Socket::INET->new(
	PeerHost => $ip,
	PeerPort => 8000,
	Type => SOCK_STREAM
) or die "Could not connect to remote computer\n";

print $client "put: $message\n\r";
close $client;
print "OK\n";
