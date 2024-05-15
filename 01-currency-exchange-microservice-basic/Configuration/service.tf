resource "kubernetes_service" "currency_exchange" {
  metadata {
    name      = "currency-exchange"
    namespace = "default"
    labels = {
      app = "currency-exchange"
    }
  }

  spec {
    selector = {
      app = "currency-exchange"
    }

    port {
      port        = 8000
      target_port = 8000
    }

    type = "NodePort"
  }
}
