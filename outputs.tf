output "sagemaker_endpoints_id" {
  description = "Map of id values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_endpoints_arn" {
  description = "Map of arn values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_endpoints_deployment_config" {
  description = "Map of deployment_config values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => one(v.deployment_config) if v.deployment_config != null && length(v.deployment_config) > 0 }
}
output "sagemaker_endpoints_endpoint_config_name" {
  description = "Map of endpoint_config_name values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.endpoint_config_name if v.endpoint_config_name != null && length(v.endpoint_config_name) > 0 }
}
output "sagemaker_endpoints_name" {
  description = "Map of name values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.name if v.name != null && length(v.name) > 0 }
}
output "sagemaker_endpoints_region" {
  description = "Map of region values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_endpoints_tags" {
  description = "Map of tags values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_endpoints_tags_all" {
  description = "Map of tags_all values across all sagemaker_endpoints, keyed the same as var.sagemaker_endpoints"
  value       = { for k, v in aws_sagemaker_endpoint.sagemaker_endpoints : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

