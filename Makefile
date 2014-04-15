FLAGS=--standalone -t revealjs --section-divs --template=template.html --no-highlight
VARS=

all: index.html

index.html: index.md
	pandoc --standalone $(FLAGS) $(VARS) index.md -o index.html
