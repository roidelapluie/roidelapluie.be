+++
title = "Mutt"
lang = "en"
categories = ["Linux"]
tags = ["mail", "Mutt", "planet-inuits"]
slug = "mutt"
date = "2015-05-09T21:29:49"
+++

In the past, I have used several mail clients, including [Thunderbird](https://www.mozilla.org/en-US/thunderbird/),
[Claws Mail](http://www.claws-mail.org/), [Alpine](https://www.washington.edu/alpine/) and [Evolution](https://help.gnome.org/users/evolution/stable/).

But since a few years, I have been using exclusively [Mutt](http://www.mutt.org/).
I would like to share pieces of configuration from my personal setup today.

### ~/.mutt/muttrc

    unset mark_old

With that line, Mutt will stop marking New email messages (`N`) as Old (`O`) when you change directory or exit. With that the flag will stay `N`. In my case it is useful because Conky only counts New email messages.

    set alias_file=~/.mutt/aliases
    source ~/.mutt/aliases


These lines tells Mutt than when I register an alias (using the `a` key), it will
by default save it into the aliases files. The `source` line means that there are
configurations directives in that alias file that needs to be loaded.

    alternates '^roidelapluie@example.com$'

I have a bunch of these. One line per email address I have. It allows Mutt to know
which email addresses are mine, which is very useful when, for example, I use the
''reply to all'' feature (`g`). In that case Mutt will not re-add email addresses
from that list in `Cc:`.

    alternative_order text/plain

A very useful line that tells Mutt than when an email contains a HTML part and
a plain text part, I prefer to see the plain text mail and not a dump of the html
file.

    macro attach 'V' "<pipe-entry>cat > ~/.cache/mutt/mail.html &&
          firefox -new-window ~/.cache/mutt/mail.html && sleep 2 &&
          rm ~/.cache/mutt/mail.html<enter>"


That line tells than when I am in the list of attachments of a mail and I press `V`,
it has to open Firefox with the content of the attachement. I do that when `elinks`
is not enough to understand a bloated HTML mail.

    unignore sender

That line tells Mutt that by default I want to see the `Sender:` field of the headers of my mails.
`From:` is not the only field that matters when you want to know where does a mail come from.

    bind compose p noop

That line removed the ability to call the pgp-menu before sending a mail. With
that I ensure that all my mails are signed. When I do not want to sign a mail I
have to run `:exec pgp-menu` to get that menu.


    send-hook . set from="roidelapluie@example.com"
    send-hook . set signature="~/.mutt/signature"
    send-hook "~t @customer.com" set from="julien.pivotto@customer.com"
    send-hook "~t @customer.com" set signature="~/.mutt/signature-customer"

Those lines tell that I want to send mails with my address `@example.com` and signature
`~/.mutt/signature` but if I send a mail to `@customer.com` then Mutt will select the
`@customer.com` mail address and `~/.mutt/signature-customer` signature.

    macro index     .n      "l((~N|~O|~F)!~D)\n"
    folder-hook     .       push '.n'

Thanks to these two lines, when I open a mailbox I only see the important messages.
The messages that have already been read are hidden (`l all` to show them again).

    set sort=threads
    set narrow_tree

Almost self-explicit. The thread trees take less space horizontally.


    set pager_stop

When I read a mail and I arrive to the end of the mail (with Page Down), it does not
go to the next mail.

    auto_view text/html

Automatically open html mails in Mutt.

    color index brightcolor001 default "PROBLEM.*CRITICAL"
    color index brightcolor001 default "PROBLEM.*DOWN"
    color index brightcolor202 default "PROBLEM.*UNKNOWN"
    color index color220 default "PROBLEM.*WARNING"
    color index brightcolor028 default "RECOVERY.*OK"
    color index brightcolor028 default "RECOVERY.*UP"
    color index color130 default "ACKNOWLEDGEMENT"

Add some colors to Icinga/Nagios emails.


### ~/.mailcap

The mailcap file tells Mutt how to open attachments.

    text/html; elinks -dump %s -eval 'set document.codepage.assume = "%{charset}"' -eval 'set document.dump.width = 66'; nametemplate=%s.html; copiousoutput
    application/pdf; mupdf-x11 %s &>/dev/null
    image/JPG; feh -F -Z %s &>/dev/null
    image/jpeg; feh -F -Z %s &>/dev/null
    image/gif; feh -F -Z %s &>/dev/null
    image/png; feh -F -Z %s &>/dev/null
    application/vnd.oasis.opendocument.text; libreoffice %s &>/dev/null
    application/vnd.ms-excel; libreoffice %s &>/dev/null
    application/vnd.oasis.opendocument.spreadsheet; libreoffice %s &>/dev/null
    application/msword; libreoffice %s &>/dev/null

### Conclusion

I hope it will help you if you are using Mutt. Enjoy these tricks!
