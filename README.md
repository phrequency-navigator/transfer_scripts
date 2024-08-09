# transfer_scripts
A few scripts for estimating size and transferring files

## Function

transfer.pl - Use rsync to copy over files in a list or directory.

estimate.pl - Estimate the total size of a list of files or a directory.

fixlist.sh - fix your file list to the format these programs expect

## Usage

These scripts are used as follows:


    $ transfer.pl
    Usage:  --file= --host= --directory= --user= --dest= --flags= [--verbose] [--help]

        --file - Input file to read with list of files/folders to transfer 

        --host - IP address or hostname of the remote system

        --directory - Relative or absolute path to the folder containing the files/folders to transfer, 

                  with no trailing slash

        --user - User account on the remote system to use

        --dest - Destination on the remote system to copy files to

        --flags - rsync flags to use when copying the files over

        --verbose - run rsync with -vvv

        --help - show this help


    $ estimate.pl                   
    Usage:  [--dir=] [--infile=] [--help]

            --dir - directory to estimate the size of

            --infile - file with a list of filenames to estimate the size of

            --prefix - prefix path for filenames in the infile

            --help - print this help


    $ fixlist.sh
    Usage: /usr/local/bin/fixlist.sh <filename>

## Contributing

Feel free to fork and submit pull requests, I will review them and merge into main if I like them. If you do submit a pull request,
please also email me at elia@sassysalamander.net so I can look at it faster.

## License

Affero General Public License 3.0

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Affero General Public License as
   published by the Free Software Foundation, either version 3 of the
   License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Affero General Public License for more details.

   You should have received a copy of the GNU Affero General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.

## Copyright

2024 Elia Farin <elia@sassysalamander.net>
