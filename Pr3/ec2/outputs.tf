output "public_ip" {
  value = {
    for instance in var.instance_count :
    instance => aws_instance.instance[instance].public_ip
  }
}

output "private_ip" {
  value = {
    for instance in var.instance_count :
    instance => aws_instance.instance[instance].private_ip
  }
}

output "private_dns" {
  value = {
    for instance in var.instance_count :
    instance => aws_instance.instance[instance].private_dns
  }
}

output "hostname" {
  value = {
    for instance in var.instance_count :
    instance => aws_instance.instance[instance].private_dns
  }
}

output "id" {
  value = {
    for instance in var.instance_count :
    instance => aws_instance.instance[instance].id
  }
}

