variable "instance-name" {
  description = "Name of the instance"
  default     = "europa"
}

variable "instance-size" {
  description = "Instance size"
  default     = "e2-micro"
}

variable "id" {
  description = "ID of a Google Cloud Project. Can be omitted and will be generated automatically"
  default     = ""
}

variable "project_id" {
  type        = string
  description = "project id"
  default     = ""
}

variable "region" {
  type        = string
  description = "Region of policy"
  default     = "europe-west2"
}