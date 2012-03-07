#!/usr/bin/env make -f

.DEFAULT_GOAL := all

# path settings {{{
core_exe = ./core/camellia.exe
core_obj = ./core/camellia.obj
core_res = ./core/resource

core_dir := $(sort $(addprefix -Fu, \
  $(dir $(wildcard ./core/*)) \
  $(dir $(wildcard ./core/*/*)) \
))

test_dir = ./test
wiki_dir = ./wiki

fptest = ./lib/fptest
apilib = ./lib/apilib
# }}}

# compiler settings {{{
Windows := $(OS)

PC = fpc
PFLAGS = \
  -dUNICODE \
  -Fu$(fptest)/src \
  -Fu$(fptest)/3rdparty/epiktimer \
  -Fu$(apilib)/src \
  -Fu$(apilib)/Common \
  -Fu$(apilib)/COM \
  -Fu$(apilib)/Win32API \
  -Mobjfpc \
  -Px86_64 \
  -Twin64 \
  -XP$(if $(Windows),,x86_64-w64-mingw32-)

RCPP = fprcp
RCPPFLAGS = \
  -l PASCAL \
  -p "$(core_res);$(apilib)/Win32API"

RC = $(if $(Windows),windres,x86_64-w64-mingw32-windres)
RCFLAGS = \
  --verbose \
  --language=0411 \
  --include-dir=$(core_res) \
  $(if $(Windows),--use-temp-file,--no-use-temp-file)

RCCV = fpcres
RCCVFLAGS = \
  -of coff \
  --arch x86_64
# }}}

# file list {{{
objs := $(filter %.o %.or %.ppu %.res, \
  $(wildcard ./*) \
  $(wildcard ./*/*) \
  $(wildcard ./*/*/*) \
  $(wildcard ./*/*/*/*) \
)

test_dll := $(subst .lpr,.dll, \
  $(filter %.lpr, \
    $(wildcard $(test_dir)/plugin/*) \
  ) \
)
# }}}

.SUFFIXES: .rc .res # {{{
.rc.res:
	$(RC) $(RCFLAGS) --input=$< --output=$@ --preprocessor='$(RCPP) -i $< $(RCPPFLAGS)'
# }}}

.SUFFIXES: .res .obj # {{{
.res.obj:
	$(RCCV) $(RCCVFLAGS) --input $< --output $@
# }}}

.SUFFIXES: .lpr .dll # {{{
.lpr.dll:
	$(PC) $(PFLAGS) $<
# }}}

.PHONY: all # {{{
all:
	@echo 'Target:'
	@echo
	@echo '  clean'
	@echo '    remove compiled objects'
	@echo
	@echo '  core'
	@echo '    compile core application'
	@echo
	@echo '  core-debug'
	@echo '    compile core application (added debug symbol)'
	@echo
	@echo '  core-test'
	@echo '    compile core application for the test'
	@echo
	@echo '  setup'
	@echo '    download (or update) libraries from repositories'
	@echo
	@echo '  wiki'
	@echo '    download (or update) documented wiki from camellia repos'
	@echo
# }}}

.PHONY: clean # {{{
clean:
	$(RM) $(core_exe) $(core_obj) $(objs) $(test_dll)
# }}}

.PHONY: core # {{{
core: $(core_obj)
	$(PC) $(PFLAGS) $(core_dir) -O2 -WG -Xs $(core_exe:.exe=.lpr)
# }}}

.PHONY: core-debug # {{{
core-debug: $(core_obj)
	$(PC) $(PFLAGS) $(core_dir) -gh -gl -WG $(core_exe:.exe=.lpr)
# }}}

.PHONY: core-test # {{{
core-test: $(core_obj) $(test_dll)
	$(PC) $(PFLAGS) $(core_dir) -dTEST -WC $(core_exe:.exe=.lpr)
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
	   svn checkout --non-interactive --trust-server-cert \
	     https://jedi-apilib.svn.sourceforge.net/svnroot/jedi-apilib/jwapi/branches/2.4a '$(apilib)'; \
	 fi
# }}}

.PHONY: wiki # {{{
wiki:
	-if [ -d '$(wiki_dir)' ]; \
	 then \
	   (cd '$(wiki_dir)'; hg pull --update); \
	 else \
	   hg clone https://bitbucket.org/sasaplus1/camellia/wiki '$(wiki_dir)'; \
	 fi
# }}}

# vim:ft=make:fdm=marker:fen:
