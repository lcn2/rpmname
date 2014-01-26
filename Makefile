#!/bin/make
# @(#)Makefile	1.2 04 May 1995 02:06:57
#
# rpmname - list installed rpm packages without version
#
# @(#) $Revision$
# @(#) $Id$
# @(#) $Source$
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


SHELL= /bin/bash
CC= cc
CFLAGS= -O3 -g3

TOPNAME= bin
INSTALL= install

DESTDIR= /usr/local/bin

TARGETS= rpmname

all: ${TARGETS}

rpmname: rpmname.sh
	rm -f $@
	cp -p $? $@
	chmod +x $@

configure:
	@echo nothing to configure

clean quick_clean quick_distclean distclean:
	@echo rule to clean or empty rule if nothing is built

clobber quick_clobber: clean
	@echo rule to clobber or empty rule if nothing is built

install: all
	@echo perhaps ${INSTALL} -m 0555 ${TARGETS} ${DESTDIR}
