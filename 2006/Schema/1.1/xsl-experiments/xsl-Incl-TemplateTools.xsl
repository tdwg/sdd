<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" >
 <xsl:variable name="GeneratorCopyrightBase_InclTemplateTools">DiversitySchemaTools Version 0.3. Copyright (c) G. Hagedorn 2004.</xsl:variable>
  <!--   *** This is intended only for includes in other transformations! ***  -->  
  
  <!-- generic replace function (note that "translate" is unable to convert 1 char to multiple char, it must be 1 char to 1 char!) -->
<xsl:template name="StringReplace">
  <xsl:param name="string" select="''"/>
  <xsl:param name="search" select="''"/>
  <xsl:param name="replacement" select="''"/>
  <xsl:choose>
    <xsl:when test="$search !='' and $string !='' and contains($string, $search)">
      <xsl:value-of select="substring-before($string, $search)"/>
      <!--Use "xsl:copy-of" instead of "xsl:value-of" so that users may substitute nodes as well as strings for $replacement. -->
      <xsl:copy-of select="$replacement"/>
      <xsl:call-template name="StringReplace">
         <xsl:with-param name="string" select="substring-after($string, $search)"/>
         <xsl:with-param name="search" select="$search"/>
         <xsl:with-param name="replacement" select="$replacement"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="$string"/>
     </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="StripSpace">
  <!-- 	remove space characters from a string -->
  <xsl:param name="string" select="''"/>
  <xsl:call-template name="StringReplace">
     <xsl:with-param name="string" select="$string"/>
     <xsl:with-param name="search" select="' '"/><!-- a space = blank character -->
     <xsl:with-param name="replacement" select="''"/><!-- nothing/empty string -->
   </xsl:call-template>
</xsl:template>
  
<xsl:template name="ReplaceReturnWithBreak">
  <!-- 	replace return character with an xhtml <br /> tag -->
  <xsl:param name="string" select="''"/>
  <xsl:call-template name="StringReplace">
     <xsl:with-param name="string" select="$string"/>
     <xsl:with-param name="search" select="'&#xA;'"/>
     <xsl:with-param name="replacement"><br /></xsl:with-param>  
   </xsl:call-template>
</xsl:template>




<xsl:template name="Tokenize2TableCell"> 
  <xsl:param name="string" select="''"/>
    <xsl:param name="delimiter"  select="' '"/> <!-- default is blank -->
    <xsl:choose> 
      <xsl:when test="contains($string, $delimiter)"> 
        <td><xsl:value-of select="substring-before($string, $delimiter)"/></td> 
        <xsl:call-template name="TokenizeByBlank"> 
          <xsl:with-param name="string" select="substring-after($string, 
$delimiter)"/> 
          <xsl:with-param name="delimiter" select="' '"/> 
        </xsl:call-template> 
      </xsl:when> 
      <xsl:otherwise> 
        <td><xsl:value-of select="$string"/></td> 
      </xsl:otherwise> 
    </xsl:choose> 
</xsl:template> 


<xsl:template name="SubstringAfterLast">
  <!-- 	similar to the substring-after function, but  for string "abc/123/xyz" and delimiter="/", "xyz" is returned -->  
  <xsl:param name="string" select="''"/>
  <xsl:param name="delimiter" select="''"/>  
  <xsl:choose> 
    <xsl:when test="contains($string, $delimiter)">      
      <xsl:call-template name="SubstringAfterLast"> 
        <xsl:with-param name="string" select="substring-after($string, 
$delimiter)"/> 
        <xsl:with-param name="delimiter" select="$delimiter"/> 
      </xsl:call-template> 
    </xsl:when> 
    <xsl:otherwise> 
      <xsl:value-of select="$string"/>
    </xsl:otherwise> 
  </xsl:choose> 
</xsl:template>



  <!-- output non-breaking space character entitiy (a bit weird, but the only functioning method I found!):
         Usage: <xsl:call-template name="nbsp"/>
         Alternative: use &#160; in XML (decimal notation, Hex is e.g. &#x20AC; for EURO sign -->
  <xsl:template name="nbsp">
    <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
  </xsl:template>

  <!-- following not used, but kept as useful example code: -->
  <xsl:template name="IsNumber">
    <xsl:if test="string(number(.))='NaN'">is not a number</xsl:if>
  </xsl:template>

<!-- Create Lists: currently only as examples, not yet used! -->
  <xsl:variable name="ListDelimiter" select="', '"/>
   <xsl:variable name="ListOperator" select="', or '"/>

  <xsl:template match="GenericListTemplate">
    <xsl:for-each select="*[position() &lt; last()]">
        <xsl:value-of select="."/><xsl:value-of select="$ListDelimiter"/>
    </xsl:for-each>
    <xsl:value-of select="*[last()]"/>
  </xsl:template>
  <xsl:template match="GenericListWithOperatorTemplate">
    <xsl:for-each select="*[position() &lt; last()-1]">
        <xsl:value-of select="."/><xsl:value-of select="$ListDelimiter"/>
    </xsl:for-each>
    <xsl:for-each select="*[position()=last()-1]">
        <xsl:value-of select="."/><xsl:value-of select="$ListOperator"/>
    </xsl:for-each>
    <xsl:value-of select="*[last()]"/>
  </xsl:template>
  <xsl:template match="GenericListWithOperatorTemplate_AlternativeImplementation">
    <xsl:for-each select="*">
        <xsl:value-of select="."/>
        <xsl:choose>
          <xsl:when test="position() &lt; last()-1"><xsl:value-of select="$ListDelimiter"/></xsl:when>
          <xsl:when test="position()=last()-1"><xsl:value-of select="$ListOperator"/></xsl:when>
        </xsl:choose>
    </xsl:for-each>
  </xsl:template>

<!-- To convert the formatted mixed conted UBIF/SDD style to non-mixed content, one may use:
<xsl:template match="Text/text()"><!- 'whenever there's a text() node within a Text element, create a t element to hold its content' ->
  <t><xsl:value-of select="." /></t>
</xsl:template>
<xsl:template match="Text/em"><!- also for ... Text/strong|Text/sub|Text/sup ..., try to use <xsl:element name="self::local-name()" > or similar ...
 ->
  <em><xsl:apply-templates /></em>
</xsl:template>

TO FIX NAMESPACE PROBLEM:
match some xhtml elements outside any namespace, and those explicitly inside the xhtml ns: 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:h="http://www.w3.org/1999/xhtml"
                version="1.0">
  <xsl:template match="p|pre|li|h1|h2|h3|h4|h:p|h:pre|h:li|h:h1|h:h2|h:h3|h:h4">

-->


<!-- To create distinct value lists, based on an attribute "name":
var items select=./item 
var distinct_items select=$items[not(@name=preceding::item/@name)] 
Alternative: use xsl:key!
-->





<!-- xslt 1.0 has no for-each-group or distinct() function (2.0 may have such!)
  <xsl:key name='itemkey' match='ITEM'  use='Id'/>
  <xsl:template match="GenericUniqueList">
    <xsl:variable name='items'  select='/data/items/ITEM[generate-id(ITEMID)=generate-id(key("brokers",ITEMID)[1]/ITEMID)]'/>
    <! - - how? the key function returns all items with a given ItemID. Select only the first, based on xslt-ID comparism. The xslt generate-id() does not depend on values, but generates IDs for the node. - - >
  </xsl:template>
  <xsl:template match="GenericUniqueList2">
    <xsl:for-each select="cities/city[not(@country =preceding::*/@country)]">
    <! - - how? preceeding is ALL preceeding, not only preceeding sibling! - - >
    </xsl:for-each>
  </xsl:template>
  -->
<!-- END Create Lists: currently only as examples, not yet used! -->

 </xsl:stylesheet>