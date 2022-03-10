.DEFAULT_GOAL := all

tex: 
	@echo "Compiling output/main.tex ...";
	@pandoc --from markdown \
          --to latex \
          --output main.tex \
          --template config/template.tex \
          config/config.yaml \
          sections/*.md

pdflatex:
	@pdflatex main.tex

pdflatex-2:
	@pdflatex main.tex

pdflatex-3:
	@pdflatex main.tex

bibtex:
	@bibtex main

clean-aux:
	@rm main.aux main.log main.out main.spl main.bbl main.blg

pdf: pdflatex bibtex pdflatex-2 pdflatex-3 clean-aux

clean:
	rm main.*

all: tex pdf