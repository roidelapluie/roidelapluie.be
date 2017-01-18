+++
title = "Gitlab makes the Entreprise edition code public"
lang = "en"
categories = ["Open-Source"]
tags = ["licenses", "philosophy"]
slug = "gitlab-ee"
date = "2015-05-22T22:15:27"
+++

It is a very sad day for Open-Source. Gitlab has opened its repository for the
Entreprise Edition (I am not going to put a link to it).

It is a very sad day because even if the code is available, it is still proprietary.
If you are interested in implementing features of the EE into the CE edition,
you have to make sure that you never look at the proprietary code. Otherwise your
changes will be illegal if they are too close to the proprietary ones.

We have the same kind of problems with other projects. The MariaDB Java connector is
LGPL and the Mysql Java Connector is under GPL. It means that it is legal to put any
great feature of the MariaDB Connector into the MySQL Connector but not the opposite.

GitLab EE would not be possible with its old competitor, now dead, Gitorious, because
it was under the GPL. I hope that some people will continue to develop Gitorious to
make it as best as Gitlab.

Opening the code without releasing it under an open source licence is not nice
for the community, not nice for the contributors and will not help that much the project:
will you review/contribute to a repository you can not use?
