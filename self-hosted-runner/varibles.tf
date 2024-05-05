variable "pm_ip" {
  description = "IP of Proxmox server"
  type        = string
}

variable "pm_user" {
  description = "Proxmox User"
  type        = string
}

variable "pm_password" {
  description = "Password for user"
  type        = string
}

variable "pm_host" {
  description = "Proxmox Hostname"
  type        = string
}

variable "runner_name" {
  description = "Name of the self-hosted runner"
  type        = string
}

variable "network_prefix" {
  description = "Network prefix for the runner IP address - e.g. 192.168.1"
  type        = string
}

variable "mac_address" {
  description = "MAC address for the runner"
  type        = string
}