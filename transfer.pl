#!/usr/bin/env perl
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


# sane defaults
my $file = "";
my $host = "";
my $directory = ".";
my $user = getlogin() || (getpwuid($<))[0] || $ENV{LOGNAME} || $ENV{USER};
my $dest= "/home/$user/Downloads/";
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

print "file: $file, host: $host, directory: $directory, user: $user, dest: $dest flags: $flags verbose: $verbose help: $help\n";
### Begin main logic
# help catch
if ($help) {
	help();

}
# If we have all the right arguments, begin the copy
elsif (length $file && length $host && length $user && length $dest && length $directory) {
	#print "in elsif block\n";
	# Open our filehandle
	open my $info, $file or die "Could not open $file: $!";

	
	my $linenum = 0;
	while( my $iterline = <$info>) {
		#print "in first while loop\n";
		$linenum++;
	}
	close $file;

	open $info, $file or die "Could not open $file: $!";
	my $xfernum = 0;
	# read line by line
	while( my $line = <$info> ) {
		#print "in second while loop\n";
		$xfernum++;
		chomp $line;
		# actual copy logic
		if (length $verbose) {
			#print "in verbose section";
			print "\n\nTransferring object $xfernum of $linenum\n\n";
			system("rsync", "-vvv", "-$flags", "$directory/$line", "$user\@$host:$dest");
		} else {
		#print "in non-verbose section";
		print "\n\nTransferring object $xfernum of $linenum\n\n";
		system("rsync", "-$flags", "$directory/$line", "$user\@$host:$dest");
		}
	}
	close $file;

} 
# if we fail the variables check, print usage help
else {
	#print "In help else\n";
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

