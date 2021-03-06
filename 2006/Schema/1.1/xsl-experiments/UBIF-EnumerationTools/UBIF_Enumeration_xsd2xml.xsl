<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml UBIF_EnumLib.xsd?>
<?xmlspysamplexml_OtherFiles SDD.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tdwg.org/2006/UBIF" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"   xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd" exclude-result-prefixes="xs">
 <!-- Note: Although xmlns:xs is not used in the output tree, without exclude-result-prefixes the namespace declaration would be copied to output.-->
 <!-- Note: exclude-result-prefixes seems to be broken in altova xml spy. It still appears in the output on the br elements (although in the input these only contain UBIF namespace content) and even in weird places outside elements (after comments). The following statement attempts to fix this, but it does not help!!-->
   <xsl:namespace-alias stylesheet-prefix="xs" result-prefix="#default" />

 <!-- I also want to output  xsi:schemaLocation="http://www.tdwg.org/2006/UBIF UBIF_Enumerations.xsd" in the root of output tree. However spy always seems to crash, regardless whether I put it into xsl:stylesheet above, or <Datasets> below! What can I do? -->
 
 <!-- ### Therefore, currently manual fixing of result xml is necessary:
1.  replace 
      xmlns:xs="http://www.w3.org/2001/XMLSchema" 
     with nothing
2. Insert
 xsi:schemaLocation="http://www.tdwg.org/2005/UBIF UBIF_Enumerations.xsd" 
    into the root 
3. Manually update the datetime attribute
4. Save the file as "UBIF_Enumerations.xml" and transform it with UBIF_Enumerations_xml2html.xsl
-->

 <xsl:variable name="GeneratorVersion" select="'0.5'"/>
 <xsl:variable name="GeneratorCopyright" >DiversitySchemaTools Version <xsl:value-of select="$GeneratorVersion"/>. Copyright (c) G. Hagedorn 2006.</xsl:variable> 
 <xsl:variable name="LabelDelimiter" select="' -- '" />

<!-- 
To be used on the UBIF_Lib.xsd w3c schema document. 
The stylesheet converts selected enumerations into an xml file that can easily be used to create a user interface. 
To do this, the following conventions are used: 
-->
  <xsl:include href="xsl-Incl-TemplateTools.xsl" /><!-- StringReplace, nbsp, GenericListTemplate, etc. -->
  <!-- overwrite the built-in template which otherwise outputs all element and attribute content: -->
  <xsl:template match="text()|@*"/>
  <xsl:output method="xml" encoding="iso-8859-1" />
  
  <xsl:template match="/xs:schema">
   <Datasets>
    <TechnicalMetadata created="9999-01-01T00:00:00"><xsl:comment>This should be changed to the true current date (e.g. 2004-08-13T00:00:00), not possible with standard xslt 1.0!</xsl:comment><!--   (In the future may use processor-specific extension, or perhaps xslt 2.0 current-date()?)-->
      <Generator name="{$GeneratorCopyright}" version="{$GeneratorVersion}"/>      
    </TechnicalMetadata>   
   <Dataset xml:lang="en">
    <Representation><Label>Enumerated Values for application building</Label>
      <Detail>This document is generated by an xslt script from the enumerations present in the following schema: "<xsl:value-of select="@version"/>". It is provided as an html and xml file. The html representation is intended for documentation and to improve discussion and correction of errors (please comment on http://wiki.tdwg.org/@@@EnumeratedValues). The xml representation follows the general conventions of UBIF documents and may be easier to import or integrate into user interfaces than the schema itself. This is especially true for SDD documents, where a large part of the terminology is provided in the form of data documents by the experts of a given knowledge domain. This document can be used side-by-side as schema-defined terminology with user-defined terminology. @@@ Note that a special UBIF payload schema Enumeration is defined in the schema UBIF_Enumerations.xsd, with which the xml version of this file can be validated.@@@</Detail>
      </Representation>
      
    <DescriptiveConcepts>
    <xsl:apply-templates />
    </DescriptiveConcepts>
    </Dataset>
   </Datasets>
  </xsl:template>
  
  <xsl:template match="xs:simpleType[./xs:restriction/xs:enumeration] | xs:simpleType[./xs:union]">
  <!-- this matches only xml schema simple types containing a list of enumerated values, and type unions ### should better be restricted to [@name="*Eum"] needs testing! ### -->
  <DescriptiveConcept id="{@name}">
    <xsl:variable name="enumlabel" select="@name" />

    <Label><xsl:comment>(label to entire enumeration to support documenting tools; most applications don't need this)</xsl:comment>
    <xsl:for-each select="xs:annotation/xs:documentation">
      <Representation><xsl:attribute name="language"><xsl:value-of select="@xml:lang" /></xsl:attribute>
        <Label><!-- For labels to the entire enumeration, output the type name as label, suppressing the "Enum" at the end of the name -->
          <xsl:call-template name="StringReplace" >
            <xsl:with-param name="string" select="$enumlabel"/>
            <xsl:with-param name="pattern" select="'Enum'"/>
            <xsl:with-param name="replacement" select="''"/>
        </xsl:call-template>
        </Label>
        <Details>
          <xsl:copy-of select="./node()" /><!-- copy-of copies nodes including html p/li, value-of would only copy the text. Select="." would include the xs:documentation, node() gives the content! -->
          <!-- for unions list the member types (the Items list below is not yet created to show the union member items) -->
          <xsl:if test="../../xs:union/@memberTypes"> [The following types are members of this union: <xsl:value-of select="../../xs:union/@memberTypes" />]</xsl:if>
        </Details><!-- = the current annotation -->
      </Representation>  
    </xsl:for-each>  
    </Label>
    <xsl:choose>
       <xsl:when test="xs:restriction/xs:enumeration">
    <ConceptStates>
       <xsl:apply-templates select="xs:restriction/xs:enumeration"/>
    </ConceptStates>
       </xsl:when>
       <xsl:when test="xs:union">
       <ConceptStates><!-- output the member items here! -->
            <xsl:call-template name="UnionGetEnumeratedValues"><xsl:with-param name="UnionMemberTypes" select="xs:union/@memberTypes"/></xsl:call-template> 
      </ConceptStates>
       </xsl:when>
       <xsl:otherwise>
         <xsl:comment>THIS should be a BUG!</xsl:comment>
       </xsl:otherwise>
    </xsl:choose>
  </DescriptiveConcept>
  </xsl:template>

  <xsl:template match="xs:enumeration"><!-- this matches a single enumerated item -->
    <StateDefinition>
      <xsl:attribute name="id"><xsl:value-of select="@value" /></xsl:attribute>
      <Representation>
      <xsl:for-each select="xs:annotation/xs:documentation">
        <Label><xsl:attribute name="language"><xsl:value-of select="@xml:lang" /></xsl:attribute>
        <!-- For enumeration item labels, try to split Label text and details at $LabelDelimiter. This may be with or without abbreviation:
          a) "[-CI{ParameterValue}] - - Lower limit of {ParameterValue}% confidence interval for mean. - - The confidence interval is defined as ...", or
          b) "Sample size - - The number of objects studied" -->
        <xsl:choose>
           <xsl:when test="contains(., $LabelDelimiter)">
              <xsl:variable name="LabelPart1" select="substring-before(., $LabelDelimiter)" />
              <xsl:variable name="LabelPart2" select="substring-after(., $LabelDelimiter)" />
              <xsl:choose>
                 <xsl:when test="starts-with($LabelPart1,'[')"><!-- i.e. this is Abbreviation; try splitting 2nd part into text and details -->
                    <xsl:choose>
                       <xsl:when test="contains($LabelPart2, $LabelDelimiter)"><!-- Text and Details (and Abbreviation) present -->
                          <Label role="full"><xsl:value-of select="substring-before($LabelPart2, $LabelDelimiter)"/></Label>
                          <Label role="abbrev"><xsl:value-of select="substring($LabelPart1, 2, string-length($LabelPart1)-2)"/><!-- trimming square brackets! --></Label>
                          <Details><xsl:value-of select="substring-after($LabelPart2, $LabelDelimiter)"/></Details>                    
                       </xsl:when>
                       <xsl:otherwise><!-- only Text (and Abbreviation) present -->
                          <Label role="full"><xsl:value-of select="$LabelPart2"/></Label>
                          <Label role="abbrev"><xsl:value-of select="substring($LabelPart1, 2, string-length($LabelPart1)-2)"/><!-- trimming square brackets! --></Label>                          
                       </xsl:otherwise>
                    </xsl:choose>
                 </xsl:when>
                 <xsl:otherwise><!-- Text and Details (and NO Abbreviation) present -->
                    <Label role="full"><xsl:value-of select="$LabelPart1"/></Label>
                    <Details><xsl:value-of select="$LabelPart2"/></Details>                    
                 </xsl:otherwise>
              </xsl:choose>
           </xsl:when>
           <xsl:otherwise><!-- Only Text (NO Details or Abbreviation) present -->
              <Label role="full"><xsl:value-of select="." /></Label>
           </xsl:otherwise>
        </xsl:choose>
        </Label>
      </xsl:for-each>
      </Representation>
      <!-- optionally, enumerated items may contain specification in appinfo, which is copied directly: -->
      <xsl:copy-of select="xs:annotation/xs:appinfo/Specification"/>
      <!-- Specification element should be removed here, i.e. only the content should be copied! -->
    </StateDefinition>
  </xsl:template>

<xsl:template name="UnionGetEnumeratedValues"> 
  <xsl:param name="UnionMemberTypes" select="''"/>
  <xsl:choose> <!-- recurse through the blank-separated list of member type names: -->
    <xsl:when test="contains($UnionMemberTypes, ' ')"> 
      <xsl:call-template name="UnionGetEnumeratedValues"> 
        <xsl:with-param name="UnionMemberTypes" select="substring-before($UnionMemberTypes, ' ')"/> 
      </xsl:call-template> 
      <xsl:call-template name="UnionGetEnumeratedValues"> 
        <xsl:with-param name="UnionMemberTypes" select="substring-after($UnionMemberTypes, ' ')"/> 
      </xsl:call-template> 
    </xsl:when> 
    <xsl:otherwise><!-- handle a single type, retrieve enumerated values from type referred to in the Union  -->
       <xsl:apply-templates select="/xs:schema/xs:simpleType[@name=$UnionMemberTypes]/xs:restriction/xs:enumeration"/>
    </xsl:otherwise> 
  </xsl:choose> 
</xsl:template> 

</xsl:stylesheet>