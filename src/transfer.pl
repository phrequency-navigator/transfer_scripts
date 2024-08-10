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
my $path= "";
my $host = "";
# get running user's name
my $user = getlogin() || (getpwuid($<))[0] || $ENV{LOGNAME} || $ENV{USER};
my $dest= "/home/$user/Downloads/";
my $flags = "rvz";
my $verbose;
my $help;
my $dir;

# options
my $result = GetOptions ( "path=s" => \$path,
	"host=s" => \$host,
	"dir" => \$dir,
	"user=s" => \$user,
	"dest=s" => \$dest,
	"flags=s" => \$flags,
	"verbose" => \$verbose,
	"help" => \$help);


sub transfer {
	#print "file: $file, host: $host, srcdir: $dir, user: $user, dest: $dest flags: $flags verbose: $verbose help: $help\n";
	### Begin main logic
	# help catch
	if ($help) {
		help();

	} 
	# if we're passed the directory flag and we have the required options set
	elsif ($dir && length $host && length $dest && length $user) {

		print "Transferring object 1 of 1 \n\n";

		# transfer our directory
		system("rsync", "-$flags", "$dir", "$user\@$host:$dest");
	}
	# If we have all the right options set for an infile, begin the copy
	elsif (length $path && length $host && length $user && length $dest) {
		#print "in elsif block\n";
		# Open our filehandle
		open my $info, $path or die "Could not open $path: $!";
		
		my $linesnum = 0;
		while( my $iterline = <$info>) {
			#print "in first while loop\n";
			$linesnum++;
		}

		# wqe need to close the filehandle or we won't be able to read the file again
		close $path;

		# open our filehandle, this time for taking action
		open $info, $path or die "Could not open $path: $!";
		my $xfernum = 0;
		# read line by line
		while( my $line = <$info> ) {
			#print "in second while loop\n";
			$xfernum++;
			chomp $line;
			# actual copy logic
			if (length $verbose) {
				#print "in verbose section";
				print "\n\nTransferring object $xfernum of $linesnum\n\n";
				system("rsync", "-vvv", "-$flags", "$line", "$user\@$host:$dest");
			} else {
			#print "in non-verbose section";
			print "\n\nTransferring object $xfernum of $linesnum\n\n";
			system("rsync", "-$flags", "$line", "$user\@$host:$dest");
			}
		}
		close $path;

	} 
	# if we fail the variables check, print usage help
	else {
		#print "In help else\n";
		help();
	}

	# help subroutine
	sub help {
		print "Usage: $ARGV[0] --path <infile or directory> [--dir] --host <IP or DNS name> --user <username> --dest <destination path> [--flags <rsync flags>] [--verbose] [--help]\n
		--path 		- Input file to read or directory to copy
		--host 		- IP address or hostname of the remote system
		--dir 		- enable directory copy mode
		--user 		- User account on the remote system to use
		--dest 		- Destination on the remote system to copy files to
		--flags 	- rsync flags to use when copying the files over. Defaults to rvz
		--verbose	- run rsync with -vvv
		--help 		- show this help\n";
	}
}

transfer();
