#!/usr/local/bin/perl
# Transfer script transfer.pl
# Author: Elia Farin 
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
use strict;
use Getopt::Long;
use re;
my $username = getlogin() || (getpwuid($<))[0] || $ENV{LOGNAME} || $ENV{USER};

# sane defaults
my $file = "";
my $host = "";
my $directory = ".";
my $user = $username;
my $dest= "/home/$username/Downloads/";
my $flags = "rvz";
my $verbose;
my $help;

# options
my $result = GetOptions ( "file=s" => \$file,
	"host=s" => \$host,
	"directory=s" => \$directory,
	"user=s" => \$user,
	"dest=s" => \$dest,
	"flags=s" => \$flags,
	"verbose" => \$verbose,
	"help" => \$help);

### Begin main logic
# help catch
if ($help) {
	help();

}
# If we have all the right arguments, begin the copy
elsif (length $file && length $host && length $user && length $dest && length $directory) {

	# Open our filehandle
	open my $info, $file or die "Could not open $file: $!";

	# read line by line
	while( my $line = <$info> ) {
		chomp $line;
		# actual copy logic
		if (length $verbose) {
			system("rsync", "-vvv", "-$flags", "$directory/$line", "$user\@$host:$dest");
		} else {
		system("rsync", "-$flags", "$directory/$line", "$user\@$host:$dest");
		}
	}

} 
# if we fail the variables check, print usage help
else {
	help();
}

# help subroutine
sub help {
	print "Usage: $ARGV[0] --file= --host= --directory= --user= --dest= --flags= [--verbose] [--help]\n
	--file - Input file to read with list of files/folders to transfer \n
	--host - IP address or hostname of the remote system\n
	--directory - Relative or absolute path to the folder containing the files/folders to transfer, \n
		      with no trailing slash\n
	--user - User account on the remote system to use\n
	--dest - Destination on the remote system to copy files to\n
	--flags - rsync flags to use when copying the files over\n
	--verbose - run rsync with -vvv\n
	--help - show this help\n";
}

