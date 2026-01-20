source "azure-arm" "ubuntu" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  managed_image_resource_group_name = "az-3-tire-rg"
  managed_image_name                = var.image_name

  location = var.location
  vm_size  = "Standard_DS2_v3"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"

  ssh_username = "packer"
}

build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = ["sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get -y install nginx curl unzip git",
      "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash ",
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync",
      "wget https://download.agent.dev.azure.com/agent/4.266.2/vsts-agent-linux-x64-4.266.2.tar.gz",
      "mkdir myagent && cd myagent",
      "tar zxvf ~/Downloads/vsts-agent-linux-x64-4.266.2.tar.gz"
    ]
    inline_shebang = "/bin/sh -x"
  }
}
