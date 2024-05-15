resource "kubernetes_ingress" "currency_exchange" {
  metadata {
    name      = "currency-exchange-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.currency_exchange.metadata[0].name
            service_port = kubernetes_service.currency_exchange.spec[0].port[0].port
          }
        }
      }
    }
  }
}
