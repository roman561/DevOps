output "ec_hostname" {
  value = module.ec2.hostname
}

output "ec_id" {
  value = module.ec2.id
}

output "ec_public_id" {
  value = module.ec2_public.id
}

output "ec_public_ip" {
  value = module.ec2_public.public_ip
}
