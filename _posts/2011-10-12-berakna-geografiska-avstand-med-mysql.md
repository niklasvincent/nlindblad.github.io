---
layout: post
title: 'Beräkna geografiska avstånd med MySQL'
language: swedish
tags:
  - database
  - geo-location
  - mysql

---

<p>Allt fler applikationer till Android/iPhone har funktioner som använder GPS-koordinater från mobilenheten för att beräkna vilka <i>points of interest</i> (butiker, restauranger, etc.) som finns inom ett visst avstånd från användaren. Att implementera det rent praktiskt i en tjänsts back-end kräver viss kunskap om linjär algebra och vad latitud/longitud egentlige innebär.</p>

<p><a href="http://www.arubin.org/blog/" target="_blank">Alexander Rubin</a> på MySQL presenterar hur en formel vid namn <a href="http://en.wikipedia.org/wiki/Haversine_formula" target="_blank">Haversine formula</a> kan implementeras direkt i SQL och som stored procedure. Vidare ger han lite tips på hur man kan vinna prestanda genom att sätta gränser på latitud/longitud och på så sätt undvika en genomsökning av hela tabellen. Mycket läsvärt!</p>



<a title="View Geo Distance Search with MySQL on Scribd" href="http://www.scribd.com/doc/2569355/Geo-Distance-Search-with-MySQL" style="margin: 12px auto 6px auto; font-family: Helvetica,Arial,Sans-serif; font-style: normal; font-variant: normal; font-weight: normal; font-size: 14px; line-height: normal; font-size-adjust: none; font-stretch: normal; -x-system-font: none; display: block; text-decoration: underline;">Geo Distance Search with MySQL</a><iframe class="scribd_iframe_embed" src="https://niklaslindblad.se/redirect/?url=aHR0cDovL3d3dy5zY3JpYmQuY29tL2VtYmVkcy8yNTY5MzU1L2NvbnRlbnQ/c3RhcnRfcGFnZT0xJiMwMzg7dmlld19tb2RlPWxpc3QmIzAzODthY2Nlc3Nfa2V5PWtleS0xemJ6NjNlMGF5MndldnljbmozbCZoYXNoPWYyNzJkMTg1OTRhMjlmNWYwMzc0YzdmOWExNGFhOGIy&hash=ef7a3ac8c26678f0790f09323ab61d2a" data-auto-height="true" data-aspect-ratio="" scrolling="no" id="doc_12039" width="100%" height="600" frameborder="0"></iframe>
