all: compile adapt-rss

compile:
	cp bulma/css/bulma.css themes/roidelapluie.be/static/css
	hugo -t roidelapluie.be

adapt-rss:
	./adapt-rss.sh

serve:
	cp bulma/css/bulma.css themes/roidelapluie.be/static/css
	hugo serve -t roidelapluie.be
