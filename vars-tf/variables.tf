variable "container_name" {
  description = "Value of the name for the Docker container"
  # basic types include string, number and bool
  type        = string
  default     = "AnantNginxContainer"
}

variable "int_port" {
  description = "Value of the name for internal Port"
  # basic types include string, number and bool
  type        = number
  default     = "80"
}

variable "ext_port" {
  description = "Value of the name for External Port"
  # basic types include string, number and bool
  type        = number
  default     = "8888"
}
