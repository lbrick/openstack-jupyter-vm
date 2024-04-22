# Create instance
resource "openstack_compute_instance_v2" "jupyter_instance" {
  name            = "jupyter-demo-instance"
  flavor_id       = var.instance_flavor_id
  key_pair        = var.key_pair
  security_groups = ["default", "ssh-allow-all", "8888 Port"]

  block_device {
    uuid                  = var.instance_image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    volume_size           = var.instance_volume_size
    delete_on_termination = true
  }

  network {
    name = var.tenant_name
  }
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "instance_floating_ip" {
  pool  = "external"
}

# Assign floating ip
resource "openstack_compute_floatingip_associate_v2" "instance_floating_ip_association" {
  floating_ip  = openstack_networking_floatingip_v2.instance_floating_ip.address
  instance_id  = openstack_compute_instance_v2.jupyter_instance.id
}

# Generate ansible hosts
locals {
  host_ini_all = templatefile("${path.module}/templates/all-hosts.tpl", {
    instance_floating_ip = openstack_networking_floatingip_v2.instance_floating_ip.address,
    instance_hostname = "support-test-instance"
    vm_private_key_file = var.key_file
  })
}

# Generate ansible host.ini file
locals {
  host_ini_content = templatefile("${path.module}/templates/host.ini.tpl", {
    instance_floating_ip = openstack_networking_floatingip_v2.instance_floating_ip.address,
    instance_hostname = "support-test-instance"
    vm_private_key_file = var.key_file
  })
}

resource "local_file" "host_ini" {
  filename = "../host.ini"
  content  = "${local.host_ini_all}\n${local.host_ini_content}"
  file_permission = "0644"
}
