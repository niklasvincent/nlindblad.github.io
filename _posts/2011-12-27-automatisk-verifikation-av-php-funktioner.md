---
layout: post
title: 'Automatisk verifikation av PHP-funktioner'
tags:
  - chef
  - linux
  - php
  - programmering-2
  - programming
  - test
  - testing
  - verifikation
  - wget

---

I samband med att jag skrev recept till <a href="http://wiki.opscode.com/display/chef/Home" target="_blank">Chef</a> behövde jag ett sätt att kontrollera att nya PHP-moduler verkligen fungerar. Syftet med receptet var att installera Apache, PHP, MySQL och nödvändiga PHP-moduler som memcache och imagick.

För att underlätta verifikationen av PHP-modulerna tog jag fram följande funktion (Bash):

<pre style='color:#000000;background:#ffffff;'><span style='color:#696969; '># ${1} Name of functionality being checked (e.g. 'imagick')</span>
<span style='color:#696969; '># ${2} PHP code snippet used for verification</span>
<span style='color:#696969; '># ${3} Expected result if test is successful</span>
<span style='color:#800000; font-weight:bold; '>function</span> verify_php <span style='color:#800080; '>{</span>
    <span style='color:#bb7977; font-weight:bold; '>echo</span> <span style='color:#0000e6; '>"Checking </span><span style='color:#797997; '>${1}</span><span style='color:#0000e6; '>"</span>
    <span style='color:#40015a; '>/etc/init.d/apache2</span> restart <span style='color:#008c00; '>1</span><span style='color:#e34adc; '>></span><span style='color:#40015a; '>/dev/null</span> <span style='color:#008c00; '>2</span><span style='color:#e34adc; '>>&amp;1</span>
    <span style='color:#bb7977; font-weight:bold; '>echo</span> <span style='color:#797997; '>${</span><span style='color:#008c00; '>2</span><span style='color:#797997; '>}</span> <span style='color:#e34adc; '>></span> <span style='color:#40015a; '>/var/www/index.php</span>
    <span style='color:#800000; font-weight:bold; '>if</span> <span style='color:#808030; '>[</span><span style='color:#0000e6; '>[ $(wget 127.0.0.1/index.php </span><span style='color:#808030; '>-</span><span style='color:#0000e6; '>O </span><span style='color:#808030; '>-</span><span style='color:#0000e6; '> 2>/dev/null) == ${3} </span><span style='color:#808030; '>]</span>]
        <span style='color:#800000; font-weight:bold; '>then</span>
        <span style='color:#bb7977; font-weight:bold; '>echo</span>  <span style='color:#0000e6; '>"</span><span style='color:#797997; '>${1}</span><span style='color:#0000e6; '> working correctly"</span>
    <span style='color:#800000; font-weight:bold; '>else</span>
        <span style='color:#bb7977; font-weight:bold; '>echo</span> <span style='color:#0000e6; '>"Could not verify a working </span><span style='color:#797997; '>${1}</span><span style='color:#0000e6; '> installation"</span>
    <span style='color:#800000; font-weight:bold; '>fi</span>
<span style='color:#800080; '>}</span>
</pre>

Funktionen i sig är väldigt enkel:

<ol>
<li>Ersätt <i>/var/www/index.php</i> med en rad PHP-kod som utför testet</li>
<li>Använd <i>wget</i> för att se resultatet av PHP-koden</li>
<li>Jämför utdatan från PHP-skriptet med ett förväntat resultat</li>
</ol>

<b>Exempel på tester</b>:

Testa om PHP fungerar korrekt. PHP-koden skriver ut användarens IP-adress. Det förväntade resultatet är <i>127.0.0.1</i> (localhost):

<pre style='color:#000000;background:#ffffff; border: 1px solid #000; padding: 10px;'>verify_php <span style='color:#0000e6; '>'PHP'</span> <span style='color:#0000e6; '>'&lt;?php echo $_SERVER["REMOTE_ADDR"]; ?>'</span> <span style='color:#0000e6; '>'127.0.0.1'</span>
</pre>

Testa om Imagick är installerat:

<pre style='color:#000000;background:#ffffff; border: 1px solid #000; padding: 10px;'>verify_php <span style='color:#0000e6; '>'Imagick'</span> <span style='color:#0000e6; '>'&lt;?php if ( ! class_exists("Imagick") ) { die("1"); } die("0"); ?>'</span> <span style='color:#0000e6; '>'0'</span>
</pre>

Testa om memcache fungerar korrekt. Ansluter till memcache och ger variabeln <i>var_key</i> ett värde:

<pre style='color:#000000;background:#ffffff; border: 1px solid #000; padding: 10px;'>verify_php <span style='color:#0000e6; '>'memcached'</span> <span style='color:#0000e6; '>'&lt;?php if ( ! function_exists("memcache_connect") ) { die(1); }<br /><br />$memcache_obj = memcache_connect("localhost", 11211);  <br /><br />memcache_set($memcache_obj, "var_key", "0"); die(memcache_get($memcache_obj, "var_key"));</span>
<span style='color:#0000e6; '>?>'</span> <span style='color:#0000e6; '>'0'</span>
</pre>


