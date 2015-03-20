---
layout: post
title: 'Spara alla grafer i MatLab'
language: swedish
tags:
  - grafer
  - matlab

---

<p>En funktion i MatLab som jag använder flitigt är en egen funktion <i>SaveAllFigures</i> som sparar alla grafer från körningen i valfritt filformat med bibehållen numrering:</p>

<pre lang="matlab">function SaveAllFigures(opt,filetype)

if nargin == 0
opt='Unknown';
end
if nargin < 2
filetype = 'fig';
end

ChildList = sort(get(0,'Children'));
for cnum = 1:length(ChildList)
if strncmp(get(ChildList(cnum),'Type'),'figure',6)
saveas(ChildList(cnum), ['graf', opt, '_', num2str(ChildList(cnum)), '.' filetype]);
end
end</pre>

<p>Spara koden ovan i en fil vid namn <i>SaveAllFigures.m</i> och se till att den finns i katalogen där du kör din MatLab-kod.</p>

<p>Genom att anropa</p>

<pre lang="matlab">
SaveAllFigures('', 'pdf');
SaveAllFigures('', 'png');
</pre>

<p>i slutet av MatLab-koden så kommer samtliga ritade grafer att sparas som både PDF och PNG. Perfekt för labbrapporten.</p>

<p></p>
