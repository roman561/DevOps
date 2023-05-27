variable "basename" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "volume_size" {
  default     = 30
  type        = number
  description = "Size of the volume in gibibytes (GiB)"
}

variable "volume_type" {
  default     = "gp3"
  type        = string
  description = "Type of volume"
}

variable "instance_count" {
  type        = set(string)
  description = "Count of instances"
  default     = (["1", "2", "3"])
}

variable "ami" {
  type = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "associate_public_ip_address" {
  default     = false
  description = "Whether to associate a public IP address with an instance in a VPC."
}

variable "user_data" {
  type    = string
  default = ""
}