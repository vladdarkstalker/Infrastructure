variable "yandex_zone" {
  description = "Yandex.Cloud network availability zones"
  type        = string
  default     = "ru-central1-a"
}

variable "yandex_cloud_id" {
  type        = string
  description = "Cloud ID"
}

variable "yandex_folder_id" {
  type        = string
  description = "Folder ID"
}

variable "image_id" {
  description = "Image ID for VM boot disk"
  type        = string
}