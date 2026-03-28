#lets create our security group for alb
  #cr4eate a new file b1.alb-sg.tf copy line 3 till 29 on line 6 change my name to your name
  resource "aws_security_group" "alb_sg" {
  # ... other configuration ...
  ######allow ssh access from anywhere
  name   = "alb-sg-gopal"
  vpc_id = aws_vpc.sky_vpc.id
 
  # ... other configuration ...

  dynamic "ingress" {
    for_each = var.allowed_alb_ingress_ports
    content {
      description = "Allow ingress on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_alb_cidr_blocks 
    }
  }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #tcp, udp, icmp and all
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

#lets create the varaibles files for alb
  #lets create a new file b2.alb-port-varaibles.tf after this do terraform apply we are just opening port 80 and 443 for the load balancer
  variable "allowed_alb_ingress_ports" {
  type        = list(number)
  default     = [80, 443]
  description = "List of allowed ingress ports for the security group"

}

variable "allowed_alb_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of allowed CIDR blocks for ingress rules"

}
