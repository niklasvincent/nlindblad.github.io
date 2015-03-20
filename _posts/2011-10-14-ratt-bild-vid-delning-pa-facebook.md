---
layout: post
title: 'Rätt bild vid delning på Facebook'
language: swedish
tags:
  - facebook

---

<p>Ett vanligt fel webbplatser gör idag är att inte underlätta för Facebooks länkspindel när den ska avgöra vilka bilder som är lämpliga att ha som tumnagel. När en länk delas via till exempel en statusuppdatering bryr sig majoriteten av användare inte sig om att bläddra igenom alla bildval för att ställa in tumnageln. Det leder tyvärr allt för ofta till att irrelevanta bilder som reklambilder visas, även om de inte har något med innehållet att göra.</p>

<p>För att tipsa Facebook om vilken bild som bör prioriteras vid delning kan man använda följande meta-tag i &lt;head&gt;:</p>

<pre style='color:#000000;background:#ffffff;'><span style='color:#808030; '>&lt;</span>link rel<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>image_src</span><span style='color:#800000; '>"</span> href<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>URL till bilden här</span><span style='color:#800000; '>"</span> <span style='color:#808030; '>/</span><span style='color:#808030; '>></span>
</pre>

<p>Vill man gå några steg längre och även ge Facebook specialiserad information om innehållet på sidan finns följande meta-taggar:</p>

<pre style='color:#000000;background:#ffffff;'><span style='color:#808030; '>&lt;</span>meta property<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>og:title</span><span style='color:#800000; '>"</span> content<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>Här bör man placera ett urdrag ut texten som lockar till läsning</span><span style='color:#800000; '>"</span> <span style='color:#808030; '>/</span><span style='color:#808030; '>></span>
<span style='color:#808030; '>&lt;</span>meta property<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>og:description</span><span style='color:#800000; '>"</span> content<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>Titel som syns</span><span style='color:#800000; '>"</span> <span style='color:#808030; '>/</span><span style='color:#808030; '>></span>
<span style='color:#808030; '>&lt;</span>meta property<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>og:image</span><span style='color:#800000; '>"</span> content<span style='color:#808030; '>=</span><span style='color:#800000; '>"</span><span style='color:#0000e6; '>Ett alternativ till den bildtaggen som nämndes innan</span><span style='color:#800000; '>"</span> <span style='color:#808030; '>/</span><span style='color:#808030; '>></span>
</pre>

<p>En naturlig indelning är att sätta <i>image_src</i> till webbplatsens logga och använda <i>og:title</i>, <i>og:description</i> och <i>og:image</i> till att sammanfatta den aktuella sidan (en produkt, en artikel i en webshopp, etc.).</p>


