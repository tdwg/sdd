<?xml version="1.0" encoding="UTF-8"?>
<?xmlspysamplexml SDD_Reduced.xsd?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.w3.org/1999/XSL/Transform schema-for-xslt20.xsd">
 <xsl:variable name="GeneratorCopyright">DiversitySchemaTools Version 0.4. Copyright (c) G. Hagedorn 2003.</xsl:variable>
  <!-- To be used on a w3c schema document.  Returns a w3c xml schema for SDD that is strongly reduced in its content. 
  This is intended to provide better overview or as an introduction to the SDD schema. -->
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>


    <!-- The following includes contain
   - a match-all-copy out rule 
   - removal of identity constraints, patterns, comments  -->  
  <xsl:include href="xsd-Incl-MatchAllAndCopyRule.xsl" />
  <xsl:include href="xsd-Incl-RemoveIdentityPatternComment.xsl" />  

  <!-- Remove annotations: currently not:
  <xsl:include href="xsd-Incl-RemoveAnnotations.xsl" />  
  ## Note: the annotations from UBIF_EnumLib are removed separately before combining them into the single file schemata!
  -->
  
<!-- Remove types, attributes or elements starting with underscore -->
  <xsl:template match="xs:element[substring(@name,1,2)='__']"/>
  <xsl:template match="xs:attribute[substring(@name,1,2)='__']"/>
  <xsl:template match="xs:group[substring(@name,1,2)='__']"/>
  <xsl:template match="xs:group[substring(@ref,1,2)='__']"/>
  <xsl:template match="xs:complexType[substring(@name,1,2)='__']"/>
  <xsl:template match="xs:simpleType[substring(@name,1,2)='__']"/>
  <xsl:template match="xs:enumeration[substring(@value,1,2)='__']"/>

  <!-- ===***=== Custom removal of active schema parts: ===***===-->
  <!-- Note: some removals are overlapping, e.g. when geography is removed but then anything from the section as well.
         This is intentional, to allow experimenting with different removal blocks. -->

  <!-- EnablingGroup, any attribute:-->
  <xsl:template match="xs:group[@ref='EnablingGroup']"/>
  <xsl:template match="xs:group[@name='EnablingGroup']"/>
  <xsl:template match="xs:complexType[@name='VersionExtension']"/>
  <xsl:template match="xs:complexType[@name='CustomExtensions']"/>
  <xsl:template match="xs:anyAttribute"/>  
 
  <!-- debugkey/ref mechanism:-->
  <xsl:template match="xs:attributeGroup[@name='debugkeyAttribute']"/>
  <xsl:template match="xs:attributeGroup[@name='debugrefAttribute']"/>
  <xsl:template match="xs:attributeGroup[@ref='debugkeyAttribute']"/>
  <xsl:template match="xs:attributeGroup[@ref='debugrefAttribute']"/>

  <!-- DerivationMetadata: remove Transformations element and the dependent type -->
  <xsl:template match="xs:element[@name='Transformations']"/>
  <xsl:template match="xs:complexType[@name='DerivationActionDetails']"/>

  <!-- General: remove ExportToken from Labels:-->
  <xsl:template match="xs:element[@name='ExportToken']"/>

  <!-- RevisionData: Remove RevisionStatus element and associated enumeration: -->
  <xsl:template match="xs:element[@name='RevisionStatus']"/>
  <xsl:template match="xs:simpleType[@name='RevisionStatusEnum']"/>

  <!-- SDD Terminology: ConfigurationData and Audiences: -->
  <xsl:template match="xs:element[@name='ConfigurationData']"/>
  <xsl:template match="xs:element[@name='Audiences']"/>
  <xsl:template match="xs:complexType[@name='AudienceDef' or @name='AudienceDefs']"/>

  <!-- SDD Terminology: Glossary system: -->
  <xsl:template match="xs:element[@name='Glossary']"/>
  <xsl:template match="xs:simpleType[@name='GlossaryKindOfTermEnum']"/>
  <xsl:template match="xs:complexType[@name='GlossaryEntry' or @name='GlossaryEntryRepr' or @name='GlossaryEntryRef' or @name='GlossaryEntryRefs']"/>
  <xsl:template match="xs:group[@ref='GlossaryRefGroup']"/>
  <xsl:template match="xs:group[@name='GlossaryRefGroup']"/>

  <!-- SDD Descriptions: remove NaturalLanguageDescription and types used therein:-->
  <xsl:template match="xs:element[@name='NaturalLanguageDescription']"/>
  <xsl:template match="xs:complexType[@name='NaturalLanguageDescription' or @name='CharacterMarkup' or @name='CategoricalMarkup' or @name='QuantitativeMarkup']"/>  
  <xsl:template match="xs:complexType[@name='ConceptMarkup' or @name='MarkupText']"/>
  <xsl:template match="xs:group[@name='PolymorphicCharModificationMarkup' or @name='PolymorphicStateModificationMarkup' or @name='PolymorphicCharMarkup']"/>
  <xsl:template match="xs:complexType[@name='CodingStatusMarkup' or @name='StateMarkup' or @name='NoteMarkup' or @name='ValueMarkup' or @name='MeasureMarkup' or @name='PMeasureMarkup']"/>
  
  <xsl:template match="xs:complexType[@name='StatementModificationMarkup' or @name='CharacterModificationMarkup' or @name='StateModificationMarkup' or @name='StateModificationPlusProbabilitiesMarkup']"/>
  <xsl:template match="xs:complexType[@name='CertaintyMarkup' or @name='SpatialMarkup' or @name='TemporalMarkup' or @name='OtherModMarkup' or @name='FrequencyMarkup' or @name='StateModMarkup']"/>
 
  <!-- SDD Descriptions: remove Identification keys and types used therein:-->
  <xsl:template match="xs:element[@name='IdentificationKeys']"/>
  <xsl:template match="xs:complexType[@name='StoredKeyDef' or @name='StoredKeyNode' or @name='StoredKeyRef' or @name='StoredKeyNodeRef']"/>

</xsl:stylesheet>