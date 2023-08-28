provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "my-context"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "myapp"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "oci://registry-1.docker.io/bitnamicharts/mysql"
  chart      = "mysql"

  values = [
    "${file("mysql-values.yaml")}"
  ]
}