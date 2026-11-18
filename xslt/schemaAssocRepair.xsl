<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <!-- 2026-11-18 ebb: This is an identity transformation 
        to patch all the schema processsing instructions 
        (schema associations) for each Nixon transcript file, 
        since the schemas were moved to their own schemas/ directory.
    -->
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="nixonTranscriptsXML" as="document-node()+" select="collection('../transcripts/?select=*.xml')"/>
    
    <xsl:template match="/">
        <xsl:for-each select="$nixonTranscriptsXML">
            <!-- ebb: store the currently processing filename using base-uri(). -->
            <xsl:variable name="filename" select="base-uri() ! tokenize(., '/')[last()]"/>
            <!-- ebb: Uncomment this to 'smoke test' the variable!  <xsl:value-of select="$filename"/> -->
            
            <!-- ebb: Store each output file with a slightly new filename we don't overwrite the originals in markup/ -->
            <xsl:result-document method="xml" 
                indent="yes" href="../xmlOut/fix-{$filename}">
                <!-- ebb: Put in the Schema lines from your source files.-->

                <xsl:processing-instruction name="xml-model">
            <xsl:text>href="schemas/transcriptTei_all.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
                 </xsl:processing-instruction> 
                <xsl:processing-instruction name="xml-model">
            <xsl:text>href="schemas/transcriptTei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
                 </xsl:processing-instruction>
                <xsl:processing-instruction name="xml-model">
            <xsl:text>href="schemas/nixonCheck.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
                 </xsl:processing-instruction>
                <xsl:processing-instruction name="xml-model">
            <xsl:text>href="schemas/nixonRefs-sqf.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
                 </xsl:processing-instruction>
                
                  <xsl:apply-templates/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>