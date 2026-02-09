variable "REGISTRY" { default = "docker.io" }
variable "NAMESPACE"  { default = "binarycodes" }

variable "APP_NAME" { default = "vaadin-addon-demo" }
variable "APP_VERSION" { default = "1.0-SNAPSHOT" }

group "default" {
  targets = ["image"]
}

target "image" {
  context    = "."
  dockerfile = "Dockerfile"

  args = {
    APP_NAME    = "${APP_NAME}"
    APP_VERSION = "${APP_VERSION}"
  }

  labels = {
    "org.opencontainers.image.title" = "${APP_NAME}"
    "org.opencontainers.image.description" = "Demo app to showcase Vaadin add-ons"
    "org.opencontainers.image.version" = "${APP_VERSION}"
  }

  tags = [
    "${REGISTRY}/${NAMESPACE}/${APP_NAME}:${APP_VERSION}",
    "${REGISTRY}/${NAMESPACE}/${APP_NAME}:latest",
  ]
}

target "image-all" {
  inherits = ["image"]
  platforms = ["linux/amd64", "linux/arm64"]
}
