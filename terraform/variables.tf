variable "tenant_name" {
  description = "FlexiHPC project Name"
  default = "NeSI-Rebase-Sandbox"
}

variable "auth_url" {
  description = "FlexiHPC authentication URL"
  default = "https://keystone.akl-1.cloud.nesi.org.nz/v3"
}

variable "region" {
  description = "FlexiHPC region"
  default = "akl-1"
}

variable "key_pair" {
  description = "FlexiHPC SSH Key Pair name"
}

variable "key_file" {
  description = "Path to local SSH private key associated with Flexi key_pair, used for provisioning"
}

variable "instance_flavor_id" {
  description = "FlexiHPC Flavor ID for support test instance, Defaults to balanced1.2cpu4ram"
  default     = "6b2e76a8-cce0-4175-8160-76e2525d3d3d" 
}

variable "instance_image_id" {
  description = "FlexiHPC Image ID for support test instance, Defaults to NeSI-FlexiHPC-CentOS_Stream-9"
  default     = "2d862f07-99fa-456f-b398-66ddc9683cd4" 
}

variable "instance_volume_size" {
  description = "The size of the support test volume in gigabytes, defaults to 30"
  default     = "30" 
}

variable "vm_user" {
  description = "FlexiHPC VM user"
  default = "cloud-user"
}
