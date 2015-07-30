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

<a title="View Geo Distance Search with MySQL on Scribd" href="http://www.scribd.com/doc/2569355/Geo-Distance-Search-with-MySQL">Geo Distance Search with MySQL</a>