variable "azurerm_instances" {
}

variable "uname" {
}

variable "public_key" {
  default = "~/.ssh/openstack.pub"
}

variable "prefix" {
}

variable "network_name" {

}
variable "ntpservers" {
  default = ["0.pool.ntp.org", "1.pool.ntp.org", "2.pool.ntp.org"]
}

#search domain
variable "searchdomain" {
  default = "f5.com"
}
#BIG-IQ

#Default Azure DNS
variable "dnsresolvers" {
  default = "168.63.129.16"
}

variable "bigiq_ipaddress" {
  default = "23.102.174.99"
}

variable "bigiq_user" {
  default = "admin"
}

variable "bigiq_pass" {

}
variable "hypervisor_type" {
  default = "azure"
}
variable "lic_pool" {
  default = "MSP-LOADv4-LIC"
}
variable "specs" {
  default = {
    default = {
      location      = "westus2"
      name_rg       = "rm_bigip_rg"
      instance_type = "Standard_DS3_v2"
      environment   = "This env is using BIG-IP"
      owner         = "Remo Mattei"
      f5version     = "15.0.103000" # "14.1.203001"
      plan_name     = "f5-big-ltm-1slot-byol"
      offer         = "f5-big-ip-byol"
      product       = "f5-big-ip-byol"
      publisher     = "f5-networks"
      sku           = "f5-big-ltm-1slot-byol"
      skukey1       = "LTM"
      skukey2       = "5G"
      unitofMeasure = "yearly"
      storage_type  = "Premium_LRS"
      virtualnet    = ["10.0.0.0/16"]
      trust         = ["10.0.10.0/24"]
      untrust       = ["10.0.20.0/24"]
      mgmt          = ["10.0.30.0/24"]
      comp_name     = "bigip-14"
      default_gw    = "10.0.30.1"
      static_ip     = ["10.0.10.4", "10.0.20.4", "10.0.30.5"]
    }
    europe = {
      location      = "westeurope"
      name_rg       = "westeurope_rg"
      instance_type = "Standard_DS3_v2"
      environment   = "This env is using BIG-IP"
      owner         = "Remo Mattei"
      f5version     = "14.1.203001"
      plan_name     = "f5-big-ltm-1slot-byol"
      offer         = "f5-big-ip-byol"
      product       = "f5-big-ip-byol"
      publisher     = "f5-networks"
      sku           = "f5-big-ltm-1slot-byol"
      skukey1       = "LTM"
      skukey2       = "5G"
      unitofMeasure = "yearly"
      storage_type  = "Premium_LRS"
      virtualnet    = ["10.0.0.0/16"]
      trust         = ["10.0.40.0/24"]
      untrust       = ["10.0.50.0/24"]
      mgmt          = ["10.0.60.0/24"]
      default_gw    = "10.0.60.1"
      comp_name     = "mybigip"
      static_ip     = ["10.0.40.4", "10.0.50.4", "10.0.60.5"]
    }
    west = {
      location      = "westus2"
      name_rg       = "westus_rm_big_rg"
      instance_type = "Standard_DS4_v2"
      environment   = "This env is using BIG-IP"
      owner         = "Remo Mattei"
      f5version     = "15.1.002000"
      plan_name     = "f5-big-ltm-1slot-byol"
      offer         = "f5-big-ip-byol"
      product       = "f5-big-ip-byol"
      publisher     = "f5-networks"
      sku           = "f5-big-ltm-1slot-byol"
      skukey1       = "LTM"
      skukey2       = "5G"
      unitofMeasure = "yearly"
      storage_type  = "Premium_LRS"
      virtualnet    = ["10.0.0.0/8"]
      trust         = ["10.0.10.0/24"]
      untrust       = ["10.0.20.0/24"]
      mgmt          = ["10.0.30.0/24"]
      default_gw    = "10.0.30.1"
      comp_name     = "mybigip"
      static_ip     = ["10.0.10.4", "10.0.20.4", "10.0.30.5"]
      uname         = "azureuser"
    }
    central = {
      location      = "southcentralus"
      name_rg       = "centralus_rg"
      instance_type = "Standard_DS3_v2"
      environment   = "This env is using BIG-IP"
      owner         = "Remo Mattei"
      f5version     = "14.1.203001"
      plan_name     = "f5-big-ltm-1slot-byol"
      offer         = "f5-big-ip-byol"
      product       = "f5-big-ip-byol"
      publisher     = "f5-networks"
      sku           = "f5-big-ltm-1slot-byol"
      skukey1       = "LTM"
      skukey2       = "5G"
      unitofMeasure = "yearly"
      storage_type  = "Premium_LRS"
      virtualnet    = ["10.0.0.0/8"]
      trust         = ["10.0.1.0/24"]
      untrust       = ["10.0.2.0/24"]
      mgmt          = ["10.0.3.0/24"]
      default_gw    = "10.0.3.1"
      comp_name     = "mybigip"
      static_ip     = ["10.0.1.4", "10.0.2.4", "10.0.3.5"]
    }
  }
}

variable "banner" {
  default = " 8888888888 888888888    F5 BOX   888888b    d88888b Y88b   d88P "
}
variable "login_ssh_banner" {
  default = "NOTICE: This is for authorized users only and it is managed by Terraform and Ansible"
}
## Please check and update the latest DO URL from https://github.com/F5Networks/f5-declarative-onboarding/releases
# always point to a specific version in order to avoid inadvertent configuration inconsistency
variable DO_URL {
  description = "URL to download the BIG-IP Declarative Onboarding module"
  default     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.12.0/f5-declarative-onboarding-1.12.0-1.noarch.rpm"
  #default     = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.9.0/f5-declarative-onboarding-1.9.0-1.noarch.rpm"
}
## Please check and update the latest AS3 URL from https://github.com/F5Networks/f5-appsvcs-extension/releases/latest
# always point to a specific version in order to avoid inadvertent configuration inconsistency
variable AS3_URL {
  description = "URL to download the BIG-IP Application Service Extension 3 (AS3) module"
  default     = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.19.0/f5-appsvcs-3.19.0-4.noarch.rpm"
  #default     = "https://github.com/F5Networks/f5-appsvcs-extension/releases/download/v3.16.0/f5-appsvcs-3.16.0-6.noarch.rpm"
}
## Please check and update the latest TS URL from https://github.com/F5Networks/f5-telemetry-streaming/releases/latest
# always point to a specific version in order to avoid inadvertent configuration inconsistency
variable TS_URL {
  description = "URL to download the BIG-IP Telemetry Streaming Extension (TS) module"
  default     = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.11.0/f5-telemetry-1.11.0-1.noarch.rpm"
  #default     = "https://github.com/F5Networks/f5-telemetry-streaming/releases/download/v1.8.0/f5-telemetry-1.8.0-1.noarch.rpm"
}
variable "libs_dir" {
  description = "Directory on the BIG-IP to download the A&O Toolchain into"
  default     = "/config/cloud/azure/node_modules"
}

variable onboard_log {
  description = "Directory on the BIG-IP to store the cloud-init logs"
  default     = "/var/log/startup-script.log"
}
