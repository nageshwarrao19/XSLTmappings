<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    
    <xsl:variable name="delimiter" select="','" />
    
    <!-- define an array containing the fields we are interested in -->
    <xsl:variable name="fieldArray">
        <field>ListName</field>
        <field>ListCategoryName</field>
        <field>CompanyCode</field>
        <field>ObjectCode</field>
        <field>Level3Code</field>
        <field>Level4Code</field>
        <field>Level5Code</field>
        <field>Level6Code</field>
        <field>Level7Code</field>
        <field>Level8Code</field>
        <field>Level9Code</field>
        <field>Level10Code</field>
        <field>Name</field>
        <field>StartDate</field>
        <field>EndDate</field>
        <field>DeletionIndicator</field>
    </xsl:variable>
    <xsl:param name="fields" select="document('')/*/xsl:variable[@name='fieldArray']/*" />
    
    <xsl:template match="/">
        <xsl:value-of select="'&#xFEFF;'"/>
        <xsl:apply-templates select="CostObjectExportData/items"/>
    </xsl:template>
    
    <xsl:template match="items">
        <xsl:variable name="currNode" select="." />
        
        <!-- output the data row -->
        <!-- loop over the field names and find the value of each one in the xml -->
        <xsl:for-each select="$fields">
            <xsl:if test="position() != 1">
                <xsl:value-of select="$delimiter"/>
            </xsl:if>
            <xsl:value-of select="$currNode/*[name() = current()]" />
        </xsl:for-each>
        
        <!-- output newline -->
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
</xsl:stylesheet>