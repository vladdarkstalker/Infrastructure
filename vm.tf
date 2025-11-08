resource "yandex_compute_instance" "vm-1" {
  name = "chapter5-lesson2-std-ext-023-27"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd853sqaosrb2anl1uve"
    }
  }

  network_interface {
    subnet_id = "e2l8h4e7l5abolnq29t8"
    nat       = true
  }

  metadata = {
    user-data = templatefile("${path.module}/cloudinit.yaml", {
      ubuntu_public_key  = chomp(file("C:/Users/boffi/.ssh/id_rsa.pub"))
      ansible_public_key = chomp(file("C:/Users/boffi/.ssh/id_ansible.pub"))
    })
  }
}
