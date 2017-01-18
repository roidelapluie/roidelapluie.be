+++
title = "It's not time to split Linux distros in two"
lang = "en"
categories = ["Linux"]
tags = ["linux", "imho", "planet-inuits"]
slug = "dont-split-linux-in-two"
date = "2014-09-13T21:24:25"
+++

*This article is a reaction to the following article:* [It's time to split Linux distros in two](http://www.infoworld.com/d/data-center/its-time-split-linux-in-two-249704) written by [@pvenezia](https://twitter.com/pvenezia).

There are a lot of changes nowadays in the way GNU/Linux evolves: systemd, steamOS, android, and a bunch of other stuff in several domains.

So I read Paul's article with attention because it's seems that GNU/Linux will evolve a lot in the following years. He is right when he points out that on one side we want stability and scalability and on the other side we want performances and wide hardware support. But it does not mean that we want to have to chose from these two aspects.

Linux can do all the things. And it can do them right. I don't want to have to choose between server and desktop, what I want is a smallish image that I can use and deploy and then choose whatever I want to install on it. I want to be able to give a kickstart and eventually get a GNOME Desktop or a httpd server.

The open-source world is moving fast. Containers, declarative distributions, and who knows what will be the next hipster stuff.. There is no room for a ballot screen that would allow you to download a desktop or a server-centric distribution.

One of the reasons is that a desktop should be able to run server applications and a server should be able to run desktop softwares. Let me show you some example.

On desktop A, a developer is running a lot of different virtual machines. To facilitate his work, he has deployed a small DNS server on it, so it is easy to work accross several projects. If the distributions were splitted, which one should he use?

On a server, I want to run acceptance tests for a website. So I need a jenkins slave, Xvfb (headless X11 server) and a browser. Which distribution should I use?

There are many risks in splitting distributions into desktop/server roles:

* No one would have all the packages he needs
* Server-centric distributions would have outdated desktop-related packages and vice-versa
* People would install packages that come from anywhere coz they are on the other distributions
* There would be a lot of double work - work that has to take place in both desktop and server distributions

But, if you look closer, you will also understand that there is already a natural way of using distributions. SteamOS and Fedora will be used more as desktops, and CentOS will more be used as server. The limits are however less important with debian-related systems.

In some special cases like SteamOS, it is right that Desktop support will come first. Maybe they won't package httpd or bind, but that would be their choice. There is not need for a big schism into every distribution because one of them has chosen to support only one of the two sides.

To conclude this article, I like the idea that with a small image, I can get whatever I want. It's really cellular differentiation. Let's avoid to do mistakes because of systemd or any other software. Let's follow what the community wants, and what business needs. Let's keep Linux distributions capable of handling all the stuff we love.
