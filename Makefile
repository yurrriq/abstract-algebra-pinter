LATEXMKFLAGS := -cd -pdfxe
ifneq (,$(findstring B,${MAKEFLAGS}))
LATEXMKFLAGS += -gg
endif

PREFIX ?= ${CURDIR}/docs

.PHONY: all clean clobber watch

all: ${PREFIX}/exercises.pdf

install: all clean

clean:
	@ latexmk ${LATEXMKFLAGS} -c -f ${PREFIX}/exercises.pdf

clobber:
	@ rm -fr ${PREFIX}

watch:
	@ watchman-make -s 2 -p 'src/*.tex' 'src/*.bib' -t all

${PREFIX}/exercises.pdf: src/exercises.tex src/exercises.bib $(filter-out src/exercises.tex, $(wildcard src/*.tex))
	@ mkdir -p $(@D)
	@ latexmk ${LATEXMKFLAGS} -outdir=$(@D) -f $<

major minor patch:
	@ semver bump $@ $(file <VERSION) | tr -d '\n' | sponge VERSION
