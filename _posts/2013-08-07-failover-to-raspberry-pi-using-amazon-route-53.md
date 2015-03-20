---
layout: post
title: "Failover to Raspberry Pi using Amazon Route 53"
language: english
category: posts
---

I have not had any issues with Linode that has caused outages, but some times the VPS is taken offline for maintenance or Linode being kind enough to upgrade [the number of cores](https://blog.linode.com/2013/03/18/linode-nextgen-the-hardware/), [RAM](https://blog.linode.com/2013/04/09/linode-nextgen-ram-upgrade/) or [disk space](https://blog.linode.com/2003/08/21/double-disk-space-now-standard-on-all-packages/).

Since I migrated this blog from Wordpress to [Jekyll](http://jekyllbootstrap.com/) (awesome [theme by Carlos Alexandro Becker](https://github.com/caarlos0/up)), I have wanted to take advantage of the fact that my blog is now just a collection of static HTML. The first thought was to migrate hosting to Amazon S3 ([like this](http://www.allthingsdistributed.com/2011/08/Jekyll-amazon-s3.html)), thus increasing uptime and make me less dependent on the [Linode VPS](http://linode.com). The only thing stopping me is that I do not want to drop SSL support. Custom SSL for Amazon's CDN service CloudFront [costs $600 per month each](http://aws.amazon.com/cloudfront/pricing/).

The only option left was to host it on a server I could trust, since the SSL certificates would have to reside on the server and port 443 has to be unused (the old "one IP per SSL certificate"). I went with a Raspberry Pi that is currently "co-located" at a friend's house, but there is [a Swedish hosting company offering free Raspberry Pi co-location](https://fsdata.se/blogg/gratis-colocation-med-raspberry-pi/) that would be suitable in the long run.

## Distributing the Blog ##

I am using the Git post-receive hook method [described in the Jekyll deployment guide](http://jekyllrb.com/docs/deployment-methods/) to copy the static HTML to the web root on my Linode VPS:

{% highlight bash %}
#!/bin/bash

GIT_REPO=$HOME/niklaslindblad.se.git
TMP_GIT_CLONE=/tmp/niklaslindblad.se-deploy
PUBLIC_WWW=/var/www/niklaslindblad.se/public

git clone $GIT_REPO $TMP_GIT_CLONE
jekyll build --trace -s $TMP_GIT_CLONE -d $PUBLIC_WWW
rm -Rf $TMP_GIT_CLONE

s3cmd sync /var/www/niklaslindblad.se/public/ s3://niklaslindblad.se/

exit
{% endhighlight %}

This also makes sure there is an up to date copy of the files in an Amazon S3 bucket.

On the Raspberry Pi I have a cron job to periodically update its local copy:

{% highlight bash %}
#!/bin/bash
cd /home/pi/niklaslindblad.se/
s3cmd sync s3://niklaslindblad.se/ ./
{% endhighlight %}

So, whenever I run:

{% highlight bash %}
git push deploy
{% endhighlight %}

the *master* branch is pushed to Linode, the files served by Apache are updated and a copy of the changed files is sent to Amazon S3.

## Fail-over with Amazon Route 53 ##

The *Active-passive failover* offered by Route 53 suited my needs:

	Use this failover configuration when you want a primary group of resources to be available the majority of the time and you want a secondary group of resources to be on standby in case all of the primary resources become unavailable. When responding to queries, Route 53 includes only the healthy primary resources. If all of the primary resources are unhealthy, Route 53 begins to include only the healthy secondary resources in response to DNS queries.
	
Everything is [outlined in the official Amazon Route 53 documentation](http://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring.html) and in the case you just want failover to Amazon S3, there is a [detailed guide on the AWS blog](http://aws.typepad.com/aws/2013/02/create-a-backup-website-using-route-53-dns-failover-and-s3-website-hosting.html).

I simply use the health check to check if it can retrieve an empty text file in the web root. If not, it will change the DNS record to point at the secondary server. The lowest possible TTL is 60 seconds, which means worst case clients will need a couple of minutes to pick up.

## How to Notice a Failover ##

Despite getting numerous alarms from services like Pingdom when my VPS goes offline, I wanted a visual clue on the blog itself that it is being served by the secondary server (the Raspberry Pi). If you see this, then this blog is not currently being served by Linode:

<img src="{{ '/images/rpi-notice.png' | asset_url }}" style="border: 1px solid #000;" />

which seems like fair usage of the [Raspberry Pi](http://raspberrypi.org) logo

	If you use the Raspberry Pi Logo in this way on a website, the logo must link to our website at http://raspberrypi.org.

The Raspberry Pi logo and text is shown if the *X-Powered-By* HTTP header is set to *raspberry-pi*.

### On the Server (nginx) ###

The custom header needed for the check:

{% highlight bash %}
add_header X-Powered-By raspberry-pi;
{% endhighlight %}

### Client Side (Javascript) ###

The jQuery AJAX call shorthand can return the jqXHR object (a superset of the XMLHTTPRequest object), which contains all headers received by the browser:

{% highlight javascript %}
$(document)
    .ready(function() {
    $.ajax({
        url: '/up.txt',
        type: 'HEAD',
        success: function(res, status, xhr) {
            var server = xhr.getResponseHeader("X-Powered-By");
            if (server != null) {
                if (server == 'raspberry-pi') {
                    $('#placeholder')
                        .html('<a href="http://www.raspberrypi.org" target="_blank"><img src="https://d2tjdh98vh6jzp.cloudfront.net/images/raspberrypi.png" /></a> <span>Powered by Raspberry Pi</span>');
                }
            }
        }
    });
});
{% endhighlight %}

## Future Improvements ##

I will probably send a Raspberry Pi to FS data in Helsingborg for proper co-location.

If it turns out the bandwidth (1 Mbps up and down) is not sufficient (although it should be, since all assets are served by CloudFront) the Raspberry Pi could simply redirect all requests to the non-SSL Amazon S3 bucket instead.
