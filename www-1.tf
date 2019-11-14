resource "digitalocean_droplet" "www-1" {
    image = "ubuntu-14-04-x64"
    name = "www-1"
    region = "nyc3"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
  connection {
      user = "root"
      type = "ssh"
      private_key = "${file(var.pvt_key)}"
      timeout = "2m"
          host = self.ipv4_address
  }
  provisioner "remote-exec" {
    inline = [
      # install nginx
      "sudo apt-get update",
      "sudo apt-get -y install nginx"
    ]
  }
}
