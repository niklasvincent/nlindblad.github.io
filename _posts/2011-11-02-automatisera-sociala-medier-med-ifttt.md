---
layout: post
title: 'Automatisera sociala medier med ifttt'
language: swedish
tags:
  - cron
  - dropbox
  - facebook
  - ifttt
  - instagram
  - twitter

---

Tjänsten <b><a href="http://ifttt.com" target="_blank">ifttt</a></b> (if this then that) gör det möjligt att få ett helt automatiskt samspel mellan olika sociala medier och tjänster som Evernote och Dropbox. Som namnet antyder handlar det om simpla logiska villkor som i sin tur triggar åtgärder.

<h2>if <b>this</b> then that</h2>
Välj vilken plattform informationen ska hämtas från. Det kan vara allt ifrån nya inlägga på en Facebook page till priset på en viss aktie.

För varje plattform ges valmöjligheter för vad som ska uppfyllas. I fallet med aktiepriser kan det vara 1) om priset överstiger ett visst värde eller 2) om priset understiger ett visst värde. När det gäller sociala medier handlar det huvudsakligen om nytt innehåll som publicerats. Det finns tyvärr ingen möjlighet att till exempel kräva att ett inlägg innehåller vissa ord.

<img alt="Ett urval av tjänsterna som fungerar med IFTTT" src="{{ site.cloudfront_url }}/wordpress/wp-content/uploads/2011/11/Skarmavbild-2011-11-02-kl.-15.32.57-300x274.png" title="Skärmavbild 2011-11-02 kl. 15.32.57" width="300" height="274" class="aligncenter size-medium wp-image-211" />

<h2>if this then <b>that</b></h2>
Nästa steg är att bestämma vad som ska hända ner villkoret är uppfyllt. I det här fallet kommer alla bilder från mitt användarkonto på Instagram att sparas till min Dropbox.

<img alt="Exempel på ett recept" src="{{ site.cloudfront_url }}/wordpress/wp-content/uploads/2011/11/Skarmavbild-2011-11-02-kl.-15.40.29.png" title="Skärmavbild 2011-11-02 kl. 15.40.29" width="500" height="177" class="aligncenter size-full wp-image-218" />
<h2>Möjligheter med tjänsten</h2>
De funktioner som <b>ifttt</b> erbjuder hade inneburit flera veckors arbete att implementera från grunden. Tyvärr saknar jag redan en del saker som förhoppningsvis kommer i framtida versioner:

<ul>
<li>Möjlighet att skicka privata meddelanden på Twitter och Facebook.</li>
<li>Premium-variant för att köra åtgärderna oftare än fyra gånger per timme.</li>
<li>Möjlighet att sätta upp mer avancerade villkor som "Twitter-inlägg som innehåller ordet X"</li>
</ul>

Sammantaget är det imponerande hur användarvänlig tjänsten är och hur många API:er de har integrerat. Jag ser fram emot att följa utvecklingen av <b>ifttt</b>.
