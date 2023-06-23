use strict;
use warnings;

use IO::Socket;

my $message = "";
my $timestamp = "";

sub handle {
    my $c = shift;
    my $command = <$c>;
    $command = "" unless $command;
    chomp $command;
    $command =~ s/[\r\n]//g;
    if ($command =~ /^put: (.*)$/) {
        print "PUT]\n";
        $message = $1;
        $timestamp = time();
        print $c "OK\n";
    }
    elsif ($command =~ /^get$/) {
        print "GET]\n";
        my $cur = time();
        if (($timestamp ne "") && ($cur - $timestamp < 60)) {
            print $c "$message,$timestamp\n";
        }
        else {
            print $c "none\n";
        }
    }
    close $c;
}

my $server = IO::Socket::INET->new(
    LocalPort => 8000,
    Type => SOCK_STREAM,
    Reuse => 1,
    Listen => 10
) or die "Could not create the server\n";

my $out = `ifconfig | grep 192.168*`;
print $out, "\n";

while (my $client = $server->accept) {   
    handle $client;
}

close $server;