provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "kubernetes_deployment" "currency_conversion_deployment" {
  metadata {
    name      = "currency-conversion"
    namespace = "default"
    labels = {
      app = "currency-conversion"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "currency-conversion"
      }
    }

    template {
      metadata {
        labels = {
          app = "currency-conversion"
        }
      }

      spec {
        containers {
          name  = "currency-conversion"
          image = "sharmanayan/currency-conversion:0.0.1-RELEASE"

          ports {
            container_port = 8100
          }

          env {
            name  = "CURRENCY_EXCHANGE_SERVICE_HOST"
            value = kubernetes_service.currency_exchange_service.cluster_ip
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "currency_conversion_service" {
  metadata {
    name      = "currency-conversion"
    namespace = "default"
    labels = {
      app = "currency-conversion"
    }
  }

  spec {
    selector = {
      app = "currency-conversion"
    }

    port {
      protocol    = "TCP"
      port        = 8100
      target_port = 8100
    }

    type = "NodePort"
  }
}

resource "kubernetes_ingress" "currency_conversion_ingress" {
  metadata {
    name      = "currency-conversion-ingress"
    namespace = "default"
    labels = {
      app = "currency-conversion"
    }
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      host = "example.com" # Replace with your domain once you have one
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.currency_conversion_service.metadata[0].name
            service_port = kubernetes_service.currency_conversion_service.spec[0].port[0].port
          }
        }
      }
    }
  }
}
