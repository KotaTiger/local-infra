resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sample" {
  description = "example security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = false
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    protocol    = "tcp"
    self        = "false"
    to_port     = "443"
  }

  name   = "sample-sg-elb"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "ecs-blue-green" {
  description = "blue green deploy for ecs security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = false
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "5000"
    protocol    = "tcp"
    self        = "false"
    to_port     = "5000"
  }

  name   = "blue-green-sg-for-alb"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "rolling-update" {
  description = "fargate-sg-for-alb"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = false
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  name   = "fargate-demo-sg-for-alb"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "ecs-service" {
  egress {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    from_port        = 0
    protocol         = "-1"
    self             = false
    to_port          = 0
  }
  ingress {
    cidr_blocks      = []
    from_port        = 5000
    protocol         = "tcp"
    security_groups  = [
      aws_security_group.rolling-update.id
    ]
    self             = false
    to_port          = 5000
  }
  ingress {
    cidr_blocks      = []
    from_port        = 80
    protocol         = "tcp"
    security_groups  = [
      aws_security_group.rolling-update.id
    ]
    self             = false
    to_port          = 80
  }
  name                   = "ecs-service" 
  vpc_id                 = aws_vpc.main.id
}

resource "aws_security_group" "aurora-postgres-sg" {
  description = "aurora-postgres blue-green deploy security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    protocol    = "tcp"
    self        = "false"
    to_port     = "443"
  }

  ingress {
    cidr_blocks = ["59.138.14.224/32"]
    from_port   = "5432"
    protocol    = "tcp"
    self        = "false"
    to_port     = "5432"
  }

  name   = "aurora-postgres-sg"
  vpc_id = aws_vpc.main.id
}