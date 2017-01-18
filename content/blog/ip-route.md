+++
title = "Specific routing table for one process"
lang = "en"
categories = ["Linux"]
tags = ["network", "planet-inuits"]
slug = "specific-routing-table"
date = "2015-10-13T21:53:15"
+++

I have multiple VPNs launched at any time that route all of my traffic outside
the eyes of my ISP (including default gateway).

Some services however require me to have my 'belgian' ip address. The easy
solution is of course to stop my VPN but hey, no way!

So here is another solution, quite simple (it does not involve mangling or bridges).

This solution is with network namespaces and multiple routing tables.

First, create a "belgium" network namespace.

```bash
ip netns add belgium
```

Create a pair of virtual ethernet interfaces (veth0 and veth1).

```bash
ip link add veth0 type veth peer name veth1
```

Move veth1 to your "belgium" namespace.

```bash
ip link set veth1 netns belgium
```

Set appropriate IP addresses to veth0 and veth1.

```bash
ip ad ad 192.168.11.0/24 dev veth0
ip netns exec belgium ip ad ad 192.168.11.2/24 dev veth1
```

Add appropriate routes in the "belgium" namespace.

```bash
ip netns exec belgium ip r add default via 192.168.11.1
```

Create a second routing table in the main network namespace by adding a line "1 rt2" to /etc/iproute2/rt_tables.

```bash
echo 1 rt2 >> /etc/iproute2/rt_tables
```

Set appropriate routes in this routing table:

```bash
ip r add 192.168.1.0/24 dev wlp3s0 table rt2
ip r add default via 192.168.1.1 dev wlp3s0 table rt2
ip r add 192.168.11.0/24 dev veth0 table rt2
```

Set the rules for that routing table to catch the right packages:

```bash
ip rule add from 192.168.11.0/24 table rt2
ip rule add to 192.168.11.0/24 table rt2
```

Allow IP forwarding and Masquerade.

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 192.168.11.2 -j MASQUERADE
```


Enjoy Football.

```bash
ip netns exec belgium su roidelapluie -c "mpv rtsp://rtmp.rtbf.be/livecast/laune"
```
