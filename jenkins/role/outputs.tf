output "role_trigger_arn" {
  value = module.events_rule_instance_creation_removal_role.arn
}

output "role_execute_arn" {
  value = module.instance_creation_removal_role.arn
}

output "instance_profile" {
  value = module.cluster_role.instance_profile
}