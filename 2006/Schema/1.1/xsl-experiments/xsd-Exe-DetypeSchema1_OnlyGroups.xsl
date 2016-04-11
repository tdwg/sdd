<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml SDD_RDT.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
 <xsl:variable name="GeneratorCopyright">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
 <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
 <xsl:include href="xsd-Incl-MatchAllAndCopyRule.xsl" />

 <!-- Resolve group refs: -->
 <xsl:template match="xs:group[@ref]">
      <!-- replace any occurrence of a group ref with the group itself:-->
      <xsl:variable name="refvalue" select="./@ref" /><!-- inserting this directly below does NOT work!-->
      <xsl:variable name="parentname" select="name(..)" /><!-- important to see whether in a sequence or not-->
      <xsl:variable name="refobject" select="/xs:schema/xs:group[@name=$refvalue]" />
      <!-- Now go through children and copy most children, except some special ones, using a for-each loop:-->
      <xsl:for-each select="$refobject/*"><!-- go through children of group definition-->
        <xsl:choose>
          <xsl:when test="name(.)='xs:annotation'"><!-- do nothing --></xsl:when>
          <xsl:when test="name(.)='xs:sequence' and $parentname='xs:sequence'  ">
           <!-- Special functionality: if group contains a sequence, and also is already contained in a sequence, skip the sequence, insert the children of it instead! -->
             <xsl:apply-templates select="child::*"/>
          </xsl:when>
          <xsl:otherwise><!-- this includes xs:choice and all within a model group! -->
            <xsl:apply-templates select="."/><!-- output current node, using copy-all rule -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
 </xsl:template>

 <!-- Resolve attributeGroup refs: -->
 <xsl:template match="xs:attributeGroup[@ref]">
      <xsl:variable name="refvalue" select="./@ref" />
      <xsl:variable name="refobject" select="/xs:schema/xs:attributeGroup[@name=$refvalue]" />
      <xsl:for-each select="$refobject/*">
         <xsl:if test="name(.)!='xs:annotation'">
         <xsl:apply-templates select="."/>
       </xsl:if>
      </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>