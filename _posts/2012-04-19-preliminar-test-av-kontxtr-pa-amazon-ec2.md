---
layout: post
title: 'Preliminär test av Kontxtr på Amazon EC2'
tags:
  - amazon
  - cloud
  - ec2
  - konxtxtr
  - sociala-medier
  - twitter

---

Under helgen experimenterades det en hel del med hur en vidareutvecklad version av <a href="http://kontxtr.se" target="_blank">Kontxtr</a> (Node.js + RabbitMQ + websockets) kan köras på <a href="http://aws.amazon.com/ec2/" target="_blank">Amazon Elastic Compute Cloud (Amazon EC2)</a>. Tanken är att varje kundbeställning ska köras på en helt egen virtuell server genom ett automatiserat system som sköter hela kedjan från beställning till konfiguration av nya serverinstanser.

Men det mest imponerande med den nya versionen är kanske det här:

<blockquote class="twitter-tweet"><p>Fun fact: the new <a href="https://twitter.com/search/%2523kontxtr">#kontxtr</a> backend displays tweets faster than Twitter's own web UI. How about that? <a href="https://twitter.com/search/%2523fb">#fb</a></p>&mdash; Nicklas Nygren (@Mossisen) April 14, 2012</blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<iframe src="https://player.vimeo.com/video/40371562?title=0&amp;byline=0&amp;portrait=0" width="400" height="300" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe><p><a href="https://vimeo.com/40371562">Speed Testing #Kontxtr</a> from <a href="https://vimeo.com/niklaslindblad">Niklas Lindblad</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

Förhoppningsvis är vår nya infrastruktur på plats lagom till sommaren.
