<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml UBIF_RDT.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
 <xsl:variable name="GeneratorCopyright">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!--  To be used on a w3c schema document.   Returns a w3c xml schema where complex types and element/attribute group refs are inserted directly.
  This is intended to provide better overview or as an introduction to the SDD schema.

Known defects:
 - #### Many xs:key/keyrefs seem to get lost i.e. copying is incomplete. This should be easy to fix, just needs careful debugging...
 - complex type recursion is excluded only using an SDD specific list! I tried to solve this, but no solution was found.
 - type extension recursion is not yet excluded (occurs e.g. when adding attributes at the point of recursion!) 
 - element group recursion is not yet excluded since not relevant for SDD. Solution would follow complex type recursion solution
-->
 <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />

  <!-- The following include contains a match-all-copy-out rule (identity) -->  
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

 <!-- Do not copy group and attributeGroup definitions to output:
      (they can be removed already in the first pass - available in input tree for copying, but not copied to output) -->
 <xsl:template match="xs:group[@name]|xs:attributeGroup[@name]"/>

 <!-- ============================================ -->

 <!-- Preparations for inserting complex types: -->
   <xsl:variable name="ctypes" select="/xs:schema/xs:complexType[@name] | /xs:schema/xs:redefine/xs:complexType[@name]" />
 <!-- Note: it is important to exclude any recursive type usage. As shown in more detail in the SchemaReport.xsl code, it is easy to find directly recursive complex types, but I did not find an xpath that produces a node set for indirect recursion. The schema report lists them using a double loop (and that could be extended to 3-step removed recursions.
 At the moment, the list of known recursive types can be verified with the SchemaReport and the manually updated... -->
 
 <!-- ### It would be nice to be able to use node sets which could be prepared as the following:
   <xsl:variable name="ctypesRecursive" select="$ctypes[@name='DerivationMetadata' or @name='ConceptTreeNode' or @name='TaxonHierarchyNode' or @name='StoredKeyNode' or @name='FormattedSimpleText' or @name='ApplyBooleanFunction']" />
   <xsl:variable name="ctypesNonRecursive" select="$ctypes[count(.|$ctypesRecursive)!=count($ctypesRecursive)]" /> = complicated way the difference between 2 node sets can be calculated in xPath...
  Then, for the element match it would simply be:
  xsl:template match="xs:element[@type=$ctypesNonRecursive/@name]]" =  element with a type reference, excluding simple types and recursive complex types
  and for the removal of named complex types simply:
  xsl:template  match=xs:complexType[@name=$ctypesNonRecursive/@name]
  However, spy says "variables can not be used in patterns!" ###  -->

 <!-- Insert complex types into typed elements (i.e. change named to multiple anonymous complex types): -->
 <xsl:template match="xs:element[@type=(/xs:schema/xs:complexType/@name | /xs:schema/xs:redefine/xs:complexType/@name) and @type!='DerivationMetadata' and @type!='ConceptTreeNode' and @type!='TaxonHierarchyNode' and @type!='StoredKeyNode' and @type!='FormattedSimpleText' and @type!='ApplyBooleanFunction']"><!-- This matches all elements with non-recursive complex type. -->
    <!-- Obtain the element type: -->
    <xsl:variable name="refvalue" select="./@type" />
    <xsl:variable name="refobject" select="$ctypes[@name=$refvalue]" />
    <xsl:element name="xs:element">
       <xsl:apply-templates select="./@*[name()!='type']" /><!-- copy attributes -->
       <xsl:apply-templates select="./xs:annotation" /><!-- copy element annotation -->
      <xsl:element name="xs:complexType"><!-- create an anonymous complex type object inside the element -->
        <xsl:for-each select="$refobject/*"><!-- copy the complex type that the element refers to -->
           <xsl:if test="name(.)!='xs:annotation'">
             <xsl:apply-templates select="."/>
         </xsl:if>
        </xsl:for-each>
      </xsl:element>
       <xsl:apply-templates select="./xs:key|./xs:keyref./xs:unique" /><!-- copy identity constraints -->
    </xsl:element>
 </xsl:template>

 <!-- Resolve complex type extensions: -->
 <xsl:template match="xs:complexContent/xs:extension">
    <!-- Obtain the base type: -->
    <xsl:variable name="refvalue" select="./@base" />
    <xsl:variable name="refobject" select="$ctypes[@name=$refvalue]" />
    <xsl:for-each select="$refobject/*"><!-- copy the complex type that is being referred to -->
       <xsl:if test="name(.)!='xs:annotation'">
         <xsl:apply-templates select="."/>
     </xsl:if>
    </xsl:for-each>
    <!-- Now continue with the extension sequence -->
    <xsl:apply-templates select="./*"/><!-- content of extended type, starts with xs:sequence|./xs:choice|./xs:all-->
    <!-- as a result, is is possible to have two sequences in the type: base + extension. This is legal but undesirable in the case of sequences, but necessary if the extension starts with a choice. This problem is difficult to solve here, probably simpler in a second pass. -->
 </xsl:template>
<!-- Supplementary template to skip the redundant complexContent around extension: -->
 <xsl:template match="xs:complexContent[xs:extension]">
    <xsl:apply-templates select="./xs:extension"/>
 </xsl:template>

 <!-- Resolve complex type extensions: -->
 <xsl:template match="xs:complexContent/xs:extension">
    <!-- Obtain the base type: -->
    <xsl:variable name="refvalue" select="./@base" />
    <xsl:variable name="refobject" select="$ctypes[@name=$refvalue]" />
    <xsl:for-each select="$refobject/*"><!-- copy the complex type that is being referred to -->
       <xsl:if test="name(.)!='xs:annotation'">
         <xsl:apply-templates select="."/>
     </xsl:if>
    </xsl:for-each>
    <!-- Now continue with the extension sequence -->
    <xsl:apply-templates select="./*"/><!-- content of extended type, starts with xs:sequence|./xs:choice|./xs:all-->
    <!-- as a result, is is possible to have two sequences in the type: base + extension. This is legal but undesirable in the case of sequences, but necessary if the extension starts with a choice. This problem is difficult to solve here, probably simpler in a second pass. -->
 </xsl:template>
<!-- Supplementary template to skip the redundant complexContent around extension: -->
 <xsl:template match="xs:complexContent[xs:extension]">
    <xsl:apply-templates select="./xs:extension"/>
 </xsl:template>


 <!-- Resolve complex type extensions: 
Skip complex type restrictions:
      <xs:complexType>
        <xs:complexContent>
          <xs:restriction base="CharacterDataType">
to
      <xs:complexType>
Note: it seems that attributes behave different, ie. they are copied from restricted base type, unless they are restricted!
This is not implemented yet!
-->
 <xsl:template match="xs:complexContent/xs:restriction">
       <xsl:apply-templates select="./@*[name()!='base']" /><!-- copy attributes -->
       <xsl:apply-templates select="./*" /><!-- copy elements -->
 </xsl:template>
 
<!-- Supplementary template to skip the redundant complexContent around extension: -->
 <xsl:template match="xs:complexContent[xs:extension]">
    <xsl:apply-templates select="./xs:extension"/>
 </xsl:template>


 <!-- Do not copy named complexType to output (except for those types known to be recursive): -->
 <xsl:template match="xs:complexType[@name!='DerivationMetadata' and @name!='ConceptTreeNode' and @name!='TaxonHierarchyNode' and @name!='StoredKeyNode' and @name!='FormattedSimpleText' and @name!='ApplyBooleanFunction']"/>

<!-- Inserting types/group refs creates the problem that unique and keyref identity constraints may have duplicate names!
Although it is possible to append a unique ID to these names, this is done when processing the source tree, which is then copied multiple times into the output tree. I did not find a solution to pipe the output of one xsl into another, so currently manually a separate 2nd stylesheet has to be applied:
SDD-Exe-DetypeSchema2.xsl -->
</xsl:stylesheet>