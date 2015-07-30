---
layout: post
title: "Master Thesis Colophon"
language: english
category: posts
---

In June I presented the final version of my master's thesis *Simulations of III-V NWFET Double-Balanced Gilbert Cells with an Improved Noise Model*. I will link to it when it becomes available online through the Lund University website.

In this post I am going to summarise the different tools and tricks used in the making of the thesis report.

## Git for Revision Control ##
I have been using [BitBucket](https://bitbucket.org) for years to handle software projects, both for customers and things I do in my spare time. Both [BitBucket](https://bitbucket.org) and [GitHub](http://github.com) offer accounts with private repositories for students.

Git allows for selectively committing certain lines within a file, which helps with keeping commits clean and easy to follow. However, using this feature from the command line might sometimes be a daunting task. I used [SourceTree](http://www.sourcetreeapp.com/) to work with my main Git repository.

<img width="800px" src="{{ site.cloudfront_url }}/images/sourcetree.png" />

I used a Git post.commit hook (*.git/hooks/post-commit*) in order to include the current Git revision in my LaTeX document:


{% highlight bash %}
REVISION_FILE="$(pwd|sed -e 's/thesis.*//g')thesis/version.tex"
git log --pretty=format:'%h' -n 1 > "${REVISION_FILE}"</pre>
{% endhighlight %}

After including *version.tex* in the header, the result looked like this:

<img src="{{ site.cloudfront_url }}/images/git-revision-latex.png" style="border: 1px solid black;" />

## LaTeX for Typesetting ##
I used a LaTeX template I have had laying around since freshman year for lab reports. Most universities provide their own templates and it turns out I should probably have gone with [the standard one by the faculty](http://www.eit.lth.se/index.php?gpuid=285&L=1).

Using the hyperref package and some nice options from the xcolor package, the final PDF had clickable hyper references for things like citations and definitions:

<img src="{{ site.cloudfront_url }}/images/pdf-hyperref.png" style="border: 1px solid black;" />

The document class is *article* and the following packages were used:

* graphicx
* wrapfig
* amsmath
* import
* inputenc
* fontenc
* fancyhdr
* float
* hyperref
* doi
* glossaries
* pbox
* tikz
* pgf
* amsfonts
* listings
* color
* booktabs
* xcolor
* mhchem
* amsthm
* setspace
* biblatex

## MatLab for Plotting ##
For prettier plots rendered by LaTex I used [Matfig2PGF](http://www.mathworks.com/matlabcentral/fileexchange/12962-matfig2pgf) for all MatLab exports:

{% highlight matlab %}
matfig2pgf('figwidth', 17, 'filename', '../../doc/figures/asymmetrical_scaling.pgf');
{% endhighlight %}

The final plots are instructions for the PGF package on how to render using LaTeX. This means the fonts used in the plot will be the same as the rest of the document.

<img src="{{ site.cloudfront_url }}/images/pgfplot.png" />

## Google Docs for Drawing Figures ##
The thesis relies heavily on electrical circuit schematics, but none of the tools I tried ([Circuit Lab](https://www.circuitlab.com/), [Scheme-it](http://www.digikey.com/schemeit)) produced satisfying results. I ended up using [this Google Docs Drawing template](https://drive.google.com/previewtemplate?id=1M00TjVs5Kp4BvP4EY3FMdINx2WzSoTNyclcNM8e7DUc#).

Of course Google Docs Drawings do not treat lines as wires or provide easy snapping for perfect alignment, so everything was done *by hand*. Placing components, drawing lines, adjusting for alignment, etc.

<img src="{{ site.cloudfront_url }}/images/gdoc-circuit.png" />

After exporting to PDF from Google Docs I used [PDFCrop](http://pdfcrop.sourceforge.net/) (a small Perl script) for removing unnecessary white space.

## References using DOI ##
I found most of the published work I cite through [IEEE Xplore](http://ieeexplore.ieee.org/) and I used a set of shell scripts to manage a directory structure for each reference to keep them numbered and searchable (kind of rolling my own citation software).

To get BibTex entries for each article I found something really neat about the DOI (Digital Object Identifier) format, which most publications use today. You can actually request a citation in BibTex format directly:

{% highlight bash %}
function retrieve_bibtex()
{
	curl -LH "Accept: application/x-bibtex" "http://dx.doi.org/${1}"
}
{% endhighlight %}

I also made sure the citations in the report are clickable and [link to their appropriate DOI](http://tex.stackexchange.com/questions/3802/how-to-get-doi-links-in-bibliography).
