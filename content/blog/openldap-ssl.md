+++
title = "Importing a CA into OpenLDAP"
lang = "en"
categories = ["Linux"]
tags = ["centos", "planet-inuits", "ldap"]
slug = "openldap-ca"
date = "2014-12-05T23:42:17"
+++


Here is a quick how to about OpenLDAP under CentOS 6 and a custom Certificate Authority..

OpenLDAP in CentOS 6 is built with NSS to deal with ssl/tls.

When you try to securely connect to a LDAP host that, you will get the following errors:

    :::text
    $ ldapsearch -H ldaps://172.28.5.5 -d -1
    [...snip...]
    TLS: certificate [CN=ldap.inuits.eu,OU=Infra,O=Inuits,ST=Antwerp,C=BE] is
    not valid - error -8179:Peer's Certificate issuer is not recognized..
    tls_write: want=7, written=7
      0000:  15 03 01 00 02
    TLS: error: connect - force handshake failure: errno 0 -
    moznss error -8179
    TLS: can't connect: TLS error -8179:Peer's Certificate issuer is not
    recognized..
    ldap_msgfree
    ldap_err2string
    ldap_sasl_interactive_bind_s: Can't contact LDAP server (-1)
            additional info: TLS error -8179:Peer's Certificate issuer
            is not recognized.


The first step is to get you CA certificates. For this post, let's assume that the CA file is called `rootCA.crt`. In real life, you will get several certificates like that.

If the certificate is in DES we will first need to convert it into PEM. This is optional if the certificate is already in a PEM format.

    :::bash
    openssl x509 -text -in rootCA.crt -inform des -outform pem > rootCA.pem

Once you have the certificat in PEM, you will need to compute the hash:

    ::text
    $ openssl x509 -in rootCA.pem -noout -hash
    e6adf2fd

You will get a hash, e.g `e6adf2fd`.

Move the certificate to the right directory, with the name `${hash}.0`:

    :::bash
    mv rootCA.prm /etc/openldap/cacerts/e6adf2fd.0

When you will to your LDAP search again with -1, you should see that the certificate is shown:

    :::text
    $ ldapsearch -H ldaps://172.28.5.5 -d -1
    [...snip...]
    TLS: loaded CA certificate file /etc/openldap/cacerts/e6adf2fd.0
    from CA certificate directory /etc/openldap/cacerts.
    [...snip...]

You can now safely use LDAPs with your own CA.
