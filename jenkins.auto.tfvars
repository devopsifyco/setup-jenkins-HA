# context auto.var
enabled     = true
namespace   = "demo"
stage       = "jenkins"
environment = "bro"
region      = "us-east-1"
#ASG
instance_type             = "t3.micro"
health_check_type         = "EC2"
wait_for_capacity_timeout = "25m"
max_size                  = 1
min_size                  = 1
desired_capacity          = 1
#VPC
cidr            = "10.99.0.0/18"
public_subnets  = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
private_subnets = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
egress_rules    = ["all-all"]
ingress_with_cidr_blocks = [
  {
    from_port   = 8080
    to_port     = 8080
    protocol    = 6
    description = "jenkins server"
    cidr_blocks = "0.0.0.0/0"
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = 6
    description = "jenkins server"
    cidr_blocks = "0.0.0.0/0"
  }
]
public_key = "ssh-rsa /+/k3NAy45JuBVe3AYg/N3QUZ+xh5xj6OyBlU+///GY2L4KHxYumJWjJZUAGiNOlwWT0e5GOrMXqj3y9vt/H0q0d0FxlxzIWcDJYY/Ed/gBm4QO9cMf636xg05VG9F56Qmap8"
