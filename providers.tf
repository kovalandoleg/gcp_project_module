locals {
    credentials_file_path = var.credentials_file_path != "" ? file(
        var.credentials_file_path) : null
}

provider "google" {
    credentials = local.credentials_file_path
    version     = "~> 3.9.0"
}

provider "google-beta" {
    credentials = local.credentials_file_path
    version     = "~> 3.9.0"
}