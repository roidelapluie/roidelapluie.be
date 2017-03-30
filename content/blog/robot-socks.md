+++
date = "2017-03-30T21:19:55+02:00"
slug = "robot-firefox-socks"
tags = ["Open-Source", "Testing", "Automation", "planet-inuits"]
categories = ["Linux"]
lang = "en"
title = "Setting a Socks Proxy in Firefox Webdriver with Robot Framework"

+++

Here are the [Robot Framework](http://robotframework.org/) keywords needed
nowadays to setup a socks5 proxy (e.g `ssh -ND 9050 bastion.example.com`):

```text
*** Settings ***
Documentation     Open a Web Page using a socks 5 proxy (demo)
Library           Selenium2Library

*** Test Cases ***
Create Webdriver and Open Page
    ${profile}=   Evaluate   sys.modules['selenium.webdriver'].FirefoxProfile()
sys
    Call Method   ${profile}   set_preference   network.proxy.socks   127.0.0.1
    Call Method   ${profile}   set_preference   network.proxy.socks_port
${9060}
    Call Method   ${profile}   set_preference   network.proxy.socks_remote_dns
${True}
    Call Method   ${profile}   set_preference   network.proxy.type   ${1}
    Create WebDriver   Firefox   firefox_profile=${profile}
    Go To    http://internal.example.com
```
