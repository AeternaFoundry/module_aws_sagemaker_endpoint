variable "sagemaker_endpoints" {
  description = <<EOT
Map of sagemaker_endpoints, attributes below
Required:
    - endpoint_config_name
Optional:
    - name
    - region
    - tags
    - tags_all
    - deployment_config (block):
        - auto_rollback_configuration (optional, block):
            - alarms (optional, block):
                - alarm_name (required)
        - blue_green_update_policy (optional, block):
            - maximum_execution_timeout_in_seconds (optional)
            - termination_wait_in_seconds (optional)
            - traffic_routing_configuration (required, block):
                - canary_size (optional, block):
                    - type (required)
                    - value (required)
                - linear_step_size (optional, block):
                    - type (required)
                    - value (required)
                - type (required)
                - wait_interval_in_seconds (required)
        - rolling_update_policy (optional, block):
            - maximum_batch_size (required, block):
                - type (required)
                - value (required)
            - maximum_execution_timeout_in_seconds (optional)
            - rollback_maximum_batch_size (optional, block):
                - type (required)
                - value (required)
            - wait_interval_in_seconds (required)
EOT

  type = map(object({
    endpoint_config_name = string
    name                 = optional(string)
    region               = optional(string)
    tags                 = optional(map(string))
    tags_all             = optional(map(string))
    deployment_config = optional(object({
      auto_rollback_configuration = optional(object({
        alarms = optional(list(object({
          alarm_name = string
        })))
      }))
      blue_green_update_policy = optional(object({
        maximum_execution_timeout_in_seconds = optional(number)
        termination_wait_in_seconds          = optional(number)
        traffic_routing_configuration = object({
          canary_size = optional(object({
            type  = string
            value = number
          }))
          linear_step_size = optional(object({
            type  = string
            value = number
          }))
          type                     = string
          wait_interval_in_seconds = number
        })
      }))
      rolling_update_policy = optional(object({
        maximum_batch_size = object({
          type  = string
          value = number
        })
        maximum_execution_timeout_in_seconds = optional(number)
        rollback_maximum_batch_size = optional(object({
          type  = string
          value = number
        }))
        wait_interval_in_seconds = number
      }))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        v.deployment_config == null || (v.deployment_config.auto_rollback_configuration == null || (v.deployment_config.auto_rollback_configuration.alarms == null || (length(v.deployment_config.auto_rollback_configuration.alarms) <= 10)))
      )
    ])
    error_message = "Each alarms list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        v.deployment_config == null || (v.deployment_config.blue_green_update_policy == null || (v.deployment_config.blue_green_update_policy.maximum_execution_timeout_in_seconds == null || (v.deployment_config.blue_green_update_policy.maximum_execution_timeout_in_seconds >= 600 && v.deployment_config.blue_green_update_policy.maximum_execution_timeout_in_seconds <= 14400)))
      )
    ])
    error_message = "must be between 600 and 14400"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        v.deployment_config == null || (v.deployment_config.blue_green_update_policy == null || (v.deployment_config.blue_green_update_policy.termination_wait_in_seconds == null || (v.deployment_config.blue_green_update_policy.termination_wait_in_seconds >= 0 && v.deployment_config.blue_green_update_policy.termination_wait_in_seconds <= 3600)))
      )
    ])
    error_message = "must be between 0 and 3600"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        v.deployment_config == null || (v.deployment_config.blue_green_update_policy == null || (v.deployment_config.blue_green_update_policy.traffic_routing_configuration.wait_interval_in_seconds >= 0 && v.deployment_config.blue_green_update_policy.traffic_routing_configuration.wait_interval_in_seconds <= 3600))
      )
    ])
    error_message = "must be between 0 and 3600"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        v.deployment_config == null || (v.deployment_config.rolling_update_policy == null || (v.deployment_config.rolling_update_policy.maximum_execution_timeout_in_seconds == null || (v.deployment_config.rolling_update_policy.maximum_execution_timeout_in_seconds >= 600 && v.deployment_config.rolling_update_policy.maximum_execution_timeout_in_seconds <= 14400)))
      )
    ])
    error_message = "must be between 600 and 14400"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        v.deployment_config == null || (v.deployment_config.rolling_update_policy == null || (v.deployment_config.rolling_update_policy.wait_interval_in_seconds >= 0 && v.deployment_config.rolling_update_policy.wait_interval_in_seconds <= 3600))
      )
    ])
    error_message = "must be between 0 and 3600"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_endpoints : (
        length(v.endpoint_config_name) <= 63
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  # Note: 14 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

