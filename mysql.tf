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

resource "helm_release" "mysql_database" {
  name       = "mysql"
  repository = "oci://registry-1.docker.io/bitnamicharts/mysql"
  chart      = "mysql"
  version    = "8.8.6"

  values = [
    "${file("mysql-values.yaml")}"
  ]
}