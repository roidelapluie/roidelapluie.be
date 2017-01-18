+++
title = "wpa_supplicant and WPS"
lang = "en"
categories = ["Linux"]
tags = ["network", "planet-inuits"]
slug = "wi-fi-protected-setup"
date = "2015-12-27T20:07:53"
+++

I do not rely on graphical tools or any third party tools for connecting to
wireless networks. I use plain wpa_supplicant with hand-crafted configuation
files (one config file per network).

Nowadays, lots of wireless setups have a way to use [Wi-Fi Protected
Setup][wps], in particular the Push-Button method. The way it works is simple:
you click a button in your computer, another one on the router and they
magically connect.

When you only have wpa_supplicant to do so, here is the procedure.

First, create and minimal config file `/etc/wpa_supplicant/wps.conf`:

```
ctrl_interface=/var/run/wpa_supplicant
```

That line allows you to use wpa_cli.

Launch wpa_supplicant:

```
# wpa_supplicant -t -Dwext -i wlp3s0 -c /etc/wpa_supplicant/wps.conf -B
```

Then, launch `wpa_cli` and do the WPS Push-Button.

```
# wpa_cli
wpa_cli v2.4
```

Initiate a scan:
```
> scan
OK
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
```

Get the BSSID:
```
> scan_results
bssid / frequency / signal level / flags / ssid
92:3c:d1:d3:d7:dc       2437    -47     [WPA2-PSK-CCMP][WPS][ESS]       MyWireless
```

Initiate the WPS procedure. Meanwhile, press the button on the network device:
```
> wps_pbc 92:3c:d1:d3:d7:dc
OK
<3>Trying to associate with 92:3c:d1:d3:d7:dc (SSID='MyWireless' freq=2437 MHz)
<3>Association request to the driver failed
<3>Associated with 92:3c:d1:d3:d7:dc
<3>CTRL-EVENT-EAP-STARTED EAP authentication started
<3>CTRL-EVENT-EAP-STATUS status='started' parameter=''
<3>CTRL-EVENT-EAP-PROPOSED-METHOD vendor=14122 method=1
<3>CTRL-EVENT-EAP-STATUS status='accept proposed method' parameter='WSC'
<3>CTRL-EVENT-EAP-METHOD EAP vendor 14122 method 1 (WSC) selected
<3>WPS-CRED-RECEIVED
<3>WPS-SUCCESS
<3>CTRL-EVENT-EAP-STATUS status='completion' parameter='failure'
<3>CTRL-EVENT-EAP-FAILURE EAP authentication failed
<3>CTRL-EVENT-DISCONNECTED bssid=92:3c:d1:d3:d7:dc reason=3 locally_generated=1
<3>Trying to associate with 92:3c:d1:d3:d7:dc (SSID='MyWireless' freq=2437 MHz)
<3>Association request to the driver failed
<3>Associated with 92:3c:d1:d3:d7:dc
<3>WPA: Key negotiation completed with 92:3c:d1:d3:d7:dc [PTK=CCMP GTK=CCMP]
<3>CTRL-EVENT-CONNECTED - Connection to 92:3c:d1:d3:d7:dc completed [id=0 id_str=]
```

If you see `CTRL-EVENT-CONNECTED`, congratulations!

It is not finished yet, we want to save the result to get the password:

```
> set update_config 1
OK
> save_config
OK
```

Now, open `/etc/wpa_supplicant/wps.conf`:

```
ctrl_interface=/var/run/wpa_supplicant
update_config=1

network={
        ssid="MyWireless"
        psk="12345678"
        proto=RSN
        key_mgmt=WPA-PSK
        pairwise=CCMP
        auth_alg=OPEN
}
```


Enjoy!

[wps]:https://en.wikipedia.org/wiki/Wi-Fi_Protected_Setup
