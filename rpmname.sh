#!/bin/bash -
#
# rpmname - list installed rpm packages without version
#
# @(#) $Revision: 1.5 $
# @(#) $Id: rpmname.sh,v 1.5 2014/01/26 10:23:58 chongo Exp $
# @(#) $Source: /usr/local/src/bin/rpmname/RCS/rpmname.sh,v $
#
# Copyright (c) 2014 by Landon Curt Noll.  All Rights Reserved.
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby granted,
# provided that the above copyright, this permission notice and text
# this comment, and the disclaimer below appear in all of the following:
#
#       supporting documentation
#       source copies
#       source works derived from this source
#       binaries derived from this source or from derived source
#
# LANDON CURT NOLL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
# INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO
# EVENT SHALL LANDON CURT NOLL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
# USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#
# chongo (Landon Curt Noll, http://www.isthe.com/chongo/index.html) /\oo/\
#
# Share and enjoy! :-)

# parse args
#
USAGE="usage: $0 [-h] [-k] [-s [-d]]

	-h	print this help message and then exit (def: don't)
	-k	include non-debian kernel and GPG public keys (def: don't)
	-s	do not sort (def: sort)
	-d	do not exclude duplicates (def: include duplicates)"
D_FLAG=
K_FLAG=
S_FLAG=
set -- $(/usr/bin/getopt hksd $*)
if [[ $? != 0 ]]; then
    echo "$0: unknown or invalid -flag" 1>&2
    echo "$USAGE" 1>&2
    exit 1
fi
for i in $*; do
    case $i in
    -h) echo "$USAGE" 1>&2; exit 0 ;;
    -k) K_FLAG="true" ;;
    -s) S_FLAG="true" ;;
    -d) D_FLAG="true" ;;
    --) shift; break ;;
    esac
    shift
done
if [[ -n "$D_FLAG" && -z "$S_FLAG" ]]; then
    echo "$0: FATAL: -d requires -s" 1>&2
    exit 2
fi
if [[ $# != 0 ]]; then
    echo "$USAGE" 1>&2
    exit 3
fi
export K_FLAG S_FLAG D_FLAG

# list debian or rpm package names
#
# List the unique normal packages installed AND
# list the kernel and GPG public key packages installed.
#
if which dpkg &> /dev/null; then
    dpkg --get-selections 2>/dev/null |
      grep -v 'deinstall$' |
      sed -e 's/[	 ][	 ]*install$//'
else
    rpm -q -a --qf '%{NAME}\n' 2>/dev/null |
      egrep -v '^kernel$|^kernel-devel$|^kernel-doc$|^kernel-firmware$|^kernel-headers$|^gpg-pubkey-[0-9a-f][0-9a-f]*-[0-9a-f][0-9a-f]*$'
    if [[ -n "$K_FLAG" ]]; then
	rpm -q kernel kernel-devel kernel-doc kernel-firmware kernel-headers gpg-pubkey 2>/dev/null |
	  egrep -v 'is not installed$'
    fi
fi |
if [[ -n "$S_FLAG" ]]; then
    if [[ -n "$D_FLAG" ]]; then
	# -s -d
	cat
    else
	# -s
	uniq
    fi
else
    if [[ -n "$D_FLAG" ]]; then
	# -u
	sort
    else
	# default
	sort -u
    fi
fi

# All done!!! - Jessica Noll, Age 2
#
exit 0
