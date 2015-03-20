---
layout: post
title: "Build Statically Compiled nginx 1.4.7 with SPDY"
language: english
category: posts
---

I wanted to simplify deployment for my blog and other sites that only consist of static files and also play with SPDY, which has been in stable nginx since 1.3.15.

If you plan on using SDPY with nginx or currently do, make sure you upgrade to 1.4.7, which corrects a security issue in the ```ngx_http_spdy_module```:

       Security: a heap memory buffer overflow might occur in a worker
       process while handling a specially crafted request by
       ngx_http_spdy_module, potentially resulting in arbitrary code
       execution (CVE-2014-0133).
       Thanks to Lucas Molas, researcher at Programa STIC, Fundación Dr.
       Manuel Sadosky, Buenos Aires, Argentina.

Below is a shell script for building a statically compiled binary of nginx 1.4.7 with SPDY. Update the ```./configure``` options to suit your needs. I have left out things I did not need, like proxying and HTTP basic auth.

The only drawback of using stable instead of mainline is that the SPDY version is a bit behind (```spdy/2``` compared to ```spdy/3``` in mainline). Check out <a href="http://spdycheck.org/#niklaslindblad.se" target="_blank">the SDPYCheck results for this blog</a>.

For a nice baseline configuration for nginx with SSL, check out <a href="https://gist.github.com/plentz/6737338#file-nginx-conf" target="_blank">this Gist</a>.

<script src="https://gist.github.com/nlindblad/9709182.js"></script>
