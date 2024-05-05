resource "proxmox_vm_qemu" "runner" {
  agent       = 1
  vmid        = 500
  name        = var.runner_name
  target_node = var.pm_host

  clone      = "ubuntu2204-temp"
  full_clone = "false"
  os_type    = "cloud-init"

  cores  = 2
  memory = 4096

  bootdisk = "scsi0"
  scsihw   = "virtio-scsi-pci"

  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = local.nic_mac
  }

  ipconfig0  = local.network_config
  nameserver = local.nameserver_config

  lifecycle {
    ignore_changes = [
      network.0.macaddr, # Ignore changes to macaddr
      sshkeys,           # Ignore changes to SSH keys
      disk,              # Ignore changes to disk attributes
      network,           # Ignore changes to network attributes
    ]
  }
  # cloud-init-runners.yaml > proxmox://var/lib/vz/snippets/runners.yaml
  cicustom = "vendor=local:snippets/runners.yaml"
}

resource "null_resource" "ansible_provisioner" {
  # Triggers to ensure the resource updates
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    # Use Heredoc syntax for clarity and correct command enclosure
    command = "ansible-playbook -i ${local.nic_ip}, ./ansible/playbook.yaml"

    environment = {
      ANSIBLE_VAULT_PASSWORD_FILE = "./ansible/password"
    }
  }
}
