<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml xsl-RecoverEncodedFormattingTest.xml?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns="http://www.w3.org/1999/xhtml" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
 <xsl:variable name="GeneratorCopyright" select="'DiversityDescriptionTools Version 0.4. Copyright (c) G. Hagedorn 2004.'"/>
  <!-- Proof of concept example code showing how encoded UBIF text formatting can be stripped, to make string comparisons and indexing of formatted string more reliable. This is the equivalent of the xsl:value-of, which in the case of mixed content would strip the markup. -->

  <xsl:template match="text()|@*"/><!-- overwrite the built-in template which otherwise outputs any element/attribute content -->

  <xsl:template match="root">  
    <html>
      <head>
        <title>Testing "strip encoded formatting" xslt code</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <link href="/Workbench02.CSS" type="text/css" rel="stylesheet"/> 
      </head>
      <body lang="en-us">
        <xsl:apply-templates/>        
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Text">
    <p><xsl:call-template name="StripEncodedFormatting"><xsl:with-param name="string" select="./text()"/></xsl:call-template></p>
  </xsl:template>

<xsl:template name="StripEncodedFormatting">
  <!-- 	Replace those encoded xhtml-markup recognized by the StripEncodedFormatting template with nothing. This makes text comparison and indexing operations safe relative to the formatting convention. Note: This routine can be easily recreated based on RecoverEncodedFormatting (if updated) by removing the start and end of the xsl:element tag from RecoverEncodedFormatting, and replace RecoverEncodedFormatting with StripEncodedFormatting (including the recursions). -->
  <xsl:param name="string" select="''"/>
  <xsl:variable name="temp" select="substring-after($string, '&lt;')"/><!-- text after start of first tag in string -->
  <xsl:variable name="tt"   select="substring-before($temp, '&gt;')"/><!-- tag text (don't normalize, may be needed unchanged if not recognized) -->
  <xsl:variable name="ta"   select="substring-after($temp, '&gt;')"/><!-- text after tag, may be empty -->
  <xsl:choose>
    <xsl:when test="string-length($tt) = 0"><!-- no more text between &lt; and &gt; found i.e. end recursion -->
      <xsl:value-of select="$string"/>
    </xsl:when>
    <xsl:otherwise>
        <xsl:variable name="tn"   select="normalize-space($tt)"/><!-- normalized (= trimmed) tag text -->
        <xsl:variable name="tclose"   select="concat('&lt;/', $tn, '&gt;')"/><!-- closing tag-->
        <xsl:value-of select="substring-before($string, '&lt;')"/><!-- output text-before opening &lt;, may be empty-->
        <xsl:choose><!-- ### The following are the accepted non-empty xhtml tags! -->
          <xsl:when test="($tn='sup' or $tn='sub' or $tn='em' or $tn='i' or $tn='b' or $tn='strong') and contains($ta, $tclose)">
            <!-- recurse into text before closing tag = formatted content -->
            <xsl:call-template name="StripEncodedFormatting"><xsl:with-param name="string" select="substring-before($ta, $tclose)"/></xsl:call-template>
            <!-- Next: recurse into text after closing tag: -->
            <xsl:call-template name="StripEncodedFormatting"><xsl:with-param name="string" select="substring-after($temp, $tclose)"/></xsl:call-template>
          </xsl:when><!-- ### The following are the accepted empty html tags! br is also accepted as html (no slash) -->
          <xsl:when test="$tn='br' or $tn='br/' or $tn='br /'">
            <xsl:element name="br" namespace="http://www.w3.org/1999/xhtml" />
            <xsl:call-template name="StripEncodedFormatting"><xsl:with-param name="string" select="$ta"/></xsl:call-template>
          </xsl:when>
          <xsl:otherwise><!-- tag not recognized, restore tag itself and recurse with text-after (ta) -->
            <xsl:value-of select="concat('&lt;', $tt, '&gt;')"/>
            <xsl:call-template name="StripEncodedFormatting"><xsl:with-param name="string" select="$ta"/></xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>