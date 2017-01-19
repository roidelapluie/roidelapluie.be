HUGO_VERSION ?= 0.18.1
HUGO ?= ./hugo-bin

all: compile adapt-rss

compile:
	cp bulma/css/bulma.css themes/roidelapluie.be/static/css
	$(HUGO) -t roidelapluie.be

adapt-rss:
	./adapt-rss.sh

serve:
	cp bulma/css/bulma.css themes/roidelapluie.be/static/css
	$(HUGO) serve -t roidelapluie.be

install:
	wget https://github.com/spf13/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz
	tar xvf hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz hugo_$(HUGO_VERSION)_linux_amd64/hugo_$(HUGO_VERSION)_linux_amd64
	mv hugo_$(HUGO_VERSION)_linux_amd64/hugo_$(HUGO_VERSION)_linux_amd64 hugo-bin
	rmdir hugo_$(HUGO_VERSION)_linux_amd64
	chmod +x hugo-bin

clean:
	rm -rf public

deploy: clean all
	cd public && \
		git init && \
		touch .nojekyll && \
		git add . && \
		git config user.name "Travis CI" && \
		git config user.email "travis@roidelapluie.be" && \
		git commit -m "Hugo output" && \
		git push -f git@github.com:roidelapluie/roidelapluie.github.io master
