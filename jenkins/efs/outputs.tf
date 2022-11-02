output "mount_target_ip" {
  value = module.efs.mount_target_ips
}

output "mount_target_dns" {
  value = module.efs.dns_name
}