variable "project_name" {
    description = ""
    type = string
}

variable "credentials_file_path" {
    default = ""
}
variable "project_id_appendix" {
    description = "id"
    type = string
    default = "id"
}

variable "org_id" {
    description = ""
    type = string
    default = ""
}

variable "folder_id" {
    description = ""
    type = string
    default = ""
}

variable "owners" {
    description = ""
    type = list
    default = []
}

variable "editors" {
    description = ""
    type = list
    default = []
}
variable "viewers" {
    description = ""
    type = list
    default = ["group:gcpgrp_666@googlegroups.com"]
}

variable "billing_account_id" {
    description = ""
    type = string
    default = ""
}

variable "billing_name" {
    description = ""
    type = string
    default = ""
}

variable "budget_amount" {
  description = "The amount to use as the budget"
  type        = number
  default     = 100
}

variable "budget_alert_spent_percents" {
  description = "A list of percentages of the budget to alert on when threshold is exceeded"
  type        = list(number)
  default     = [0.5, 0.7, 1.0]
}