# resource "tls_private_key" "ec2_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
# resource "aws_key_pair" "key_pair" {
#   key_name   = "demo_key"
#   public_key = "${tls_private_key.ec2_key.public_key_openssh}"
  
#   provisioner "local-exec" { 
#     command = "mkdir key"
#   }

#   provisioner "local-exec" { 
#     command = "powershell.exe Out-File -FilePath ./key/id.txt -InputObject ${tls_private_key.ec2_key.id}"
#   }

#   provisioner "local-exec" { 
#     command = "powershell.exe Out-File -FilePath ./key/id.txt -InputObject \"${tls_private_key.ec2_key.public_key_pem}\""
#   }

#   provisioner "local-exec" { 
#     command = "powershell.exe Out-File -FilePath ./key/id.txt -InputObject \"${tls_private_key.ec2_key.private_key_pem}\""
#   }

# #   provisioner "local-exec" { 
# #     # command = "chmod 400 ./key/myKey.pem"
# #     command = <<EOT
# #         icacls.exe ./key/myKey.pem /reset
# #         icacls.exe ./key/myKey.pem /grant:r "$($env.username):(r)"
# #         icacls.exe ./key/myKey.pem /inheritance:r
# #     EOT
# #   }

#   provisioner "local-exec" {
#     when    = destroy
#     # command = "rm -rf ./key"
#     command = "Remove-Item key -Recurse -Force -Confirm:$false"
#   }

#   lifecycle {
#     ignore_changes = [tags]
#   }
# }
