output "vm_external_ip" {
  description = "External IP of the VM"
  value       = module.vm.external_ip_address
}

output "vm_id" {
  description = "ID of the VM"
  value       = module.vm.instance_id
}

output "subnet_ids" {
  description = "Subnets of default network by zone"
  value       = module.network.subnet_ids
}
