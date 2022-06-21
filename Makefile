include .env

MYSQL_DUMPS_DIR=data/db_dumps

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  help                   This help"
	@echo "  composer               Run composer              eg. make composer require laravel/framework"
	@echo "  artisan                Laravel artisan           eg. make artisan make:controller UserController"
	@echo "  phpversion             Print PHP version"
	@echo "  build                  Build environment"
	@echo "  start                  Start environment"
	@echo "  stop                   Stop environment"
	@echo "  pause                  Pause environment"
	@echo "  resume                 Resume environment"
	@echo "  mysqldump              Dump database"
	@echo "  mysqlrestore           Restore databasedump"

artisan:
	docker exec ${COMPOSE_PROJECT_NAME}_php_$(PHP_VERSION) php artisan $(filter-out $@,$(MAKECMDGOALS))

composer:
	@docker exec ${COMPOSE_PROJECT_NAME}_php_$(PHP_VERSION) composer $(filter-out $@,$(MAKECMDGOALS))

build:
	docker-compose build

start:
	docker-compose up -d

stop:
	docker-compose down

pause:
	docker-compose pause

unpause:
	docker-compose unpause

phpversion:
	@docker exec php$(PHP_VERSION) php -v

mysqldump:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec ${COMPOSE_PROJECT_NAME}_database_$(strip $(DB_TYPE))_$(strip $(DB_VERSION)) mysqldump -u root -p$(DB_ROOT_PASSWORD) ${DB_DATABASE} > $(MYSQL_DUMPS_DIR)/${DB_DATABASE}.sql

mysqlrestore:
	@docker exec -i ${COMPOSE_PROJECT_NAME}_database_$(strip $(DB_TYPE))_$(strip $(DB_VERSION)) mysql -u root -p$(DB_ROOT_PASSWORD) ${DB_DATABASE} < $(MYSQL_DUMPS_DIR)/${DB_DATABASE}.sql
