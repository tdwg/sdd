<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" >
 <xsl:variable name="GeneratorCopyrightBase_InclMatchAllRule">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!-- To be used on a w3c schema document.  Returns a w3c xml schema for SDD that is identical with the input. 
   *** This rule is intended only for includes in other transformations! ***
  -->
  <!-- Match all nodes and attributes (but not xml comments, these are always removed!)-->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Default values for some schema attributes are inserted during validation. Remove them again: -->
  <xsl:template match="@nillable[.='false'] | @abstract[.='false'] | @mixed[.='false']"/>
  <xsl:template match="@maxOccurs[.=1] | @minOccurs[.=1]"/>
  
 </xsl:stylesheet>