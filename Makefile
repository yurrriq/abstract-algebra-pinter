LATEXMKFLAGS := -cd -pdfxe -Werror
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

${PREFIX}/exercises.pdf: src/exercises.tex $(filter-out src/exercises.tex, $(wildcard src/*.tex))
	@ mkdir -p $(@D)
	@ latexmk ${LATEXMKFLAGS} -outdir=$(@D) $<
