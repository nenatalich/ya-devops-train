# sensitive data, set in terraform.tfvars
variable "service_account_key_file" {}
variable "cloud_id" {}
variable "folder_id" {}
variable "public_key_file_path" {}
variable "private_key_file_path" {}
variable "student_email" {}
variable "ya_service_account_key_file" {}
variable "db_password" {}
variable "replicant_pass" {}

variable "db_name" {
  default = "bingo"
}
variable "db_user" {
  default = "bingo"
}
