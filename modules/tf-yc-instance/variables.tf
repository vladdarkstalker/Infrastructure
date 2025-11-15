variable "instance_name" {
  description = "VM Name"
  type        = string
}

variable "zone" {
  description = "Network availability zones"
  type        = string
  default     = "ru-central1-a"
}

variable "platform_id" {
  description = "VM Platform"
  type        = string
  default     = "standard-v1"
}

variable "cores" {
  description = "vCPU Count"
  type        = number
  default     = 2
}

variable "memory" {
  description = "RAM Size"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Disk Size"
  type        = number
  default     = 20
}

variable "image_id" {
  description = "Image ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "preemptible" {
  description     = "Preemptible VM"
  type        = bool
  default = false
}

variable "ubuntu_public_key_path" {
  description = "Path to SSH key for ubuntu"
  type        = string
}

variable "ansible_public_key_path" {
  description = "Path to SSH key for ansible"
  type        = string
}


