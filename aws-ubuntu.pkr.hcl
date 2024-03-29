packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-linux-aws"
  instance_type = "t2.micro"
  region        = "ap-southeast-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    environment_vars = [
      "FOO=hello world",
    ]

    scripts = [
      "scripts/install_software.sh",
    ]

    ## Cannot use both scripts and inline at the same time 
    #inline = [
    #  "sudo apt-get install -y apache2",
    #  "sudo systemctl enable apache2",
    #  "sudo systemctl start apache2",
    # "sudo sh -c 'echo Welcome to my Apache server > /var/www/html/index.html'"
    #]
  }

  provisioner "file" {
    source      = "sourcefile/"              # Copy all files and subdirs
    destination = "/var/www/html/"
  }
}

