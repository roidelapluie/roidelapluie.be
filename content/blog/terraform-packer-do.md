+++
date = "2017-04-21T20:12:29+02:00"
slug = "digitalocean-terraform-packer"
tags = ["linux", "hashicorp"]
categories = ["cloud"]
lang = "en"
title = "A link between DigitalOcean, Packer and Terraform"

+++

In the coming months, I will run several workshops about Jenkins. Those
workshops will be hands-on, so people will bring their own laptops to hack on
Jenkins instances.

For that, I expect lots of them will simply run Jenkins on their laptops, or use
an external laptop. But, as a backup, or a primary solution, I plan to provision
multiple instances of Jenkins, ready to be used, in the cloud.

Amongst the cloud providers, [DigitalOcean](https://www.digitalocean.com/) is
great for this purpose: while it is feature limited, it is simple. Its pricing
model is simple too.

In the cloud, you run images. Like I will spin up a lot of them, I want to have
those images ready, so I just need to boot them and configure them. The tool for
that is [Packer](https://packer.io). Packer builds images. For DigitalOcean,
Docker, AWS, Virtualbox.. It has a great list of providers.

That part was easy. I've got my snapshots built quickly.

Then enters [Terraform](https://terraform.io). Terraform can deploy the
snapshots built by Packer. Just like this:

```
resource "digitalocean_droplet" "jenkins" {
  image = "1028374"
  count  = "${var.count}"
  name = "${format("jenkins%02d", count.index + 1)}"
  ssh_keys = [ "${var.do_ssh_key}" ]
  region = "${var.do_datacenter}"
  private_networking = "true",
  size = "512mb"
}
```

That configuration works but has a problem: the image parameter is an ID. For
Snapshots, you can not use name, slugs, you have to use id numbers. This is very
annoying, because I to not want the image 1028374, I want the image
"jenkins-1.0.0". Which is the name I defined in Packer.

## The workaround

Like lots of problems with open-source software, there is a workaround.
Terraform has an [external
datasource](https://www.terraform.io/docs/providers/external/data_source.html)
plugin. It can run any script. Here is mine:

```bash
#!/bin/bash -e
set -o pipefail
snapshots="$(eval $(jq -r '@sh "doctl -t=\(.api_token) compute snapshot list
\(.id) -o json"'))"
nr="$(echo "$snapshots"|jq '.|length')"
if [[ "$nr" -ne 1 ]]
then
    echo "Expected 1 snapshot, found $nr" >&2
    exit 1
fi
id="$(echo "$snapshots"|jq -r .[0].id)"
jq -r -n --arg id "$id" '{"id":$id}'
```

In Terraform:

```
data "external" "jenkins_snapshot" {
  program = ["./do_snapshot_id"]
  query {
    id = "jenkins-${var.do_jenkins_droplet_version}"
    api_token = "${var.do_api_token}"
  }
}

resource "digitalocean_droplet" "jenkins" {
  image = "${data.external.jenkins_snapshot.result.id}"
  count  = "${var.count}"
  name = "${format("jenkins%02d", count.index + 1)}"
  ssh_keys = [ "${var.do_ssh_key}" ]
  region = "${var.do_datacenter}"
  private_networking = "true",
  size = "512mb"
}
```

That is already better. I can now use the same name as the one I use in Packer.
No more meaningless ID's.

But this approach has multiple problems:

- Bash scripting is unreadable; it is just 10 lines but is a mess.
- It introduces jq and doctl as dependencies. So it will not work for everyone.
- It delegates the digitalocean credentials to multiple processes. I do not like
  that.

## The Solution

I ended up spending some time on an implementation in go. It is now [merged][p] en
Terraform, which means I had to write documentation and tests, so everyone can
use it now. Here is the DigitalOcean image datasource:

[p]:https://github.com/hashicorp/terraform/commit/c2a1e688cb19aef1ac76d7f360876824ce4f8c46

```
data "digitalocean_image" "jenkins" {
  name = "jenkins-${var.do_jenkins_droplet_version}"
}

resource "digitalocean_droplet" "jenkins" {
  image  = "${data.digitalocean_image.jenkins.image}"
  count  = "${var.count}"
  name = "${format("jenkins%02d", count.index + 1)}"
  ssh_keys = [ "${var.do_ssh_key}" ]
  region = "${var.do_datacenter}"
  private_networking = "true",
  size = "512mb"
}
```

It is a lot better. No external dependencies, bash scripts, and it is available
for everyone. And it is shorter and easier to understand.

I hope you will enjoy it. It will be available in the next release of Terraform
(0.9.4).
