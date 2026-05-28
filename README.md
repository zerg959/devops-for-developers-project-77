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

### 1. Установка зависимостей
```bash
make setup