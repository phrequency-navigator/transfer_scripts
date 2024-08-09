#!/usr/bin/env perl
#
# Author: Elia Farin 2024
# Written: 8/9/24
# Modified: 8/9/24
# License: AGPL-3.0-or-later
#
#   Copyright (C) 2024 Elia Farin
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as
#   published by the Free Software Foundation, either version 3 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#
use strict;
use warnings;
use Getopt::Long;

# declare options variables
my $infile = "";
my $prefixdir = "";
my $dir = "";
my $help;

# Options
my $result = GetOptions(
    "infile=s" => \$infile,
    "dir=s" => \$dir,
    "prefix=s" => \$prefixdir,
    "help" => \$help
);

# define global scope variables
our $bytes = 0;
our $line = "";

# main subroutine
sub main {
    # print help
    if ($help) {
        help();
    }

    # If we have an infile
    if (length $infile) {
	# open filehandle	
        open my $info, '<', $infile or die "Could not open $infile: $!\n";
	# read line by line
        while ($line = <$info>) {
	    # chomp newline/whitespace
            chomp $line;
	    # increment $bytes variable
            $bytes += estimate("$prefixdir/$line");
        }

	# close our filehandle
        close $info;
	# print total calculated bytes
        print "Total Size: $bytes B\n";

	# if we're given a directory
    } elsif (length $dir) {
	# just get the bytes estimate
        $bytes = estimate("$dir");
	# print he bytes estimate
        print "Total Directory Size: $bytes B\n";
    } else {
	# if we don't have any options, print help
        help();
    }
}

# help subroutine
sub help {
    print "Usage: $ARGV[0] [--dir=] [--infile=] [--help]\n
        --dir - directory to estimate the size of\n
        --infile - file with a list of filenames to estimate the size of\n
        --prefix - prefix path for filenames in the infile\n
        --help - print this help\n";
}

# estimate subroutine, using du for disk usage
sub estimate {
    # argument passed = 1, $path
    my $path = $_[0];
    # calculate usage
    my $output = `du -s "$path"`;
    # split the bytes number off of the filename
    my @size = split /\s+/, $output;
    # return number of bytes
    return $size[0];
}

# Call main subroutine
main();

