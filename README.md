### Hexlet tests and linter status:
[![Actions Status](https://github.com/zerg959/devops-for-developers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/zerg959/devops-for-developers-project-77/actions)

# DevOps Project: Infrastructure + Deployment

## Требования
- Terraform >= 1.4
- Ansible >= 2.14
- Docker (для локального тестирования образа)

## Секреты
Все чувствительные данные хранятся в зашифрованном виде:
- `ansible/vault_vars.yml` — зашифрован Ansible Vault
- Пароль для расшифровки: хранится в `.vault_pass` (не коммитить!)

## Быстрый старт
Все основные команды вынесены в Makefile.
### 1. Установка зависимостей
Скачивает внешние роли (geerlingguy) и коллекции Ansible:
```bash
make install
```
### 2. Создание инфраструктуры (Terraform)
Инициализация:
```bash
cd terraform && ./tf.sh init
```
Просмотр плана изменений:
```bash
cd terraform && ./tf.sh plan
```
Создание серверов, БД и балансировщика:
```bash
cd terraform && ./tf.sh apply -auto-approve
```
### 3. Подготовка серверов
Установка необходимых пакетов (Python, Docker) на созданных серверах:
```bash
make prepare
```
### 4. Деплой приложения
Развертывание Docker-контейнеров и настройка сервисов:
```bash
make deploy
```
### 5. Удаление инфраструктуры
```bash
make destroy
```