variable "count" {
  default = 0
}

resource "random_pet" "training-vm" {
  keepers = {
    count = "${count.index}"
    image = "Ubuntu 18.04"
  }

  length = 2
  count  = "${var.count}"
}

resource "openstack_compute_instance_v2" "training-vm" {
  name            = "gat-${count.index}.training.galaxyproject.eu"
  image_name      = "Ubuntu 18.04"
  flavor_name     = "m1.xlarge"
  security_groups = ["public", "public-ping", "public-web2", "egress"]

  key_pair = "cloud2"

  network {
    name = "public"
  }

  # Update user password
  user_data = <<-EOF
    #cloud-config
    chpasswd:
      list: |
        ubuntu:${element(random_pet.training-vm.*.id, count.index)}
      expire: False
    runcmd:
     - [ sed, -i, s/PasswordAuthentication no/PasswordAuthentication yes/, /etc/ssh/sshd_config ]
     - [ systemctl, restart, ssh ]
  EOF

  count = "${var.count}"
}

output "training_ips" {
  value = ["${openstack_compute_instance_v2.training-vm.*.access_ip_v4}"]
}

output "training_pws" {
  value     = ["${random_pet.training-vm.*.id}"]
  sensitive = true
}

resource "aws_route53_record" "training-vm" {
  zone_id = "${var.zone_galaxyproject_eu}"
  name    = "gat-${count.index}.training.galaxyproject.eu"
  type    = "A"
  ttl     = "7200"
  records = ["${element(openstack_compute_instance_v2.training-vm.*.access_ip_v4, count.index)}"]
  count   = "${var.count}"
}

resource "aws_route53_record" "training-vm-gxit-wildcard" {
  zone_id = "${var.zone_galaxyproject_eu}"
  name    = "*.interactivetoolentrypoint.interactivetool.gat-${count.index}.training.galaxyproject.eu"
  type    = "CNAME"
  ttl     = "7200"
  records = ["gat-${count.index}.training.galaxyproject.eu"]
  count   = "${var.count}"
}

output "training_dns" {
  value = ["${aws_route53_record.training-vm.*.name}"]
}
