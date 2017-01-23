compile-bootstrap:
	./compile-bootstrap.sh

install-bootstrap: compile-bootstrap
	cp -rv bootstrap/dist/css/* themes/roidelapluie.be/static/css
	cp -rv bootstrap/dist/js/* themes/roidelapluie.be/static/js
