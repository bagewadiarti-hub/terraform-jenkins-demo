variable "conatiner_name" {
  description = "Name for the ngnix container"
  type = string
  default = "jenkins-terraform-ngnix"
}
variable "external_port" {
  description = "Port to expose ngnix on"
  type = number
  default = 8090
}
