packer {
  required_version = ">= 1.7.0"
  required_plugins {
    qemu = {
      version = "~> 1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "null" "dependencies" {
  communicator = "none"
}

source "qemu" "training-container" {
  iso_url      = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  iso_checksum = "file:https://cloud-images.ubuntu.com/jammy/current/SHA256SUMS"

  output_directory = "images"

  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout  = "10m"

  shutdown_command = "sudo -S shutdown -P now"

  disk_compression = true
  disk_image       = true
  disk_size        = "20G"

  headless = true
  qemu_img_args {
    create = ["-F", "qcow2"]
  }
  qemuargs = [
    ["-machine", "ubuntu,accel=kvm"],
    ["-cpu", "host"],
    ["-serial", "mon:stdio"],
    ["-device", "virtio-gpu-pci"],
    ["-drive", "file=output-cloudimg/packer-cloudimg,format=qcow2"],
    ["-drive", "file=seeds.iso,format=raw"],
  ]
}

build {
  name    = "training-container.deps"
  sources = ["source.null.dependencies"]

  provisioner "shell-local" {
    inline = [
      "cloud-localds seeds.iso cloud-init/user-data cloud-init/meta-data"
    ]
  }
}

build {
  name = "registry"

  source "source.qemu.training-container" {
    vm_name = "training-container-registry.img"
  }

  provisioner "shell" {
    inline = ["which cloud-init && time cloud-init status --wait"]
  }

  provisioner "shell" {
    execute_command = "sudo -S env {{ .Vars }} {{ .Path }}"
    script          = "./install_registry.sh"
  }
}
