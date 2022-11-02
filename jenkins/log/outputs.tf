output "log_creation" {
  value = module.instance_creation_logs.log_group_name
}

output "log_removal" {
  value = module.instance_removal_logs.log_group_name
}