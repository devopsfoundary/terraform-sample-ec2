provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYGISKITYSDY5ON7L"
  secret_key = "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"
}

variable "ami_id" {
  type = "map"

  default = {
    ubuntu = "ami-04b9e92b5572fa0d1"
    centos = "ami-00068cd7555f543d5"
  }
}

variable "instance_family" {
  type = "map"

  default = {
    test = "t2.nano"
    prod = "t2.micro"
  }
}

variable "instance_name" {
  description = "Name of the instance"
}

resource "aws_instance" "sample-server" {
  count = 2
  ami           = "${lookup(var.ami_id,"ubuntu")}"
  instance_type = "t2.micro"
  key_name      = "test_acc"

  tags = {
    Name = "${format("${var.instance_name}-%03d", count.index + 1)}"
  }
}

output "ip" {
  value = "${aws_instance.sample-server.*.public_ip}"
}

output "subnet" {
  value = "${aws_instance.sample-server.*.subnet_id}"
}



