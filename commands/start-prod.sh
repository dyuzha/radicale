#!/bin/bash

CONTAINER_NAME=${CONTAINER_NAME:-"radicale-radicale-1"}

container_exists() {
    # Проверка существования контейнера
    docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"
}


container_running() {
    # Проверка запущен ли контейнер
    docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"
}


check_config() {
    # Проверка наличия конфигурационного файла
    [ -f "./config/config" ] || {
        echo "Ошибка: отсутствует файл конфигурации ./config/config"
        return 1
    }
}


start_container() {
    # Создать новый контейнер
    docker compose up -d
}


# Проверяем, существует ли контейнер
if container_exists; then
    if container_running; then
        echo "Контейнер '${CONTAINER_NAME}' уже запущен"
    else
        echo "Запускаем существующий контейнер '${CONTAINER_NAME}'..."
        docker start $CONTAINER_NAME
    fi
else
    echo "Контейнер не найден. Создаем новый... '${CONTAINER_NAME}'..."
    if check_config; then
        start_container
    else
        echo "Файл ./config/config не найден"
        echo "Добавьте базовую конфигурацию или загрузите backup"
        echo "С помощюью '$0 restore <radicale-backup.tar.gz>'"
    fi

fi
