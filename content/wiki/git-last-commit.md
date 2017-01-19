+++
title = "Removing the last commit in git"
lang = "en"
date = "2014-03-28T09:23:28"
+++

A one shot command to remove the last commit in git.. useful when you want to re-apply a patch.

    EDITOR="echo noop >" git rebase -i HEAD~1

or:

    git reset --hard HEAD~1
