HUGO_VERSION ?= 0.18.1
HUGO ?= ./hugo-bin
JQUERY_VERSION ?= 3.1.1

all: compile adapt-rss

compile:
	$(HUGO) -t roidelapluie.be

adapt-rss:
	./adapt-rss.sh

serve:
	$(HUGO) serve -t roidelapluie.be

install:
	sudo apt-get install python3-pygments
	wget https://github.com/spf13/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz
	tar xvf hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz hugo_$(HUGO_VERSION)_linux_amd64/hugo_$(HUGO_VERSION)_linux_amd64
	mv hugo_$(HUGO_VERSION)_linux_amd64/hugo_$(HUGO_VERSION)_linux_amd64 hugo-bin
	rmdir hugo_$(HUGO_VERSION)_linux_amd64
	chmod +x hugo-bin
	wget -O themes/roidelapluie.be/static/js/jquery.min.js https://code.jquery.com/jquery-$(JQUERY_VERSION).min.js
	wget -O themes/roidelapluie.be/static/js/jquery.min.map https://code.jquery.com/jquery-$(JQUERY_VERSION).min.map

clean:
	rm -rf public

deploy: clean all
	cd public && \
		rm css/.gitignore && \
		rm fonts/.gitignore && \
		rm js/.gitignore && \
		git init && \
		touch .nojekyll && \
		git add . && \
		git config user.name "Travis CI" && \
		git config user.email "travis@roidelapluie.be" && \
		git commit -m "Hugo output" && \
		git push -f git@github.com:roidelapluie/roidelapluie.github.io master
