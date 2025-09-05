.PHONY: db-up db-down psql load test

db-up:
	docker compose up -d

db-down:
	docker compose down -v

psql:
	docker exec -it $$(docker ps -qf "ancestor=postgres:16") psql -U retailx -d retailx

load:
	# Initialised on container start via docker/init

test:
	psql -h localhost -U retailx -d retailx -f tests.sql

