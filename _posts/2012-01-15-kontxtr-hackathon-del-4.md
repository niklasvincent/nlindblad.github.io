---
layout: post
title: 'Kontxtr-hackathon – Del 4'
tags:
  - memcache
  - node-js
  - nowplaying
  - phirehose
  - twitter
  - video

---

Utan Spotify igång (största bandbreddstjuven) fick vi följande resultat för den populära hashtagen #nowplaying:

<pre>
Phirehose rate: 2 status/sec (126 total), avg enqueueStatus(): 5.31ms
Phirehose rate: 2 status/sec (149 total), avg enqueueStatus(): 5.1ms
Phirehose rate: 3 status/sec (157 total), avg enqueueStatus(): 5.49ms
Phirehose rate: 2 status/sec (140 total), avg enqueueStatus(): 4.41ms
Phirehose rate: 2 status/sec (127 total), avg enqueueStatus(): 5.38ms
Phirehose rate: 2 status/sec (126 total), avg enqueueStatus(): 5.45ms
Phirehose rate: 2 status/sec (133 total), avg enqueueStatus(): 5.83ms
Phirehose rate: 2 status/sec (141 total), avg enqueueStatus(): 5.7ms
Phirehose rate: 3 status/sec (150 total), avg enqueueStatus(): 5.5ms
</pre>

<iframe src="https://player.vimeo.com/video/35088658?title=0&amp;byline=0&amp;portrait=0" width="250" height="228" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>

Alltså i snitt runt 2 Tweets/sekund, med en serverbelastning på:

<pre>
load average: 0.73, 0.64, 0.39
</pre>


