use strict;
use warnings;

if( -e ".svn") {
    my $svnoutput = `svn info`;
    my @lines = split /\n/, $svnoutput;
    foreach my $line (@lines) {
        print "$1\n" if($line =~ m/Revision: (\d+)/)
    }
}
elsif( -e ".git") {
    my $gitoutput = `git branch`;
    my @lines = split /\n/, $gitoutput;
    foreach my $line (@lines) {
        print "$1\n" if($line =~ /^\* (.+)/);
    }
}
else {
    print "*\n";
}