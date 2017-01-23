compile-bootstrap:
	nvm install 4
	node --version
	npm --version
	nvm --version
	cp _custom.scss bootstrap/scss/_custom.scss && \
	cd bootstrap && npm install -g npm@3 && \
	&& bundle install --deployment --jobs=3 --retry=3 && \
	&& cp grunt/npm-shrinkwrap.json ./ && \
	&& npm install && \
	grunt

install-bootstrap: compile-bootstrap
	cp -rv bootstrap/dist/css/* themes/roidelapluie.be/static/css
	cp -rv bootstrap/dist/js/* themes/roidelapluie.be/static/js
