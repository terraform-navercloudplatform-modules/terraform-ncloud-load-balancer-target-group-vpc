output "id" {
  description = "The ID of target group."
  value       = ncloud_lb_target_group.target_group.id
}

output "target_group_no" {
  description = "The ID of target group (It is the same result as id)"
  value       = ncloud_lb_target_group.target_group.target_group_no
}

output "load_balancer_instance_no" {
  description = "The ID of the Load Balancer associated with the Target Group."
  value       = ncloud_lb_target_group.target_group.load_balancer_instance_no
}

output "target_no_list" {
  description = "The list of target number to bind to the target group."
  value       = ncloud_lb_target_group.target_group.target_no_list
}