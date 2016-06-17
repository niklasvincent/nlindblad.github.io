---
layout: post
title: "Loading Configuration from S3 in Python AWS Lambda"
language: english
category: posts
---

I am currently rewriting some recurring background tasks as AWS Lambda functions. Instead of running underutilised servers with a few cronjobs, Lambda allows me to focus more on the solving the specific task and not having to care about servers.

I have been using a lambda to sync my [Splitwise](https://splitwise.com) budget to a Google Spreadsheet for quite some time now (which I am hoping to refactor a bit and open source). The lambda requires API keys for Splitwise, [Open Exchange Rates](https://openexchangerates.org/) and Google Docs.

In order to make configuration management easier, I wrote a small class that downloads a configuration file from a specified AWS S3 bucket and parses it using [ConfigParser](https://docs.python.org/2/library/configparser.html):

<script src="https://gist.github.com/nlindblad/73cd94cfb33730f3d9d4593e5a08e997.js"></script>

You can see it in action [in a lambda I wrote for relaying SNS messages to Telegram and/or Slack chat](https://github.com/nlindblad/chat-lambda/blob/master/src/main.py#L7).
