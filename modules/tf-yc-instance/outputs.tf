output "instance_id" {
  description = "ID VM"
  value       = yandex_compute_instance.this.id
}

output "instance_name" {
  description = "VM Name"
  value       = yandex_compute_instance.this.name
}

output "external_ip_address" {
  description = "IP NAT VM"
  value       = yandex_compute_instance.this.network_interface[0].nat_ip_address
}
