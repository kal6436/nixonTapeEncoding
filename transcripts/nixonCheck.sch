<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <pattern id="check-ids-and-refs">  
      <!-- 2026-11-04 ebb: This is for checking that ref attributes are correctly resolving to the nixonReference.xml file. -->
        
        <let name="nixonRefIds" value="doc('metaInfo/nixonReference.xml')//@xml:id"/>

        <rule context="@who | @ref | @resp">
            <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
            <assert test="every $token in $tokens satisfies $token = $nixonRefIds">This attribute value (<value-of select="current()"/>)
                (after the hashtag, #) needs to match a defined @xml:id in the nixonReference file!</assert>
        </rule>
        
    </pattern>
    
</schema>