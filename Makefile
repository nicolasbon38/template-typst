MAIN = main
TYPST = typst
TYPST_OPTIONS = --font-path fonts/

TYPFILES = $(wildcard *.typ)
BIBFILES = $(wildcard *.bib) $(wildcard cryptobib/*.bib)

all: $(MAIN).pdf

$(MAIN).pdf: $(TYPFILES) $(BIBFILES)
	$(TYPST) compile $(TYPST_OPTIONS) $(MAIN).typ

clean:
	rm $(MAIN).pdf

watch:
	$(TYPST) watch $(TYPST_OPTIONS) $(MAIN).typ

.PHONY: all clean watch
