#!/usr/bin/env make -f

.DEFAULT_GOAL := all

# path settings {{{
main_exe = ./core/camellia.exe
main_res = ./core/camellia.res

fptest = ./lib/fptest
apilib = ./lib/apilib
w32api = ./lib/w32api
# }}}

# compiler settings {{{
win = $(filter-out Linux Darwin, $(shell uname))

PC = $(if $(win), ppcrossx64, fpc)
PFLAGS = \
  -Fu$(fptest)/src \
  -Fu$(fptest)/3rdparty/epiktimer \
  -Fu$(apilib)/src \
  -Fu$(apilib)/Common \
  -Fu$(apilib)/COM \
  -Fu$(apilib)/Win32API \
  -Mobjfpc \
  -Twin64 \
  -XP$(if $(win),,x86_64-w64-mingw32-)

RC = $(if $(win), windres, x86_64-w64-mingw32-windres)
RCFLAGS = \
  --include-dir=$(w32api)/include \
  --language=0411 \
  --target=pei-x86-64
# }}}

# w32api download settings {{{
w32api_arc = w32api-3.17-2-mingw32-dev.tar.lzma
w32api_uri = w32api-3.17/$(w32api_arc)
downloader = wget -O '$(w32api_arc)'
# }}}

# file list {{{
main_units = $(sort $(addprefix -Fu, \
  $(dir $(wildcard ./core/*)) \
  $(dir $(wildcard ./core/*/*)) \
))

objs = $(filter %.o %.obj %.or %.ppu, \
  $(wildcard ./*) \
  $(wildcard ./*/*) \
  $(wildcard ./*/*/*) \
  $(wildcard ./*/*/*/*) \
)
# }}}

.SUFFIXES: .rc .res # {{{
.rc.res:
	$(RC) $(RCFLAGS) --input $< --output $@
# }}}

.PHONY: all # {{{
all:
	@echo 'Target:'
	@echo '  clean'
	@echo '  main'
	@echo '  main-debug'
	@echo '  main-test'
	@echo '  setup'
# }}}

.PHONY: clean # {{{
clean:
	$(RM) $(main_exe) $(main_res) $(objs)
# }}}

.PHONY: main # {{{
main: $(main_res)
	$(PC) $(PFLAGS) $(main_units) -O2 -WG -Xs $(main_exe:.exe=.lpr)
# }}}

.PHONY: main-debug # {{{
main-debug: $(main_res)
	$(PC) $(PFLAGS) $(main_units) -gh -gl -WG $(main_exe:.exe=.lpr)
# }}}

.PHONY: main-test # {{{
main-test:
	$(PC) $(PFLAGS) $(main_units) -dTEST -WC $(main_exe:.exe=.lpr)
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
