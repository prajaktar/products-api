SHELL := /bin/bash

all: build db run

run: build
	docker-compose run --service-ports backend

dev: build
	docker-compose run --service-ports backend

build: .built .bundled

.built: Dockerfile.dev
	docker-compose build
	touch .built

.bundled: Gemfile Gemfile.lock
	docker-compose run backend bundle
	touch .bundled

stop:
	docker-compose stop

restart: build
	docker-compose restart backend

clean: stop
	rm -f tmp/pids/*
	rm -rf node_modules
	docker-compose rm -f -v bundle_cache
	rm -f .bundled
	docker-compose rm -f
	rm -f .built

test: build db
	docker-compose run backend rspec

db: build
	docker-compose run backend rails db:create db:migrate

drop-db: build
	docker-compose run backend rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1

.PHONY: all run build stop restart test db drop-db
