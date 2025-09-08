#!/bin/bash
sudo kill -9 `sudo lsof -t -i:3000`

echo "🚀 Начинаем сборку Nuxt проекта..."

echo "🗑️  Удаляем кэш и старые зависимости..."
rm -rf .nuxt node_modules package-lock.json

echo "📦 Устанавливаем зависимости..."
npm install

echo "🔨 Собираем проект..."
npm run build

echo "✅ Сборка завершена успешно!"

echo "✅ запускаем проект успешно!"
npm run dev
