---
layout: post
title: 'Snabbare Zend-applikationer med Minify'
language: swedish
tags:
  - css
  - javascript
  - js
  - optimering
  - php
  - prestanda
  - zend

---

Minify är ett simpelt PHP-skript som packar ihop flera CSS-filer eller Javascript-filer till en enda dataström, vilket gör att webbläsaren inte behöver fråga efter flera filer. Storleken är oftast inte den avgörande faktorn när en fil efterfrågas, utan varje förfrågan har en viss svarstid som aldrig går att kringgå.

Att dela upp en webbplats i flera separata stilmallar och Javascript-filer gör det enklare att underhålla sidan och att utveckla nya funktioner. Nackdelen är att den formatering som är mest bekväm för oss människor innehåller onödiga mellanslag och tabuleringar som gör att filen tar längre tid att hantera för webbläsaren.

På grund av svartsiden som alltid måste genomlidas vid varje förfrågan leder separata stilmallar/Javascript-filer även till att dessa (förhoppningsvis) små svarstiderna summeras. <b>Att ha 20 inlänkade CSS-filer kräver alltså 19 gånger så hög total svarstid som att ha en enda CSS-fil.</b>

I idealfallet kan alltså en förfrågan till webbplatsen innebära:
<ol>
<li>En HTTP-förfrågan för innehåll (XHTML)</li>
<li>En HTTP-förfrågan för stilmallar (CSS)</li>
<li>En HTTP-förfrågan för Javascript</li>
<li>En HTTP-förfrågan för varje bildelement</li>
</ol>

Minify (<a href="http://code.google.com/p/minify/" title="http://code.google.com/p/minify/">http://code.google.com/p/minify/</a>) erbjuder det bästa utav båda världar: läsbara CSS-filer och Javascript samtidigt som webbplatsen i sig bara behöver länka in en enda CSS-fil och en enda Javascript-fil.

Genom att installera Minify i webbroten (public/ för ett Zend-projekt) kan en förfrågan om ett gäng Javascript-filer istället länkas in som:

<pre style='color:#000000;background:#ffffff;'><span style='color:#808030; '>/</span><span style='color:#603000; '>min</span><span style='color:#808030; '>/</span><span style='color:#800080; '>?</span>f<span style='color:#808030; '>=</span><span style='color:#808030; '>/</span>js<span style='color:#808030; '>/</span><span style='color:#400000; '>main</span><span style='color:#808030; '>.</span>js<span style='color:#808030; '>,</span><span style='color:#808030; '>/</span>js<span style='color:#808030; '>/</span>bootstrap<span style='color:#808030; '>-</span>modal<span style='color:#808030; '>.</span>js
</pre>

Minify kommer då se till att kombinera de två Javascript-filerna till en enda fil utan mellanslag och tabuleringar. Om det görs ändringar i Javascript-filerna kommer Minify automatiskt generera en ny version med jämna mellanrum (standard är 1800 sekunder, det vill säga en halvtimme).

För en webbapplikation i produktionsmiljö rekommenderas en cache-tid på en vecka (604800 sekunder).

<h2>Minify i Zend Framework</h2>

För att få ett bättre arbetsflöde med Minify i Zend finns det två hjälpskript som placeras i 

<pre style='color:#000000;background:#ffffff;'>application<span style='color:#808030; '>/</span>views<span style='color:#808030; '>/</span>helpers<span style='color:#808030; '>/</span>
</pre>

Hjälpskripten finns här: <a href="https://github.com/bubba-h57/zf-helpers" title="https://github.com/bubba-h57/zf-helpers">https://github.com/bubba-h57/zf-helpers</a>

För att länka in Javascript-filer i &lt;head&gt;:

<pre style='color:#000000;background:#ffffff;'><span style='color:#5f5035; background:#ffffe8; '>&lt;?php</span><span style='color:#000000; background:#ffffe8; '> </span>
<span style='color:#800000; background:#ffffe8; font-weight:bold; '>echo</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#797997; background:#ffffe8; '>$</span><span style='color:#800000; background:#ffffe8; font-weight:bold; '>this</span><span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>minifyHeadScript</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>prependFile</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#0000e6; background:#ffffe8; '>'/js/bootstrap-modal.js'</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#000000; background:#ffffe8; '>       </span>
<span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>prependFile</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#0000e6; background:#ffffe8; '>'/js/jquery.min.js'</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#5f5035; background:#ffffe8; '>?></span>
</pre>

Och för CSS:

<pre style='color:#000000;background:#ffffff;'><span style='color:#5f5035; background:#ffffe8; '>&lt;?php</span><span style='color:#000000; background:#ffffe8; '>  </span>
<span style='color:#800000; background:#ffffe8; font-weight:bold; '>echo</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#797997; background:#ffffe8; '>$</span><span style='color:#800000; background:#ffffe8; font-weight:bold; '>this</span><span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>minifyHeadLink</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>prependStylesheet</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#0000e6; background:#ffffe8; '>'/css/style.css'</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>prependStylesheet</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#0000e6; background:#ffffe8; '>'/bootstrap/bootstrap-1.2.0.css'</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#5f5035; background:#ffffe8; '>?></span>
</pre>

Om du har installerat Minify i public/min bör du göra följande ändringar i config.php:

<pre style='color:#000000;background:#ffffff;'>
<span style='color:#797997; background:#ffffe8; '>$min_documentRoot</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#808030; background:#ffffe8; '>=</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#400000; background:#ffffe8; '>dirname</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#7d0045; background:#ffffe8; '>__FILE__</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#808030; background:#ffffe8; '>.</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#0000e6; background:#ffffe8; '>'</span><span style='color:#800000; background:#ffffe8; '>/</span><span style='color:#808030; background:#ffffe8; '>.</span><span style='color:#808030; background:#ffffe8; '>.</span><span style='color:#800000; background:#ffffe8; '>/</span><span style='color:#0000e6; background:#ffffe8; '>'</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#797997; background:#ffffe8; '>$min_cachePath</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#808030; background:#ffffe8; '>=</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#0000e6; background:#ffffe8; '>'/tmp'</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
</pre>

Beroende på var dina CSS-filer och Javascript befinner sig så måste varje sökväg tillåtas. Detta är för att skydda mot att Minify används för att läsa andra filer i systemet:

<pre style='color:#000000;background:#ffffff;'>
<span style='color:#797997; background:#ffffe8; '>$min_serveOptions</span><span style='color:#808030; background:#ffffe8; '>[</span><span style='color:#0000e6; background:#ffffe8; '>'minApp'</span><span style='color:#808030; background:#ffffe8; '>]</span><span style='color:#808030; background:#ffffe8; '>[</span><span style='color:#0000e6; background:#ffffe8; '>'allowDirs'</span><span style='color:#808030; background:#ffffe8; '>]</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#808030; background:#ffffe8; '>=</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#800000; background:#ffffe8; font-weight:bold; '>array</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#0000e6; background:#ffffe8; '>'//js'</span><span style='color:#808030; background:#ffffe8; '>,</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#0000e6; background:#ffffe8; '>'//css'</span><span style='color:#808030; background:#ffffe8; '>,</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#0000e6; background:#ffffe8; '>'//bootstrap'</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
</pre>

I det här fallet ligger Javascript i public/js, CSS i public/css och jag använder ett CSS-ramverk som heter Bootstrap som ligger i public/bootstrap.

<h2>Minify och Memcache</h2>

Istället för att lagra de genererade filerna i /tmp går det att använda Memcache. Lägg till följande i config.php för Minify:

<pre style='color:#000000;background:#ffffff;'>
<span style='color:#800000; background:#ffffe8; font-weight:bold; '>require</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#0000e6; background:#ffffe8; '>'lib/Minify/Cache/Memcache.php'</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#797997; background:#ffffe8; '>$memcache</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#808030; background:#ffffe8; '>=</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#800000; background:#ffffe8; font-weight:bold; '>new</span><span style='color:#000000; background:#ffffe8; '> Memcache</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#797997; background:#ffffe8; '>$memcache</span><span style='color:#808030; background:#ffffe8; '>-</span><span style='color:#808030; background:#ffffe8; '>></span><span style='color:#000000; background:#ffffe8; '>connect</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#0000e6; background:#ffffe8; '>'localhost'</span><span style='color:#808030; background:#ffffe8; '>,</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#008c00; background:#ffffe8; '>11211</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
<span style='color:#797997; background:#ffffe8; '>$min_cachePath</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#808030; background:#ffffe8; '>=</span><span style='color:#000000; background:#ffffe8; '> </span><span style='color:#800000; background:#ffffe8; font-weight:bold; '>new</span><span style='color:#000000; background:#ffffe8; '> Minify_Cache_Memcache</span><span style='color:#808030; background:#ffffe8; '>(</span><span style='color:#797997; background:#ffffe8; '>$memcache</span><span style='color:#808030; background:#ffffe8; '>)</span><span style='color:#800080; background:#ffffe8; '>;</span><span style='color:#000000; background:#ffffe8; '></span>
</pre>

Glöm inte att kommentera ut:

<pre style='color:#000000;background:#ffffff;'>
<span style='color:#696969; background:#ffffe8; '>//$min_cachePath = '/tmp';</span><span style='color:#000000; background:#ffffe8; '></span>
</pre>

<h2>Resultat</h2>
<a href="http://pingdom.com" target="_blank">Pingdom</a> släppte för ett tag sedan <a href="http://fpt.pingdom.com/" target="_blank">ett riktigt bra verktyg för att mäta prestandan för en webbplats</a>.

Efter att ha installerat Minify och gått igenom alla steg ovan:

<a href="https://s3.amazonaws.com/cdn.niklaslindblad.se/wordpress/wp-content/uploads/2011/10/Skarmavbild-2011-10-29-kl.-17.11.31.png"><img src="https://d2tjdh98vh6jzp.cloudfront.net/wordpress/wp-content/uploads/2011/10/Skarmavbild-2011-10-29-kl.-17.11.31-300x106.png" alt="Pingdom-mätning" title="Pingdom-mätning" width="300" height="106" class="aligncenter size-medium wp-image-203" /></a>

Anledningen till att prestanda-betyget inte blir 100/100 är att Minify använder GET-variabler (till exempel /min/?f=), vilket gör att vissa proxy-servrar inte kommer cacha förfrågan.


