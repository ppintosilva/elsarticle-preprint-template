.DEFAULT_GOAL := all

PDFFLAGS := -interaction=nonstopmode -halt-on-error

tex: 
	@echo "Step 1/5 - Run pandoc to generate main.tex";
	@pandoc --from markdown \
          --to latex \
          --output main.tex \
          --template config/template.tex \
          config/config.yaml \
          sections/*.md

# error handling adapted from https://tex.stackexchange.com/a/482137
pdflatex:
	@echo "Step 2/5 - Run pdflatex";
	@pdflatex $(PDFFLAGS) main.tex > main.txt \
		|| (grep -e '^!.*' -e "^l..*" --color=always main.txt && false)

pdflatex-2:
	@echo "Step 4/5 - Run pdflatex";
	@pdflatex $(PDFFLAGS) main.tex > /dev/null 2>&1

pdflatex-3:
	@echo "Step 5/5 - Run pdflatex to generate main.pdf";
	@pdflatex $(PDFFLAGS) main.tex > main.txt

bibtex:
	@echo "Step 3/5 - Run bibtex";
	@bibtex -terse main

clean-aux:
	@rm -f main.aux main.log main.out main.spl main.bbl main.blg

pdf: pdflatex bibtex pdflatex-2 pdflatex-3 clean-aux

clean:
	rm main.*

all: tex pdf
