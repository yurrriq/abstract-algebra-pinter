LATEXMKFLAGS := -pdfxe -Werror
ifneq (,$(findstring B,${MAKEFLAGS}))
LATEXMKFLAGS += -gg
endif

.PHONY: all clean clobber watch

# all: ../docs/exercises.pdf
all: exercises.pdf

clean:
	@ latexmk -c

clobber:
	@ latexmk -C

watch:
	@ latexmk ${LATEXMKFLAGS} -pvc -new-viewer- exercises

# ../docs/%.pdf: %.tex
%.pdf: $(wildcard *.tex)
	@ latexmk ${LATEXMKFLAGS} $*
