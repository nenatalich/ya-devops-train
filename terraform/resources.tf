resource "yandex_vpc_network" "default" {}

resource "yandex_vpc_subnet" "subnet" {
  zone           = "ru-central1-a"
  network_id     = local.network_id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

resource "yandex_compute_instance" "bingo-1" {
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = local.subnet_id
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi-container.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_file_path)}"
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "bingo-2" {
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = local.subnet_id
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi-container.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_file_path)}"
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "db-master" {
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = local.subnet_id
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_file_path)}"
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "db-slave" {
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = local.subnet_id
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_file_path)}"
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "nginx" {
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = local.subnet_id
    nat       = true
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_file_path)}"
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "monitoring" {
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = local.subnet_id
    nat       = true
  }
  boot_disk {
    initialize_params {
      type     = "network-hdd"
      size     = "30"
      image_id = data.yandex_compute_image.coi.id
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_file_path)}"
  }
  allow_stopping_for_update = true
}

resource "local_file" "hosts" {
  content = templatefile(
    "${path.module}/hosts.tftpl",
    {
      bingo-1                     = local.bingo-1_ip,
      bingo-2                     = local.bingo-2_ip,
      nginx                       = local.nginx_ip,
      db-master                   = local.db-master_ip,
      db-slave                    = local.db-slave_ip,
      monitoring                  = local.monitoring_ip,
      private_key_file            = var.private_key_file_path,
      student_email               = var.student_email
      ya_service_account_key_file = var.ya_service_account_key_file
    })
  filename = "${path.module}/../ansible/hosts.yml"
}

resource "local_file" "db_vars" {
  content = templatefile(
    "${path.module}/db_vars.tftpl",
    {
      db_user        = var.db_user,
      db_password    = var.db_password,
      db_name        = var.db_name,
      replicant_pass = var.replicant_pass
    })
  filename = "${path.module}/../ansible/db_vars.yaml"
}
