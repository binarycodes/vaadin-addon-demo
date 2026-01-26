variable "REGISTRY" { default = "docker.io/binarycodes" }
variable "APP_NAME" { default = "vaadin-addon-demo" }
variable "APP_VERSION" { default = "1.0-SNAPSHOT" }

group "default" {
  targets = ["app"]
}

target "app" {
  context    = "."
  dockerfile = "Dockerfile"

  args = {
    APP_NAME    = "${APP_NAME}"
    APP_VERSION = "${APP_VERSION}"
  }

  tags = [
    "${REGISTRY}/${APP_NAME}:${APP_VERSION}",
    "${REGISTRY}/${APP_NAME}:latest",
  ]

  platforms = ["linux/amd64", "linux/arm64"]
}