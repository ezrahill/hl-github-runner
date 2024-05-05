terraform {
  required_version = "1.8.2"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      #latest version as of 26 Jan 2023
      version = "2.9.11"
    }
  }
}
