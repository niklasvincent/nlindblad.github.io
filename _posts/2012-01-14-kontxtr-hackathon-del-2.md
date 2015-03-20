---
layout: post
title: 'Kontxtr-hackathon – Del 2'
tags:
  - foursquare
  - instagram
  - kontxtr
  - memcache
  - node-js
  - rabbitmq
  - twitter

---

Vårt nya back-end fungerar utan problem och är snabbare än någonsin. Allt innehåll (Tweets, bilder från Instagram, check-ins från Foursquare) sparas i minnet (Memcache) och i en databas (MySQL). Enbart Memcache används av själva presentationen, vilket i kombination med Node.js ger grym prestanda på leverans till klienterna (webbläsare). Databasen är för att i efterhand kunna erbjuda kunden historik för sitt evenemang.

Vi har även övergivit long-polling för att hämta nytt innehåll och valt att enbart köra websockets. Nedan följer en enkel översikt av arktitekturen:



<h2>RabbitMQ i PHP</h2>
Efter omfattande prestandatester har jag märkt att RabbitMQ är mycket mer stabilt än Beanstalkd vid hög belastning. Förklaringen kan delvis ligga i att RabbitMQ körs som ren PHP-extension (implementerad i C), medan de bibliotek jag har använt för Beanstalkd har varit skrivna i PHP.

Att installera <i>amqp</i> (RabbitMQ-klient) i PHP var inte helt trivialt:

<pre># hg clone http://hg.rabbitmq.com/rabbitmq-c rabbitmq-c
# cd rabbitmq-c/
# hg clone http://hg.rabbitmq.com/rabbitmq-codegen codegen
# autoreconf -i && ./configure && make && sudo make install
# cd ..
# wget http://pecl.php.net/get/amqp
# tar xvzf amqp-0.3.1.tgz 
# cd amqp-0.3.1/
# phpize && ./configure --with-amqp && make && make install
# echo 'extension = amqp.so' > /etc/php5/conf.d/amqp.ini 
# /etc/init.d/apache restart
</pre>


