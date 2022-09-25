/* main.tf
   Alta3 Research - rzfeeser@alta3.com */

# terraform block
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

// interact with docker
provider "docker" {}

resource "docker_network" "ansible-net" {
  name = "ansible-net"
  ipam_config {
    subnet = "10.10.2.0/24"
  }
}

// create our image
resource "docker_image" "fry" {
  name         = "ssh-fry:latest"
  keep_locally = true
  build {
    path = "/home/student/mycode/ansible-tf/" # path to Dockerfile
    tag  = ["ssh-fry"]
    build_arg = {
      user : "fry"
    }
  }
}

resource "docker_container" "fry" {
  name     = "fry"
  image    = docker_image.fry.name
  hostname = "fry"

  networks_advanced {
    name         = docker_network.ansible-net.name
    aliases      = ["ansible-net"]
    ipv4_address = "10.10.2.4"
  }
}

// create our image
resource "docker_image" "bender" {
  name         = "ssh-bender:latest"
  keep_locally = true
  build {
    path = "/home/student/mycode/ansible-tf/" # path to Dockerfile
    tag  = ["ssh-bender"]
    build_arg = {
      user : "bender"
    }
  }
}

resource "docker_container" "bender" {
  name     = "bender"
  image    = docker_image.bender.name
  hostname = "bender"

  networks_advanced {
    name         = docker_network.ansible-net.name
    aliases      = ["ansible-net"]
    ipv4_address = "10.10.2.3"
  }
}

// create our image
resource "docker_image" "zoidberg" {
  name         = "ssh-zoidberg:latest"
  keep_locally = true
  build {
    path = "/home/student/mycode/ansible-tf/" # path to Dockerfile
    tag  = ["ssh-zoidberg"]
    build_arg = {
      user : "zoidberg"
    }
  }
}

resource "docker_container" "zoidberg" {
  name     = "zoidberg"
  image    = docker_image.zoidberg.name
  hostname = "zoidberg"

  networks_advanced {
    name         = docker_network.ansible-net.name
    aliases      = ["ansible-net"]
    ipv4_address = "10.10.2.5"
  }
}
