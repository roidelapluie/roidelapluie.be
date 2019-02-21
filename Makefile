HUGO_VERSION ?= 0.54.0
HUGO ?= ./hugo
JQUERY_VERSION ?= 3.1.1
VIS_VERSION ?= 4.19.1

all: compile adapt-rss

compile:
	$(HUGO) -F -t roidelapluie.be

adapt-rss:
	./adapt-rss.sh

serve:
	$(HUGO) serve -t roidelapluie.be

install:
	sudo apt-get install python3-pygments
	wget https://github.com/spf13/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz
	tar xvf hugo_$(HUGO_VERSION)_Linux-64bit.tar.gz hugo
#	wget https://github.com/roidelapluie/bootstrap/archive/compiled.tar.gz
#	tar xvf compiled.tar.gz
#	cp -rv bootstrap-compiled/dist/css/* themes/roidelapluie.be/static/css
#	cp -rv bootstrap-compiled/dist/js/* themes/roidelapluie.be/static/js
	chmod +x $(HUGO)
	wget -O themes/roidelapluie.be/static/css/vis.min.css https://cdnjs.cloudflare.com/ajax/libs/vis/$(VIS_VERSION)/vis.min.css
	wget -O themes/roidelapluie.be/static/js/vis.min.js https://cdnjs.cloudflare.com/ajax/libs/vis/$(VIS_VERSION)/vis.min.js
	wget -O themes/roidelapluie.be/static/js/jquery.min.js https://code.jquery.com/jquery-$(JQUERY_VERSION).min.js
	wget -O themes/roidelapluie.be/static/js/jquery.min.map https://code.jquery.com/jquery-$(JQUERY_VERSION).min.map

clean:
	rm -rf public

deploy: clean all
	./deploy.sh
