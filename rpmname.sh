#!/bin/bash -
#
# rpmname - list installed rpm packages without version
#
# @(#) $Revision: 1.2 $
# @(#) $Id: rpmname.sh,v 1.2 2014/01/26 08:56:35 chongo Exp chongo $
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
if [[ $# -ne 0 ]]; then
    echo "usage: $0" 1>&2
    exit 1
fi

# list debian or rpm package names
#
# List the unique normal packages installed AND
# list the kernel and GPG public key packages installed.
#
if which dpkg &> /dev/null; then
    dpkg --get-selections |
      grep -v 'deinstall$' |
      sed -e 's/[	 ][	 ]*install$//'
else
    rpm -q -a --qf '%{NAME}\n' |
      egrep -v '^kernel$|^kernel-devel$|^kernel-doc$|^kernel-firmware$|^kernel-headers$|^gpg-pubkey-[0-9a-f][0-9a-f]*-[0-9a-f][0-9a-f]*$'
    rpm -q kernel kernel-devel kernel-doc kernel-firmware kernel-headers gpg-pubkey
fi | sort -u

# All done!!! - Jessica Noll, Age 2
#
exit 0
