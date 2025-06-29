variable "location" {
  default = "East US"
}

variable "test" {
  type = string
}

variable "vm_size" {
  default = "Standard_B1ms"
}

variable "admin_username" {
  default = "adminuser-shay"
}

variable "admin_password" {
  default = "Password123!"
  sensitive = true
}

variable "env" {
    default = "shay"
  
}
