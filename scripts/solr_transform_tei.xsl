<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  <xsl:output indent="yes"/>
  
  <xsl:include href="../../../scripts/xslt/cdrh_to_solr/lib/common.xsl"/>
  
  <xsl:template match="/">
    <add>
      <doc>
      
        <field name="id">
          <!-- Get the filename -->
          <xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>
          
          <!-- Split the filename using '\.' -->
          <xsl:variable name="filenamepart" select="substring-before($filename, '.xml')"/>
              
          <!-- Remove the file extension -->
          <xsl:value-of select="$filenamepart"/>
        </field>
        
        <field name="type">
          <xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>
          
          <!-- Split the filename using '\.' -->
          <xsl:variable name="filenamepart" select="substring-before($filename, '.xml')"/>

          <xsl:choose>
            <xsl:when test="starts-with($filenamepart, 'cdn.land')">
              <xsl:text>Land</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($filenamepart, 'cdn.water')">
              <xsl:text>Water</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>Other</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </field>
        
        <field name="titleMain">
          <xsl:choose>
            <xsl:when test="/TEI/teiHeader/fileDesc/titleStmt/title[@type='main']">
              <xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title[@type='main']"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>No Title</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </field>
        
        <field name="date">
          <xsl:value-of select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/date/@when"/>
        </field>
        
        <field name="year">
          <xsl:value-of select="substring(/TEI/teiHeader/fileDesc/sourceDesc/bibl/date/@when,1,4)"/>
        </field>
        
        <field name="source">
          <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/bibl/title[@level='j']">
            <xsl:value-of
              select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/title[@level='j']"/>
          </xsl:if>
          <xsl:if test="/TEI/teiHeader/fileDesc/sourceDesc/bibl/title[@level='m']">
            <xsl:value-of
              select="/TEI/teiHeader/fileDesc/sourceDesc/bibl/title[@level='m']"/>
          </xsl:if>
        </field>

        <field name="text">
          <xsl:value-of select="//text"/>
        </field>
      </doc>
    </add>
  </xsl:template>
  
</xsl:stylesheet>
