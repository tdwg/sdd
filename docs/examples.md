---
author: Gregor Hagedorn
---

GregorHagedorn - Mon Jan 18 2010 - Version 1.17

# Real world examples (SDD 1.1)

<p>To help application developers in understanding SDD and testing their software, we provide a number of "real world" example data sets for SDD, version 1.1. We try to provide different data sets with different properties and originating from different applications.</p>

<h2>1. Data sets for multi-access keys ("matrix keys")</h2>

<h3>Transformed DELTA example data set</h3>

<p><a target="_blank" href="http://delta-intkey.com/" title="DELTA and Intkey home page"><img src="http://delta-intkey.com/www/deltlogo.gif" alt="DELTA and Intkey home page" align="right" style="float:right;margin-left:20px;margin-bottom:10px"/></a>  <strong>Introduction:</strong> The following two datasets are either distributed together with the <a target="_blank" href="http://delta-intkey.com/" title="DELTA and Intkey home page">CSIRO DELTA programs</a>, or used in feature comparisons. They are provided here to help people with a DELTA background to understand the relation between SDD and DELTA.</p>

<p><strong>Description of data sets:</strong> The first data set is a minimal set with 4 characters and 3 descriptions of beetles. It is used as the example on <a target="_blank" href="http://delta-intkey.com/www/descdata.htm">Data Requirements for Natural-language Descriptions and Identification</a> and provided there in various formats (DELTA, NEXUS, Lucid Interchange Format File v. 1.1 (old version of Lucid), and XDELTA). The second set contains a larger character set and 14 grass species. It is distributed together with the DELTA programs (version from 2000, see "All programs (including Intkey)" on <a target="_blank" href="http://delta-intkey.com/www/programs.htm">DELTA Programs and Documentation</a>). The original DELTA file is ANSI (not ASCII) encoded and uses RTF for character markup. This example is provided both as a single-document and as a multifile xml-document set. The multifile approach uses multiple xml fragments that can be individually edited or placed in different repositories and which finally can be combined using xml entities into a "master-document". To some extent this mirror the most common use of DELTA using a folder plus multiple directive files.</p>

<p><strong>Data conversion:</strong> Both datasets were initially converted by importing the DELTA data into <a href="http://www.diversityworkbench.net/Portal/wiki/DiversityDescriptions">DiversityDescriptions 2.0 beta 10</a> and exported to SDD 1.1 from there. Since the SDD produced in this way contains various DiversityDescriptions-specific information, the datasets were slightly cleaned by hand afterwards.</p>

<p><strong>Copyright and license:</strong> Both datasets are used by specific permission by Mike Dallwitz 2008. They are not placed under a general license.</p>

<p><strong>SDD documents:</strong> </p>

<p>FOLLOWING ARE 3 BROKEN LINKS - NEED TO BE FIXED: </p>

<ul>
  <li><a href="examples/Beetles.sdd11.zip">Beetles.sdd11.zip</a>: Beetles dataset in SDD 1.1 format</li>
  <li><a href="examples/DELTA2000-Sample.sdd11.zip">DELTA2000-Sample.sdd11.zip</a>: DELTA.exe (2000) sample dataset on 14 Grass genera in SDD 1.1 format</li>
  <li><a href="examples/DELTA2000_Multifile.sdd11.zip">DELTA2000_Multifile.sdd11.zip</a>: As above, but using multiple xml fragments combined into a master document</li>
</ul>

<hr>

<h3>LIAS data set</h3>

<p><a target="_blank" href="http://www.lias.net/" title="LIAS project"><img src="http://www.lias.net/Pictures/LIAS_small.gif" alt="LIAS project" align="right" style="float:right;margin-left:20px;margin-bottom:10px"/></a> <strong>Introduction:</strong> <a href="http://www.lias.net/">LIAS</a> is a global information system for Lichenized and Non-Lichenized Ascomycetes. The vision of LIAS is to establish a non-commercial global information system for the collection and distribution of descriptive, phylogenetic, and other biodiversity data on these taxonomic groups that uses advanced technology and where published biodiversity data of all ascomycetes are joined in a multi-authored database and used for the most sophisticated queries. Specific goals are to</p>

<ul>
  <li>provide a working space for cooperation and collaboration of experts on ascomycetes in the Internet</li>
  <li>establish a multi-authored worldwide database on descriptive data of all ascomycetes</li>
  <li>design user-friendly web tools for an easier access and remote editing of database records via Internet</li>
  <li>offer a online database system for multiple usage and therewith dissemination of expert knowledge especially by providing public access to database generated identification keys and natural language description of ascomycetes</li>
  <li>promote the gathering, furnishing and administration of data by experts in a standard database system which allows an information deposit for individual use only (e. g. for revision) and &#8211; after agreement &#8211; the public access to the data via Internet</li>
  <li>promote common standards on descriptive data connected with taxonomic names of ascomycetes to facilitate interoperability and data exchange</li>
</ul>

<p>LIAS is the work of many collaborators. The primary editors are G. Rambold and D. Triebel. Cooperating Institutions are the <a href="http://www.mycology.uni-bayreuth.de" target="_blank">University of Bayreuth, Department of Mycology</a>, <a href="http://www.botanischestaatssammlung.de" target="_blank">Botanische Staatssammlung München</a>, <a href="http://nhc.asu.edu/lichens/" target="_blank">Arizona State University, Department of Plant Biology</a>, <a href="http://www.biologie.uni-hamburg.de/ialb/herbar/hbg_02.htm" target="_blank">University of Hamburg, Herbarium Hamburgense</a>, and the <a href="http://www.toyen.uio.no/botanisk/bot-mus/english_index.html" target="_blank">University of Oslo, Botanical Museum</a>. It is or was supported by funds from the <a href="http://www.stmwfk.bayern.de/index.html" target="_blank">Bayerisches Staatsministerium für Wissenschaft, Forschung und Kunst</a>, <a href="http://www.bmbf.de/" target="_blank">Bundesministerium für Bildung und Wissenschaft (BMBF)</a>, <a href="http://www.dfg.de/" target="_blank">Deutsche Forschungsgemeinschaft (DFG)</a>, and <a href="http://www.naturwissenschaftlichesammlungenbayerns.de/" target="_blank">Staatliche Naturwissenschaftliche Sammlungen Bayerns</a>.</p>

<p><strong>Description of data set:</strong> The data set provided here is the complete <a href="http://www.lias.net/">LIAS</a> main data set as of 2007-07. It provides descriptions of 2480 genera and species of lichens using 987 characters with a total of 7632 categorical state definitions (plus 3128 status values or statistical measures for quantitative characters). The descriptions are atomized to a total of 221821 values. Only relatively few characters and states are "pseudo-" or "management-characters", dealing with taxonomy, revision management, etc. Of the total LIAS main character data matrix of 2480x987 = 2447760 cells, 157041 cells are filled (6.4%). Part of this low fill factor is due to the taxonomic diversity encompassed in the data set, but it also shows that significant work still has to be done.</p>

<p><strong>Related data sets:</strong> Two datasets are closely related with "LIAS main": (1) <a href="http://liaslight.lias.net/">LIAS light</a> contains fewer characters but has been more extensively revised and has a higher fill factor. It is therefore more suitable for practical identification and currently strongly expanded as part of two major joint projects: the <a href="http://www.biota-africa.org">BIOTA Africa</a> project and the <a href="http://nhc.asu.edu/lichens/flora/flora.jsp">Greater Sonoran Desert Lichen Flora</a>. (2) A key to around 700 powdery mildews (Erysiphales), which for reasons convenience is coupled with LIAS main, has been excluded from this release.</p>

<p><strong>Data conversion:</strong> The "LIAS main" dataset is managed in <a href="http://www.diversityworkbench.net/Portal/wiki/DiversityDescriptions">DiversityDescriptions</a>; the attached SDD 1.1 export file was created by the <nop>DiversityDescriptions export routine.</p>

<p><strong>Highlights for testing SDD:</strong> The LIAS dataset is a large dataset and is especially suitable for testing the behavior of an application with large and rich keys.</p>

<p><strong>Copyright and license:</strong> The "LIAS main" dataset attached here is © 1996-2007 by Botanische Staatssammlung München. All rights reserved. It is here released under the Creative Commons non-commercial, by attribution, share-alike license in version 2.5. Further details are included in the file itself.</p>

<p><strong>SDD document:</strong> <a href="examples/LIAS_Main.sdd11.zip">LIAS_Main.sdd11.zip</a>: LIAS Main dataset in SDD 1.1 format</p>

<hr>

<h3>Interactive Key to Species of Erythroneura</h3>

<p><strong>Introduction:</strong> The <a href="http://ctap.inhs.uiuc.edu/dmitriev/key.asp?key=Erythroneura&lng=En&i=1&keyN=2">Interactive Key to Species of the Genus Erythroneura (Homoptera, Cicadellidae)</a> by D. Dmitriev & C. Dietrich is also available online under the <a href="http://ctap.inhs.uiuc.edu/dmitriev/">3I software</a> created by Dmitry A. Dmitriev. 3I (Internet-accessible Interactive Identification) is a set of software tools for creating on-line identification keys, taxonomic databases, and virtual taxonomic revisions. By organizing illustrations and nomenclatural, morphological, bibliographical, and distributional data into a single database 3I also facilitates production of traditional, printed taxonomic papers and monographs. As such it is more comprehensive that SDD alone, pointing into the direction into which SDD plans to evolve (online monographs including nomenclature as well as descriptions and identification tools).</p>

<p><strong>Description of data set:</strong> The data set is a small sized key for 54 taxa, using 42 characters, 171 categorical state definitions, and 2401 values. It contains only a single quantitative character.</p>

<p><strong>Data conversion:</strong> The export to SDD occurred indirectly, importing the original 3I database into <a href="http://www.diversityworkbench.net/Portal/wiki/DiversityDescriptions">DiversityDescriptions</a> (converter available since version 2.0) and creating SDD from there. As a result, some details (specimen, nomenclature, publication data), which could in principle be expressed in SDD 1.1, were lost because they were not fully supported by <nop>DiversityDescriptions.</p>

<p><strong>Highlights for testing SDD:</strong> The dataset is a small fully revised and published dataset with rich illustrations. Although the images are not included here, as of 2007-10-12 the given URLs were resolvable. Note: the dataset does not use any Status values ("unknown", "not applicable", etc.).</p>

<p><strong>Copyright and license:</strong> The Erythroneura dataset attached here is © 2003-2006 D. Dmitriev & C. Dietrich. The SDD version is released here under the Creative Commons non-commercial, by attribution, share-alike license in version 2.5. </p>

<p><strong>SDD document:</strong> <a href="examples/Erythroneura.sdd11.zip">Erythroneura.sdd11.zip</a>: D.Dmitriev's Erythroneura key in SDD 1.1 format</p>

<hr>

<h3>An Interactive Key to Tribes of Leafhoppers / &#1048;&#1085;&#1090;&#1077;&#1088;&#1072;&#1082;&#1090;&#1080;&#1074;&#1085;&#1072;&#1103; &#1054;&#1087;&#1088;&#1077;&#1076;&#1077;&#1083;&#1080;&#1090;&#1077;&#1083;&#1100;&#1085;&#1072;&#1103; &#1058;&#1072;&#1073;&#1083;&#1080;&#1094;&#1072; &#1062;&#1080;&#1082;&#1072;&#1076;&#1086;&#1082; (Cicadellidae, in English and Russian)</h3>

<p><strong>Introduction:</strong> This key by D. Dmitriev & C. Dietrich is used to demonstrate the multilingual properties of the <a href="http://ctap.inhs.uiuc.edu/dmitriev/">3I software</a> and is available in <a href="http://ctap.inhs.uiuc.edu/dmitriev/key.asp?key=Cicnymph&i=1&lng=En">English</a> and <a href="http://ctap.inhs.uiuc.edu/dmitriev/key.asp?key=Cicnymph&i=1&lng=Ru">Russian</a>. See the "Interactive Key to Species of Erythroneura" above for further information on 3I.</p>

<p><strong>Description of data set:</strong> The data set is a small to medium sized key for 152 taxa, using 146 characters, 414 categorical state definitions, and 13252 values. It contains no quantitative or text characters. The revision of the dataset is not complete.</p>

<p><strong>Data conversion:</strong> The export to SDD occurred indirectly, importing the original 3I database into <a href="http://www.diversityworkbench.net/Portal/wiki/DiversityDescriptions">DiversityDescriptions</a> (converter available since version 2.0) and creating SDD from there. As a result, some details that could in principle be expressed in SDD 1.1, were lost because they were not fully supported by <nop>DiversityDescriptions.</p>

<p><strong>Highlights for testing SDD:</strong> This dataset is provided as a fully multilingual dataset. Note that at the moment the natural language features are only partly exported in both languages; this is solely due to incomplete conversion, neither to 3I nor SDD.</p>

<p><strong>Copyright and license:</strong> The "Key to Tribes of Leafhoppers" dataset attached here is © 2003-2006 D. Dmitriev & C. Dietrich. The SDD version is released here under the Creative Commons non-commercial, by attribution, share-alike license in version 2.5. </p>

<p><strong>SDD document:</strong> <a href="examples/Cicad.sdd11.zip">Cicad.sdd11.zip</a>: D.Dmitriev's English/Russian multilingual example data set.</p>

<hr>

<h2>2. Data sets for natural language descriptions including markup</h2>

<p>(None at the moment, please help us providing such a data set!)</p>

<hr>

<h2>3. Data sets for branching (static dichotomous or polytomous) keys</h2>

<h3>Dichotomous key to higher plants from Val Rosandra (Italy)</h3>

<p>This SDD dataset is an export of the <a href="http://www.dryades.eu">FRIDA</a> key to the higher plants of the <a href="http://www.comune.san-dorligo-della-valle.ts.it/">Val Rosandra nature reserve</a> in Italy. The original FRIDA key is available <a href="http://dbiodbs.units.it/carso/chiavi_pub21?sc=67">online</a>. The dataset has been created as a prototype for more widespread adoption of SDD in the context of the <a href="http://www.keytonature.eu/">Key to Nature</a> EU project.</p>

<p><strong>Description of data set:</strong> The data set is a medium to large sized dichotomous key covering 1149 taxa in 1154 couplets (2308 leads). 1949 images are linked into the key. The dichotomous key itself is fully translated to English. It key contains a single inner reticulation (where a lead can be reached by multiple paths) and many "terminal reticulations", i.e. taxa that are keyed out multiple times. It also contains 400 Italian natural language descriptions. In addition to the real FRIDA key, the dataset contains a second dummy key, to illustrate two points: a) a dataset may have multiple labeled keys, b) the optional question/answer style available in SDD.</p>

<p><strong>Data conversion:</strong> The dataset is semi-manual prototype export from the FRIDA database. It is planned that the export routine will be fully automatized and that all available FRIDA keys will in the future be also available in SDD format.</p>

<p><strong>Copyright and license:</strong> The "Val Rosandra" dataset attached here is © 2008 P.L. Nimis & S. Martellos. The SDD version is released here under the Creative Commons non-commercial, by attribution, share-alike license (Creative Commons 3.0 NC-BY-SA unported).</p>

<p><strong>SDD document:</strong> <a href="examples/Val-Rosandra-FRIDA-Key.sdd11.zip">Val-Rosandra-FRIDA-Key.sdd11.zip</a>: Dichotomous key to higher plants from Val Rosandra (Italy).</p>

<h3>Key to Dutch reptiles and amphibians (by ETI)</h3>

<p><a target="_blank" href="http://www.eti.uva.nl/" title="ETI ~BioInformatics home page"><img src="http://www.keytonature.eu/mediawiki/images/c/c0/Logo-Eti.png" alt="ETI ~BioInformatics home page" align="right" style="float:right;margin-left:20px;margin-bottom:10px"/></a>  The dataset has been created as a prototype while implementing SDD in the <a target="_blank" href="http://www.eti.uva.nl/">ETI <nop>BioInformatics</a> mobile key created in the context of the <a href="http://www.keytonature.eu/">Key to Nature</a> EU project. Its goal is to create a small, but realistic identification dataset for testing purposes, combining several features of SDD. </p>

<p><strong>Description of data set:</strong> The taxon names here contain atomized data (<nop>CanonicalName; this is the only dataset that features this), the key is dual language in Dutch and English. The key contains only categorical characters (no quantitative or text). The characters are labeled in question style, with the states giving the answers. Each taxon has a short Natural Language description (plain text without semantic markup; note that the English text is not a fully reflection of the Dutch). The key contains both coded descriptions to use with a multi-access key, and a manually created, fixed single-access key (polytomous). The latter in part uses question/answer style ("Does it have legs? yes/no"), in part couplet style with leads ("Warty skin, pupil horizontal/Warty skin, pupil vertical/Smooth skin, pupil vertical"). The size of the data set is small, with 24 taxa and 20 characters.</p>

<p><strong>Data conversion:</strong> The dataset is semi-manual prototype export from ETI data.</p>

<p><strong>Copyright and license:</strong> The dataset attached here is © 2008 ETI. The SDD version is released here under the Creative Commons non-commercial, by attribution, share-alike license (Creative Commons 3.0 NC-BY-SA unported).</p>

<p><strong>SDD document:</strong> <a href="examples/ETI_rept_amph_key.sdd11.xml.zip">ETI_rept_amph_key.sdd11.xml.zip</a>: Key to Dutch reptiles and amphibians (by ETI)</p>

<hr>

<p>-- Main.GregorHagedorn - 20 Nov 2008</p>
