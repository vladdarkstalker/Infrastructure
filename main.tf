module "network" {
  source = "./modules/tf-yc-network"

  network_zones = [
    "ru-central1-a",
    "ru-central1-b",
  ]
}

module "vm" {
  source = "./modules/tf-yc-instance"

  instance_name           = "chapter5-lesson2-std-ext-023-27"
  zone                    = var.yandex_zone
  image_id                = var.image_id
  subnet_id               = module.network.subnet_ids[var.yandex_zone]
  ubuntu_public_key_path  = "C:/Users/boffi/.ssh/id_rsa.pub"
  ansible_public_key_path = "C:/Users/boffi/.ssh/id_ansible.pub"
}
