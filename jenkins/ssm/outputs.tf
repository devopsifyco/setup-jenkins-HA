output "document_instance_creation_arn" {
  value = aws_ssm_document.instance_creation.arn
}

output "document_instance_removal_arn" {
  value = aws_ssm_document.instance_removal.arn
}