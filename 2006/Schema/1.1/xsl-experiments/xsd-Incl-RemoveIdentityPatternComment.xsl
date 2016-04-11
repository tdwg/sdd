<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" >
 <xsl:variable name="GeneratorCopyrightBase_InclRemoveIdentity">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!--   *** This rule is intended only for includes in other transformations! ***  -->
  
  <!-- Match but do not copy the following items:  1. identity constraints, 2. patterns. 
Note: Comments are always removed already by the Match-All-Rule usually used, so the "|comment()" is redundant. It is still left here in case this include rule is combined with another rule.  -->
  <xsl:template match="xs:unique|xs:key|xs:keyref|xs:pattern|comment()"/>
 
 </xsl:stylesheet>