terraform {
  required_providers {
    twc = {
      # Используем зеркало Timeweb, а не registry.terraform.io
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.4.4"
}

provider "twc" {
  token = var.timeweb_token
}