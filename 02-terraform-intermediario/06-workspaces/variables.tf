variable "aws_region" {
  description = "Regiao AWS onde os recursos estao localizados"

  type = object({
    dev  = string
    prod = string
  })

  default = {
    dev  = "us-east-1"
    prod = "us-east-2"
  }
}

variable "instance" {
  description = "Configuracao de instancias de acordo com o Workspace"

  type = object({
    dev = object({
      ami    = string
      type   = string
      number = number
    })

    prod = object({
      ami    = string
      type   = string
      number = number
    })
  })

  default = {
    dev = {
      ami    = "ami-053b0d53c279acc90"
      type   = "t2.micro"
      number = 1
    }

    prod = {
      ami    = "ami-024e6efaf93d85776"
      type   = "t3.medium"
      number = 2
    }
  }
}