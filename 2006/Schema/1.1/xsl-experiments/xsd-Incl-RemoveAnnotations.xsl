<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" >
 <xsl:variable name="GeneratorCopyrightBase_InclRemoveAnnotation">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!--   *** This rule is intended only for includes in other transformations! ***  -->  
  <!-- Match but do not copy the following items:  1. xml schema: Annotation -->
  <xsl:template match="xs:annotation"/>
 
 </xsl:stylesheet>