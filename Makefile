open: talk.html
	sensible-browser $<

all: talk.html talk.tex talk.pdf talk-handout.pdf talk-notes.pdf

talk.html: talk.json reveal.js
	pandoc --standalone --slide-level=2 --to revealjs \
		--css style.css --filter ./filters/transform-notes.hs \
		-S -o $@ $<

talk.tex: talk.json
	pandoc --standalone --slide-level=2 --to beamer \
		--filter ./filters/transform-notes-beamer.hs \
		-o $@ $<

talk.pdf: talk.json
	pandoc --standalone --slide-level=2 --to beamer \
		--filter ./filters/transform-notes-beamer.hs \
		--latex-engine=xelatex --latex-engine-opt=--shell-escape \
		-o $@ $<

talk-notes.pdf: talk.json
	pandoc --standalone --slide-level=2 --to beamer \
		--filter ./filters/transform-notes-beamer.hs \
		--latex-engine=xelatex \
		--metadata='classoption:notes=only' \
		-o $@ $<

talk-handout.pdf: talk.json
	pandoc --standalone --to latex \
		--latex-engine=xelatex \
		-o $@ $<

talk.json: talk.org
	pandoc -S --standalone --to json -o $@ $<

reveal.js:
	git submodule update --init

clean:
	git clean -dXf

.PHONY: all clean open
