/* outputs.tf
   outputs to display */

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server1.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server1.public_ip
}
output "instance_root_disk" {
  description = "Root device of EC2 Instance"
  value       = aws_instance.app_server1.root_block_device[0].device_name
}
