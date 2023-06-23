use strict;
use warnings;

use Proc::Daemon;

my $child = Proc::Daemon->new(
    work_dir => ".",
    exec_command => "perl server.pl"
);

$child->Init;
print "Daemon launched\n";
