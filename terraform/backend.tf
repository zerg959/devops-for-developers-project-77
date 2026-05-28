terraform {
  backend "s3" {
    bucket = "terraform-state-hexlet"
    key    = "prod/terraform.tfstate"
    
    # Заглушка региона (обязательна, но не используется благодаря skip)
    region = "us-east-1"
    
    # === ОТКЛЮЧАЕМ ВСЕ ПРОВЕРКИ ДЛЯ S3-СОВМЕСТИМЫХ ХРАНИЛИЩ ===
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    
    # Критично: отключаем вызовы к AWS-сервисам, которых нет в Timeweb
    skip_s3_checksum            = true
    use_legacy_workflow         = false
    
    # Стиль путей для S3-совместимых хранилищ
    use_path_style = true

    # Эндпоинт Timeweb Cloud S3
    endpoints = {
      s3 = "https://s3.timeweb.cloud"
    }
    
    # Ключи передаются через -backend-config в terraform init
  }
}