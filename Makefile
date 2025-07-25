.PHONY: status, start, build, stop, clear, clear-full, restart, rebuild, backup, term, help, restore


CONTAINER_NAME := radicale-radicale-1
ENV ?= prod


status:
	@docker ps -f name="^${CONTAINER_NAME}$$" \
		--format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

run:
	@echo "Запуск контейнера Radicale..."
	@docker compose -d up

start:
	@echo "Запуск Radicale..."
	@./commands/start-prod.sh

build:
	@echo "Сборка Radicale..."
	@./commands/build.sh

stop:
	@echo "Остановка Radicale..."
	@-docker stop ${CONTAINER_NAME} 2>/dev/null || true

clear:
	@echo "Удаление контейнера..."
	@-docker rm ${CONTAINER_NAME} 2>/dev/null || true

clear-full:
	@echo "Удаление контейнера и образа..."
	@-docker rmi ${CONTAINER_NAME} 2>/dev/null || true

restart: stop start

rebuild: stop clear build run

term:
	@echo "Подключение к ${CONTAINER_NAME}..."
	@docker exec -it ${CONTAINER_NAME} /bin/sh

logs:
	@docker logs -f ${CONTAINER_NAME}

backup:
	@echo "Создание backup"
	@./commands/backup.sh

restore:
	@echo "Загрузка из архива..."
	@./commands/restore.sh $(ARCHIVE)

help:
	@./commands/help.sh

