# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db_dumps

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  help                   This help"
	@echo "  composer               Run composer              eg. make composer require laravel/framework"
	@echo "  phpversion             Print PHP version"
	@echo "  build                  Build environment"
	@echo "  start                  Start environment"
	@echo "  stop                   Stop environment"
	@echo "  mysqldump              Dump database"
	@echo "  mysqlrestore           Restore databasedump"

composer:
	@docker exec php$(PHP_VERSION) composer $(filter-out $@,$(MAKECMDGOALS))

build:
	docker-compose build

start:
	docker-compose up -d

stop:
	docker-compose down

phpversion:
	@docker exec php$(PHP_VERSION) php -v

mysqldump:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec database_$(strip $(DB_TYPE))_$(strip $(DB_VERSION)) mysqldump -u root -p$(DB_ROOT_PASSWORD) ${DB_DATABASE} > $(MYSQL_DUMPS_DIR)/${DB_DATABASE}.sql

mysqlrestore:
	@docker exec -i database_$(strip $(DB_TYPE))_$(strip $(DB_VERSION)) mysql -u root -p$(DB_ROOT_PASSWORD) ${DB_DATABASE} < $(MYSQL_DUMPS_DIR)/${DB_DATABASE}.sql
