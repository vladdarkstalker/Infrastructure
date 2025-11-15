resource "yandex_compute_instance" "this" {
  name = var.instance_name
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  metadata = {
    user-data = templatefile("${path.module}/cloudinit.yaml", {
      ubuntu_public_key  = chomp(file(var.ubuntu_public_key_path))
      ansible_public_key = chomp(file(var.ansible_public_key_path))
    })
  }
}
