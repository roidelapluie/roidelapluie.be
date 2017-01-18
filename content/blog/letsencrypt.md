+++
title = "This blog runs a Let's Encrypt certificate"
lang = "en"
categories = ["Blog"]
tags = ["ssl", "security"]
slug = "letsencrypt"
date = "2015-10-28T08:43:26"
+++

I am part of the [Let's Encrypt](https://letsencrypt.org) beta test. As part of it,
I generated a SSL certificate for my blog, and it is now live.

In the past I used [Startssl](https://cert.startcom.org/) to get free certificates.
Those certificates expired in September. At that time I switched to a [Comodo](https://comodo.com)
certificate, because the validity was only 3 months and I hoped Let's Encrypt to
be there before the end of the year.

And it came. Here is how it works: you have [a tool](https://github.com/letsencrypt/letsencrypt)
to get your certificates. You run the tool, you agree the TOS and then you give
your email address and the domains that will be covered by the certificate.

After that, you need to put a file in http://example.com/.well-known/acme-challenge/
to check that you are the owner of the domain. This is a poor verification proof
but this is the only way you can do that fast and automatically.

You need to serve a JSON file with a specific Content-Type header. I added the following
snippet to my apache vhost configuration:

```
<LocationMatch "/.well-known/acme-challenge/*">
  Header set Content-Type "application/jose+json"
</LocationMatch>
```

And then I got the certificates. As I expected, it only contains the domain names.
No email, name or anything else. The certificates are valid for 3 months, so if
some SSL protocols become deprecated they will be able to switch all the certificates
in 3 months. That is probably the price to get a fully automated procedure.

Conclusion: it just works and I like it. It will not be a danger for the other CA
because most of the companies will want to have more fields in their certificates,
like Company name, and a longer validity.

