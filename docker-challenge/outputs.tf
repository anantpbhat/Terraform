# produces an output value named "container_net_ip"
output "container_net_ip" {
  description = "Network IP of the Docker container"
  value       = docker_container.flaskcontainer.network_data[0].ip_address
}

# produces an output value named "container_int_ports"
output "container_int_ports" {
  description = "Docker container internal port"
  value       = docker_container.flaskcontainer.ports[0].internal
}

# produces an output value named "container_ext_ports"
output "container_ext_ports" {
  description = "Docker container external port"
  value       = docker_container.flaskcontainer.ports[0].external
}
