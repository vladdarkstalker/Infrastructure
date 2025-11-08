output "yandex_vpc_subnets" {
  description = "Yandex.Cloud Subnets map"
  value       = data.yandex_vpc_subnet.default
} 

output "vm_external_ip" {
  description = "External IP of VM"
  value       = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
} 