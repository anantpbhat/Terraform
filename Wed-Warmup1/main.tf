locals {  
  rgs = {
          "alpha" = "eastus"
          "bravo" = "southindia"
          "charlie" = "westus2"
  }
}

resource "null_resource" "dummy_rgs" {
  for_each = local.rgs
  triggers = {
               name = each.key
               region = each.value
  }
}
