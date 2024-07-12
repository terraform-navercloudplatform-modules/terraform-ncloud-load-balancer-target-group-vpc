resource "ncloud_lb_target_group" "target_group" {
  name               = var.name
  port               = var.port
  protocol           = var.protocol
  description        = var.description
  health_check       = var.health_check
  target_type        = var.target_type
  vpc_no             = var.vpc_no
  use_sticky_session = var.use_sticky_session
  use_proxy_protocol = var.use_proxy_protocol
  algorithm_type     = var.algorithm_type
}