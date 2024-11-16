variable "resource_group1" {
    default = "HCL-Noida-RG01"
    description = "this resource will be used for Dev environment"
}

variable "storage_account" {
    default = "assddfffgg765g12"
}

variable "nsg" {
    default = "HCL-Noida-VM01-nsg01"
}

variable "vnet" {
  default = "HCL-Noida-VNET01"
}

variable "subnet1" {
    default = "HCL-Noida-SUBNET01"
}

variable "subnet2" {
    default = "HCL-Noida-SUBNET02"
}

variable "nic" {
  default = "HCL-Noida-VM01-nic01"
}

variable "vm_name" {
 default = "HCL-Noida-VM01"
}

variable "vm_username" {
  default = "ADMIN01"
}

variable "vm_password" {
  default = "Admin01@123456"
}