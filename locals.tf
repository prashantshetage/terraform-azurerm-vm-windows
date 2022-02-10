locals {
  default_name = lower("${var.client_name}-${var.environment}")
  vm_name      = coalesce(var.custom_name, "${local.default_name}-vm")

  ip_configuration_name = coalesce(var.custom_ipconfig_name, "${local.vm_name}-nic-ipconfig")

  custom_data_params  = "Param($ComputerName = \"${local.vm_name}\")"
  custom_data_content = "${local.custom_data_params} ${file(format("%s/files/tls12.ps1", path.module))}"

  admin_password_encoded = replace(replace(replace(replace(replace(var.admin_password, "&[^#]", "&#38;"), ">", "&#62;"), "<", "&#60;"), "'", "&#39;"), "\"", "&#34;")

  backup_resource_group_name = var.backup_policy_id != null ? split("/", var.backup_policy_id)[4] : null
  backup_recovery_vault_name = var.backup_policy_id != null ? split("/", var.backup_policy_id)[8] : null

  #key_vault_name = split("/", var.key_vault_id)[8]
}
