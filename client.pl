use strict;
use warnings;

use IO::Socket;


sub pinger {
    my $host = shift;
    my $port = shift;
    my $sleep_time = 1;

    while (1) {
        my $client = IO::Socket::INET->new(
            PeerHost => $host,
            PeerPort => $port,
            Type => SOCK_STREAM
        ) or die "Couldn't connect to remote computer\n";
        
        print $client "get\r\n";
        my $answer = <$client>;
        $answer =~ s/[\r\n]//g;
        
        if ($answer eq "none") {
            $sleep_time = 1;
        }
        else {
            my $message = (split /\,/, $answer)[0];
            print $message, "\n";
            if ($message =~ /^http/) {
                print "open link: $message\n";
                system "open $message";
            }
            $sleep_time = 10 * 60;
            print "Not pinging for next $sleep_time seconds\n";
        }
        close $client;
        sleep $sleep_time;
    }
}


my $host = shift;
my $port = 8000;

pinger $host, $port;
