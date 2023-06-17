
output "instance_url" {
  description = "Lightsail public ip"
  value       = module.lightsail.ip_address["0"]
}