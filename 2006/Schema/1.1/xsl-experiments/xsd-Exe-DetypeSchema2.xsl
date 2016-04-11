<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml SDD_DT.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
 <xsl:variable name="GeneratorCopyright">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!--  Did not manage to run the detyping transformation in a single pass, instead this fixes it up, if applied to the output of the first pass!
-->
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  
  <!-- The following include contains a match-all-copy-out rule (identity) -->  
  <xsl:include href="xsd-Incl-MatchAllAndCopyRule.xsl" />

  <!-- inserting types/group refs creates the problem that unique and keyref identity constraints may have duplicate names! The following rule fixes this: 
-->
  <!-- append id to the name attributes of xs:keyref|xs:unique to make them unique again!-->
  <xsl:template match="xs:keyref/@name|xs:unique/@name">
    <xsl:attribute name="name">
      <xsl:value-of select="." /><!-- copy existing value -->
      <xsl:value-of select="generate-id()" /><!-- append unique number to name attribute -->
    </xsl:attribute>
  </xsl:template>

  <!-- some complex types have 2 or more sequences in complex types
It would be good to merge them, but the problem is how?
A template with match="xs:complexType[count(./xs:sequence)>1]"
gets them, but I have no clue how to merge sister nodes in xslt...

#### CURRENTLY I STILL HAVE TO DO THIS MANUALLY!!!
One way to fix it is to remove the leading blanks and then search for </xs:sequence><xs:sequence>

#### Another thing to do manually is to remove top level annotations that make no sense any longer.
-->

</xsl:stylesheet>