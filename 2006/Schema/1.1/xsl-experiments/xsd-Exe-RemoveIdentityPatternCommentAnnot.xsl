<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml UBIF_EnumLib_JOINED.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
 <xsl:variable name="GeneratorCopyrightBase">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!-- To be used on a w3c schema document.  Returns a w3c xml schema for SDD that is reduced in its content. 
  This is a weak reduction, removing only identity constraints, patterns, and comments. It can be used on its own, or included in other reduction templates.
  -->
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  
    <!-- The following includes contain
   - a match-all-copy-out rule (identity) 
   - removal of identity constraints, patterns, comments  -->
  <xsl:include href="xsd-Incl-MatchAllAndCopyRule.xsl" />
  <xsl:include href="xsd-Incl-RemoveIdentityPatternComment.xsl" />  
   <!-- Annotations are removed, e.g., from the UBIF_EnumLib.xsd! -->
  <xsl:include href="xsd-Incl-RemoveAnnotations.xsl" />  
   <!-- -->  
 </xsl:stylesheet>