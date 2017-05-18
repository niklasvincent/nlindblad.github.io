---
layout: post
title: 'Tvinga Wordpress att använda HTTPS (SSL)'
tags:
  - sakerhet-2
  - ssl
  - wordpress

---

Häromdagen köpte jag ett SSL-certifikat till den här bloggen. Tillvägagångssättet att installera SSL-certifikat beskrivs ofta väldigt utförligt av företaget som du köper SSL-certifikatet ifrån. För Apache, som de allra flesta webbplatser körs på, är det inga problem att hitta bra guider. Ett exempel på en bra guide är <a href="https://uk.godaddy.com/help/install-ssl-certificates-16623" target="_blank">denna från GoDaddy</a>.

<h2>Ändra i .htaccess</h2>
För att Apache (webbservern) ska hänvisa besökare till att använda en krypterad anslutning kan man lägga till följande direktiv i <i>.htaccess</i>:

<pre style='color:#000000;background:#ffffff;'><span style='color:#808030; '>&lt;</span>IfModule mod_rewrite<span style='color:#808030; '>.</span>c<span style='color:#808030; '>></span>
RewriteEngine On
RewriteBase <span style='color:#808030; '>/</span>
RewriteRule <span style='color:#808030; '>^</span>index\<span style='color:#808030; '>.</span>php$ <span style='color:#808030; '>-</span> <span style='color:#808030; '>[</span>L<span style='color:#808030; '>]</span>
RewriteCond <span style='color:#808030; '>%</span><span style='color:#800080; '>{</span>REQUEST_FILENAME<span style='color:#800080; '>}</span> <span style='color:#808030; '>!</span><span style='color:#808030; '>-</span>f
RewriteCond <span style='color:#808030; '>%</span><span style='color:#800080; '>{</span>REQUEST_FILENAME<span style='color:#800080; '>}</span> <span style='color:#808030; '>!</span><span style='color:#808030; '>-</span>d
RewriteRule <span style='color:#808030; '>.</span> <span style='color:#808030; '>/</span>index<span style='color:#808030; '>.</span>php <span style='color:#808030; '>[</span>L<span style='color:#808030; '>]</span>
RewriteCond <span style='color:#808030; '>%</span><span style='color:#800080; '>{</span>SERVER_PORT<span style='color:#800080; '>}</span> <span style='color:#808030; '>^</span><span style='color:#008c00; '>80</span>$
RewriteRule     <span style='color:#808030; '>^</span><span style='color:#808030; '>(</span><span style='color:#808030; '>.</span><span style='color:#808030; '>*</span><span style='color:#808030; '>)</span>$ https<span style='color:#800080; '>:</span><span style='color:#696969; '>//%{SERVER_NAME}%{REQUEST_URI} [L,R]</span>
<span style='color:#808030; '>&lt;</span><span style='color:#808030; '>/</span>IfModule<span style='color:#808030; '>></span>
</pre>

<h2>Ändra inställningar i WordPress</h2>
Direkt under <i>Allmänna inställningar</i> i Wordpress administrationsgränssnitt finns inställningar för vilken URL Wordpress kommer använda som standard när den konstruerar länkar.



<h2>Installera pluginet <i>Force SSL</i></h2>
Trots de rigorösa inställningarna ovan kan det ändå bli fel ibland när besökare kommer från pingback-adresser eller andra adresser som länkar till gammalt innehåll.

<a target="_blank" href="http://wordpress.org/extend/plugins/force-ssl/">Pluginet finns här</a>.

<h2>Olika beteenden i olika webbläsare</h2>
Google Chrome kommer att visa olika ikoner i adressfältet beroende på om sidan laddar innehåll (bilder, iframe, etc.) från källor som inte använder HTTPS.

I det sista fallet är det ett blogginlägg som inkluderar <a href="http://www.scribd.com/doc/2569355/Geo-Distance-Search-with-MySQL" target="_blank">en presentation från Scribd</a>. Deras lösning för inbäddning (precis som många andra sidor) bygger på iframe och källan är oftast inte krypterad.

<b>Se till att allt innehåll på själva bloggen inte har <i>http://</i> i länkarna utan <i>https://</i>. Som standard använder Wordpress hela URL:en när bilder läggs till från mediagalleriet. Gamla inlägg kommer därför ha bildlänkar som inte är HTTPS.</b>
