.PHONY: build clean test doc

all: build

# boot should install the opam tool as well

update-vendor:
		opam update
		opam upgrade jbuilder
		opam upgrade core
		opam upgrade cryptokit
		opam upgrade alcotest
		opam upgrade odoc
		opam upgrade odig

vendor:
		opam install jbuilder
		opam install core
		opam install cryptokit
		opam install alcotest
		opam install odoc
		opam install odig

build:
		jbuilder build --dev

test: build
		jbuilder runtest --dev

doc: build
		jbuilder build @doc

cleanup:
		rm -fv *~
		rm -fv lib/*~
		rm -fv lib_test/*~
		rm -fv .*.un~
		rm -fv lib/.*.un~
		rm -fv lib_test/.*.un~

clean: cleanup
		jbuilder clean

install: build
		jbuilder install

uninstall:
		jbuilder uninstall

# END
