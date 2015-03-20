---
layout: post
title: "Monitor OpenELEC with Graphite"
language: english
category: posts
---

Recently I have started consolidating metrics for all my machines into [Graphite](http://graphite.wikidot.com/). I keep a couple of [Raspberry Pi](http://www.raspberrypi.org/)s around the house and one of them runs [OpenELEC](http://openelec.tv/), my favourite way for running XBMC on Raspberry Pi.

This is a quick guide on how to monitor uptime and load average on OpenELEC and send it to Graphite.

Before you start, make sure your time is accurate, since Graphite relies on timestamps for storing the information:

{% highlight bash %}
ntpdate ntp.lth.se
{% endhighlight %}

OpenELEC uses BusyBox and does not come with a package manager. Fortunately screen is quite portable and it is simple to manually extract it from Raspbians packages and drop in the binaries.

Either copy the files from an existing Raspbian system or use the commands below on a Debian based system to extract the files.

Both screen and the script is going to run out of /storage/

## Grab a copy of screen

{% highlight bash %}
wget http://mirrordirector.raspbian.org/raspbian/pool/main/s/screen/screen_4.1.0~20120320gitdb59704-9_armhf.deb
mkdir screen-arm
dpkg -x screen_4.1.0~20120320gitdb59704-9_armhf.deb screen-arm
scp screen-arm/usr/bin/screen openelec:/storage/.
{% endhighlight %}

## Grab a copy of libpam and libaudit

{% highlight bash %}
wget http://mirrordirector.raspbian.org/raspbian/pool/main/p/pam/libpam0g_1.1.8-2_armhf.deb
mkdir libpam
dpkg -x libpam0g_1.1.8-2_armhf.deb libpam
scp libpam/lib/arm-linux-gnueabihf/libpam.so.0.83.1 openelec:/storage/libpam.so.0
mkdir libaudit
wget http://mirrordirector.raspbian.org/raspbian/pool/main/a/audit/libaudit0_1.7.18-1.1_armhf.deb
dpkg -x libaudit0_1.7.18-1.1_armhf.deb libaudit
scp libaudit/lib/libaudit.so.0.0.0 tv:/storage/libaudit.so.0 openelec:/storage/libaudit.so.1
{% endhighlight %}

## Create a wrapper for screen
Now that all files are in place in /storage/. Create ```screen.sh```
{% highlight bash %}
export LD_LIBRARY_PATH="/storage:${LD_LIBRARY_PATH}"
./screen "$@"
{% endhighlight %}

## Create the monitoring script
Create ```stats.sh```:
<script src="https://gist.github.com/nlindblad/9706202.js"></script>

## Start and detach screen
{% highlight bash %}
./screen.sh ./stats.sh
{% endhighlight %}

Detach with ```CTRL + A + D```.

## Watch the results in Graphite

<img src="https://s3.amazonaws.com/cdn.niklaslindblad.se/images/openelec-graphite.png" /> 
