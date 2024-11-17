variable "name" {
  description = "Name of a Google Cloud Project"
  default     = "europa"
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