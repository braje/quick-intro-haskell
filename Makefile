FLAGS=--standalone -t revealjs --section-divs --template=template.html --no-highlight
VARS=--variable subtitle='An Ode to <a href="http://learnyouahaskell.com">Learn You a Haskell</a>'

all: index.html

index.html: lyah.md
	pandoc $(FLAGS) $(VARS) lyah.md -o index.html
