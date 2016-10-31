open: talk.html
	sensible-browser $<

talk.html: talk.org reveal.js
	pandoc --standalone --slide-level=2 --to revealjs --css style.css -o $@ $<

talk.pdf: talk.org
	pandoc --standalone --slide-level=2 --to beamer -o $@ $<

talk-handout.pdf: talk.org
	pandoc --standalone --to latex -o $@ $<

reveal.js:
	git submodule update --init

clean:
	rm talk-handout.pdf talk.pdf talk.html

.PHONY: clean open
