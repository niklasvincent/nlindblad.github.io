---
layout: post
title: 'Ny tjänst: vilkenbok.nu'
tags:
  - bocker
  - kurslitteratur
  - lth
  - lunds-tekniska-hogskola
  - tjanst

---

Att hitta rätt böcker till läsperiodens nya kurser på LTH stjäl en hel del tid när enda sättet är att antingen skumma igenom kursbeskrivningar eller gamla kurshemisdor. För att lösa det problemet (och för att få en ursäkt att experimentera lite med textigenkänning, Google Books och Memcache) skapade jag i helgen tjänsten <a href="http://vilkenbok.nu" target="_blank">Vilkenbok.nu</a>.



<h2>Om tjänsten</h2>

Tjänsten använder <i>LTHs KursAdministrativa system (KA) med kursanmälan för studenter</i> som informationskälla för att försöka hitta ISBN-nummer<a href="http://en.wikipedia.org/wiki/ISBN" target="_blank">[1]</a> i anslutning till kursbeskrivningar.

Med hjälp utav publika tjänster som <a href="http://books.google.se/" target="_blank">Google Books</a> och <a href="http://isbndb.com/" target="_blank">ISBNdb.com</a> görs ett uppslag för att kontrollera bokens titel och författare. All information sparas sedan i en databas och informationen förnyas en gång per läsår.

Förutom att lista vilka böcker som används som kurslitteratur i en viss kurs finns även länkar till e-bokhandeln <a href="http://adlibris.se" target="_blank">Adlibris</a> och <a href="http://bokus.se" target="_blank">Bokus</a> samt <a href="http://bokfynd.se" target="_blank">Bokfynd</a> för att enkelt kunna jämföra priser och beställa böckerna.

<h2>Tekniken bakom</h2>

Om det är första gången en kurskod matas in görs en sökning i <i>LTHs KursAdministrativa system (KA)</i> som sedan analyseras för att hitta ISBN-nummer. För att kontrollera att böckerna existerar och att informationen i kursbeskrivningen är korrekt görs ett uppslag per bok (kurser kan ha mer än en kursbok) mot <a href="http://books.google.se/" target="_blank">Google Books</a> och <a href="http://isbndb.com/" target="_blank">ISBNdb.com</a> Därefter indexeras kursen och dess böcker i en relationsdatabas som används för framtida sökningar.

För att sänka svarstiden på sökningarna (det är rimligt att anta att vid till exempel terminsstart kommer många sökningar vara likartade) så används Memcache. Tack vare Memcache kan AJAX-anropet som utgör varje separat sökning göras på under 100 millisekunder.




