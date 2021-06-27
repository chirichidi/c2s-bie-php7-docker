RUNTIME_TAG='chirichidi/git-repo-executor-php:0.1'

build:
	docker build . --tag ${RUNTIME_TAG}

push:
	docker login
	docker push ${RUNTIME_TAG}