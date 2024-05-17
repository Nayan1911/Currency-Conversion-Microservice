resource "kubernetes_deployment" "currency_exchange" {
  metadata {
    name      = "currency-exchange"
    namespace = "default"
    labels = {
      app = "currency-exchange"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "currency-exchange"
      }
    }

    template {
      metadata {
        labels = {
          app = "currency-exchange"
        }
      }

      spec {
        container {
          name  = "currency-exchange"
          image = "sharmanayan/currency-exchange:0.0.1-RELEASE"

          # Use "port" argument instead of a block
          port {
            container_port = 8000
          }

          # Use "resources" argument with "requests" and "limits" as nested arguments
          resources {
            requests = {
              cpu    = "100m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "1024Mi"
            }
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 8000
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            failure_threshold     = 5
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8000
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            failure_threshold     = 5
          }
        }
      }
    }
  }
}
