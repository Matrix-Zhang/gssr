variable "credentials_file_path" {
  description = "Location of the credentials to use."
  type        = string
  default     = "<YOUR ACCOUNT FILE>"
}

variable "region" {
  description = "The Google Cloud Platform region you want to deploy"
  type        = string
  default     = "asia-east2"
}

variable "region_zone" {
  description = "The The Google Cloud Platform region zone you want to deploy"
  type        = string
  default     = "asia-east2-c"
}

variable "project_name" {
  description = "The project name"
  type        = string
  default     = "<YOUR PROJECT ID>"
}

variable "image_id" {
  description = "The image id"
  type        = string
  default     = "<YOUR IMAGE ID>"
}

variable "machine_type" {
  description = "The vm machine_type"
  type        = string
  default     = "e2-standard-4"
}

variable "ssh_name" {
  description = "The user mame to login with ssh"
  type        = string
  default     = "<YOUR SSH PUBLIC KEY PATH>"
}

variable "ssh_public_key" {
  description = "The public_key to login with ssh"
  type        = string
  default     = "<YOUR SSH PUBLIC KEY PATH>"
}

variable "ssr_port" {
  description = "The ssr port"
  type        = number
  default     = 10086
}

variable "ssr_encrypt_method" {
  description = "The ssr encrypt method"
  type        = string
  default     = "chacha20-ietf-poly1305"
}

variable "ssr_password" {
  description = "The password of the ssserver to use"
  type        = string
  default     = "<YOUR SSR PASSWORD>"
}
