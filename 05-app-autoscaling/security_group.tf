#------------------- WEB SERVER --------------------------------

resource "aws_security_group" "web" {
  name        = "Web"
  description = "Permitir acesso publico de entrada"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80 # PERMITIR HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443 # PERMITIR HTTPS
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1 # PERMITIR MONITORAMENTO ICMP
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306 # PERMITIR BANCO DE DADOS
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.this["pvt_a"].cidr_block]
  }

  tags = merge(local.common_tags, { Name = "Web Server" })

}

#------------------- BANCO DE DADOS --------------------------------

resource "aws_security_group" "db" {
  name        = "DB"
  description = "Permitir conexoes de entrada para o banco de dados"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 3306 # PERMITIR BANCO DE DADOS
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    from_port   = 22 # PERMITIR SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1 # PERMITIR MONITORAMENTO ICMP
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 80 # PERMITIR HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443 # PERMITIR HTTPS
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Database MySQL" })

}

resource "aws_security_group" "elb" {
  name        = "ELB"
  description = "Load Balancer SG"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80 # PERMITIR HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 # PERMITIR TUDO
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Elastic Load Balancer" })

}

resource "aws_security_group" "autoscaling" {
  name        = "Autoscaling"
  description = "Security Group para o Autoscaling"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 80 # PERMITIR HTTP
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]
  }

  ingress {
    from_port   = 22 # PERMITIR SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0 # PERMITIR TUDO
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Auto Scaling" })

}

resource "aws_security_group" "jenkins" {
  name        = "Jenkins"
  description = "Habilitar acesso a instancia do Jenkins"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 22 # PERMITIR SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1 # PERMITIR MONITORAMENTO ICMP
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port       = 22 # PERMITIR SSH INTERNO
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  tags = merge(local.common_tags, { Name = "Jenkins Instance" })

}