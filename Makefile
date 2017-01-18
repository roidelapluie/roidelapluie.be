build:
	cp bulma/css/bulma.css themes/roidelapluie.be/static/css
	hugo -t roidelapluie.be

serve:
	cp bulma/css/bulma.css themes/roidelapluie.be/static/css
	hugo serve -t roidelapluie.be
