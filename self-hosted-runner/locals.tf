locals {
  nic_ip            = "${var.network_prefix}.83"
  network_config    = "ip=${local.nic_ip}/24,gw=${var.network_prefix}.1"
  nameserver_config = "${var.network_prefix}.88"
  nic_mac           = var.mac_address
}