output "zone_id" {
  description = "Private zone ID created"
  value       = local.zone_id
}
output "name_servers" {
  description = "A list of name servers in associated (or default) delegation set"
  value       = local.name_servers
}
output "zone_name" {
  description = "Route53 Hosted Zone domain name"
  value       = var.zone_name
}
