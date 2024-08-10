#!/usr/bin/env sh
# Author: Ela Farin
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
if [ "$EUID" -ne 0 ]; then
	echo "This script must be run as root to install system-wide"
	exit 1
fi
cp ./transfer.pl /usr/local/bin/transfer.pl
cp ./estimate.pl /usr/local/bin/estimate.pl
cp ./fixlist.sh /usr/local/bin/fixlist.sh
chmod 755 /usr/local/bin/transfer.pl
chmod 755 /usr/local/bin/estimate.pl
chmod 755 /usr/local/bin/fixlist.sh

cpan install Getopt::Long