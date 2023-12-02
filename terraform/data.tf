data "yandex_compute_image" "coi" {
  family = "ubuntu-2204-lts"
}

data "yandex_compute_image" "coi-container" {
  family = "container-optimized-image"
}
