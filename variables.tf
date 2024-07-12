variable "name" {
  description = "(Required) The name of the target group."
  type        = string
}

variable "port" {
  description = "(Optional) The port on which targets receive traffic. Default: 80. Valid from 1 to 65534."
  type        = number
  default     = 80
  validation {
    condition     = var.port > 0 && var.port < 65535
    error_message = "port must be between 1 and 65534"
  }
}

variable "protocol" {
  description = "(Required) The protocol to use for routing traffic to the targets. Accepted values: TCP | PROXY_TCP | HTTP | HTTPS. The protocol you use determines which type of load balancer is applicable. APPLICATION Load Balancer Accepted values: HTTP | HTTPS, NETWORK Load Balancer Accepted values : TCP, NETWORK_PROXY Load Balancer Accepted values : PROXY_TCP."
  type        = string
  validation {
    condition     = contains(["TCP", "PROXY_TCP", "HTTP", "HTTPS"], var.protocol)
    error_message = "protocol must be one of TCP, PROXY_TCP, HTTP, or HTTPS"
  }
}

variable "description" {
  description = "(Optional) The description of the target group."
  type        = string
  default     = null
}

variable "health_check" {
  description = <<EOF
  (Optional) The health check to check the health of the target.
  - cycle - (Optional) The number of health check cycle. Default: 30. Valid from 5 to 300.
  - down_threshold - (Optional) The number of health check failure threshold. You can determine the number of consecutive health check failures that are required before a health check is considered a failed state. Default: 2. Valid from 2 to 10.
  - up_threshold - (Optional) The number of health check normal threshold. You can determine the number of consecutive health checks that are required before health checks are considered success state. Default: 2. Valid from 2 to 10.
  - http_method - (Optional) The HTTP method for the health check. You can determine which HTTP method to use for health checks. If the health check protocol type is HTTP or HTTPS, be sure to enter it. Accepted values: HEAD | GET.
  - port - (Optional) The port to use for health checks. Default: 80. Valid from 1 to 65534.
  - protocol - (Required) The type of protocol to use for health checks. If the target group protocol type is TCP or PROXY_TCP, Heal Check Protocol is only valid for TCP. If the target group protocol type is HTTP or HTTPS, Heal Check Protocol is valid only for HTTP and HTTPS.
  - url_path - (Optional) The URL path of the health check. Valid only if Health Check protocol type is HTTP or HTTPS. URL path must begin with /.
  EOF
  type = object({
    cycle          = optional(number)
    down_threshold = optional(number)
    up_threshold   = optional(number)
    http_method    = optional(string)
    port           = optional(number)
    protocol       = string
    url_path       = optional(string)
  })
  default = null
}

variable "target_type" {
  description = "(Optional) The type of target to be added to the target group."
  type        = string
  default     = null
}

variable "vpc_no" {
  description = "(Required) The ID of the VPC in to create the target group."
  type        = string
}

variable "use_sticky_session" {
  description = "(Optional) Whether to use session specific access."
  type        = bool
  default     = false
}

variable "use_proxy_protocol" {
  description = "(Optional) Whether to use a proxy protocol. Valid only available if the target group type selected is TCP | HTTP | HTTPS."
  type        = bool
  default     = false
  validation {
    condition     = var.use_proxy_protocol == true && contains(["TCP", "HTTP", "HTTPS"], var.protocol)
    error_message = "use_proxy_protocol must be true only if the target group type selected is TCP | HTTP | HTTPS"
  }
}

variable "algorithm_type" {
  description = "(Optional) The type of algorithm to use for load balancing. Accepted values: RR(Round Robin) | SIPHS(Source IP Hash) | LC(Least Connection) | MH(Maglev Hash). RR | SIPHS | LC are valid only if the target group type is PROXY_TCP, HTTP or HTTPS. MH | RR are valid only if the target group type is TCP."
  type        = string
  default     = null
  validation {
    condition     = var.algorithm_type == null || contains(["RR", "SIPHS", "LC", "MH"], var.algorithm_type)
    error_message = "algorithm_type must be one of RR, SIPHS, LC, or MH"
  }
}