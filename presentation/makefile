all:
	pandoc presentation.md \
	    --pdf-engine=pdflatex \
	    -t beamer \
	    -V theme:Custom \
	    -V colortheme:orchid\
	    -V 'fontfamily: arev' \
	    --highlight-style=kate \
	    -o presentation.pdf
