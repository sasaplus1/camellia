#!/usr/bin/env make -f

.DEFAULT_GOAL := all

fptest = ./lib/fptest
apilib = ./lib/apilib
w32api = ./lib/w32api

# {{{ w32api download settings
w32api_arc = w32api-3.17-2-mingw32-dev.tar.lzma
w32api_uri = w32api-3.17/$(w32api_arc)
downloader = wget -O '$(w32api_arc)'
# }}}

.PHONY: all # {{{
all:
	@echo 'Target:'
	@echo '  setup'
# }}}

.PHONY: setup # {{{
setup:
	-if [ -d '$(fptest)' ]; \
	 then \
	   (cd '$(fptest)'; git pull --rebase); \
	 else \
	   git clone git://github.com/graemeg/fptest.git '$(fptest)'; \
	 fi
	-if [ -d '$(apilib)' ]; \
	 then \
	   (cd '$(apilib)'; svn update); \
	 else \
	   svn checkout https://jedi-apilib.svn.sourceforge.net/svnroot/jedi-apilib/jwapi/branches/2.4a '$(apilib)'; \
	 fi
	-if [ -d '$(w32api)' ]; \
	 then \
	   $(RM) $(w32api); \
	 fi; \
	 mkdir -p $(w32api); \
	 $(downloader) 'http://ftp.jaist.ac.jp/pub/sourceforge/m/project/mi/mingw/MinGW/Base/w32api/$(w32api_uri)'; \
	 tar xvfJ '$(w32api_arc)' -C '$(w32api)'; \
	 $(RM) $(w32api_arc)
# }}}

# vim:ft=make:fdm=marker:fen:
