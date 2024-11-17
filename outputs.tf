output "ip_ssh_key" {
  value = values(module.vm-instance)[*]
}