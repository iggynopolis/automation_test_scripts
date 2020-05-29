variable "aviatrix_fqdn_mode" {}
variable "aviatrix_fqdn_status" {}
variable "aviatrix_fqdn_tag" {}
variable "aviatrix_fqdn_gateway" {}

variable "aviatrix_fqdn_source_ip_list" {
  type = list(string)
}
variable "aviatrix_fqdn_domain" {
  type = list(string)
}
variable "aviatrix_fqdn_protocol" {
  type = list(string)
}
variable "aviatrix_fqdn_port" {
  type = list(string)
}
variable "aviatrix_fqdn_action" {
  type = list(string)
}
