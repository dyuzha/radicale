#!/bin/bash

# Функция для вывода помощи
show_help() {
    echo "Использование:"
    echo -e "\t$0 <команда> [опции]"
    echo "Команды:"
    echo "  help        Показать эту справку"
    echo "  backup      Создать бэкап"
    echo "  run         Запусить контейнер"
    echo "  build       Собрать образ"
    echo "  term        Подключиться к существующему контейнеру"
    echo "  restore     Загрузить из backup"
    exit 0
}

show_help
