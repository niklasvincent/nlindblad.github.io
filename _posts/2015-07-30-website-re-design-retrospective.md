---
layout: post
title: "Website re-design retrospective"
language: english
category: posts
---

This website has not received a lot of attention in the past year or so, but recently I felt like doing a major re-design, using things I've picked up upon after having got more exposure to front-end web development.

## New hosting

As well as re-doing the Jekyll templating powering it, I changed the way the website is hosted. I used to run a Digital Ocean droplet and host the Jekyll generated HTML straight from the file system and serve it using Nginx.

The current version of the site uses:

	- AWS Route 53 for DNS
	- Nginx running on AWS EC2
	- Reverse proxying to content on Github pages

I chose this setup after much consideration, with the main motivation being that I did not want the web server to keep any state whatsoever. The thing stopping me from using AWS S3 hosting or relying solely on Github Pages is the fact that I prefer to serve my website over SSL.

The idea is that the webserver is essentially just performing SSL termination and reverse proxying, with a modest (about 10 minutes) cache time.

In the future I might look into building an optimised Nginx binary embedded together with my Nginx configuration into a Docker image, or a machine image on AWS. Similair to what we [are doing at The Guardian](https://github.com/guardian/machine-images) using [Packer](https://packer.io/), an awesome tool from the creator of Vagrant.

That would make re-deployments easier and make sure I can move to a new hosting solution to take advantage of better pricing (Packer supports Digital Ocean droplet images, AWS AMI and Docker).

## Use an asset pipeline for generating CSS

I've been using [Grunt](http://gruntjs.com/) (even though [@mossisen](http://mossisen.se/) politely pointed out I really should be using [Gulp](http://gulpjs.com/) instead).

The [`Gruntfile.js`](https://github.com/nlindblad/nlindblad.github.io/blob/4f5c12cac5a064d7244bcae3d45e96115791a1e2/Gruntfile.js) is not that complicated, it basically compiles some SASS in `_sass` and minifies it together with some pre-compiled stylesheets in `_css`. The result is placed in `_includes` and is then included inline in each generated page, since I found that greatly increases page load time and the GZIP compression makes sure the final size of the HTML is in the range of 10 - 20 KB.

## Minify HTML using an ordinary Jekyll template

Using [jekyll-compress-html](https://github.com/penibelst/jekyll-compress-html) the HTML is minified at compile time.

## Chased down broken links using LinkChecker

This blog started back in 2011 and used to be powered by Wordpress. Over the years it has been ported to different platforms, before I finally decided to stick with Jekyll.

The only thing I really miss at the moment is the fact that you cannot run anything but vanilla Jekyll on Github Pages, but it also forces me to actually read up on the Jekyll and Liquid documentation before trying to solve things using my own hacky plugins.

The images used on the blog has moved from being hosted via `wp-content` on the same server, to AWS S3 and now reside on AWS CloudFront.

To ensure I don't have any broken links, I used [LinkChecker](https://wummel.github.io/linkchecker/), a small Python program that recursively goes through a website and finds any broken links (both images and text links).

## Automatically list public Github repositories on a project page

When Jekyll is compiling the website on Github's servers, it has access to [some interesting metadata](https://help.github.com/articles/repository-metadata-on-github-pages/) about the current Github account the Github pages belong to.

I wanted to give a simplified view of my open source projects on Github using the `site.github.public_repositories` configuration variable, but sorted by the number of watchers on each repository. That way popular repositories would stay at the top, with the less interesting ones not getting in the way.

Here is a Gist for the Liquid template code required to achieve this:


<script src="https://gist.github.com/nlindblad/b9e48c409d49963b13d6.js"></script>

## Timeline on the about page

As my career has progressed, I decided to make a [visual timeline](/about.html#timeline) (based on [this example](https://codepen.io/P233/pen/lGewF)) instead of writing everything out in paragraphs.

## Future changes

I am still doing testing on different screen sizes and trying to optimise the fonts, but apart from that, I am very pleased with the new version!
