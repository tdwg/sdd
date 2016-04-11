<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml UBIF_RDT.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
  <xsl:variable name="GeneratorCopyright">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!--  

-->
  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>
  <xsl:template match="text ()"/>
  <xsl:template match="Stereo[QuadraphonicDiscPlayer][count (Speaker) &lt; 4]">
    <xsl:text>ERROR:  Quadraphonic sound source without enough speakers.
</xsl:text>
  </xsl:template>
  <xsl:template match="Stereo[count (CDPlayer | Turntable | CassetteDeck | QuadraphonicDiscPlayer) = 0]">
    <xsl:text>ERROR:  Stereo system must have at least one sound source.
</xsl:text>
  </xsl:template>
</xsl:stylesheet>
