#-----------------------------------------------------------
# Docker
#-----------------------------------------------------------

# Start docker containers
start:
	docker-compose start

# Stop docker containers
stop:
	docker-compose stop

# Recreate docker containers
up:
	docker-compose up -d

# Stop and remove containers and networks
down:
	docker-compose down

# Stop and remove containers, networks, volumes and images
clean:
	docker-compose down --rmi local -v

ultra-clean:
	rm -rf $(wildcard node_modules/)
	rm -rf $(wildcard vendor/)
	rm $(wildcard composer.lock)
	docker-compose down --rmi local -v

# Restart all containers
restart: stop start

# Build and up docker containers
build:
	docker-compose build --progress=plain

# Build containers with no cache option
build-no-cache:
	docker-compose build --no-cache

# Build and up docker containers
rebuild: build up

env:
	[ -f .env ] && echo .env exists || cp .env.example .env

#-----------------------------------------------------------
# Linter
#-----------------------------------------------------------
pint:
	./vendor/bin/sail pint -v --test

# Fix code directly
pint-hard:
	./vendor/bin/sail pint -v

stan:
	./vendor/bin/sail bin phpstan analyse

lint:
	./vendor/bin/sail bin php-cs-fixer fix --diff -v

test:
	./vendor/bin/sail php artisan co:cle
	./vendor/bin/sail php artisan ca:cle
	./vendor/bin/sail php artisan test --type-coverage --min=100 --profile

#check: pint lint analyze test
check: pint lint test
style: pint-hard lint
