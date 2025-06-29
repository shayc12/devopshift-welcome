
output "vm_public_ip" {
  value = azurerm_public_ip.pip-shay.ip_address
  depends_on = [time_sleep.wait_for_ip]
  description = "Public IP address of the VM"
}