#!/bin/bash

TARGET="$1"
TMPDIR="/tmp/radicale/backups/load_data/"

if ! mkdir -p "$TMPDIR/config" "$TMPDIR/data"; then
    echo "Ошибка: не удалось создать временные директории"
    exit 1
fi

if ! tar -xzf "$TARGET" -C "$TMPDIR"; then
    echo "Ошибка: не удалось распаковать архив директории"
    exit 1
fi

if ! mkdir -p ./config .data; then
    echo "Ошибка: не удалось создать целевые директории"
    exit 1
fi

if ! rsync -a --delete "$TMPDIR/config/" ./config/; then
    "Ошибка: не удалось синхронизировать config"
    exit 1
fi

if ! rsync -a --delete "$TMPDIR/data/" ./data/; then
    "Ошибка: не удалось синхронизировать data"
    exit 1
fi


echo "Успешная загрузка backup"
