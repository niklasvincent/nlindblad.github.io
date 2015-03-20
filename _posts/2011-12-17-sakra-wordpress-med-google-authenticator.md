---
layout: post
title: 'Säkra WordPress med Google Authenticator'
tags:
  - android
  - google
  - google-authenticator
  - iphone
  - otp
  - sakerhet-2
  - security
  - wordpress

---

Förra året släppte Google en applikation till <a href="https://market.android.com/details?id=com.google.android.apps.authenticator&hl=sv" target="_blank">Android</a> och <a target="_blank" href="http://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8"/>iPhone</a> som gör det möjligt att köra <a target="_blank" href="http://support.google.com/accounts/bin/static.py?hl=sv&guide=1056283&page=guide.cs&answer=180744&rd=3">tvåstegsverifiering med ditt Google-konto</a>.

I praktiken innebär det att även om ditt lösenord blir allmänt känt (till exempel om du av någon anledning använder samma lösenord på flera webbplatser och en utav dem blir hackad) behöver en oberhörig person även kunna mata in rätt engångskod vid inloggning.

Själva engångskoderna följer samma princip som bankdosor. I applikationen Google Authenticator och på Googles servrar lagras en gemensam hemlighet som används för att skapa nycklar i form utav 6 siffror. Varje nyckel är giltig i en minut och nycklar kan inte återanvändas kort inpå varandra. Att föra över den gemensamma hemligheten när du aktiverar tvåstegsverifiering gör du enkelt genom att scanna en QR-kod.



<h2>Använd Google Authenticator med WordPress</h2>
Tack vare att Google inte har låst Google Authenticator till sina egna tjänster och att den bygger på en öppen standard går det att använda samma säkra inloggning med andra tjänster.

Majoriteten av WordPress-bloggar administreras helt okrypterat och det kan innebära att obehöriga personer kan få tillgång till hela din blogg/webbplats om du loggar in via till exempel ett osäkert trådlöst nätverk. Genom att lägga till tvåstegsverifiering löser du inte problemet med att inloggningsuppgifter skickas okrypterat, men du kan begränsa skadan detta orsakar.

<a href="http://wordpress.org/extend/plugins/google-authenticator/" target="_blank">Wordpress-pluginet Google Authenticator</a> är enkelt att komma igång med och lägger till ett extra fält i WordPress inloggningsruta. 



För att lägga till din blogg i Google Authenticator-appen presenteras en QR-kod som du enkelt kan scanna.




