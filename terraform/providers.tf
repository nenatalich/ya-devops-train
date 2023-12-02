provider "yandex" {
  service_account_key_file = file(var.service_account_key_file)
  folder_id                = var.folder_id
  cloud_id                 = var.cloud_id
  zone                     = "ru-central1-a"
}
