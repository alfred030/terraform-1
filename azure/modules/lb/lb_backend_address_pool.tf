#-----------------------------------------------------------
# Azure lb backend address pool
#-----------------------------------------------------------
resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  count = var.enable_lb_backend_address_pool ? 1 : 0

  name            = var.lb_backend_address_pool_name != "" ? var.lb_backend_address_pool_name : "${lower(var.name)}-lb-backend-address-pool-${lower(var.environment)}"
  loadbalancer_id = var.lb_backend_address_pool_loadbalancer_id != "" ? var.lb_backend_address_pool_loadbalancer_id : (var.enable_lb ? azurerm_lb.lb[count.index].id : null)

  dynamic "tunnel_interface" {
    iterator = tunnel_interface
    for_each = var.lb_backend_address_pool_tunnel_interface

    content {
      tunnel_interface = lookup(tunnel_interface.value, "tunnel_interface", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.lb_nat_pool_timeouts)) > 0 ? [var.lb_nat_pool_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_lb.lb
  ]
}