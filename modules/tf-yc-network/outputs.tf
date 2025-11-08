output "network_id" {
  description = "ID сети default"
  value       = data.yandex_vpc_network.default.id
}

output "subnet_ids" {
  description = "ID подсетей default-<zone> по всем зонам"
  value       = { for zone, s in data.yandex_vpc_subnet.subnets : zone => s.id }
}
