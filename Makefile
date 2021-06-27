RUNTIME_TAG='chirichidi/c2s-bie-php7-docker'

build:
	docker build . --tag ${RUNTIME_TAG}

push:
	docker login
	docker push ${RUNTIME_TAG}