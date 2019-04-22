+++
title = "GCP container registry and terraform provider docker"
date = 2019-04-22T23:32:47+02:00
lang = "en"
categories = ["cloud"]
tags = ["gcp", "docker"]
slug = "docker"

+++

Here are some snippets you can use to get the terraform docker provider to work
with terraform:

```hcl
# Your config
provider "google" {}

data "google_client_config" "default" {}

provider "docker" {
  registry_auth {
    address  = "gcr.io"
    username = "oauth2accesstoken"
    password = "${data.google_client_config.default.access_token}"
  }
}

data "google_container_registry_image" "myapp_tagged" {
  name = "${var.docker_image_myapp}"
  tag  = "${var.docker_image_tag_myapp}"
}

data "docker_registry_image" "myapp" {
  name = "${data.google_container_registry_image.myapp_tagged.image_url}"
}

data "google_container_registry_image" "myapp" {
  name   = "${var.docker_image_myapp}"
  digest = "${data.docker_registry_image.myapp.sha256_digest}"
}
```

Now you can use: `${data.google_container_registry_image.myapp.image_url}` in
as image to get your tagged image in your pods, and get predictable container
image update!

Your service account must have storage read access.

Note: this example is not complete (I did not include vars and google provider
auth).
