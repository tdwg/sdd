<?xml version="1.0" encoding="iso-8859-1"?>
<?xmlspysamplexml UBIF_Enumerations.xhtml?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:variable name="GeneratorCopyright" select="'DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.'"/>
  <!-- ### I FAILED TO GET THIS WORKING!!!!!!!!!! -->

 <xsl:include href="xsl-Incl-TemplateTools.xsl"/>
 <!-- StringReplace, nbsp, GenericListTemplate, etc. -->
  
 <!-- The following include contains a match-all-copy-out rule (identity) <xsl:include href="xsd-Incl-MatchAllAndCopyRule.xsl" /> -->  
 
  <xsl:output method="text" encoding="iso-8859-1"  />
  
  <xsl:template match="/">
This output converts xhtml, especially tables in a format that can easily be copied into a TWIKI as used for UBIF and SDD

    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="p">
    <!-- remove the p around a paragraph, add return before and after 
    <xsl:copy-of select="./node()"/>
-->
<xsl:text>
                </xsl:text>
####<xsl:text/>
</xsl:template>

  <xsl:template match="table">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="td">
    <!-- replace closing td with bar -->
    <xsl:apply-templates/><xsl:text>####</xsl:text>
  </xsl:template>

</xsl:stylesheet>
