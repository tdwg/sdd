<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml SDD_CompleteWithUBIF.xsd?>
<?gh_altenative_filenames_for samplexml UBIF_Reduced.xsd UBIF_CompleteSingleFile.xsd UBIF.xsd SDD.xsd SDD_CompleteWithUBIF.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd" exclude-result-prefixes="xs">
 <xsl:variable name="GeneratorCopyright" select="'DiversitySchemaTools Version 0.4. Copyright (c) G. Hagedorn 2004.'"/>
  <!-- To be used on w3c schema documents. This documenter reports some special aspects of the schema (listed by feature not by structure as most other documenters do). Many thanks to Bob Morris for reviewing version 0.2 and providing helpful corrections and comments! -->
   <xsl:namespace-alias stylesheet-prefix="xs" result-prefix="#default" />
   
  <xsl:include href="xsl-Incl-TemplateTools.xsl" /><!-- StringReplace, nbsp, GenericListTemplate, etc. -->

  <!-- overwrite the built-in template which otherwise outputs element and attribute content: -->
  <xsl:template match="text()|@*"/>

   <!-- following variables are intended to turn on/off certain sections of the report; used for debug purposes. Use 0 or 1-->
  <xsl:variable name="output_elements" select="1"/>
  <xsl:variable name="output_default_attr" select="1"/>
  <xsl:variable name="output_typeusage" select="1"/><!-- this one is really slow! -->
  <xsl:variable name="output_deriv" select="1"/>
  <xsl:variable name="output_key" select="1 and count(.//xs:key)"/>
  <xsl:variable name="output_keyref" select="1 and count(.//xs:keyref)"/>
  <xsl:variable name="output_unique" select="1 and count(.//xs:unique)"/>
  <xsl:variable name="output_annot_problem" select="1"/>

  <xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
 <!-- key definitions to speed up retrieval of object groups by name: -->
  <!-- global elements/attributes would be: /xs:schema/xs:element and /xs:schema/xs:attribute-->
  <xsl:key name="attributeByType" match="//xs:attribute" use="@type"/>
  <xsl:key name="elementByType" match="//xs:element" use="@type"/>
  <xsl:key name="extensionByBase" match="//xs:extension" use="@base"/>
  <xsl:key name="restrictionByBase" match="//xs:restriction" use="@base"/>
  <xsl:key name="complexType" match="/xs:schema/xs:complexType | /xs:schema/xs:redefine/xs:complexType" use="@name"/>
  <xsl:key name="simpleType" match="/xs:schema/xs:simpleType | /xs:schema/xs:redefine/xs:simpleType" use="@name"/>
 <!-- currently not used:
  <xsl:key name="attribute" match="//xs:attribute" use="@name"/>
  <xsl:key name="element" match="//xs:element" use="@name"/>
  <xsl:key name="type" match="/xs:schema/xs:complexType | /xs:schema/xs:simpleType | /xs:schema/xs:redefine/xs:complexType | /xs:schema/xs:redefine/xs:simpleType" use="@name"/>
  <xsl:key name="attributeGroup" match="/xs:schema/xs:attributeGroup | /xs:schema/xs:redefine/xs:attributeGroup" use="@name"/>
  <xsl:key name="group" match="/xs:schema/xs:group | /xs:schema/xs:redefine/xs:group" use="@name"/>
  -->

  <xsl:template match="/xs:schema">
  
   <xsl:variable name="title"><!-- First heading and html header title, based on last part of schema namespace string -->
     <xsl:call-template name="SubstringAfterLast"><xsl:with-param name="string" select="@targetNamespace"/><xsl:with-param name="delimiter" select="'/'"/></xsl:call-template>
     Schema Supplementary Report
   </xsl:variable>
    <html>
      <head>
        <title><xsl:value-of select="$title"/></title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <link href="/Workbench02.CSS" type="text/css" rel="stylesheet"/>
        <link href="/Workbench02p.CSS" type="text/css" rel="stylesheet" media="print"/>
      </head>
      <body lang="en-us">
        <h1><xsl:value-of select="$title"/></h1>
        <p class="compact"><strong>(Version: <xsl:value-of select="/xs:schema/@version"/>)</strong></p>
        <p class="signature"><a href="http://www.tdwg.org" class="invis">TDWG</a> working group: <a href="../../index.html" class="invis">Structure of Descriptive Data (SDD)</a></p>
        <p>The standard schema reports generated by xml spy or the xs3p script document the structure of the schema organized by the element and type tree. As a supplement to this, this report documents the use of selected features throughout the entire schema.</p>
        <p>This is a highly technical report aimed at xml schema experts. The purpose of the type and element listing is primarily to search for design problems or errors in the schema. The overview over default values and identity constraints is valuable for implementers.</p>

        <h2>Table of contents</h2>
        <ol class="compact">
<xsl:if  test="$output_elements">
        <li><a href="#elements">Table of elements (name/type synopsis)</a></li>
</xsl:if>
<xsl:if  test="$output_default_attr">
        <li><a href="#default_attr">Table of defined default values</a></li>
</xsl:if>
<xsl:if  test="$output_typeusage">
        <li><a href="#typeusage">Type usage</a><ul class="compact">
            <li><a href="#complextypeusage">Usage of complex types</a></li>
            <li><a href="#simpletypeusage">Usage of simple types</a></li>
            <li><a href="#unusedtypes">Summary of types present but not used</a></li>
            <li><a href="#typerecursion">Recursive use of types</a></li></ul></li>
</xsl:if>
<xsl:if  test="$output_deriv">
        <li><a href="#deriv">Type inheritance</a><ul class="compact">
            <li><a href="#ComplexExtension">Complex types derived by extension</a></li>
            <li><a href="#ComplexRestr">Complex types derived by restriction</a></li>
            <li><a href="#SimpleRestr">Simple types derived by restriction</a></li></ul></li>
</xsl:if>
<xsl:if  test="$output_key or $output_keyref or $output_unique">
        <li><a href="#identityconstraints">Identity constraints</a><ul class="compact">
            <li><a href="#key">Key identity constraints</a></li>
            <li><a href="#keyref">Keyref identity constraints</a></li>
            <li><a href="#unique">Uniqueness constraints</a></li></ul></li>
</xsl:if>
<xsl:if  test="$output_annot_problem">
        <li><a href="#annot_problem">Table of annotations containing the problem marker (= '@')</a></li>
</xsl:if>
        </ol>

<xsl:if  test="$output_elements">
        <h2><a name="elements">Table of elements (name/type synopsis)</a></h2>
        <p>The SDD schema uses element names with different types, depending on the context. To write xslt it is often useful to know which element names in a schema uniquely identify a type, and where the content type depends on the context. The following list shows all elements in alphabetical order together with their type name. Anonymous types, including anonymous type derivations, are annotated with "(anon.)". An advanced script may list the base type of a derivation, but in most cases we avoid anonymous derivation in the TDWG schemata so we did not implement this yet. In the context column the path to the element is given. Elements names are shown directly, and complex type and element/attribute group names are prefixed with "type:", "group:", and "attgroup:", respectively.</p>
<p>The use of an element name with several different types has two major sources: a) the alternative element types are themselves all derived from a base type (see e.<xsl:call-template name="nbsp"/>g. <i>Modifiers</i>), or b) an object is defined in one place and a reference is made to it. This is very similar to the usage pattern in xml schema itself, where object names are used both for definition and reference (examples: element name="x" and element ref="x", or group name="y" and group ref="y").</p>
<p>Note: element names starting with underscore (= tentative elements placed for the purpose of discussion) are not shown.</p>
        <table cellpadding="2" cellspacing="0" border="0" summary="element names and type">
          <tr class="header">
            <th>Element Name</th>
            <th>Type</th>
            <th>Context</th>
          </tr>
          <xsl:for-each select=".//xs:element[not(starts-with(@name,'_'))]">
            <xsl:sort select="@name"/>
            <xsl:sort select="@type"/>
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <td><xsl:value-of select="@name"/></td>
             <td>
             <xsl:choose><!--  report missing as constant string -->
               <xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when>
               <xsl:otherwise>(anon.)</xsl:otherwise>
             </xsl:choose>
             </td>
             <td><xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template></td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
</xsl:if>

<xsl:if  test="$output_default_attr">
        <h2><a name="default_attr">Table of defined default values</a></h2>
        <p>Elements or attributes for which default values have been defined in the schema need special attention insofar as the processing of an instance document depends on whether it has been validated against the schema (validation will add default values in the infoset). A script or application processing instance documents may thus either validate the document, or it may handle the following attributes itself.</p>
        <table cellpadding="2" cellspacing="0" border="0"  summary="default values">
          <tr class="header">
                <th>Object</th>
                <th>Name</th>
                <th>Default value</th>
                <th>Parent</th>
          </tr>
          <xsl:for-each select=".//xs:attribute[@default] | .//xs:element[@default] ">
            <xsl:sort select="local-name(.)"/>
            <xsl:sort select="@name"/>
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
                <td><xsl:value-of select="local-name(.)"/></td>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of select="@default"/></td>
                <td><xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template></td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
</xsl:if>

<xsl:if  test="$output_typeusage">
        <h2><a name="typeusage">Type usage</a></h2>
        <p>The following tables provide an overview of the number of times complex and simple types are used in the schema. Only schema-specific types are reported, not the w3c defined base types (xs:string, xs:boolean, etc.). Type usage is interesting to detect orphan (unused) types, or to argue whether types used only a single time should rather be anonymous.</p>

        <h3><a name="complextypeusage">Usage of complex types</a></h3>
        <table cellpadding="2" cellspacing="0" border="0" summary="type usage">
          <thead>
          <tr class="header">
            <th></th>
            <th colspan="7">Usage count:</th>
          </tr>
          <tr class="header">
            <th>Type name</th>
            <th>Total</th>
            <th></th>
            <th>Elements</th>
            <th></th>
            <th>Extensions</th>
            <th></th>
            <th>Restrictions</th>
          </tr>
          </thead>
          <tbody>
          <xsl:for-each select="/xs:schema/xs:complexType | /xs:schema/xs:redefine/xs:complexType"><!-- exclude anonymous types. Note: can not use key('complexType') without name parameter! -->
            <xsl:sort select="@name"/>
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <!-- type name must be saved in a variable to be used in count() below -->
             <xsl:variable name="tname" select="@name"/>
             <!-- counts saved to variables to speed the calculation of totals (could calculate totals through count(//xs:element[@type=$tname] | //xs:restriction[@base=$tname] |  //xs:extension[@base=$tname]) but this unneccecarily repeats work-->
             <xsl:variable name="ecount" select="count(key('elementByType', $tname))"/>
             <xsl:variable name="xcount" select="count(key('extensionByBase', $tname))"/><!-- this is extension[@base=$tname] !-->
             <xsl:variable name="rcount" select="count(key('restrictionByBase', $tname))"/>
             <td><xsl:value-of select="@name"/></td>
             <td align="center"><xsl:value-of select="$ecount + $xcount + $rcount"/></td>
             <td>=</td>
             <td align="center"><xsl:value-of select="$ecount"/></td>
             <td>+</td>
             <td align="center"><xsl:value-of select="$xcount"/></td>
             <td>+</td>
             <td align="center"><xsl:value-of select="$rcount"/></td>
            </tr>
          </xsl:for-each>
          </tbody>
        </table>

        <h3><a name="simpletypeusage">Usage of simple types</a></h3>
        <p>Note: the usuage count is currently sometimes misleading, as usage in xs:union constructs are currently not being counted!</p>
        <table cellpadding="2" cellspacing="0" border="0" summary="type usage">
          <tr class="header">
            <th></th>
            <th colspan="7">Usage count:</th>
          </tr>
          <tr class="header">
            <th>Type name</th>
            <th>Total</th>
            <th></th>
            <th>Attributes</th>
            <th></th>
            <th>Elements</th>
            <th></th>
            <th>Restrictions</th>
          </tr>
          <xsl:for-each select="/xs:schema/xs:simpleType[@name]"><!-- exclude anonymous types -->
            <xsl:sort select="@name"/>
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <!-- type name must be saved in a variable to be used in count() below -->
             <xsl:variable name="tname" select="@name"/>
             <!-- counts saved to variables to speed the calculation of totals-->
             <xsl:variable name="ecount" select="count(key('elementByType', $tname))"/>
             <xsl:variable name="acount" select="count(key('attributeByType', $tname))"/>
             <xsl:variable name="rcount" select="count(key('restrictionByBase', $tname))"/>
             <td><xsl:value-of select="@name"/></td>
             <td align="center"><xsl:value-of select="$acount + $ecount + $rcount"/></td>
             <td>=</td>
             <td align="center"><xsl:value-of select="$acount"/></td>
             <td>+</td>
             <td align="center"><xsl:value-of select="$ecount"/></td>
             <td>+</td>
             <td align="center"><xsl:value-of select="$rcount"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <hr/>

        <h3><a name="unusedtypes">Summary of types present but not used</a></h3>

          <xsl:variable name="ctypes" select="/xs:schema/xs:complexType[@name] | /xs:schema/xs:redefine/xs:complexType[@name]" />
          <xsl:variable name="stypes" select="/xs:schema/xs:simpleType[@name]" />
          <!-- type usage: -->
          <!-- The following could be rewritten to partly use the keys already created!!! -->
          <xsl:variable name="ctypesUsedE" select="$ctypes[@name=//xs:element/@type] | /xs:schema/xs:redefine/xs:complexType[@name=//xs:element/@type]" />
          <xsl:variable name="ctypesUsedXR" select="$ctypes[@name=key('extensionByBase', ./@name)/@base or @name=key('restrictionByBase', ./@name)/@base]" />
          <xsl:variable name="ctypesUsed" select="$ctypesUsedE|$ctypesUsedXR" />
          <xsl:variable name="stypesUsedE" select="$stypes[@name=//xs:element/@type]" />
          <xsl:variable name="stypesUsedA" select="$stypes[@name=//xs:attribute/@type]" />
          <xsl:variable name="stypesUsed" select="$stypesUsedE|$stypesUsedA" />
      <!-- I would now like to get differences and intersections of these node sets. It gets a bit ugly here, since xpath has no real intersection method. The following uses the "Kaysian method":   intersection = $set1[count(.|$set2)=count($set2)] - -  i.e.: "The XPath union operator determines that a given node doesn't impact on the count of nodes of the union of the node and the second node-set." /// "The symmetric difference requires an expression involving the union of the determination of those nodes in each set that are not in the other set:" ($set1[count(.|$set2)!=count($set2)] | $set2[count(.|$set1)!=count($set1)] )
      -->
          <xsl:variable name="ctypesUnused" select="$ctypes[count(.|$ctypesUsed)!=count($ctypesUsed)]" />
          <xsl:variable name="stypesUnused" select="$stypes[count(.|$stypesUsed)!=count($stypesUsed)]" />
          <p>The following types have been defined in the schema, but are not used in elements, attributes, extension, or restriction:<br />
          <strong>Complex types: </strong><br />
          <xsl:choose>
             <xsl:when test="count($ctypesUnused) = 0">(none)<br /></xsl:when>
             <xsl:otherwise>
                <xsl:for-each select="$ctypesUnused">
                  <xsl:sort select="@name"/>
                  <xsl:value-of select="@name"/><br />
                </xsl:for-each>
             </xsl:otherwise>
           </xsl:choose>
          <strong>Simple types: </strong><br />
          <xsl:choose>
             <xsl:when test="count($stypesUnused) = 0">(none)<br /></xsl:when>
             <xsl:otherwise>
                <xsl:for-each select="$stypesUnused">
                  <xsl:sort select="@name"/>
                  <xsl:value-of select="@name"/><br />
                </xsl:for-each>
             </xsl:otherwise>
           </xsl:choose>
          </p>

        <h3><a name="typerecursion">Recursive use of types</a></h3>

         <!-- these are the types that directly contain themselves recursively: -->
         <xsl:variable name="ctypesDirectRecursion" select="/xs:schema/xs:complexType[@name=.//xs:element/@type]" />
         <p><strong>Direct recursion:</strong> The following complex types contain elements of their own type:<br />
          <xsl:choose>
             <xsl:when test="count($ctypesDirectRecursion) = 0">(none found)<br /></xsl:when>
             <xsl:otherwise>
                <xsl:for-each select="$ctypesDirectRecursion">
                  <xsl:sort select="@name"/>
                  <xsl:value-of select="@name"/><br />
                </xsl:for-each>
             </xsl:otherwise>
           </xsl:choose>
          </p>

          <!-- Much more difficult is indirect containment:
          complexType name="a"
            .//element type="b"
          complexType name="b"
            .//element type="a"
          Cannot write it as a node set (which could then be used in xpath expressions!), but at least I can to it with loops into the output...
          -->
          <xsl:variable name="ctypesNotDirectRecursion" select="$ctypes[count(.|$ctypesDirectRecursion)!=count($ctypesDirectRecursion)]" />
         <p><strong>Indirect recursion (1 step):</strong> The following complex types contain elements of a type, that contains elements of their own type. Both types involved will be listed:<br />

          <xsl:choose>
             <xsl:when test="count($ctypesNotDirectRecursion) = 0">(none found)<br /></xsl:when>
             <xsl:otherwise>
               <xsl:for-each select="$ctypesNotDirectRecursion">
                  <xsl:sort select="@name"/><!-- sorting all types, then only selective output! -->
                  <xsl:variable name="Current1" select="." />
                  <xsl:variable name="ctOfElementsInCurrent1" select="$ctypes[@name=$Current1//xs:element/@type]" />
                  <xsl:for-each select="$ctOfElementsInCurrent1">
                      <xsl:variable name="Current2" select="." />
                      <xsl:variable name="ctOfElementsInCurrent2AlsoEqualCurr1" select="$ctypes[@name=$Current2//xs:element/@type and @name=$Current1/@name]" />
                      <xsl:if test="count($ctOfElementsInCurrent2AlsoEqualCurr1)!=0"><xsl:value-of select="$Current1/@name"/> / <xsl:value-of select="$Current2/@name"/><br /></xsl:if>
                  </xsl:for-each>
               </xsl:for-each>
             </xsl:otherwise>
           </xsl:choose>
         </p>

         <p>Note: some other types of recursion, e.<xsl:call-template name="nbsp"/>g. involving cycles of three complex types, recursion of type extension, alternations of complex types and element groups, or element groups alone are not yet reported!</p>
         <!-- recursion involving extension: it is possible to extend an anonymous type of an element based on the type itself, esp. when adding attributes! <xs:element name="ins"><xs:complexType><xs:complexContent><xs:extension base="FormattedSimpleTextType"><xs:attribute name="cite" type="xs:anyURI"/>. - Alternating group and type occurs in ApplyBooleanType! -->
        <hr/>

</xsl:if>


<xsl:if  test="$output_deriv">
        <h2><a name="deriv">Type inheritance</a></h2>
        <p>The SDD schema is used object-oriented inheritance mechanisms for complex types. The following tables give an overview of type derivations present in the schema.</p>

        <h3><a name="ComplexExtension">Complex types derived by extension</a></h3>
        <p>(In a future version this report should list indirect type derivation as well!)</p>

        <table cellpadding="2" cellspacing="0" border="0" summary="complex type derivations">
          <tr class="header">
            <th>Base type</th>
            <th>Abstract<xsl:call-template name="nbsp"/><xsl:call-template name="nbsp"/></th>
            <th>Derived type</th>
            <th>Abstract</th>
          </tr>
          <xsl:for-each select=".//xs:complexContent/xs:extension">
            <xsl:sort select="@base"/>
            <xsl:sort select="./../../@name"/><!-- current is extension, .. up to complexContent, .. up to element/type/group-->
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <td><xsl:value-of select="@base"/></td>
             <td><xsl:value-of select="key('complexType', @base)/@abstract"/></td>
             <td><xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template></td>
             <td><xsl:value-of select="../../@abstract"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <h3><a name="ComplexRestr">Complex types derived by restriction</a></h3>
        <table cellpadding="2" cellspacing="0" border="0" summary="complex type derivations">
          <tr class="header">
            <th>Base type</th>
            <th>Abstract<xsl:call-template name="nbsp"/><xsl:call-template name="nbsp"/></th>
            <th>Derived type</th>
            <th>Abstract</th>
          </tr>
          <xsl:for-each select=".//xs:complexContent/xs:restriction">
            <xsl:sort select="@base"/>
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <td><xsl:value-of select="@base"/></td>
             <td><xsl:value-of select="key('complexType', @base)/@abstract"/></td>
             <td><xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template></td>
             <td><xsl:value-of select="../../@abstract"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <h3><a name="SimpleRestr">Simple types derived by restriction</a></h3>
        <table cellpadding="2" cellspacing="0" border="0" summary="simple type derivations">
          <tr class="header">
                <th>Base type</th>
                <th>Derived type</th>
          </tr>
          <xsl:for-each select=".//xs:simpleType/xs:restriction"><!-- restriction[@name] would exclude anonymous types -->
            <xsl:sort select="@base"/>
            <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
                <td><xsl:value-of select="@base"/></td>
                <td>
                   <xsl:variable name="TypeDescr">
                     <xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template>
                   </xsl:variable>
                   <xsl:choose><!--  report missing as constant string -->
                     <xsl:when test="$TypeDescr=''">(anon.)</xsl:when>
                     <xsl:otherwise><xsl:value-of select="$TypeDescr"/></xsl:otherwise>
                   </xsl:choose>
                </td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
</xsl:if>


<xsl:if  test="$output_key or $output_keyref or $output_unique">
        <h2><a name="identityconstraints">Identity constraints</a></h2>

<xsl:if  test="$output_key">
        <h3><a name="key">Key identity constraints</a></h3>
        <p>The SDD schema is an object-relational design where data structures cannot be shown in a single hierarchical tree. It therefore makes liberal use of key/keyref relations. The integrity of these relations is protected by two xml schema mechanisms: xs:key  guarantees that all key values are present and unique, and xs:keyref guarantees that all references to key values point to an existing key. The following tables give an overview of the key and keyref constraints defined in the schema:</p>
        <table cellpadding="2" cellspacing="0" border="0" summary="key identity constraints">
          <tr class="header"><xsl:call-template name="KeyTableHeader"/></tr>
          <xsl:for-each select=".//xs:key">
            <xsl:sort select="@name"/>
              <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <xsl:call-template name="KeyTableRow"/>
             </tr>
          </xsl:for-each>
        </table>
</xsl:if>

<xsl:if  test="$output_keyref">
        <h3><a name="keyref">Keyref identity constraints</a></h3>
        <table cellpadding="2" cellspacing="0" border="0" summary="keyref identity constraints">
          <tr class="header"><xsl:call-template name="KeyrefTableHeader"/></tr>
          <xsl:for-each select=".//xs:keyref">
            <xsl:sort select="@name"/>
              <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <xsl:call-template name="KeyrefTableRow"/>
             </tr>
          </xsl:for-each>
        </table>
</xsl:if>

<xsl:if  test="$output_unique">
        <h3><a name="unique">Uniqueness constraints</a></h3>
        <p>Uniqueness constraints differ from key constraints in that the elements referred to are not required to be present. However, whenever they are present, however, the combination of all fields has to be unique. In SDD schema, most uniqueness constraints could in fact be modeled as key constraints, since the data elements are required. However, to stress the distinction between key definitions to which keyrefs refer, and other constraints, we prefer to model them as uniqueness constraints.</p>
        <table cellpadding="2" cellspacing="0" border="0" summary="uniqueness identity constraints">
          <tr class="header"><xsl:call-template name="UniqueTableHeader"/></tr>
          <xsl:for-each select=".//xs:unique">
            <xsl:sort select="@name"/>
              <tr>
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
             <xsl:call-template name="KeyTableRow"/>
             </tr>
          </xsl:for-each>
        </table>
</xsl:if>
        <hr/>
</xsl:if><!-- end any identity constraint-->


<xsl:if  test="$output_annot_problem">
        <h2><a name="annot_problem">Table of annotations containing the problem marker (= '@@')</a></h2>
        <p>The character '@' is used inside schema annotations to mark problem or places that need further discussion. The table is sorted by order of occurrence in the schema.</p>
        <table cellpadding="2" cellspacing="0" border="0"  summary="annotations containing @@ = problem marker">
          <tr class="header">
                <th></th>
                <th>Annotation</th>
                <th>Parent</th>
          </tr>
          <xsl:for-each select=".//xs:annotation[contains(.,'@@') and not(name(..) = 'xs:schema')]">
            <tr><!-- exclude the annotation on schema root, since this explains the error marker! -->
             <xsl:choose><!--  create rows with alternating background color! -->
               <xsl:when test="position() mod 2 = 1"><xsl:attribute name="class">data1</xsl:attribute></xsl:when>
               <xsl:otherwise><xsl:attribute name="class">data2</xsl:attribute></xsl:otherwise>
             </xsl:choose>
                <td><xsl:value-of select="position()"/>.</td>
                <td><xsl:value-of select="xs:documentation"/></td>
                <td><xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template></td>
            </tr>
          </xsl:for-each>
        </table>
        <hr/>
</xsl:if>

      <p>(Generated by <xsl:value-of select="$GeneratorCopyright"/><!-- ideally would add something like: , $systemdate, but I don't know how to do that -->)</p>

      </body>
    </html>
  </xsl:template>

<!-- ++++++++++++++++++++++++++++++++++++++++++ -->

  <xsl:template name="KeyTableHeader">
    <th>Key Name</th>
    <th>Selector path</th>
    <th>Field(s)</th>
    <th></th><!-- up to three fields supported... -->
    <th></th>
  </xsl:template>
  <xsl:template name="KeyTableRow">
    <td><a name="{@name}"><xsl:value-of select="@name"/></a></td>
    <td><!-- replace slash with slash-blank to allow the long path names to wrap:-->
        <xsl:call-template name="StringReplace">
          <xsl:with-param name="string" select="xs:selector/@xpath"/>
          <xsl:with-param name="pattern" select="'/'"/>
          <xsl:with-param name="replacement" select="'/ '"/><!-- it would be better to use /&thinsp; here, but char. entities don't work for me... -->
      </xsl:call-template>
    </td>
    <td><xsl:value-of select="xs:field[1]/@xpath"/><xsl:call-template name="nbsp"/></td>
    <td><xsl:value-of select="xs:field[2]/@xpath"/><xsl:call-template name="nbsp"/></td>
    <td><xsl:value-of select="xs:field[3]/@xpath"/><xsl:call-template name="nbsp"/></td>
    <!-- Simple solution is: <xsl:for-each select="xs:field"><td><xsl:value-of select="@xpath"/></td></xsl:for-each> but this produces differing amounts of columns for different constraints. Not compatible with xhtml, and formatting looks odd because table rows have differing amounts of columns (visible where background is gray!) -->
  </xsl:template>

  <xsl:template name="UniqueTableHeader">
    <th>Uniqueness constraint</th>
    <th>Selector path</th>
    <th>Field(s)</th>
    <th><xsl:call-template name="nbsp"/></th><!-- up to three fields supported... -->
    <th><xsl:call-template name="nbsp"/></th>
  </xsl:template>
  <!-- template name="UniqueTableRow" not needed, identical to KeyTableRow -->


  <xsl:template name="KeyrefTableHeader">
    <th>Keyref Name</th>
    <th>Parent</th>
    <th>Referred key</th>
    <th>Selector<xsl:call-template name="nbsp"/></th>
    <th>Field(s)</th>
    <th><xsl:call-template name="nbsp"/></th><!-- up to three fields supported... -->
    <th><xsl:call-template name="nbsp"/></th>
  </xsl:template>
  <xsl:template name="KeyrefTableRow">
    <td><xsl:value-of select="@name"/></td>
    <td><xsl:call-template name="DescribeParent"><xsl:with-param name="currentnode" select=".."/></xsl:call-template></td><!-- alternative simple parent display: xsl:value-of select="../@name"  always works, but context is then not known -->
    <td><a href="#{@refer}"><xsl:value-of select="@refer"/></a></td>
    <td><xsl:value-of select="xs:selector/@xpath"/></td>
    <td><xsl:value-of select="xs:field[1]/@xpath"/><xsl:call-template name="nbsp"/></td>
    <td><xsl:value-of select="xs:field[2]/@xpath"/><xsl:call-template name="nbsp"/></td>
    <td><xsl:value-of select="xs:field[3]/@xpath"/><xsl:call-template name="nbsp"/></td>
    <!-- Simple solution is: <xsl:for-each select="xs:field"><td><xsl:value-of select="@xpath"/></td></xsl:for-each> but this produces differing amounts of columns for different constraints. Not compatible with xhtml, and formatting looks odd because table rows have differing amounts of columns (visible where background is gray!) -->
  </xsl:template>


  <!-- template for any w3c xml schema, describing the parent of an element, annotation, etc.
    Only elements, complex type names and groups are considered descriptive.
  -->
  <xsl:template name="DescribeParent">
  <xsl:param name="currentnode" />
  <xsl:choose>
    <xsl:when test="name($currentnode) ='xs:element' and $currentnode/@name != 'Document'">
      <xsl:call-template name="DescribeParent"><!-- continue recursion -->
         <xsl:with-param name="currentnode" select="$currentnode/.."/>
      </xsl:call-template>
      <xsl:value-of select="concat($currentnode/@name,'/ ')"/>
    </xsl:when>
    <xsl:when test="name($currentnode)='xs:attribute' or name($currentnode) ='xs:simpleType' or name($currentnode) ='xs:enumeration' or name($currentnode) ='xs:key' or name($currentnode) ='xs:keyref' or name($currentnode) ='xs:unique' " >
      <xsl:call-template name="DescribeParent"><!-- continue recursion -->
         <xsl:with-param name="currentnode" select="$currentnode/.."/>
      </xsl:call-template>
      <xsl:value-of select="local-name($currentnode)"/>
      <xsl:if test="$currentnode[@name]">: <xsl:value-of select="$currentnode/@name"/></xsl:if><!-- add ': ' only if a name exists! -->
    </xsl:when>
    <!-- following 3 cases: only named complex types or groups should be output. $currentnode[@name] is the xpath (cryptic...) way to say: only if an attribute @name exists ... Also they stop recursion! -->
    <xsl:when test="name($currentnode) ='xs:complexType' and $currentnode[@name]">
      <xsl:value-of select="concat('type: ', $currentnode/@name,'/ ')"/>
     </xsl:when>
    <xsl:when test="name($currentnode) ='xs:group' and $currentnode[@name]">
      <xsl:value-of select="concat('group: ', $currentnode/@name,'/ ')"/>
     </xsl:when>
    <xsl:when test="name($currentnode) ='xs:attributeGroup' and $currentnode[@name]">
      <xsl:value-of select="concat('attgroup: ', $currentnode/@name,'/ ')"/>
     </xsl:when>
    <xsl:when test="name($currentnode) ='xs:schema'"><!-- stop recursion  /// perhaps add:  or (name($currentnode) ='xs:element' and $currentnode/@name='Document'-->
      (schema root)
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="DescribeParent"><!-- continue recursion -->
            <xsl:with-param name="currentnode" select="$currentnode/.."/>
      </xsl:call-template>
     </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

</xsl:stylesheet>