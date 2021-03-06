# Create the virtual machine. Use the "count" variable to define how many
# to create.
resource "azurerm_linux_virtual_machine" "virtualmachine" {
  count                           = var.azurerm_instances
  name                            = title("${var.prefix}_machine_num_${count.index + 1}")
  admin_username                  = var.specs[terraform.workspace]["uname"]
  admin_password                  = random_password.dpasswrd.result
  computer_name                   = title("${var.specs[terraform.workspace]["comp_name"]}-${count.index + 1}")
  location                        = azurerm_resource_group.azmain.location
  resource_group_name             = azurerm_resource_group.azmain.name
  size                            = var.specs[terraform.workspace]["instance_type"]
  disable_password_authentication = false


  network_interface_ids = [
    element(azurerm_network_interface.Management.*.id, count.index),
    element(azurerm_network_interface.Untrust.*.id, count.index),
    element(azurerm_network_interface.Trust.*.id, count.index),
  ]

  # F5 resources
  source_image_reference {
    publisher = var.specs[terraform.workspace]["publisher"]
    offer     = var.specs[terraform.workspace]["offer"]
    sku       = var.specs[terraform.workspace]["sku"]
    version   = var.specs[terraform.workspace]["f5version"]
  }

  plan {
    name      = var.specs[terraform.workspace]["plan_name"]
    product   = var.specs[terraform.workspace]["product"]
    publisher = var.specs[terraform.workspace]["publisher"]
  }

  #Disk
  os_disk {
    name                 = "${var.prefix}-osdisk-${count.index}"
    storage_account_type = var.specs[terraform.workspace]["storage_type"]
    caching              = "ReadWrite"
  }

  custom_data = base64encode(data.template_file.vm_onboard.rendered)

  #SSH key push into the VM
  admin_ssh_key {
    username   = var.specs[terraform.workspace]["uname"]
    public_key = file(var.public_key)
  }
}
#
# Setup Onboarding scripts
data "template_file" "vm_onboard" {
  template = "${file("${path.module}/onboard.yml")}"
  vars = {
    uname = var.uname
    # replace this with a reference to the secret id
    upassword   = random_password.dpasswrd.result
    DO_URL      = var.DO_URL
    AS3_URL     = var.AS3_URL
    TS_URL      = var.TS_URL
    libs_dir    = var.libs_dir
    onboard_log = var.onboard_log
    #licenseType                 = ""
    bigip_hostname              = "mybigipbox"
    bigiq_license_host          = var.bigiq_ipaddress
    bigiq_license_username      = var.bigiq_user
    bigiq_license_password      = var.bigiq_pass
    bigiq_license_licensepool   = var.lic_pool
    bigiq_license_skuKeyword1   = var.specs[terraform.workspace]["skukey1"]
    bigiq_license_skuKeyword2   = var.specs[terraform.workspace]["skukey2"]
    bigiq_license_unitOfMeasure = var.specs[terraform.workspace]["unitofMeasure"]
    bigiq_hypervisor            = var.hypervisor_type
    name_servers                = var.dnsresolvers
    search_domain               = var.searchdomain
    default_gw                  = var.specs[terraform.workspace]["default_gw"]
    external_self_ip            = azurerm_network_interface.Trust[0].private_ip_address
    internal_self_ip            = azurerm_network_interface.Untrust[0].private_ip_address
  }
}
