/* Locals configuration */

locals {
    billing_account_id    = var.billing_account_id != "" ? var.billing_account_id : null
    billing_name          = var.billing_name != "" ? var.billing_name : null
    project_org_id        = var.folder_id != "" ? null : var.org_id
    project_folder_id     = var.folder_id != "" ? var.folder_id : null
    project_id            = format("%s-%s", var.project_name, var.project_id_appendix)
}

data "google_billing_account" "account" {
    provider = google-beta
    billing_account = local.billing_account_id
    display_name = local.billing_name
}

/* Project creation */

resource "google_project" "project" {
    name                = var.project_name
    project_id          = local.project_id
    billing_account     = data.google_billing_account.account.id
    org_id              = local.project_org_id
    folder_id           = local.project_folder_id
}

/* Members with premitive roles creation*/

resource "google_project_iam_member" "owners" {
  count   = length(var.owners)
  project = google_project.project.project_id
  role    = "roles/owner"
  member  = element(var.owners, count.index)
}

resource "google_project_iam_member" "editors" {
  count   = length(var.editors)
  project = google_project.project.project_id
  role    = "roles/editor"
  member  = element(var.editors, count.index)
}

resource "google_project_iam_member" "viewers" {
  count   = length(var.viewers)
  project = google_project.project.project_id
  role    = "roles/viewer"
  member  = element(var.viewers, count.index)
}

/* Budget creation */

resource "google_billing_budget" "budget" {
  provider = google-beta
  billing_account = data.google_billing_account.account.id
  display_name = "Budget for ${var.project_name}"

  budget_filter {
    projects = ["projects/${google_project.project.project_id}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units = var.budget_amount
    }
  }

  dynamic "threshold_rules" {
    for_each = var.budget_alert_spent_percents
    content {
      threshold_percent = threshold_rules.value
    }
  }
}