# produces an output value named "container_id"
output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

# produces an output value named "container_ip"
output "container_net" {
  description = "Network IP of the Docker container"
  value       = slice(docker_container.nginx.network_data, 0, 0)
}

# produces an output value named "image_id"
output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.id
}

# produces an output value named "image_id"
output "image_name" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.name
}
