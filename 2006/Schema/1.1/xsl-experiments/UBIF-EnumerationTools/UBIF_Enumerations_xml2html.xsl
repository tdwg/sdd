<?xml version="1.0" encoding="iso-8859-1"?>
<?xmlspysamplexml UBIF_Enumerations.xml?>
<?xmlspysamplexml_otherfile SDD_Enumerations.xml?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ub="http://www.tdwg.org/2006/UBIF" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="ub">
  <xsl:variable name="GeneratorCopyright" select="'DiversitySchemaTools Version 0.5. Copyright (c) G. Hagedorn 2006."/>
  <!-- To be used on UBIF_Enumerations.xml, which in turn is generated from the enumerations present in the UBIF enumeration type library using UBIF_Enumerations.xsl -->

  <xsl:include href="xsl-Incl-TemplateTools.xsl"/>
  <!-- StringReplace, nbsp, GenericListTemplate, etc. -->

  <xsl:output method="xml" encoding="iso-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

  <!-- Some parts of the ub: namespace (the label formatting like em, strong, sub, etc.) should be treated as xhtml markup: -->
  <xsl:namespace-alias stylesheet-prefix="ub" result-prefix="#default"/>

  <!-- overwrite the built-in template which otherwise outputs element and attribute content: -->
  <xsl:template match="text()|@*"/>

  <xsl:template match="/ub:Datasets">
    <!-- The Datasets root template only provides the document frame. Otherwise, each Dataset in the collection is handled individually  -->
    <html>
      <head>
        <title>Documentation of UBIF enumerations</title>
        <meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
        <link href="http://160.45.63.11/Workbench02.CSS" type="text/css" rel="stylesheet"/>
        <link href="http://160.45.63.11/Workbench02p.CSS" type="text/css" rel="stylesheet" media="print"/>
      </head>
      <body lang="en-us">
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="ub:Dataset">
    <!-- Note: The Datasets root only provides the document frame. Otherwise, each Dataset in the collection is handled individually  -->
    <h1><xsl:copy-of select="ub:Metadata/ub:Description/ub:Representation[1]/ub:Title/node()"/></h1>
    <p><xsl:copy-of select="ub:Metadata/ub:Description/ub:Representation[1]/ub:Details/node()"/></p>
    <hr/>
    <xsl:apply-templates/>
    <hr/>
  </xsl:template>

  <xsl:template match="ub:Enumerations">    
    <h2><a name="toc">Contents</a></h2><!-- generate table of contents -->
    <xsl:for-each select="ub:Enumeration">    
          <xsl:variable name="PrefLabel" select="./ub:Label/ub:Representation[1]"/>
          &#160;-&#160;&#160;<a href="#{@key}"><xsl:value-of select="$PrefLabel/ub:Text/node()"/></a><br />
    </xsl:for-each>
    <p>&#160;</p>
    <hr/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ub:Enumeration">
    <h3><a name="{@key}"><xsl:copy-of select="ub:Label/ub:Representation[1]/ub:Text/node()"/></a></h3>
    <p><xsl:copy-of select="ub:Label/ub:Representation[1]/ub:Details/node()"/></p>     
    <xsl:apply-templates/>
    <p class="small"><a href="#toc">(Return to table of contents)</a></p> 
  </xsl:template>
  
  <xsl:template match="ub:Items">
    <xsl:variable name="HasAbbreviations" select="./ub:Item/ub:Label/ub:Representation/ub:Abbreviation"/>
    <xsl:variable name="HasDetails" select="./ub:Item/ub:Label/ub:Representation/ub:Details"/>
    <table width="100%" border="1" cellspacing="0" cellpadding="3" frame="hsides" rules="groups" summary="Items of the enumeration'">
      <!-- <colgroup>
 <col width="120" />
 <col width="80" />
 <col width="*" />
 <col width="20" />
 <col width="50" />
</colgroup> -->
      <thead>
        <tr class="header"><!-- should be valign="bottom", implicit in css class -->
          <th>Value</th>
          <xsl:if  test="$HasAbbreviations"><th>Abbrev.</th></xsl:if>          
          <th>Label</th><th>&#160;</th>
          <xsl:if  test="$HasDetails"><th>Details</th></xsl:if>          
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="./ub:Item">
          <xsl:variable name="PrefLabel" select="./ub:Label/ub:Representation[1]"/>
          <tr><!-- should be valign="top", implicit in css class -->
            <xsl:choose><!--  create rows with alternating background color! -->
              <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
              <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
            </xsl:choose>
            <td><xsl:value-of select="@key"/></td>
            <xsl:if  test="$HasAbbreviations"><td><xsl:value-of select="$PrefLabel/ub:Abbreviation/node()"/></td></xsl:if>            
            <td><xsl:value-of select="$PrefLabel/ub:Text/node()"/></td><td></td>
          <xsl:if  test="$HasDetails"><td><xsl:value-of select="$PrefLabel/ub:Details/node()"/></td></xsl:if>            
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
