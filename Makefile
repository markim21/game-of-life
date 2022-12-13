.PHONY: test check

build:
	dune build

code:
	-dune build
	code .
	! dune build --watch

zip:
	rm -f game-of-life.zip
	zip -r game-of-life.zip .

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

play:
	OCAMLRUNPARAM=b dune exec bin/main.exe

doc:
	dune build @doc

opendoc: doc
	@bash opendoc.sh