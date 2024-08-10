#!/usr/bin/env sh

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
#
if [ -z "${1}" ]; then
	echo "Usage: ${0} <filename>"
	exit 1
fi
line=$(uname -a | grep -i 'freebsd')
if [ $? -eq 0 ]; then
	line=$(which gsed | grep -e '/bin.gsed/')

	if [ $? -eq 1 ]; then
		gsed -e 's/\\//g' -i ${1}
		gsed -e 's/\/\s*$//g' -i ${1}
	else
		echo "This script requires gsed to be installed"
	fi
else
	sed -e 's/\\//g' -i ${1}
	sed -e 's/\/\s*$//g' -i ${1}
fi
	
