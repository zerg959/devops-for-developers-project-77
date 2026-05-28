#!/bin/bash
set -e

# === НАСТРОЙКА ПУТЕЙ ===
# Находим абсолютный путь к папке со скриптом
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Находим корень проекта
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# Путь к vault файлу
VAULT_FILE="$PROJECT_ROOT/ansible/vault_vars.yml"

# Переходим в папку с terraform
cd "$SCRIPT_DIR"

# === ИЗВЛЕЧЕНИЕ СЕКРЕТОВ ===
echo " Расшифровка секретов из Vault..."
# Парсим всё за один раз
VAULT_CONTENT=$(ansible-vault view "$VAULT_FILE")

TOKEN=$(echo "$VAULT_CONTENT" | awk -F'"' '/^timeweb_token:/ {print $2}')
S3_ACCESS=$(echo "$VAULT_CONTENT" | awk -F'"' '/^s3_access_key:/ {print $2}')
S3_SECRET=$(echo "$VAULT_CONTENT" | awk -F'"' '/^s3_secret_key:/ {print $2}')

# Проверка, что не пусто
if [[ -z "$TOKEN" || -z "$S3_ACCESS" || -z "$S3_SECRET" ]]; then
  echo "Ошибка: не удалось извлечь секреты из $VAULT_FILE"
  exit 1
fi
echo "Секреты готовы"

# === ЗАПУСК TERAFFORM ===
COMMAND="${1:-}"
shift 2>/dev/null || true

case "$COMMAND" in
  init)
    echo " terraform init..."
    terraform init \
      -backend-config="access_key=$S3_ACCESS" \
      -backend-config="secret_key=$S3_SECRET" \
      "$@"
    ;;
  plan|apply|destroy)
    echo "terraform $COMMAND..."
    terraform "$COMMAND" \
      -var="timeweb_token=$TOKEN" \
      "$@"
    ;;
  *)
    echo "Использование: $0 {init|plan|apply|destroy}"
    exit 1
    ;;
esac