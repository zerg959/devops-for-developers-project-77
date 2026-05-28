variable "s3_access_key" {
  description = "S3 Access Key"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "S3 Secret Key"
  type        = string
  sensitive   = true
}

variable "timeweb_token" {
  description = "API Token for Timeweb Cloud"
  type        = string
  sensitive   = true
}