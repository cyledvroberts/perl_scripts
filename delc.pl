#!/usr/bin/perl -w
use Cwd;
use File::Path qw(rmtree);
my $current_directory = getcwd();

if (@ARGV) 
{ 
    @file_list = @ARGV;
} else { 
    print "ERROR: no args\n";
    exit 1;
}

my @new_list = ();

foreach (@file_list) 
{
    if (-d $_) 
    {
        print "$_ is a directory\n";
        print "delete? [y,q] dir: $_ ";
        $input = <STDIN>;
        chomp($input);
        last if lc($input) eq "q";
        if (lc($input) eq "y") {
            push @new_list, $_;
        }
    } elsif (-f $_ && $_ ne "delc.pl"  && $_ ne "$current_directory/delc.pl") 
    {
        print "$_ is a file\n";
        print "delete? [y,q] file: $_ ";
        $input = <STDIN>;
        chomp($input);
        last if lc($input) eq "q";
        if (lc($input) eq "y") {
            push @new_list, $_;
        }
    }
}
print("Complete all deletions? [y]: ");
$input = <STDIN>;
chomp($input);
if(lc($input) eq "y")
{
  foreach (@new_list)
  {
    if (-d $_) 
    {
      rmtree($_) or die "Failed to delete dir : $_\n";
    }
    elsif(-e $_)
    {
      unlink $_ or die "Failed to delete file : $_\n";
    }
  }
}
else
{
  print("Nothing has been deleted\n")
}
exit 0;
