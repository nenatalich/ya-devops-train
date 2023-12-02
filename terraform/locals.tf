locals {
  network_id = yandex_vpc_network.default.id
  subnet_id = yandex_vpc_subnet.subnet.id
  bingo-1_ip = yandex_compute_instance.bingo-1.network_interface.0.ip_address
  bingo-2_ip = yandex_compute_instance.bingo-2.network_interface.0.ip_address
  nginx_ip = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
  db-master_ip = yandex_compute_instance.db-master.network_interface.0.ip_address
  db-slave_ip = yandex_compute_instance.db-slave.network_interface.0.ip_address
  monitoring_ip = yandex_compute_instance.monitoring.network_interface.0.nat_ip_address
}
