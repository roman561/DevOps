provider "aws" { 
  region = "ua-east-1"  
} 
 
# First EC2 instance with Prometheus stack, Node-exporter and Cadvisor-exporter installed 
resource "aws_instance" "server_1" { 
  ami           = "ami-0c94855ba95c71c99" 
  instance_type = "t2.micro" 
  key_name      = "my-ec2-key" 
  tags = { 
    Name = "server-1" 
  } 
 
  provisioner "remote-exec" { 
    inline = [ 
      "sudo apt-get update", 
      "sudo apt-get install -y curl gnupg2", 
      "curl https://packages.grafana.com/gpg.key | sudo apt-key add -", 
      "echo 'deb https://packages.grafana.com/oss/deb stable main' | sudo tee /etc/apt/sources.list.d/grafana.list", 
      "sudo apt-get update", 
      "sudo apt-get install -y prometheus prometheus-node-exporter cadvisor", 
      "sudo systemctl enable prometheus", 
      "sudo systemctl start prometheus", 
      "sudo systemctl enable prometheus-node-exporter", 
      "sudo systemctl start prometheus-node-exporter", 
      "sudo systemctl enable cadvisor", 
      "sudo systemctl start cadvisor" 
    ] 
  } 
} 
 
# Second EC2 instance with Node-exporter and Cadvisor-exporter installed via user data and remote-exec 
resource "aws_instance" "server_2" { 
  ami           = "ami-0c94855ba95c71c99" 
  instance_type = "t2.micro" 
  key_name      = "my-ec2-key" 
  tags = { 
    Name = "server-2" 
  } 
 
  user_data = <<-EOF 
              #!/bin/bash 
              sudo apt-get update 
              sudo apt-get install -y curl gnupg2 
              curl https://packages.grafana.com/gpg.key | sudo apt-key add - 
              echo 'deb https://packages.grafana.com/oss/deb stable main' | sudo tee /etc/apt/sources.list.d/grafana.list 
              sudo apt-get update 
              sudo apt-get install -y prometheus-node-exporter cadvisor 
              sudo systemctl enable prometheus-node-exporter 
              sudo systemctl start prometheus-node-exporter 
              sudo systemctl enable cadvisor 
              sudo systemctl start cadvisor 
              EOF 
 
  provisioner "remote-exec" { 
    inline = [ 
      "sudo systemctl start prometheus-node-exporter", 
      "sudo systemctl start cadvisor" 
    ] 
  } 
} 
 
